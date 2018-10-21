Received: from eggs.gnu.org ([2001:4830:134:3::10]:46874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrQ-0006Ph-2t
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrM-0005c9-UV
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:48 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFrM-0005bm-Mp
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:44 -0400
Date: Sun, 21 Oct 2018 17:41:32 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <37b455609e450610e7b19e227a6e7e9c6117a9f8.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 28/38] tests/tcg/mips: Test R5900
 three-operand MULTU1
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
 tests/tcg/mips/mipsr5900/multu.c | 43 ++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/multu.c b/tests/tcg/mips/mipsr5900/multu.c
index 3a59675395..f043904d69 100644
--- a/tests/tcg/mips/mipsr5900/multu.c
+++ b/tests/tcg/mips/mipsr5900/multu.c
@@ -1,5 +1,5 @@
 /*
- * Test R5900-specific three-operand MULTU.
+ * Test R5900-specific three-operand MULTU and MULTU1.
  */
 
 #include <stdio.h>
@@ -25,15 +25,44 @@ static uint64_t multu(uint32_t rs, uint32_t rt)
     return r;
 }
 
+static uint64_t multu1(uint32_t rs, uint32_t rt)
+{
+    uint32_t rd, lo, hi;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    multu1 %0, %3, %4\n"
+            "    mflo1 %1\n"
+            "    mfhi1 %2\n"
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
+static uint64_t multu_variants(uint32_t rs, uint32_t rt)
+{
+    uint64_t rd  = multu(rs, rt);
+    uint64_t rd1 = multu1(rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
 int main()
 {
-    assert(multu(17, 19) == 323);
-    assert(multu(77773, 99991) == 7776600043);
-    assert(multu(12207031, 305175781) == 3725290219116211);
+    assert(multu_variants(17, 19) == 323);
+    assert(multu_variants(77773, 99991) == 7776600043);
+    assert(multu_variants(12207031, 305175781) == 3725290219116211);
 
-    assert(multu(0x80000000U, 0x7FFFFFFF) == 0x3FFFFFFF80000000);
-    assert(multu(0x80000000U, 0x80000000U) ==  0x4000000000000000);
-    assert(multu(0xFFFFFFFFU, 0xFFFFFFFFU) ==  0xFFFFFFFE00000001U);
+    assert(multu_variants(0x80000000U, 0x7FFFFFFF) == 0x3FFFFFFF80000000);
+    assert(multu_variants(0x80000000U, 0x80000000U) ==  0x4000000000000000);
+    assert(multu_variants(0xFFFFFFFFU, 0xFFFFFFFFU) ==  0xFFFFFFFE00000001U);
 
     return 0;
 }
-- 
2.18.1
