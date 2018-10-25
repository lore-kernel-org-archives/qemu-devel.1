Received: from eggs.gnu.org ([2001:4830:134:3::10]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjVu-0001pU-TO
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjVp-0000lV-Tt
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:33:42 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:40957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjVp-0000fj-JV
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:33:37 -0400
Date: Thu, 25 Oct 2018 19:33:08 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <f455bbec993d916edf09c0c399fd54506461ced8.1540487815.git.noring@nocrew.org>
References: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540487815.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 08/11] tests/tcg/mips: Test R5900 three-operand
 MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsr5900/maddu.c | 37 ++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/maddu.c b/tests/tcg/mips/mipsr5900/maddu.c
index e4e552102d..30936fb2b4 100644
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
2.18.1
