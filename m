Received: from eggs.gnu.org ([209.51.188.92]:34175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil6q-0006Gp-25
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil6o-00064n-5E
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:07:47 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:55676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil6m-00063g-9C
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:07:44 -0500
Date: Sun, 13 Jan 2019 20:07:29 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <5a4aa79777985d3d5c777ad2cdc6fdee9081345f.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 7/9] tests/tcg/mips: Test R5900 multimedia
 instructions PCPYUD and PCPYLD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsn32r5900/Makefile  | 25 +++++++++++++++
 tests/tcg/mips/mipsn32r5900/pcpyuld.c | 46 +++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tests/tcg/mips/mipsn32r5900/Makefile
 create mode 100644 tests/tcg/mips/mipsn32r5900/pcpyuld.c

diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn32r5900/Makefile
new file mode 100644
index 0000000000..f4887678ae
--- /dev/null
+++ b/tests/tcg/mips/mipsn32r5900/Makefile
@@ -0,0 +1,25 @@
+-include ../../config-host.mak
+
+CROSS=mips64r5900el-unknown-linux-gnu-
+
+SIM=qemu-mipsn32el
+SIM_FLAGS=-cpu R5900
+
+CC      = $(CROSS)gcc
+CFLAGS  = -Wall -mabi=n32 -march=r5900 -static
+
+TESTCASES = pcpyuld.tst
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
diff --git a/tests/tcg/mips/mipsn32r5900/pcpyuld.c b/tests/tcg/mips/mipsn32r5900/pcpyuld.c
new file mode 100644
index 0000000000..c92af6330b
--- /dev/null
+++ b/tests/tcg/mips/mipsn32r5900/pcpyuld.c
@@ -0,0 +1,46 @@
+/*
+ * Test PCPYUD and PCPYLD.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+#include <assert.h>
+
+/* 128-bit multimedia register */
+struct mmr { uint64_t hi, lo; } __attribute__((aligned(16)));
+
+static void verify_zero(void)
+{
+    __asm__ __volatile__ (
+        "    pcpyud  $0, $0, $0\n"
+        "    pcpyld  $0, $0, $0\n"
+    );
+}
+
+static void verify_copy(void)
+{
+    const struct mmr value = {
+        .hi = 0x6665646362613938,
+        .lo = 0x3736353433323130
+    };
+    struct mmr result = { };
+
+    __asm__ __volatile__ (
+        "    pcpyld  %0, %2, %3\n"
+        "    move    %1, %0\n"
+        "    pcpyud  %0, %0, %0\n"
+        : "=r" (result.hi), "=r" (result.lo)
+        : "r" (value.hi), "r" (value.lo));
+
+    assert(value.hi == result.hi);
+    assert(value.lo == result.lo);
+}
+
+int main()
+{
+    verify_zero();
+    verify_copy();
+
+    return 0;
+}
-- 
2.19.2
