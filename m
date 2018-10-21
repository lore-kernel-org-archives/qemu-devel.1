Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFt0-0000AX-Km
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFsw-0006Uj-Hi
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:43:25 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFsv-0006Te-IM
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:43:22 -0400
Date: Sun, 21 Oct 2018 17:43:14 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <1f3d1bd100d08d014aa64dd6b22215a64f130fa9.1540134919.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 33/38] tests/tcg/mips: Test R5900
 three-operand MADD
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
 tests/tcg/mips/mipsr5900/madd.c   | 45 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/madd.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index a1c388bc3c..97ca2a671c 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -10,6 +10,7 @@ CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
 TESTCASES = div1.tst
 TESTCASES += divu1.tst
+TESTCASES += madd.tst
 TESTCASES += mflohi1.tst
 TESTCASES += mtlohi1.tst
 TESTCASES += mult.tst
diff --git a/tests/tcg/mips/mipsr5900/madd.c b/tests/tcg/mips/mipsr5900/madd.c
new file mode 100644
index 0000000000..9ad2ea6dbb
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/madd.c
@@ -0,0 +1,45 @@
+/*
+ * Test R5900-specific three-operand MADD.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+int64_t madd(int64_t a, int32_t rs, int32_t rt)
+{
+    int32_t lo = a;
+    int32_t hi = a >> 32;
+    int32_t rd;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo %5\n"
+            "    mthi %6\n"
+            "    madd %0, %3, %4\n"
+            "    mflo %1\n"
+            "    mfhi %2\n"
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
+static void verify_madd(int64_t a, int32_t rs, int32_t rt, int64_t expected)
+{
+    assert(madd(a, rs, rt) == expected);
+    assert(madd(a, -rs, rt) == a + a - expected);
+    assert(madd(a, rs, -rt) == a + a - expected);
+    assert(madd(a, -rs, -rt) == expected);
+}
+
+int main()
+{
+    verify_madd(13, 17, 19, 336);
+
+    return 0;
+}
-- 
2.18.1
