Received: from eggs.gnu.org ([2001:4830:134:3::10]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFs6-0006zY-FE
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFs3-00062G-5L
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:42:30 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFs2-00061x-Sa
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:42:27 -0400
Date: Sun, 21 Oct 2018 17:42:19 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <76c3c6692e62384c2a0c8b81e7142cdb039ef412.1540134919.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 32/38] tests/tcg/mips: Test R5900 DIVU1
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
 tests/tcg/mips/mipsr5900/divu1.c  | 48 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/divu1.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
index 757eb83862..a1c388bc3c 100644
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
index 0000000000..72aeed31de
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
2.18.1
