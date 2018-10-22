Received: from eggs.gnu.org ([2001:4830:134:3::10]:46135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmt-0000Jc-0n
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmp-0008Dr-Nj
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:26 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33466 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmo-000854-1J
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:51 +0200
Message-Id: <1540213077-15211-29-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 28/34] tests/tcg/mips: Test R5900 MTLO1 and MTHI1
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

Add a test for MTLO1 and MTHI1.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/Makefile  |  1 +
 tests/tcg/mips/mipsr5900/mtlohi1.c | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/mtlohi1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index fd8ee6b..287c248 100644
--- a/tests/tcg/mips/mipsr5900/Makefile
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -9,6 +9,7 @@ CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=32 -march=r5900 -static
 
 TESTCASES = mflohi1.tst
+TESTCASES += mtlohi1.tst
 TESTCASES += mult.tst
 TESTCASES += multu.tst
 
diff --git a/tests/tcg/mips/mipsr5900/mtlohi1.c b/tests/tcg/mips/mipsr5900/mtlohi1.c
new file mode 100644
index 0000000..7f3e728
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/mtlohi1.c
@@ -0,0 +1,40 @@
+/*
+ * Test R5900-specific MTLO1 and MTHI1.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+int main()
+{
+    int32_t tlo  = 12207031, thi  = 305175781;
+    int32_t tlo1 = 32452867, thi1 = 49979687;
+    int32_t flo, fhi, flo1, fhi1;
+
+    /* Test both LO/HI and LO1/HI1 to verify separation. */
+    __asm__ __volatile__ (
+            "    mtlo  %4\n"
+            "    mthi  %5\n"
+            "    mtlo1 %6\n"
+            "    mthi1 %7\n"
+            "    move  %0, $0\n"
+            "    move  %1, $0\n"
+            "    move  %2, $0\n"
+            "    move  %3, $0\n"
+            "    mflo  %0\n"
+            "    mfhi  %1\n"
+            "    mflo1 %2\n"
+            "    mfhi1 %3\n"
+            : "=r" (flo),  "=r" (fhi),
+              "=r" (flo1), "=r" (fhi1)
+            : "r" (tlo),  "r" (thi),
+              "r" (tlo1), "r" (thi1));
+
+    assert(flo  == 12207031);
+    assert(fhi  == 305175781);
+    assert(flo1 == 32452867);
+    assert(fhi1 == 49979687);
+
+    return 0;
+}
-- 
2.7.4
