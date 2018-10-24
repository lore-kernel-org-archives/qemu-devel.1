Received: from eggs.gnu.org ([2001:4830:134:3::10]:60156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQd-0005AS-6C
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQa-00020h-Vt
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49956 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQY-0001rw-Ox
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:36 +0200
Message-Id: <1540388447-27062-23-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 22/33] tests/tcg/mips: Add tests for R5900
 three-operand MULT
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

Add a test for MULT.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/mipsr5900/Makefile | 25 +++++++++++++++++++++
 tests/tcg/mips/mipsr5900/mult.c   | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 tests/tcg/mips/mipsr5900/Makefile
 create mode 100644 tests/tcg/mips/mipsr5900/mult.c

diff --git a/tests/tcg/mips/mipsr5900/Makefile b/tests/tcg/mips/mipsr5900/Makefile
new file mode 100644
index 0000000..6757168
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
index 0000000..2c0c16d
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
2.7.4
