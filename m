Received: from eggs.gnu.org ([2001:4830:134:3::10]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFr5-00068J-K6
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFr2-0005U5-Ei
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:27 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFr2-0005Sq-5W
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:24 -0400
Date: Sun, 21 Oct 2018 17:41:21 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <2909560e25c4fa5899533558fbe94897e6bf83e5.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 27/38] tests/tcg/mips: Test R5900
 three-operand MULT1
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
 tests/tcg/mips/mipsr5900/mult.c | 45 +++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/mult.c b/tests/tcg/mips/mipsr5900/mult.c
index 2c0c16d232..5710b395e6 100644
--- a/tests/tcg/mips/mipsr5900/mult.c
+++ b/tests/tcg/mips/mipsr5900/mult.c
@@ -1,5 +1,5 @@
 /*
- * Test R5900-specific three-operand MULT.
+ * Test R5900-specific three-operand MULT and MULT1.
  */
 
 #include <stdio.h>
@@ -25,12 +25,41 @@ static int64_t mult(int32_t rs, int32_t rt)
     return r;
 }
 
+static int64_t mult1(int32_t rs, int32_t rt)
+{
+    int32_t rd, lo, hi;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mult1 %0, %3, %4\n"
+            "    mflo1 %1\n"
+            "    mfhi1 %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert((int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t mult_variants(int32_t rs, int32_t rt)
+{
+    int64_t rd  = mult(rs, rt);
+    int64_t rd1 = mult1(rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
 static void verify_mult_negations(int32_t rs, int32_t rt, int64_t expected)
 {
-    assert(mult(rs, rt) == expected);
-    assert(mult(-rs, rt) == -expected);
-    assert(mult(rs, -rt) == -expected);
-    assert(mult(-rs, -rt) == expected);
+    assert(mult_variants(rs, rt) == expected);
+    assert(mult_variants(-rs, rt) == -expected);
+    assert(mult_variants(rs, -rt) == -expected);
+    assert(mult_variants(-rs, -rt) == expected);
 }
 
 int main()
@@ -39,9 +68,9 @@ int main()
     verify_mult_negations(77773, 99991, 7776600043);
     verify_mult_negations(12207031, 305175781, 3725290219116211);
 
-    assert(mult(-0x80000000,  0x7FFFFFFF) == -0x3FFFFFFF80000000);
-    assert(mult(-0x80000000, -0x7FFFFFFF) ==  0x3FFFFFFF80000000);
-    assert(mult(-0x80000000, -0x80000000) ==  0x4000000000000000);
+    assert(mult_variants(-0x80000000,  0x7FFFFFFF) == -0x3FFFFFFF80000000);
+    assert(mult_variants(-0x80000000, -0x7FFFFFFF) ==  0x3FFFFFFF80000000);
+    assert(mult_variants(-0x80000000, -0x80000000) ==  0x4000000000000000);
 
     return 0;
 }
-- 
2.18.1
