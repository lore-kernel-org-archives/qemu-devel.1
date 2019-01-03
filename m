Received: from eggs.gnu.org ([208.118.235.92]:38614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UN-0004rC-Tr
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UL-00082K-1I
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:59 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46272 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UK-0007kZ-O6
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:17 +0100
Message-Id: <1546535297-11040-45-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 44/44] tests/tcg: mips: Test R5900
 three-operand MADDU1
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

Test R5900 three-operand MADDU1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsr5900/maddu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/maddu.c b/tests/tcg/mips/mipsr5900/maddu.c
index e4e5521..30936fb 100644
--- a/tests/tcg/mips/mipsr5900/maddu.c
+++ b/tests/tcg/mips/mipsr5900/maddu.c
@@ -1,5 +1,5 @@
 /*
- * Test R5900-specific three-operand MADDU.
+ * Test R5900-specific three-operand MADDU and MADDU1.
  */
 
 #include <stdio.h>
@@ -29,9 +29,42 @@ uint64_t maddu(uint64_t a, uint32_t rs, uint32_t rt)
     return r;
 }
 
+uint64_t maddu1(uint64_t a, uint32_t rs, uint32_t rt)
+{
+    uint32_t lo = a;
+    uint32_t hi = a >> 32;
+    uint32_t rd;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo1  %5\n"
+            "    mthi1  %6\n"
+            "    maddu1 %0, %3, %4\n"
+            "    mflo1  %1\n"
+            "    mfhi1  %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt), "r" (lo), "r" (hi));
+    r = ((uint64_t)hi << 32) | (uint32_t)lo;
+
+    assert(a + (uint64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static int64_t maddu_variants(int64_t a, int32_t rs, int32_t rt)
+{
+    int64_t rd  = maddu(a, rs, rt);
+    int64_t rd1 = maddu1(a, rs, rt);
+
+    assert(rd == rd1);
+
+    return rd;
+}
+
 int main()
 {
-    assert(maddu(13, 17, 19) == 336);
+    assert(maddu_variants(13, 17, 19) == 336);
 
     return 0;
 }
-- 
2.7.4
