Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZn4-0000ez-BV
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmy-0008Jp-0n
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33776 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmx-00089k-OJ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:31 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:53 +0200
Message-Id: <1540213077-15211-31-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 30/34] tests/tcg/mips: Test R5900 DIVU1
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

add a test for DIVU1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/Makefile |  1 +
 tests/tcg/mips/mipsr5900/divu1.c  | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/divu1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index 757eb83..a1c388b 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -9,6 +9,7 @@ CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
 TESTCASES = div1.tst
+TESTCASES += divu1.tst
 TESTCASES += mflohi1.tst
 TESTCASES += mtlohi1.tst
 TESTCASES += mult.tst
diff --git a/tests/tcg/mips/mipsr5900/divu1.c b/tests/tcg/mips/mipsr5900/divu1.c
new file mode 100644
index 0000000..72aeed3
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/divu1.c
@@ -0,0 +1,48 @@
+/*
+ * Test R5900-specific DIVU1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+struct quotient_remainder { uint32_t quotient, remainder; };
+
+static struct quotient_remainder divu1(uint32_t rs, uint32_t rt)
+{
+    uint32_t lo, hi;
+
+    __asm__ __volatile__ (
+            "    divu1 $0, %2, %3\n"
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
+static void verify_divu1(uint32_t rs, uint32_t rt,
+                         uint32_t expected_quotient,
+                         uint32_t expected_remainder)
+{
+    struct quotient_remainder qr = divu1(rs, rt);
+
+    assert(qr.quotient == expected_quotient);
+    assert(qr.remainder == expected_remainder);
+}
+
+int main()
+{
+    verify_divu1(0, 1, 0, 0);
+    verify_divu1(1, 1, 1, 0);
+    verify_divu1(1, 2, 0, 1);
+    verify_divu1(17, 19, 0, 17);
+    verify_divu1(19, 17, 1, 2);
+    verify_divu1(77773, 101, 770, 3);
+
+    return 0;
+}
-- 
2.7.4
