Received: from eggs.gnu.org ([2001:4830:134:3::10]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQd-0005AZ-7S
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQa-00020S-RR
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49958 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQY-0001sZ-Jw
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:37 +0200
Message-Id: <1540388447-27062-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 23/33] tests/tcg/mips: Add tests for R5900
 three-operand MULTU
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

Add a test for MULTU.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/Makefile |  1 +
 tests/tcg/mips/mipsr5900/multu.c  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/multu.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index 6757168..b3ddb9a 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -9,6 +9,7 @@ CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
 TESTCASES = mult.tst
+TESTCASES += multu.tst
 
 all: $(TESTCASES)
 
diff --git a/tests/tcg/mips/mipsr5900/multu.c b/tests/tcg/mips/mipsr5900/multu.c
new file mode 100644
index 0000000..3a59675
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/multu.c
@@ -0,0 +1,39 @@
+/*
+ * Test R5900-specific three-operand MULTU.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+static uint64_t multu(uint32_t rs, uint32_t rt)
+{
+    uint32_t rd, lo, hi;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    multu %0, %3, %4\n"
+            "    mflo %1\n"
+            "    mfhi %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((uint64_t)hi << 32) | (uint32_t)lo;
+
+    assert((uint64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+int main()
+{
+    assert(multu(17, 19) == 323);
+    assert(multu(77773, 99991) == 7776600043);
+    assert(multu(12207031, 305175781) == 3725290219116211);
+
+    assert(multu(0x80000000U, 0x7FFFFFFF) == 0x3FFFFFFF80000000);
+    assert(multu(0x80000000U, 0x80000000U) ==  0x4000000000000000);
+    assert(multu(0xFFFFFFFFU, 0xFFFFFFFFU) ==  0xFFFFFFFE00000001U);
+
+    return 0;
+}
-- 
2.7.4
