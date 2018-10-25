Received: from eggs.gnu.org ([2001:4830:134:3::10]:44649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjVJ-0000In-Vl
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjVG-0000Ty-S2
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:33:05 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:32997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjVG-0000QZ-Jv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:33:02 -0400
Date: Thu, 25 Oct 2018 19:32:50 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <edd7dd4e42e2b874333999341734cb6acfe8df82.1540487815.git.noring@nocrew.org>
References: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540487815.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 06/11] tests/tcg/mips: Test R5900 three-operand
 MADD1
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
 tests/tcg/mips/mipsr5900/madd.c | 43 +++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/mips/mipsr5900/madd.c b/tests/tcg/mips/mipsr5900/madd.c
index 9ad2ea6dbb..f6f215e1c3 100644
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
2.18.1
