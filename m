Received: from eggs.gnu.org ([2001:4830:134:3::10]:49953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004v2-Lu
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWB9-00035M-UO
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWB9-000347-Nh
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:51 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:14 +0200
Message-Id: <20180501142222.19154-5-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 04/12] tests/tcg/tricore: Add bmerge test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile      |  1 +
 tests/tcg/tricore/macros.h      | 24 ++++++++++++++++++++++++
 tests/tcg/tricore/test_bmerge.S |  8 ++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tests/tcg/tricore/test_bmerge.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index a0e1f4b20d..34c91dccf5 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -9,6 +9,7 @@ SIM = ../../../tricore-softmmu/qemu-system-tricore
 SIMFLAGS = -M tricore_testboard -nographic -kernel
 
 TESTCASES += test_abs.tst
+TESTCASES += test_bmerge.tst
 
 all: build
 
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/macros.h
index 76c133132a..52aa936c56 100644
--- a/tests/tcg/tricore/macros.h
+++ b/tests/tcg/tricore/macros.h
@@ -8,7 +8,10 @@
 #define TESTDEV_ADDR 0xf0000000
 /* Register definitions */
 #define DREG_RS1 %d0
+#define DREG_RS2 %d1
 #define DREG_CALC_RESULT %d1
+#define DREG_CALC_PSW %d2
+#define DREG_CORRECT_PSW %d3
 #define DREG_TEMP_LI %d10
 #define DREG_TEMP %d11
 #define DREG_TEST_NUM %d14
@@ -24,6 +27,17 @@ test_ ## num:                                     \
     mov DREG_TEST_NUM, num;                       \
     jne testreg, DREG_CORRECT_RESULT, fail        \
 
+#define TEST_CASE_PSW(num, testreg, correct, correct_psw, code...) \
+test_ ## num:                                                      \
+    code;                                                          \
+    LI(DREG_CORRECT_RESULT, correct)                               \
+    mov DREG_TEST_NUM, num;                                        \
+    jne testreg, DREG_CORRECT_RESULT, fail;                        \
+    mfcr DREG_CALC_PSW, $psw;                                      \
+    LI(DREG_CORRECT_PSW, correct_psw)                              \
+    mov DREG_TEST_NUM, num;                                        \
+    jne DREG_CALC_PSW, DREG_CORRECT_PSW, fail;
+
 /* Actual test case type
  * e.g inst %dX, %dY      -> TEST_D_D
  *     inst %dX, %dY, %dZ -> TEST_D_DD
@@ -35,6 +49,16 @@ test_ ## num:                                     \
     insn DREG_CALC_RESULT, DREG_RS1;          \
     )
 
+#define TEST_D_DD_PSW(insn, num, result, psw, rs1, rs2) \
+    TEST_CASE_PSW(num, DREG_CALC_RESULT, result, psw,   \
+    LI(DREG_RS1, rs1);                                  \
+    LI(DREG_RS2, rs2);                                  \
+    rstv;                                               \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2;          \
+    )
+
+
+
 /* Pass/Fail handling part */
 #define TEST_PASSFAIL                       \
         j pass;                             \
diff --git a/tests/tcg/tricore/test_bmerge.S b/tests/tcg/tricore/test_bmerge.S
new file mode 100644
index 0000000000..8a0fa6d3f6
--- /dev/null
+++ b/tests/tcg/tricore/test_bmerge.S
@@ -0,0 +1,8 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_DD_PSW(bmerge, 1, 0x555557f7, 0x00000b80, 0x0000001d, 0x0000ffff)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
