Received: from eggs.gnu.org ([209.51.188.92]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil7p-00073H-0m
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil7o-0006XM-4g
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:08:49 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil7n-0006X4-QR
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:08:48 -0500
Date: Sun, 13 Jan 2019 20:08:39 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <e1efe4eff36a4069bbf8411a09d01acd387fb49d.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 8/9] tests/tcg/mips: Test R5900 multimedia
 instruction LQ
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
 tests/tcg/mips/mipsn32r5900/Makefile |   3 +-
 tests/tcg/mips/mipsn32r5900/lq.c     | 111 +++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/mipsn32r5900/lq.c

diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn32r5900/Makefile
index f4887678ae..cb3ef9d26a 100644
--- a/tests/tcg/mips/mipsn32r5900/Makefile
+++ b/tests/tcg/mips/mipsn32r5900/Makefile
@@ -8,7 +8,8 @@ SIM_FLAGS=-cpu R5900
 CC      = $(CROSS)gcc
 CFLAGS  = -Wall -mabi=n32 -march=r5900 -static
 
-TESTCASES = pcpyuld.tst
+TESTCASES = lq.tst
+TESTCASES += pcpyuld.tst
 
 all: $(TESTCASES)
 
diff --git a/tests/tcg/mips/mipsn32r5900/lq.c b/tests/tcg/mips/mipsn32r5900/lq.c
new file mode 100644
index 0000000000..5a16b12450
--- /dev/null
+++ b/tests/tcg/mips/mipsn32r5900/lq.c
@@ -0,0 +1,111 @@
+/*
+ * Test LQ.
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <assert.h>
+
+/* 128-bit multimedia register */
+struct mmr { uint64_t hi, lo; } __attribute__((aligned(16)));
+
+#define LQ(base, offset) \
+    ({ \
+        uint64_t hi, lo; \
+    \
+        __asm__ __volatile__ ( \
+            "    pcpyld  %1, %1, %1\n" \
+            "    lq %1, %3(%2)\n" \
+            "    pcpyud  %0, %1, %1\n" \
+            : "=r" (hi), "=r" (lo) \
+            : "r" (base), "i" (offset)); \
+    \
+        (struct mmr) { .hi = hi, .lo = lo }; \
+    })
+
+static uint64_t ld_reference(const void *base, int16_t offset)
+{
+    const uint8_t *p = base;
+    uint64_t r = 0;
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        r |= (uint64_t)p[offset + i] << (8 * i);
+    }
+
+    return r;
+}
+
+static struct mmr lq_reference(const void *base, int16_t offset)
+{
+    /*
+     * The least significant four bits of the effective address are
+     * masked to zero, effectively creating an aligned address. No
+     * address exceptions due to alignment are possible.
+     */
+    const uint8_t *b = base;
+    const uint8_t *o = &b[offset];
+    const void *a = (const void*)((unsigned long)o & ~0xFUL);
+
+    return (struct mmr) {
+        .hi = ld_reference(a, 8),
+        .lo = ld_reference(a, 0)
+    };
+}
+
+static void assert_equal_mmr(struct mmr a, struct mmr b)
+{
+    assert(a.hi == b.hi);
+    assert(a.lo == b.lo);
+}
+
+#define VERIFY_LQ(base, offset) \
+    assert_equal_mmr(LQ(base, offset), lq_reference(base, offset))
+
+int main()
+{
+    static const char data[] __attribute__((aligned(16)))=
+        "0123456789abcdef"
+        "ghijklmnopqrstuv"
+        "wxyzABCDEFGHIJKL"
+        "MNOPQRSTUVWXYZ.,";
+    int i;
+
+    for (i = 16; i < 48; i++) {
+        VERIFY_LQ(&data[i], -16);
+        VERIFY_LQ(&data[i], -15);
+        VERIFY_LQ(&data[i], -14);
+        VERIFY_LQ(&data[i], -13);
+        VERIFY_LQ(&data[i], -12);
+        VERIFY_LQ(&data[i], -11);
+        VERIFY_LQ(&data[i], -10);
+        VERIFY_LQ(&data[i], -9);
+        VERIFY_LQ(&data[i], -8);
+        VERIFY_LQ(&data[i], -7);
+        VERIFY_LQ(&data[i], -6);
+        VERIFY_LQ(&data[i], -5);
+        VERIFY_LQ(&data[i], -4);
+        VERIFY_LQ(&data[i], -3);
+        VERIFY_LQ(&data[i], -2);
+        VERIFY_LQ(&data[i], -1);
+        VERIFY_LQ(&data[i],  0);
+        VERIFY_LQ(&data[i],  1);
+        VERIFY_LQ(&data[i],  2);
+        VERIFY_LQ(&data[i],  3);
+        VERIFY_LQ(&data[i],  4);
+        VERIFY_LQ(&data[i],  5);
+        VERIFY_LQ(&data[i],  6);
+        VERIFY_LQ(&data[i],  7);
+        VERIFY_LQ(&data[i],  8);
+        VERIFY_LQ(&data[i],  9);
+        VERIFY_LQ(&data[i],  10);
+        VERIFY_LQ(&data[i],  11);
+        VERIFY_LQ(&data[i],  12);
+        VERIFY_LQ(&data[i],  13);
+        VERIFY_LQ(&data[i],  14);
+        VERIFY_LQ(&data[i],  15);
+        VERIFY_LQ(&data[i],  16);
+    }
+
+    return 0;
+}
-- 
2.19.2
