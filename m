Received: from eggs.gnu.org ([208.118.235.92]:58094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcpBs-0000JN-Oy
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 05:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcosp-0007cV-Tm
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:56:48 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49733 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoPO-0003KE-Ju
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:22 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:46 +0100
Message-Id: <1545989148-13582-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 39/41] tests/tcg: mips: Test R5900 three-operand
 MADD1
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

Test R5900 three-operand MADD1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsr5900/madd.c | 43 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/madd.c b/tests/tcg/mips/mipsr5900/madd.c
index 9ad2ea6..f6f215e 100644
--- a/tests/tcg/mips/mipsr5900/madd.c
+++ b/tests/tcg/mips/mipsr5900/madd.c
@@ -1,5 +1,5 @@
 /*
- * Test R5900-specific three-operand MADD.
+ * Test R5900-specific three-operand MADD and MADD1.
  */
 
 #include <stdio.h>
@@ -29,12 +29,45 @@ int64_t madd(int64_t a, int32_t rs, int32_t rt)
     return r;
 }
 
+int64_t madd1(int64_t a, int32_t rs, int32_t rt)
+{
+    int32_t lo = a;
+    int32_t hi = a >> 32;
+    int32_t rd;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo1 %5\n"
+            "    mthi1 %6\n"
+            "    madd1 %0, %3, %4\n"
+            "    mflo1 %1\n"
+            "    mfhi1 %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert(a + (int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t madd_variants(int64_t a, int32_t rs, int32_t rt)
+{
+    int64_t rd  = madd(a, rs, rt);
+    int64_t rd1 = madd1(a, rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
 static void verify_madd(int64_t a, int32_t rs, int32_t rt, int64_t expected)
 {
-    assert(madd(a, rs, rt) == expected);
-    assert(madd(a, -rs, rt) == a + a - expected);
-    assert(madd(a, rs, -rt) == a + a - expected);
-    assert(madd(a, -rs, -rt) == expected);
+    assert(madd_variants(a, rs, rt) == expected);
+    assert(madd_variants(a, -rs, rt) == a + a - expected);
+    assert(madd_variants(a, rs, -rt) == a + a - expected);
+    assert(madd_variants(a, -rs, -rt) == expected);
 }
 
 int main()
-- 
2.7.4
