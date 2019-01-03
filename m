Received: from eggs.gnu.org ([208.118.235.92]:38600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UN-0004qG-BQ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UK-00081u-Sl
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:59 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46269 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UK-0007jY-Ho
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:14 +0100
Message-Id: <1546535297-11040-42-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 41/44] tests/tcg: mips: Test R5900
 three-operand MADD
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

Test R5900 three-operand MADD.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsr5900/Makefile |  1 +
 tests/tcg/mips/mipsr5900/madd.c   | 45 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/madd.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index a1c388b..97ca2a6 100644
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
index 0000000..9ad2ea6
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
2.7.4
