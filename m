Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQb-00058n-4X
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQY-0001zC-E2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49959 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQW-0001sb-FM
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:25 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:38 +0200
Message-Id: <1540388447-27062-25-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 24/33] tests/tcg/mips: Add tests for R5900
 three-operand MULT1
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

Add a test for MULT1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/mult.c | 45 +++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/mult.c b/tests/tcg/mips/mipsr5900/mult.c
index 2c0c16d..5710b39 100644
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
2.7.4
