Received: from eggs.gnu.org ([2001:4830:134:3::10]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFra-0006YZ-4s
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrX-0005ho-0V
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:58 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFrW-0005hD-PU
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:54 -0400
Date: Sun, 21 Oct 2018 17:41:47 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <16415de65ec690062e2d1fbd06f105b85661f4df.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 29/38] tests/tcg/mips: Test R5900 MFLO1 and
 MFHI1
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
 tests/tcg/mips/mipsr5900/Makefile  |  3 ++-
 tests/tcg/mips/mipsr5900/mflohi1.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/mipsr5900/mflohi1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index b3ddb9a7bf..fd8ee6b0e3 100644
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
index 0000000000..eed3683dc5
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
2.18.1
