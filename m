Received: from eggs.gnu.org ([2001:4830:134:3::10]:49954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004v3-LL
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBA-00036E-P2
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWBA-00035C-Et
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:52 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:16 +0200
Message-Id: <20180501142222.19154-7-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 06/12] tests/tcg/tricore: Add dvstep test
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
 tests/tcg/tricore/macros.h      | 29 ++++++++++++++++++++++++++++-
 tests/tcg/tricore/test_dvstep.S | 15 +++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/tricore/test_dvstep.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index 16ec5460d7..36f15a7544 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -11,6 +11,7 @@ SIMFLAGS = -M tricore_testboard -nographic -kernel
 TESTCASES += test_abs.tst
 TESTCASES += test_bmerge.tst
 TESTCASES += test_clz.tst
+TESTCASES += test_dvstep.tst
 
 all: build
 
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/macros.h
index 52aa936c56..59b4b9a352 100644
--- a/tests/tcg/tricore/macros.h
+++ b/tests/tcg/tricore/macros.h
@@ -19,6 +19,18 @@
 
 #define DREG_DEV_ADDR %a15
 
+#define EREG_RS1 %e6
+#define EREG_RS1_LO %d6
+#define EREG_RS1_HI %d7
+#define EREG_RS2 %e8
+#define EREG_RS2_LO %d8
+#define EREG_RS2_HI %d9
+#define EREG_CALC_RESULT %e8
+#define EREG_CALC_RESULT_HI %d9
+#define EREG_CALC_RESULT_LO %d8
+#define EREG_CORRECT_RESULT_LO %d0
+#define EREG_CORRECT_RESULT_HI %d1
+
 /* Test case wrappers */
 #define TEST_CASE(num, testreg, correct, code...) \
 test_ ## num:                                     \
@@ -27,6 +39,15 @@ test_ ## num:                                     \
     mov DREG_TEST_NUM, num;                       \
     jne testreg, DREG_CORRECT_RESULT, fail        \
 
+#define TEST_CASE_E(num, correct_lo, correct_hi, code...)  \
+test_ ## num:                                              \
+    code;                                                  \
+    mov DREG_TEST_NUM, num;                                \
+    LI(EREG_CORRECT_RESULT_LO, correct_lo)                 \
+    jne EREG_CALC_RESULT_LO, EREG_CORRECT_RESULT_LO, fail; \
+    LI(EREG_CORRECT_RESULT_HI, correct_hi)                 \
+    jne EREG_CALC_RESULT_HI, EREG_CORRECT_RESULT_HI, fail;
+
 #define TEST_CASE_PSW(num, testreg, correct, correct_psw, code...) \
 test_ ## num:                                                      \
     code;                                                          \
@@ -57,7 +78,13 @@ test_ ## num:                                                      \
     insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2;          \
     )
 
-
+#define TEST_E_ED(insn, num, res_hi, res_lo, rs1_hi, rs1_lo, rs2) \
+    TEST_CASE_E(num, res_lo, res_hi,                              \
+    LI(EREG_RS1_LO, rs1_lo);                                      \
+    LI(EREG_RS1_HI, rs1_hi);                                      \
+    LI(DREG_RS2, rs2);                                            \
+    insn EREG_CALC_RESULT, EREG_RS1, DREG_RS2;                    \
+    )
 
 /* Pass/Fail handling part */
 #define TEST_PASSFAIL                       \
diff --git a/tests/tcg/tricore/test_dvstep.S b/tests/tcg/tricore/test_dvstep.S
new file mode 100644
index 0000000000..858dbc62dd
--- /dev/null
+++ b/tests/tcg/tricore/test_dvstep.S
@@ -0,0 +1,15 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    #                              Result                   RS1            RS2
+    TEST_E_ED(dvstep,   1, 0x000001ff, 0xfffe5cff, 0x00000001, 0xfffffe5c, 0x0)
+    TEST_E_ED(dvstep,   2, 0x00000000, 0x000000ff, 0x00000000, 0x00000000, 0x0)
+    TEST_E_ED(dvstep,   3, 0x0000f000, 0x000000fd, 0x010000f0, 0x00000000, 0x0)
+    TEST_E_ED(dvstep,   4, 0xfffff000, 0x00000000, 0x7ffffff0, 0x00000000, 0x0)
+    TEST_E_ED(dvstep.u, 5, 0xffffff00, 0x100008ff, 0xffffffff, 0x00100008, 0x0)
+    TEST_E_ED(dvstep.u, 6, 0x00000100, 0x00000000, 0x08000001, 0x00000000, \
+                           0xffffff2d)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
