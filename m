Received: from eggs.gnu.org ([2001:4830:134:3::10]:47949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFtV-0000eE-1B
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFtR-0006sj-Pb
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:43:56 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFtR-0006qs-HS
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:43:53 -0400
Date: Sun, 21 Oct 2018 17:43:37 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <8bbbf24b886ba075f757e9823a5bab868dec7b18.1540134919.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 35/38] tests/tcg/mips: Test R5900
 three-operand MADDU
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
 tests/tcg/mips/mipsr5900/maddu.c  | 37 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/maddu.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index 97ca2a671c..27ee5d5f54 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -11,6 +11,7 @@ CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 TESTCASES = div1.tst
 TESTCASES += divu1.tst
 TESTCASES += madd.tst
+TESTCASES += maddu.tst
 TESTCASES += mflohi1.tst
 TESTCASES += mtlohi1.tst
 TESTCASES += mult.tst
diff --git a/tests/tcg/mips/mipsr5900/maddu.c b/tests/tcg/mips/mipsr5900/maddu.c
new file mode 100644
index 0000000000..e4e552102d
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/maddu.c
@@ -0,0 +1,37 @@
+/*
+ * Test R5900-specific three-operand MADDU.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+uint64_t maddu(uint64_t a, uint32_t rs, uint32_t rt)
+{
+    uint32_t lo = a;
+    uint32_t hi = a >> 32;
+    uint32_t rd;
+    uint64_t r;
+
+    __asm__ __volatile__ (
+            "    mtlo  %5\n"
+            "    mthi  %6\n"
+            "    maddu %0, %3, %4\n"
+            "    mflo  %1\n"
+            "    mfhi  %2\n"
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
+int main()
+{
+    assert(maddu(13, 17, 19) == 336);
+
+    return 0;
+}
-- 
2.18.1
