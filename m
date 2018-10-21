Received: from eggs.gnu.org ([2001:4830:134:3::10]:46984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrw-0006qb-1K
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFrq-0005vB-Cs
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:42:18 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFrm-0005tU-UP
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:42:11 -0400
Date: Sun, 21 Oct 2018 17:41:58 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <34d804d77e02394b2af7e93804eea8cb0b44f832.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 30/38] tests/tcg/mips: Test R5900 MTLO1 and
 MTHI1
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
 tests/tcg/mips/mipsr5900/Makefile  |  1 +
 tests/tcg/mips/mipsr5900/mtlohi1.c | 40 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/mtlohi1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index fd8ee6b0e3..287c248f6d 100644
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
index 0000000000..7f3e72835a
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
2.18.1
