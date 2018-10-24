Received: from eggs.gnu.org ([2001:4830:134:3::10]:60232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQh-0005GC-Di
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQd-00023L-3P
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49962 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQa-0001sp-S0
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:30 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:42 +0200
Message-Id: <1540388447-27062-29-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 28/33] tests/tcg/mips: Add tests for R5900
 DIV1
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

Add a test for DIV1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/Makefile |  3 +-
 tests/tcg/mips/mipsr5900/div1.c   | 73 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/mipsr5900/div1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index 287c248..757eb83 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -8,7 +8,8 @@ SIM_FLAGS=-cpu R5900
 CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
-TESTCASES = mflohi1.tst
+TESTCASES = div1.tst
+TESTCASES += mflohi1.tst
 TESTCASES += mtlohi1.tst
 TESTCASES += mult.tst
 TESTCASES += multu.tst
diff --git a/tests/tcg/mips/mipsr5900/div1.c b/tests/tcg/mips/mipsr5900/div1.c
new file mode 100644
index 0000000..83dafa0
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/div1.c
@@ -0,0 +1,73 @@
+/*
+ * Test R5900-specific DIV1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+struct quotient_remainder { int32_t quotient, remainder; };
+
+static struct quotient_remainder div1(int32_t rs, int32_t rt)
+{
+    int32_t lo, hi;
+
+    __asm__ __volatile__ (
+            "    div1 $0, %2, %3\n"
+            "    mflo1 %0\n"
+            "    mfhi1 %1\n"
+            : "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+
+    assert(rs / rt == lo);
+    assert(rs % rt == hi);
+
+    return (struct quotient_remainder) { .quotient = lo, .remainder = hi };
+}
+
+static void verify_div1(int32_t rs, int32_t rt,
+                        int32_t expected_quotient,
+                        int32_t expected_remainder)
+{
+    struct quotient_remainder qr = div1(rs, rt);
+
+    assert(qr.quotient == expected_quotient);
+    assert(qr.remainder == expected_remainder);
+}
+
+static void verify_div1_negations(int32_t rs, int32_t rt,
+                                  int32_t expected_quotient,
+                                  int32_t expected_remainder)
+{
+    verify_div1(rs, rt, expected_quotient, expected_remainder);
+    verify_div1(rs, -rt, -expected_quotient, expected_remainder);
+    verify_div1(-rs, rt, -expected_quotient, -expected_remainder);
+    verify_div1(-rs, -rt, expected_quotient, -expected_remainder);
+}
+
+int main()
+{
+    verify_div1_negations(0, 1, 0, 0);
+    verify_div1_negations(1, 1, 1, 0);
+    verify_div1_negations(1, 2, 0, 1);
+    verify_div1_negations(17, 19, 0, 17);
+    verify_div1_negations(19, 17, 1, 2);
+    verify_div1_negations(77773, 101, 770, 3);
+
+    verify_div1(-0x80000000,  1, -0x80000000, 0);
+
+    /*
+     * Supplementary explanation from the Toshiba TX System RISC TX79 Core
+     * Architecture manual, A-38 and B-7, https://wiki.qemu.org/File:C790.pdf
+     *
+     * Normally, when 0x80000000 (-2147483648) the signed minimum value is
+     * divided by 0xFFFFFFFF (-1), the operation will result in an overflow.
+     * However, in this instruction an overflow exception doesn't occur and
+     * the result will be as follows:
+     *
+     * Quotient is 0x80000000 (-2147483648), and remainder is 0x00000000 (0).
+     */
+    verify_div1(-0x80000000, -1, -0x80000000, 0);
+
+    return 0;
+}
-- 
2.7.4
