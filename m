Received: from eggs.gnu.org ([2001:4830:134:3::10]:47378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2Vp-0005yV-QC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2Vj-0001RP-Ro
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:28 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2Vj-0001RI-Dj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:23 -0400
Received: by mail-wm0-x241.google.com with SMTP id x3so8675583wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:50:23 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:43 +0300
Message-Id: <20170608184944.19406-9-mrolnik@gmail.com>
In-Reply-To: <20170608184944.19406-1-mrolnik@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 08/13] target-avr: instruction decoder
 generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <1471522070-77598-9-git-send-email-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/avr/cpugen/CMakeLists.txt           |  38 +++
 target/avr/cpugen/README.md                |  17 ++
 target/avr/cpugen/cpu/avr.yaml             | 213 ++++++++++++++
 target/avr/cpugen/src/CMakeLists.txt       |  62 ++++
 target/avr/cpugen/src/cpugen.cpp           | 457 +++++++++++++++++++++++++++++
 target/avr/cpugen/src/utils.cpp            |  26 ++
 target/avr/cpugen/src/utils.h              |  78 +++++
 target/avr/cpugen/xsl/decode.c.xsl         | 103 +++++++
 target/avr/cpugen/xsl/translate-inst.h.xsl | 118 ++++++++
 target/avr/cpugen/xsl/utils.xsl            | 108 +++++++
 10 files changed, 1220 insertions(+)
 create mode 100644 target/avr/cpugen/CMakeLists.txt
 create mode 100644 target/avr/cpugen/README.md
 create mode 100644 target/avr/cpugen/cpu/avr.yaml
 create mode 100644 target/avr/cpugen/src/CMakeLists.txt
 create mode 100644 target/avr/cpugen/src/cpugen.cpp
 create mode 100644 target/avr/cpugen/src/utils.cpp
 create mode 100644 target/avr/cpugen/src/utils.h
 create mode 100644 target/avr/cpugen/xsl/decode.c.xsl
 create mode 100644 target/avr/cpugen/xsl/translate-inst.h.xsl
 create mode 100644 target/avr/cpugen/xsl/utils.xsl

diff --git a/target/avr/cpugen/CMakeLists.txt b/target/avr/cpugen/CMakeLists.txt
new file mode 100644
index 0000000000..ded391c9c2
--- /dev/null
+++ b/target/avr/cpugen/CMakeLists.txt
@@ -0,0 +1,38 @@
+cmake_minimum_required(VERSION 2.8)
+
+project(cpugen)
+
+set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -ggdb -g3")
+set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
+
+set(Boost_USE_STATIC_LIBS   ON)
+find_package(
+    Boost 1.60.0
+    REQUIRED
+    COMPONENTS
+        system
+        regex)
+#set(BUILD_SHARED_LIBS       OFF)
+#set(BUILD_STATIC_LIBS       ON)
+add_subdirectory(tinyxml2)
+add_subdirectory(yaml-cpp)
+
+include_directories(
+    ${CMAKE_CURRENT_SOURCE_DIR}
+    ${CMAKE_CURRENT_SOURCE_DIR}/..
+    ${CMAKE_CURRENT_SOURCE_DIR}/../yaml-cpp/include
+    ${Boost_INCLUDE_DIRS}
+)
+
+add_executable(
+    cpugen
+    src/cpugen.cpp
+    src/utils.cpp
+)
+
+target_link_libraries(
+    cpugen
+    yaml-cpp
+    tinyxml2
+    ${Boost_LIBRARIES}
+)
diff --git a/target/avr/cpugen/README.md b/target/avr/cpugen/README.md
new file mode 100644
index 0000000000..f0caa8b135
--- /dev/null
+++ b/target/avr/cpugen/README.md
@@ -0,0 +1,17 @@
+# CPUGEN
+## How to build
+within ```cpugen``` directory do
+```
+git clone https://github.com/leethomason/tinyxml2
+git clone https://github.com/jbeder/yaml-cpp
+mkdir build
+cd build
+cmake ..
+make
+```
+## How to use
+```
+cpugen ../cpu/avr.yaml
+xsltproc ../xsl/decode.c.xsl output.xml > ../../decode.c
+xsltproc ../xsl/translate-inst.h.xsl output.xml > ../../translate-inst.h
+```
diff --git a/target/avr/cpugen/cpu/avr.yaml b/target/avr/cpugen/cpu/avr.yaml
new file mode 100644
index 0000000000..c36b628cf1
--- /dev/null
+++ b/target/avr/cpugen/cpu/avr.yaml
@@ -0,0 +1,213 @@
+cpu:
+    name: avr
+    instructions:
+        - ADC:
+            opcode: 0001 11 hRr[1] Rd[5] lRr[4]
+        - ADD:
+            opcode: 0000 11 hRr[1] Rd[5] lRr[4]
+        - ADIW:
+            opcode: 1001 0110 hImm[2] Rd[2] lImm[4]
+        - AND:
+            opcode: 0010 00 hRr[1] Rd[5] lRr[4]
+        - ANDI:
+            opcode: 0111 hImm[4] Rd[4] lImm[4]
+        - ASR:
+            opcode: 1001 010 Rd[5] 0101
+        - BCLR:
+            opcode: 1001 0100 1 Bit[3] 1000
+        - BLD:
+            opcode: 1111 100 Rd[5] 0 Bit[3]
+        - BRBC:
+            opcode: 1111 01 Imm[7] Bit[3]
+        - BRBS:
+            opcode: 1111 00 Imm[7] Bit[3]
+        - BREAK:
+            opcode: 1001 0101 1001 1000
+        - BSET:
+            opcode: 1001 0100 0 Bit[3] 1000
+        - BST:
+            opcode: 1111 101 Rd[5] 0 Bit[3]
+        - CALL:
+            opcode: 1001 010 hImm[5] 111 lImm[17]
+        - CBI:
+            opcode: 1001 1000 Imm[5] Bit[3]
+        - COM:
+            opcode: 1001 010 Rd[5] 0000
+        - CP:
+            opcode: 0001 01 hRr[1] Rd[5] lRr[4]
+        - CPC:
+            opcode: 0000 01 hRr[1] Rd[5] lRr[4]
+        - CPI:
+            opcode: 0011 hImm[4] Rd[4] lImm[4]
+        - CPSE:
+            opcode: 0001 00 hRr[1] Rd[5] lRr[4]
+        - DEC:
+            opcode: 1001 010 Rd[5] 1010
+        - DES:
+            opcode: 1001 0100 Imm[4] 1011
+        - EICALL:
+            opcode: 1001 0101 0001 1001
+        - EIJMP:
+            opcode: 1001 0100 0001 1001
+        - ELPM1:
+            opcode: 1001 0101 1101 1000
+        - ELPM2:
+            opcode: 1001 000 Rd[5] 0110
+        - ELPMX:
+            opcode: 1001 000 Rd[5] 0111
+        - EOR:
+            opcode: 0010 01 hRr[1] Rd[5] lRr[4]
+        - FMUL:
+            opcode: 0000 0011 0 Rd[3] 1 Rr[3]
+        - FMULS:
+            opcode: 0000 0011 1 Rd[3] 0 Rr[3]
+        - FMULSU:
+            opcode: 0000 0011 1 Rd[3] 1 Rr[3]
+        - ICALL:
+            opcode: 1001 0101 0000 1001
+        - IJMP:
+            opcode: 1001 0100 0000 1001
+        - IN:
+            opcode: 1011 0 hImm[2] Rd[5] lImm[4]
+        - INC:
+            opcode: 1001 010 Rd[5] 0011
+        - JMP:
+            opcode: 1001 010 hImm[5] 110 lImm[17]
+        - LAC:
+            opcode: 1001 001 Rr[5] 0110
+        - LAS:
+            opcode: 1001 001 Rr[5] 0101
+        - LAT:
+            opcode: 1001 001 Rr[5] 0111
+        - LDX1:
+            opcode: 1001 000 Rd[5] 1100
+        - LDX2:
+            opcode: 1001 000 Rd[5] 1101
+        - LDX3:
+            opcode: 1001 000 Rd[5] 1110
+#        - LDY1:
+#            opcode: 1000 000 Rd[5] 1000
+        - LDY2:
+            opcode: 1001 000 Rd[5] 1001
+        - LDY3:
+            opcode: 1001 000 Rd[5] 1010
+        - LDDY:
+            opcode: 10 hImm[1] 0 mImm[2] 0 Rd[5] 1 lImm[3]
+#        - LDZ1:
+#            opcode: 1000 000 Rd[5] 0000
+        - LDZ2:
+            opcode: 1001 000 Rd[5] 0001
+        - LDZ3:
+            opcode: 1001 000 Rd[5] 0010
+        - LDDZ:
+            opcode: 10 hImm[1] 0 mImm[2] 0 Rd[5] 0 lImm[3]
+        - LDI:
+            opcode: 1110 hImm[4] Rd[4] lImm[4]
+        - LDS:
+            opcode: 1001 000 Rd[5] 0000 Imm[16]
+#        - LDS16:
+#            opcode: 1010 0 hImm[3] Rd[4] lImm[4]
+        - LPM1:
+            opcode: 1001 0101 1100 1000
+        - LPM2:
+            opcode: 1001 000 Rd[5] 0100
+        - LPMX:
+            opcode: 1001 000 Rd[5] 0101
+        - LSR:
+            opcode: 1001 010 Rd[5] 0110
+        - MOV:
+            opcode: 0010 11 hRr[1] Rd[5] lRr[4]
+        - MOVW:
+            opcode: 0000 0001 Rd[4] Rr[4]
+        - MUL:
+            opcode: 1001 11 hRr[1] Rd[5] lRr[4]
+        - MULS:
+            opcode: 0000 0010 Rd[4] Rr[4]
+        - MULSU:
+            opcode: 0000 0011 0 Rd[3] 0 Rr[3]
+        - NEG:
+            opcode: 1001 010 Rd[5] 0001
+        - NOP:
+            opcode: 0000 0000 0000 0000
+        - OR:
+            opcode: 0010 10 hRr[1] Rd[5] lRr[4]
+        - ORI:
+            opcode: 0110 hImm[4] Rd[4] lImm[4]
+        - OUT:
+            opcode: 1011 1 hImm[2] Rd[5] lImm[4]
+        - POP:
+            opcode: 1001 000 Rd[5] 1111
+        - PUSH:
+            opcode: 1001 001 Rd[5] 1111
+        - RCALL:
+            opcode: 1101 Imm[12]
+        - RET:
+            opcode: 1001 0101 0000 1000
+        - RETI:
+            opcode: 1001 0101 0001 1000
+        - RJMP:
+            opcode: 1100 Imm[12]
+        - ROR:
+            opcode: 1001 010 Rd[5] 0111
+        - SBC:
+            opcode: 0000 10 hRr[1] Rd[5] lRr[4]
+        - SBCI:
+            opcode: 0100 hImm[4] Rd[4] lImm[4]
+        - SBI:
+            opcode: 1001 1010 Imm[5] Bit[3]
+        - SBIC:
+            opcode: 1001 1001 Imm[5] Bit[3]
+        - SBIS:
+            opcode: 1001 1011 Imm[5] Bit[3]
+        - SBIW:
+            opcode: 1001 0111 hImm[2] Rd[2] lImm[4]
+#        - SBR:
+#            opcode: 0110 hImm[4] Rd[4] lImm[4]
+        - SBRC:
+            opcode: 1111 110 Rr[5] 0 Bit[3]
+        - SBRS:
+            opcode: 1111 111 Rr[5] 0 Bit[3]
+        - SLEEP:
+            opcode: 1001 0101 1000 1000
+        - SPM:
+            opcode: 1001 0101 1110 1000
+        - SPMX:
+            opcode: 1001 0101 1111 1000
+        - STX1:
+            opcode: 1001 001 Rr[5] 1100
+        - STX2:
+            opcode: 1001 001 Rr[5] 1101
+        - STX3:
+            opcode: 1001 001 Rr[5] 1110
+#        - STY1:
+#            opcode: 1000 001 Rd[5] 1000
+        - STY2:
+            opcode: 1001 001 Rd[5] 1001
+        - STY3:
+            opcode: 1001 001 Rd[5] 1010
+        - STDY:
+            opcode: 10 hImm[1] 0 mImm[2] 1 Rd[5] 1 lImm[3]
+#        - STZ1:
+#            opcode: 1000 001 Rd[5] 0000
+        - STZ2:
+            opcode: 1001 001 Rd[5] 0001
+        - STZ3:
+            opcode: 1001 001 Rd[5] 0010
+        - STDZ:
+            opcode: 10 hImm[1] 0 mImm[2] 1 Rd[5] 0 lImm[3]
+        - STS:
+            opcode: 1001 001 Rd[5] 0000 Imm[16]
+#        - STS16:
+#            opcode: 1010 1 hImm[3] Rd[4] lImm[4]
+        - SUB:
+            opcode: 0001 10 hRr[1] Rd[5] lRr[4]
+        - SUBI:
+            opcode: 0101 hImm[4] Rd[4] lImm[4]
+        - SWAP:
+            opcode: 1001 010 Rd[5] 0010
+#        - TST:
+#            opcode: 0010 00 Rd[10]
+        - WDR:
+            opcode: 1001 0101 1010 1000
+        - XCH:
+            opcode: 1001 001 Rd[5] 0100
diff --git a/target/avr/cpugen/src/CMakeLists.txt b/target/avr/cpugen/src/CMakeLists.txt
new file mode 100644
index 0000000000..5f08761dbf
--- /dev/null
+++ b/target/avr/cpugen/src/CMakeLists.txt
@@ -0,0 +1,62 @@
+#
+# CPUGEN
+#
+# Copyright (c) 2016 Michael Rolnik
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+# THE SOFTWARE.
+#
+
+cmake_minimum_required(VERSION 2.8)
+
+project(cpugen)
+
+set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -ggdb -g3")
+set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
+
+set(Boost_USE_STATIC_LIBS   ON)
+find_package(
+    Boost 1.60.0
+    REQUIRED
+    COMPONENTS
+        system
+        regex)
+set(BUILD_SHARED_LIBS       OFF)
+set(BUILD_STATIC_LIBS       ON)
+add_subdirectory(../tinyxml2    ${CMAKE_CURRENT_BINARY_DIR}/tinyxml2)
+add_subdirectory(../yaml-cpp    ${CMAKE_CURRENT_BINARY_DIR}/yaml-cpp)
+
+include_directories(
+    ${CMAKE_CURRENT_SOURCE_DIR}
+    ${CMAKE_CURRENT_SOURCE_DIR}/..
+    ${CMAKE_CURRENT_SOURCE_DIR}/../yaml-cpp/include
+    ${Boost_INCLUDE_DIRS}
+)
+
+add_executable(
+    cpugen
+    cpugen.cpp
+    utils.cpp
+)
+
+target_link_libraries(
+    cpugen
+    yaml-cpp
+    tinyxml2_static
+    ${Boost_LIBRARIES}
+)
diff --git a/target/avr/cpugen/src/cpugen.cpp b/target/avr/cpugen/src/cpugen.cpp
new file mode 100644
index 0000000000..e479b08251
--- /dev/null
+++ b/target/avr/cpugen/src/cpugen.cpp
@@ -0,0 +1,457 @@
+/*
+ * CPUGEN
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <cstdio>
+#include <cstdlib>
+#include <iostream>
+#include <fstream>
+#include <limits>
+#include <stdint.h>
+#include <algorithm>
+#include <iomanip>
+#include <string>
+#include <vector>
+#include <boost/regex.hpp>
+
+#include "yaml-cpp/yaml.h"
+#include "tinyxml2/tinyxml2.h"
+
+#include "utils.h"
+
+#include <boost/algorithm/string.hpp>
+
+struct  inst_info_t {
+    std::string name;
+    std::string opcode;
+
+    tinyxml2::XMLElement *nodeFields;
+};
+
+struct  cpu_info_t {
+    std::string name;
+    std::vector<inst_info_t * > instructions;
+};
+
+int countbits(uint64_t value)
+{
+    int counter = 0;
+    uint64_t mask = 1;
+
+    for (size_t i = 0; i < sizeof(value) * 8; ++i) {
+        if (value & mask) {
+            counter++;
+        }
+
+        mask <<= 1;
+    }
+
+    return counter;
+}
+
+int encode(uint64_t mask, uint64_t value)
+{
+    uint64_t i = 0x0000000000000001;
+    uint64_t j = 0x0000000000000001;
+    uint64_t v = 0x0000000000000000;
+
+    for (size_t it = 0; it < sizeof(value) * 8; ++it) {
+        if (mask & i) {
+            if (value & j) {
+                v |= i;
+            }
+            j <<= 1;
+        }
+
+        i <<= 1;
+    }
+
+    return v;
+}
+
+std::string num2hex(uint64_t value)
+{
+    std::ostringstream  str;
+    str << "0x" << std::hex << std::setw(8) << std::setfill('0') << value;
+
+    return str.str();
+}
+
+tinyxml2::XMLDocument   doc;
+
+void operator >> (const YAML::Node & node, inst_info_t & info)
+{
+    for (auto it = node.begin(); it != node.end(); ++it) {
+        const YAML::Node & curr = it->second;
+        std::string name = it->first.as<std::string>();
+
+        info.opcode = curr["opcode"].as<std::string>();
+
+        const char *response;
+        std::vector<std::string> fields;
+        std::string opcode = "";
+        int offset;
+        tinyxml2::XMLElement *nodeFields = doc.NewElement("fields");
+        uint32_t bitoffset = 0;
+
+        do {
+            opcode = info.opcode;
+            boost::replace_all(info.opcode, "  ", " ");
+            boost::replace_all(info.opcode, "0 0", "00");
+            boost::replace_all(info.opcode, "0 1", "01");
+            boost::replace_all(info.opcode, "1 0", "10");
+            boost::replace_all(info.opcode, "1 1", "11");
+        } while (opcode != info.opcode);
+
+        boost::replace_all(info.opcode, "- -", "--");
+
+        fields = boost::split(fields, info.opcode, boost::is_any_of(" "));
+
+        opcode = "";
+        info.opcode = "";
+        unsigned f = 0;
+        for (int i = 0; i < fields.size(); i++) {
+            std::string field = fields[i];
+
+            if (field.empty()) {
+                continue;
+            }
+
+            size_t len = field.length();
+            boost::cmatch match;
+            tinyxml2::XMLElement *nodeField = doc.NewElement("field");
+
+            nodeFields->LinkEndChild(nodeField);
+
+            if (boost::regex_match(field.c_str(),
+                        match,
+                        boost::regex("^[01]+$"))) {
+                int length = field.length();
+
+                nodeField->SetAttribute("name", field.c_str());
+                nodeField->SetAttribute("length", length);
+                nodeField->SetAttribute("offset", bitoffset);
+
+                info.opcode += field;
+
+                bitoffset   += len;
+            } else if (boost::regex_match(
+                    field.c_str(),
+                    match,
+                    boost::regex("^[-]+$")))
+            {
+                int         length = field.length();
+
+                nodeField->SetAttribute("name", "RESERVED");
+                nodeField->SetAttribute("length", length);
+                nodeField->SetAttribute("offset", bitoffset);
+
+                info.opcode += field;
+
+                bitoffset   += len;
+            } else if (boost::regex_match(field.c_str(),
+                    match,
+                    boost::regex("^([a-zA-Z][a-zA-Z0-9]*)\\[([0-9]+)\\]"))) {
+                int         length = std::atoi(match[2].first);
+                std::string name = std::string(match[1].first, match[1].second);
+
+                nodeField->SetAttribute("name", name.c_str());
+                nodeField->SetAttribute("length", length);
+                nodeField->SetAttribute("offset", bitoffset);
+
+                for (int j = 0; j < length; j++) {
+                    info.opcode += 'a' + f;
+                }
+
+                f++;
+
+                bitoffset   += length;
+            } else if (field == "~") {
+                /* nothing */
+            } else {
+                std::cout << "cannot parse " << name
+                          << ": '" << field << "'" << std::endl;
+                exit(0);
+            }
+        }
+
+        info.nodeFields = nodeFields;
+        info.name = name;
+    }
+}
+
+void operator >> (inst_info_t & info, tinyxml2::XMLElement & node)
+{
+    node.SetAttribute("length", (unsigned)info.opcode.length());
+    node.SetAttribute("name", info.name.c_str());
+    node.SetAttribute("opcode", info.opcode.c_str());
+}
+
+void operator >> (const YAML::Node & node, cpu_info_t & cpu)
+{
+    const YAML::Node & insts = node["instructions"];
+
+    cpu.name = node["name"].as<std::string>();
+
+    for (unsigned i = 0; i < insts.size(); i++) {
+        inst_info_t *inst = new inst_info_t();
+
+        insts[i] >> (*inst);
+
+        if (inst->opcode != "" &&inst->opcode != "~") {
+            cpu.instructions.push_back(inst);
+        }
+    }
+}
+
+std::pair<size_t, size_t> getMinMaxInstructionLength(
+                                std::vector<inst_info_t * > &instructions)
+{
+    size_t  min = std::numeric_limits<size_t>::max();
+    size_t  max = std::numeric_limits<size_t>::min();
+
+    for (size_t i = 0; i < instructions.size(); i++) {
+        inst_info_t *inst = instructions[i];
+        std::string opcode = inst->opcode;
+        size_t length = opcode.length();
+
+        if (opcode != "~") {
+            min = std::min(min, length);
+            max = std::max(max, length);
+        }
+    }
+
+    return std::make_pair(min, max);
+}
+
+uint64_t getXs(std::string const &opcode, size_t len, char chr)
+{
+    uint64_t result = 0;
+    size_t cur;
+    uint64_t bit = 1ull << (len - 1);
+
+    for (cur = 0; cur < len; cur++) {
+        if (opcode[cur] == chr) {
+            result  |= bit;
+        }
+
+        bit >>= 1;
+    }
+
+    return result;
+}
+
+uint64_t get0s(std::string const &opcode, size_t len)
+{
+    return getXs(opcode, len, '0');
+}
+
+uint64_t get1s(std::string const &opcode, size_t len)
+{
+    return getXs(opcode, len, '1');
+}
+
+class InstSorter
+{
+    public:
+        InstSorter(size_t offset, size_t length)
+            : offset(offset), length(length)
+        {
+
+        }
+
+        bool operator()(inst_info_t *a, inst_info_t *b)
+        {
+            uint64_t field0;
+            uint64_t field1;
+            uint64_t fieldA;
+            uint64_t fieldB;
+
+            field0 = get0s(a->opcode, length);
+            field1 = get1s(a->opcode, length);
+            fieldA = field0 | field1;
+
+            field0 = get0s(b->opcode, length);
+            field1 = get1s(b->opcode, length);
+            fieldB = field0 | field1;
+
+            return fieldB < fieldA;
+        }
+
+    private:
+        size_t offset;
+        size_t length;
+
+};
+
+void divide(uint64_t select0, uint64_t select1,
+            std::vector<inst_info_t * > &info,
+            size_t level, tinyxml2::XMLElement *root)
+{
+    std::pair<size_t, size_t>   minmaxSize;
+
+    minmaxSize = getMinMaxInstructionLength(info);
+
+    size_t minlen = minmaxSize.first;
+    size_t maxlen = minmaxSize.second;
+    size_t bits = std::min(minlen, sizeof(select0) * 8);
+    uint64_t all1 = (1ULL << bits) - 1;
+    uint64_t all0 = (1ULL << bits) - 1;
+    uint64_t allx = (1ULL << bits) - 1;
+    uint64_t diff;
+
+    for (size_t i = 0; i < info.size(); ++i) {
+        std::string opcode = info[i]->opcode;
+        uint64_t field0 = get0s(opcode, minlen);
+        uint64_t field1 = get1s(opcode, minlen);
+        uint64_t fieldx = field0 | field1;
+
+        if (opcode == "~") {
+            continue;
+        }
+        all0 &= field0;
+        all1 &= field1;
+        allx &= fieldx;
+    }
+
+    diff = allx ^ (all0 | all1);
+
+    if (diff == 0) {
+        tinyxml2::XMLElement *oopsNode = doc.NewElement("oops");
+        oopsNode->SetAttribute("bits", (unsigned)bits);
+        oopsNode->SetAttribute("maxlen", (unsigned)maxlen);
+        oopsNode->SetAttribute("allx", num2hex(allx).c_str());
+        oopsNode->SetAttribute("all0", num2hex(all0).c_str());
+        oopsNode->SetAttribute("all1", num2hex(all1).c_str());
+        oopsNode->SetAttribute("select0", num2hex(select0).c_str());
+        oopsNode->SetAttribute("select1", num2hex(select1).c_str());
+        root->LinkEndChild(oopsNode);
+
+        std::sort(info.begin(), info.end(), InstSorter(0, minlen));
+
+        for (size_t i = 0; i < info.size(); ++i) {
+            inst_info_t *inst = info[i];
+            tinyxml2::XMLElement *instNode = doc.NewElement("instruction");
+            tinyxml2::XMLElement *matchNode = doc.NewElement("match01");
+
+            uint64_t field0 = get0s(inst->opcode, minlen);
+            uint64_t field1 = get1s(inst->opcode, minlen);
+            uint64_t fieldx = field0 | field1;
+
+            root->LinkEndChild(matchNode);
+            matchNode->LinkEndChild(instNode);
+
+            matchNode->SetAttribute("mask", num2hex(fieldx).c_str());
+            matchNode->SetAttribute("value", num2hex(field1).c_str());
+
+            *inst >> *instNode;
+
+            instNode->LinkEndChild(inst->nodeFields);
+        }
+
+        return;
+    }
+
+    uint64_t    bitsN = countbits(diff); /* number of meaningfull bits */
+
+    tinyxml2::XMLElement *switchNode = doc.NewElement("switch");
+    switchNode->SetAttribute("bits", (unsigned)bits);
+    switchNode->SetAttribute("bitoffset", (unsigned)0);
+    switchNode->SetAttribute("mask", num2hex(diff).c_str());
+    root->LinkEndChild(switchNode);
+
+    /* there are at most 1 << length subsets */
+    for (size_t s = 0; s < (1 << bitsN); ++s) {
+        std::vector<inst_info_t * > subset;
+        uint64_t index = encode(diff, s);
+
+        tinyxml2::XMLElement *caseNode = doc.NewElement("case");
+        caseNode->SetAttribute("value", num2hex(index).c_str());
+        switchNode->LinkEndChild(caseNode);
+
+        for (size_t i = 0; i < info.size(); ++i) {
+            std::string opcode = info[i]->opcode;
+            uint64_t field0 = get0s(opcode, minlen);
+            uint64_t field1 = get1s(opcode, minlen);
+
+            if (((field0 & diff) == (~index & diff))
+                && ((field1 & diff) == (index  & diff))) {
+                subset.push_back(info[i]);
+            }
+        }
+
+        if (subset.size() == 1) {
+            inst_info_t *inst = subset[0];
+            tinyxml2::XMLElement *instNode = doc.NewElement("instruction");
+
+            *inst >> *instNode;
+
+            instNode->LinkEndChild(inst->nodeFields);
+
+            caseNode->LinkEndChild(instNode);
+        } else if (subset.size() > 1) {
+            /* this is a set of instructions, continue dividing */
+            divide(select0 | (diff & ~index),
+                   select1 | (diff & index),
+                   subset,
+                   level + 2,
+                   caseNode);
+        }
+    }
+}
+
+void generateParser(cpu_info_t & cpu)
+{
+    tinyxml2::XMLElement *cpuNode = doc.NewElement("cpu");
+    tinyxml2::XMLElement *instNode = doc.NewElement("instructions");
+
+    cpuNode->SetAttribute("name", cpu.name.c_str());
+    cpuNode->LinkEndChild(instNode);
+
+    doc.LinkEndChild(cpuNode);
+
+    divide(0, 0, cpu.instructions, 1, instNode);
+
+    doc.SaveFile("output.xml");
+}
+
+int main(int argc, char *argv[])
+{
+    if (argc != 2) {
+        std::cerr << "error: usage: cpuarg [input.yaml]" << std::endl;
+        std::exit(0);
+    }
+
+    try {
+        const char *filename = argv[1];
+        std::ifstream input(filename);
+        YAML::Node doc = YAML::Load(input);
+        cpu_info_t cpu;
+
+        doc["cpu"] >> cpu;
+
+        generateParser(cpu);
+    } catch(const YAML::Exception & e) {
+        std::cerr << e.what() << "\n";
+    }
+}
diff --git a/target/avr/cpugen/src/utils.cpp b/target/avr/cpugen/src/utils.cpp
new file mode 100644
index 0000000000..5ef1961418
--- /dev/null
+++ b/target/avr/cpugen/src/utils.cpp
@@ -0,0 +1,26 @@
+/*
+ * CPUGEN
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "utils.h"
+#include <sstream>
diff --git a/target/avr/cpugen/src/utils.h b/target/avr/cpugen/src/utils.h
new file mode 100644
index 0000000000..0efaa3eded
--- /dev/null
+++ b/target/avr/cpugen/src/utils.h
@@ -0,0 +1,78 @@
+/*
+ * CPUGEN
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef UTILS_H_
+#define UTILS_H_
+
+#include <string>
+#include <vector>
+#include <iostream>
+#include <iomanip>
+
+typedef std::vector<std::string>    string_vector_t;
+
+std::string extract(std::string & str, std::string delimiter);
+std::string rextract(std::string & str, std::string del);
+string_vector_t split(std::string str, std::string delimeter);
+std::string join(string_vector_t const &vec, std::string delimeter);
+
+int countbits(uint64_t value);
+int encode(uint64_t mask, uint64_t value);
+std::string num2hex(uint64_t value);
+
+class multi
+{
+/*
+    http://www.angelikalanger.com/Articles/Cuj/05.Manipulators/Manipulators.html
+*/
+    public:
+        multi(char c, size_t n)
+            : how_many_(n)
+            , what_(c)
+        {
+        }
+
+    private:
+        const size_t    how_many_;
+        const char      what_;
+
+    public:
+        template <class Ostream>
+        Ostream & apply(Ostream & os) const
+        {
+            for (unsigned int i = 0; i < how_many_; ++i) {
+                os.put(what_);
+            }
+            os.flush();
+            return os;
+        }
+};
+
+template <class Ostream>
+Ostream & operator << (Ostream & os, const multi & m)
+{
+    return m.apply(os);
+}
+
+#endif
diff --git a/target/avr/cpugen/xsl/decode.c.xsl b/target/avr/cpugen/xsl/decode.c.xsl
new file mode 100644
index 0000000000..b8aa02c5d7
--- /dev/null
+++ b/target/avr/cpugen/xsl/decode.c.xsl
@@ -0,0 +1,103 @@
+<?xml version="1.0"?>
+<!--
+   CPUGEN
+
+   Copyright (c) 2016 Michael Rolnik
+
+   Permission is hereby granted, free of charge, to any person obtaining a copy
+   of this software and associated documentation files (the "Software"), to deal
+   in the Software without restriction, including without limitation the rights
+   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+   copies of the Software, and to permit persons to whom the Software is
+   furnished to do so, subject to the following conditions:
+
+   The above copyright notice and this permission notice shall be included in
+   all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+   THE SOFTWARE.
+-->
+
+<xsl:stylesheet version="1.0"
+    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
+    xmlns:func  = "http://exslt.org/functions"
+    xmlns:str   = "http://exslt.org/strings"
+    xmlns:mine  = "mrolnik@gmail.com"
+    extension-element-prefixes="func"
+    >
+
+    <xsl:strip-space elements="*"/>
+    <xsl:output method="text" omit-xml-declaration="yes" indent="yes"/>
+
+    <xsl:include href="utils.xsl"/>
+
+    <xsl:template match="/cpu/instructions">
+        <xsl:value-of select="$license" />
+        <xsl:text>
+#include &lt;stdint.h&gt;
+#include "translate.h"
+
+void </xsl:text><xsl:value-of select="/cpu/@name"/><xsl:text>_decode(uint32_t pc, uint32_t *l, uint32_t c, translate_function_t *t)
+{
+</xsl:text>
+    <xsl:apply-templates select="switch">
+        <xsl:with-param name="ident" ><xsl:value-of select="$tab"/></xsl:with-param>
+    </xsl:apply-templates>
+<xsl:text>
+}
+</xsl:text>
+</xsl:template>
+
+    <xsl:template match="switch">
+        <xsl:param name="ident" />
+        <xsl:if test="not (@bitoffset = ../../@bitoffset and @bits = ../../@bits)" >
+            <xsl:value-of select="concat($ident, 'uint32_t opc  = extract32(c, ', @bitoffset, ', ', @bits, ');', $newline)" />
+        </xsl:if>
+        <xsl:value-of select="concat($ident, 'switch (opc &amp; ', @mask, ') {', $newline)"/>
+        <xsl:apply-templates select="case">
+            <xsl:with-param name="ident" ><xsl:value-of select="$ident"/><xsl:value-of select="$tab"/></xsl:with-param>
+        </xsl:apply-templates>
+        <xsl:value-of select="concat($ident, '}', $newline)"/>
+    </xsl:template>
+
+    <xsl:template match="case">
+        <xsl:param name="ident" />
+
+        <xsl:value-of select="concat($ident, 'case ', @value, ': {', $newline)"/>
+        <xsl:apply-templates select="switch">
+            <xsl:with-param name="ident"><xsl:value-of select="concat($ident, $tab)"/></xsl:with-param>
+        </xsl:apply-templates>
+        <xsl:apply-templates select="match01">
+            <xsl:with-param name="ident"><xsl:value-of select="concat($ident, $tab)"/></xsl:with-param>
+        </xsl:apply-templates>
+        <xsl:apply-templates select="instruction">
+            <xsl:with-param name="ident"><xsl:value-of select="concat($ident, $tab)"/></xsl:with-param>
+        </xsl:apply-templates>
+        <xsl:value-of select="concat($ident, $tab, 'break;', $newline)"/>
+        <xsl:value-of select="concat($ident, '}', $newline)"/>
+    </xsl:template>
+
+    <xsl:template match="instruction">
+        <xsl:param name="ident" />
+
+        <xsl:value-of select="concat($ident, '*l = ', string-length(@opcode), ';', $newline)" />
+        <xsl:value-of select="concat($ident, '*t = &amp;', /cpu/@name, '_translate_', @name, ';', $newline)" />
+    </xsl:template>
+
+    <xsl:template match="match01">
+        <xsl:param name="ident" />
+
+        <xsl:value-of select="concat($ident, 'if((opc &amp; ', @mask, ' == ', @value, ') {', $newline)" />
+        <xsl:apply-templates select="instruction">
+            <xsl:with-param name="ident"><xsl:value-of select="concat($ident, $tab)"/></xsl:with-param>
+        </xsl:apply-templates>
+        <xsl:value-of select="concat($ident, 'break;', $newline)"/>
+        <xsl:value-of select="concat($ident, '}', $newline)"/>
+    </xsl:template>
+
+</xsl:stylesheet>
diff --git a/target/avr/cpugen/xsl/translate-inst.h.xsl b/target/avr/cpugen/xsl/translate-inst.h.xsl
new file mode 100644
index 0000000000..2830ce3d1b
--- /dev/null
+++ b/target/avr/cpugen/xsl/translate-inst.h.xsl
@@ -0,0 +1,118 @@
+<?xml version="1.0"?>
+
+<!--
+   CPUGEN
+
+   Copyright (c) 2016 Michael Rolnik
+
+   Permission is hereby granted, free of charge, to any person obtaining a copy
+   of this software and associated documentation files (the "Software"), to deal
+   in the Software without restriction, including without limitation the rights
+   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+   copies of the Software, and to permit persons to whom the Software is
+   furnished to do so, subject to the following conditions:
+
+   The above copyright notice and this permission notice shall be included in
+   all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+   THE SOFTWARE.
+-->
+
+<xsl:stylesheet version="1.0"
+    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
+    xmlns:func  = "http://exslt.org/functions"
+    xmlns:str   = "http://exslt.org/strings"
+    xmlns:mine  = "mrolnik@gmail.com"
+    extension-element-prefixes="func"
+    >
+
+    <xsl:include href="utils.xsl"/>
+
+<xsl:strip-space elements="*"/>
+<xsl:output method="text" omit-xml-declaration="yes" indent="yes"/>
+
+<xsl:template match="/cpu/instructions">
+        <xsl:value-of select="$license" />
+<xsl:text>
+#ifndef AVR_TRANSLATE_INST_H_
+#define AVR_TRANSLATE_INST_H_
+
+typedef struct DisasContext    DisasContext;
+
+</xsl:text>
+
+<xsl:apply-templates select="//instruction" />
+
+<xsl:text>
+#endif
+</xsl:text>
+</xsl:template>
+
+<xsl:template match="instruction">
+    <xsl:variable name="length"     select="string-length(@opcode)" />
+    <xsl:variable name="datatype"   select="mine:get-opcode-struct-type($length)" />
+    <xsl:variable name="namestem"   select="@name"/>
+    <xsl:variable name="ilength"    select="@length"/>
+
+    <xsl:value-of select="concat('int ', /cpu/@name, '_translate_', @name, '(CPUAVRState *env, DisasContext* ctx, uint32_t opcode);', $newline)" />
+    <xsl:for-each select="fields/field">
+        <xsl:sort select="position()" data-type="number" order="descending"/>
+        <xsl:choose>
+            <xsl:when test="str:replace(str:replace(@name, '0', ''), '1', '') = ''">
+            </xsl:when>
+            <xsl:otherwise>
+                <xsl:variable name="field" select="substring(@name, 2, string-length(@name) - 1)" />
+                <xsl:variable name="h"     select="../field[@name = concat('h', $field)]"/>
+                <xsl:variable name="l"     select="../field[@name = concat('l', $field)]"/>
+                <xsl:variable name="m"     select="../field[@name = concat('m', $field)]"/>
+
+                <xsl:if test="not($h/@name = @name or $m/@name = @name or $l/@name = @name)">
+                    <xsl:value-of select="concat('static inline uint32_t ', $namestem, '_', @name, '(uint32_t opcode)', $newline)" />
+                    <xsl:value-of select="concat('{', $newline)" />
+                    <xsl:value-of select="concat('    return extract32(opcode, ', $ilength - @offset - @length, ', ', @length, ');', $newline)" />
+                    <xsl:value-of select="concat('}', $newline)" />
+                </xsl:if>
+
+                <xsl:if test="$l and $h and ($h/@name = @name)">
+                    <xsl:value-of select="concat('static inline uint32_t ', $namestem, '_', $field, '(uint32_t opcode)', $newline)" />
+                    <xsl:value-of select="concat('{', $newline)" />
+                    <xsl:value-of select="'    return '" />
+
+<xsl:variable name="l_length"   select="$l/@length"/>
+<xsl:variable name="l_offset"   select="$ilength - $l/@offset - $l_length"/>
+
+<xsl:variable name="m_length"   select="$m/@length"/>
+<xsl:variable name="m_offset"   select="$ilength - $m/@offset - $m_length"/>
+
+<xsl:variable name="h_length"   select="$h/@length"/>
+<xsl:variable name="h_offset"   select="$ilength - $h/@offset - $h_length"/>
+
+
+                    <xsl:choose>
+                        <xsl:when test="$h and $m and $l">
+                            <xsl:value-of select="concat('(extract32(opcode, ', $h_offset, ', ', $h_length, ') &lt;&lt; ', $l_length + $m_length, ') | ')" />
+                            <xsl:value-of select="concat('(extract32(opcode, ', $m_offset, ', ', $m_length, ') &lt;&lt; ', $l_length, ') | ')" />
+                            <xsl:value-of select="concat('(extract32(opcode, ', $l_offset, ', ', $l_length, '))')" />
+                        </xsl:when>
+                        <xsl:otherwise>
+                            <xsl:value-of select="concat('(extract32(opcode, ', $h_offset, ', ', $h_length, ') &lt;&lt; ', $l_length, ') | ')" />
+                            <xsl:value-of select="concat('(extract32(opcode, ', $l_offset, ', ', $l_length, '))')" />
+                        </xsl:otherwise>
+                    </xsl:choose>
+
+                    <xsl:value-of select="concat(';', $newline)"/>
+                    <xsl:value-of select="concat('}', $newline)"/>
+                </xsl:if>
+            </xsl:otherwise>
+        </xsl:choose>
+    </xsl:for-each>
+    <xsl:value-of select="$newline" />
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/target/avr/cpugen/xsl/utils.xsl b/target/avr/cpugen/xsl/utils.xsl
new file mode 100644
index 0000000000..b4511b6438
--- /dev/null
+++ b/target/avr/cpugen/xsl/utils.xsl
@@ -0,0 +1,108 @@
+<?xml version="1.0"?>
+<!--
+   CPUGEN
+
+   Copyright (c) 2016 Michael Rolnik
+
+   Permission is hereby granted, free of charge, to any person obtaining a copy
+   of this software and associated documentation files (the "Software"), to deal
+   in the Software without restriction, including without limitation the rights
+   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+   copies of the Software, and to permit persons to whom the Software is
+   furnished to do so, subject to the following conditions:
+
+   The above copyright notice and this permission notice shall be included in
+   all copies or substantial portions of the Software.
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+   THE SOFTWARE.
+-->
+<xsl:stylesheet version="1.0"
+    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
+    xmlns:str   = "http://exslt.org/strings"
+    xmlns:func  = "http://exslt.org/functions"
+    xmlns:exsl  = "http://exslt.org/common"
+    xmlns:mine  = "mrolnik@gmail.com"
+    extension-element-prefixes="func">
+
+    <xsl:output method = "text" />
+    <xsl:strip-space elements="*"/>
+
+    <xsl:variable name="newline">
+    <xsl:text>
+</xsl:text>
+    </xsl:variable>
+    <xsl:variable name="license">
+        <xsl:text>/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * &lt;http://www.gnu.org/licenses/lgpl-2.1.html&gt;
+ */
+
+</xsl:text>
+    </xsl:variable>
+
+    <xsl:variable name="tab">
+        <xsl:text>    </xsl:text>
+    </xsl:variable>
+
+    <func:function name="mine:pad" as="string">
+        <xsl:param      name="str"      as="xs:string"/>
+        <xsl:param      name="len"      as="xs:integer"/>
+        <xsl:variable   name="lstr"     select="string-length($str)"/>
+        <xsl:variable   name="pad"      select="str:padding($len - $lstr, ' ')"/>
+        <func:result select="concat($str,$pad)"/>
+    </func:function>
+
+    <func:function  name="mine:toupper" as="string">
+        <xsl:param      name="str"      as="xs:string"/>
+        <xsl:variable   name="upper"    select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,-.'" />
+        <xsl:variable   name="lower"    select="'abcdefghijklmnopqrstuvwxyz____'" />
+        <func:result    select="translate($str, $upper, $lower)" />
+    </func:function>
+
+    <func:function  name="mine:toname" as="string">
+        <xsl:param      name="str"      as="xs:string"/>
+        <xsl:variable   name="src"      select="'. ,-'" />
+        <xsl:variable   name="dst"      select="'_'" />
+        <func:result    select="translate($str, $src, $dst)" />
+    </func:function>
+
+    <func:function name="mine:get-opcode-struct-type">
+        <xsl:param name="length"/>
+            <xsl:choose>
+                <xsl:when test="$length &lt; '9'">
+                    <func:result select="'uint8_t '"/>
+                </xsl:when>
+                <xsl:when test="$length &lt; '17'">
+                    <func:result select="'uint16_t'"/>
+                </xsl:when>
+                <xsl:when test="$length &lt; '33'">
+                    <func:result select="'uint32_t'"/>
+                </xsl:when>
+                <xsl:when test="$length &lt; '65'">
+                    <func:result select="'uint64_t'"/>
+                </xsl:when>
+            </xsl:choose>
+    </func:function>
+
+</xsl:stylesheet>
-- 
2.11.0 (Apple Git-81)
