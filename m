Received: from eggs.gnu.org ([2001:4830:134:3::10]:46731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFqu-000607-Vf
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFqr-0005Mj-Qb
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:16 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFqr-0005Jk-J6
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:41:13 -0400
Date: Sun, 21 Oct 2018 17:41:01 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <b72eb39dd9c465d110e3df2e3660c32c979d0e4d.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 25/38] tests/tcg/mips: Test R5900
 three-operand MULT
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
 tests/tcg/mips/mipsr5900/Makefile | 25 ++++++++++++++++
 tests/tcg/mips/mipsr5900/mult.c   | 47 +++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/Makefile
 create mode 100644 tests/tcg/mips/mipsr5900/mult.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
new file mode 100644
index 0000000000..6757168fc9
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/Makefile
@@ -0,0 +1,25 @@
+-include ../../config-host.mak
+
+CROSS=mipsr5900el-unknown-linux-gnu-
+
+SIM=qemu-mipsel
+SIM_FLAGS=-cpu R5900
+
+CC      = $(CROSS)gcc
+CFLAGS  = -Wall -mabi=32 -march=r5900 -static
+
+TESTCASES = mult.tst
+
+all: $(TESTCASES)
+
+%.tst: %.c
+	$(CC) $(CFLAGS) $< -o $@
+
+check: $(TESTCASES)
+	@for case in $(TESTCASES); do \
+        echo $(SIM) $(SIM_FLAGS) ./$$case;\
+        $(SIM) $(SIM_FLAGS) ./$$case; \
+	done
+
+clean:
+	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/mips/mipsr5900/mult.c b/tests/tcg/mips/mipsr5900/mult.c
new file mode 100644
index 0000000000..2c0c16d232
--- /dev/null
+++ b/tests/tcg/mips/mipsr5900/mult.c
@@ -0,0 +1,47 @@
+/*
+ * Test R5900-specific three-operand MULT.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+static int64_t mult(int32_t rs, int32_t rt)
+{
+    int32_t rd, lo, hi;
+    int64_t r;
+
+    __asm__ __volatile__ (
+            "    mult %0, %3, %4\n"
+            "    mflo %1\n"
+            "    mfhi %2\n"
+            : "=r" (rd), "=r" (lo), "=r" (hi)
+            : "r" (rs), "r" (rt));
+    r = ((int64_t)hi << 32) | (uint32_t)lo;
+
+    assert((int64_t)rs * rt == r);
+    assert(rd == lo);
+
+    return r;
+}
+
+static void verify_mult_negations(int32_t rs, int32_t rt, int64_t expected)
+{
+    assert(mult(rs, rt) == expected);
+    assert(mult(-rs, rt) == -expected);
+    assert(mult(rs, -rt) == -expected);
+    assert(mult(-rs, -rt) == expected);
+}
+
+int main()
+{
+    verify_mult_negations(17, 19, 323);
+    verify_mult_negations(77773, 99991, 7776600043);
+    verify_mult_negations(12207031, 305175781, 3725290219116211);
+
+    assert(mult(-0x80000000,  0x7FFFFFFF) == -0x3FFFFFFF80000000);
+    assert(mult(-0x80000000, -0x7FFFFFFF) ==  0x3FFFFFFF80000000);
+    assert(mult(-0x80000000, -0x80000000) ==  0x4000000000000000);
+
+    return 0;
+}
-- 
2.18.1
