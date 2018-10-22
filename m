Received: from eggs.gnu.org ([2001:4830:134:3::10]:46141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmt-0000Ji-37
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmq-0008EL-6l
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:26 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33467 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmp-000852-NB
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:49 +0200
Message-Id: <1540213077-15211-27-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 26/34] tests/tcg/mips: Test R5900 three-operand
 MULTU1
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

Add a test for MULTU1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/multu.c | 43 +++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/multu.c b/tests/tcg/mips/mipsr5900/multu.c
index 3a59675..f043904 100644
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
2.7.4
