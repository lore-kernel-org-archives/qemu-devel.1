Received: from eggs.gnu.org ([2001:4830:134:3::10]:49949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWBC-0004uy-LH
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDWB9-000357-LH
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:54 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDWB9-00033v-EM
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:22:51 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Tue,  1 May 2018 16:22:13 +0200
Message-Id: <20180501142222.19154-4-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [RFC PATCH 03/12] tests/tcg/tricore: Add macros to
 easily create tests and first test 'abs'
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

This kind of tests is inspired by the riscv-tests repository. This adds
macros that makes it easy to create single instruction self containing
tests.

This is achieved by macros that create a test sequence for an
instruction and check for a supplied correct value. If the value is correct the
next instruction is tested. Otherwise we jump to fail handler that writes is
test number as a status code back to qemu that then exits on that status code.
If all tests pass we write back 0 as a status code and exit.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 tests/tcg/tricore/Makefile   |  2 ++
 tests/tcg/tricore/macros.h   | 53 ++++++++++++++++++++++++++++++++++++++++++++
 tests/tcg/tricore/test_abs.S |  8 +++++++
 3 files changed, 63 insertions(+)
 create mode 100644 tests/tcg/tricore/macros.h
 create mode 100644 tests/tcg/tricore/test_abs.S

diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
index 8c168d1062..a0e1f4b20d 100644
--- a/tests/tcg/tricore/Makefile
+++ b/tests/tcg/tricore/Makefile
@@ -8,6 +8,8 @@ ASFLAGS =
 SIM = ../../../tricore-softmmu/qemu-system-tricore
 SIMFLAGS = -M tricore_testboard -nographic -kernel
 
+TESTCASES += test_abs.tst
+
 all: build
 
 %.pS: %.S
diff --git a/tests/tcg/tricore/macros.h b/tests/tcg/tricore/macros.h
new file mode 100644
index 0000000000..76c133132a
--- /dev/null
+++ b/tests/tcg/tricore/macros.h
@@ -0,0 +1,53 @@
+/* Helpers */
+#define LI(reg, val)           \
+    mov.u reg, lo:val;         \
+    movh DREG_TEMP_LI, up:val; \
+    or reg, reg, DREG_TEMP_LI; \
+
+/* Address definitions */
+#define TESTDEV_ADDR 0xf0000000
+/* Register definitions */
+#define DREG_RS1 %d0
+#define DREG_CALC_RESULT %d1
+#define DREG_TEMP_LI %d10
+#define DREG_TEMP %d11
+#define DREG_TEST_NUM %d14
+#define DREG_CORRECT_RESULT %d15
+
+#define DREG_DEV_ADDR %a15
+
+/* Test case wrappers */
+#define TEST_CASE(num, testreg, correct, code...) \
+test_ ## num:                                     \
+    code;                                         \
+    LI(DREG_CORRECT_RESULT, correct)              \
+    mov DREG_TEST_NUM, num;                       \
+    jne testreg, DREG_CORRECT_RESULT, fail        \
+
+/* Actual test case type
+ * e.g inst %dX, %dY      -> TEST_D_D
+ *     inst %dX, %dY, %dZ -> TEST_D_DD
+ *     inst %eX, %dY, %dZ -> TEST_E_DD
+ */
+#define TEST_D_D(insn, num, result, rs1)      \
+    TEST_CASE(num, DREG_CALC_RESULT, result,  \
+    LI(DREG_RS1, rs1);                        \
+    insn DREG_CALC_RESULT, DREG_RS1;          \
+    )
+
+/* Pass/Fail handling part */
+#define TEST_PASSFAIL                       \
+        j pass;                             \
+fail:                                       \
+        LI(DREG_TEMP, TESTDEV_ADDR)         \
+        mov.a DREG_DEV_ADDR, DREG_TEMP;     \
+        st.w [DREG_DEV_ADDR], DREG_TEST_NUM;\
+        debug;                              \
+        j fail;                             \
+pass:                                       \
+        LI(DREG_TEMP, TESTDEV_ADDR)         \
+        mov.a DREG_DEV_ADDR, DREG_TEMP;     \
+        mov DREG_TEST_NUM, 0;               \
+        st.w [DREG_DEV_ADDR], DREG_TEST_NUM;\
+        debug;                              \
+        j pass;
diff --git a/tests/tcg/tricore/test_abs.S b/tests/tcg/tricore/test_abs.S
new file mode 100644
index 0000000000..acc143901c
--- /dev/null
+++ b/tests/tcg/tricore/test_abs.S
@@ -0,0 +1,8 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_D(abs, 1, 0, 0)
+
+    TEST_PASSFAIL
+
-- 
2.11.0
