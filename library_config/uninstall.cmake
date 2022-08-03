cmake_minimum_required(VERSION 2.8.5)

set(MANIFEST "${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt")  # install_manifest.txt 存放 CMake 安装文件的列表

if(NOT EXISTS ${MANIFEST})
    message(FATAL_ERROR "Cannot find install mainfest: ${MANIFEST}")
endif()

file(STRINGS ${MANIFEST} files)  # 将解析的文件内容放入一个字符串变量中
foreach(file ${files})
    if(EXISTS ${file} OR IS_SYMLINK ${file})
        message(STATUS "Removing: ${file}")

        # 执行 Linux 命令
        execute_process(COMMAND rm -f ${file}
            RESULT_VARIABLE result
            OUTPUT_QUIET
            ERROR_VARIABLE stderr
            ERROR_STRIP_TRAILING_WHITESPACE
        )

        if(NOT ${result} EQUAL 0)
            message(FATAL_ERROR "${stderr}")
        endif()
    else()
        message(STATUS "Does-not-exist: ${file}")
    endif()
endforeach(file)
