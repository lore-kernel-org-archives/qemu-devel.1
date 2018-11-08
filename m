Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpIc-0006ye-Hx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpIW-0003B6-Cy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:45:02 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:30573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKpIV-0002PI-R6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:44:56 -0500
Date: Thu, 8 Nov 2018 19:43:40 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <b04427024562b10c852a5519b57033e094fcdc3b.1541701393.git.noring@nocrew.org>
References: <cover.1541701393.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541701393.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 2/2] tests/tcg/mips: Test user mode DMULT for
 the R5900
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

The R5900 reports itself as MIPS III but does not implement DMULT.
Verify that DMULT is emulated properly in user mode by multiplying
two 64-bit numbers to produce a 128-bit number.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 tests/tcg/mips/mipsn32r5900/Makefile | 25 +++++++++++++++++
 tests/tcg/mips/mipsn32r5900/dmult.c  | 40 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tests/tcg/mips/mipsn32r5900/Makefile
 create mode 100644 tests/tcg/mips/mipsn32r5900/dmult.c

diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn32r5900/Makefile
new file mode 100644
index 0000000000..7dd16723fe
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
+TESTCASES = dmult.tst
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
diff --git a/tests/tcg/mips/mipsn32r5900/dmult.c b/tests/tcg/mips/mipsn32r5900/dmult.c
new file mode 100644
index 0000000000..2827ab5358
--- /dev/null
+++ b/tests/tcg/mips/mipsn32r5900/dmult.c
@@ -0,0 +1,40 @@
+/*
+ * Test DMULT.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+struct hi_lo { int64_t hi; uint64_t lo; };
+
+static struct hi_lo dmult(int64_t rs, int64_t rt)
+{
+    int64_t hi;
+    uint64_t lo;
+
+    /*
+     * The R5900 reports itself as MIPS III but does not implement DMULT.
+     * Verify that DMULT is emulated properly in user mode.
+     */
+    __asm__ __volatile__ (
+            "    .set  mips3\n"
+            "    dmult %2, %3\n"
+            "    mfhi  %0\n"
+            "    mflo  %1\n"
+            : "=r" (hi), "=r" (lo)
+            : "r" (rs), "r" (rt));
+
+    return (struct hi_lo) { .hi = hi, .lo = lo };
+}
+
+int main()
+{
+    /* Verify that multiplying two 64-bit numbers yields a 128-bit number. */
+    struct hi_lo r = dmult(2760727302517, 5665449960167);
+
+    assert(r.hi == 847887);
+    assert(r.lo == 7893651516417804947);
+
+    return 0;
+}
-- 
2.18.1
