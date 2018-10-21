Received: from eggs.gnu.org ([2001:4830:134:3::10]:46812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrC-0006EV-Fj
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrA-0005Xj-Ge
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:34 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFr8-0005Wj-Pv
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:32 -0400
Date: Sun, 21 Oct 2018 17:41:13 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <cbbd082da291cfe03a4136bfd49f0ac39134dc66.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 26/38] tests/tcg/mips: Test R5900
 three-operand MULTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsr5900/Makefile |  1 +
 tests/tcg/mips/mipsr5900/multu.c  | 39 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/multu.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index 6757168fc9..b3ddb9a7bf 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -9,6 +9,7 @@ CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
 TESTCASES = mult.tst
+TESTCASES += multu.tst
 
 all: $(TESTCASES)
 
diff --git a/tests/tcg/mips/mipsr5900/multu.c b/tests/tcg/mips/mipsr5900/multu.c
new file mode 100644
index 0000000000..3a59675395
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
2.18.1
