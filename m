Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZn6-0000gg-50
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZn5-0008Ob-5F
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33773 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZn4-00089U-Pk
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:38 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:50 +0200
Message-Id: <1540213077-15211-28-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 27/34] tests/tcg/mips: Test R5900 MFLO1 and MFHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

Add a test for MFLO1 and MFHI1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/Makefile  |  3 ++-
 tests/tcg/mips/mipsr5900/mflohi1.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/mipsr5900/mflohi1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index b3ddb9a..fd8ee6b 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -8,7 +8,8 @@ SIM_FLAGS=-cpu R5900
 CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
-TESTCASES = mult.tst
+TESTCASES = mflohi1.tst
+TESTCASES += mult.tst
 TESTCASES += multu.tst
 
 all: $(TESTCASES)
diff --git a/tests/tcg/mips/mipsr5900/mflohi1.c b/tests/tcg/mips/mipsr5900/mflohi1.c
new file mode 100644
index 0000000..eed3683
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/mflohi1.c
@@ -0,0 +1,35 @@
+/*
+ * Test R5900-specific MFLO1 and MFHI1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+int main()
+{
+    int32_t rs  = 12207031, rt  = 305175781;
+    int32_t rs1 = 32452867, rt1 = 49979687;
+    int64_t lo, hi, lo1, hi1;
+    int64_t r, r1;
+
+    /* Test both LO/HI and LO1/HI1 to verify separation. */
+    __asm__ __volatile__ (
+            "    mult $0, %4, %5\n"
+            "    mult1 $0, %6, %7\n"
+            "    mflo %0\n"
+            "    mfhi %1\n"
+            "    mflo1 %2\n"
+            "    mfhi1 %3\n"
+            : "=r" (lo),  "=r" (hi),
+              "=r" (lo1), "=r" (hi1)
+            : "r" (rs),  "r" (rt),
+              "r" (rs1), "r" (rt1));
+    r  = ((int64_t)hi  << 32) | (uint32_t)lo;
+    r1 = ((int64_t)hi1 << 32) | (uint32_t)lo1;
+
+    assert(r  == 3725290219116211);
+    assert(r1 == 1621984134912629);
+
+    return 0;
+}
-- 
2.7.4
