Received: from eggs.gnu.org ([209.51.188.92]:34735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil8o-0007r1-Nw
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil8n-0006zH-1W
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:09:50 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil8l-0006y4-5b
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:09:47 -0500
Date: Sun, 13 Jan 2019 20:09:44 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <f12b05b6581daa925e253a9639dd44d34441a511.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 9/9] tests/tcg/mips: Test R5900 multimedia
 instruction SQ
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
 tests/tcg/mips/mipsn32r5900/Makefile |   1 +
 tests/tcg/mips/mipsn32r5900/sq.c     | 105 +++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tests/tcg/mips/mipsn32r5900/sq.c

diff --git a/tests/tcg/mips/mipsn32r5900/Makefile b/tests/tcg/mips/mipsn32r5900/Makefile
index cb3ef9d26a..a9e9481457 100644
--- a/tests/tcg/mips/mipsn32r5900/Makefile
+++ b/tests/tcg/mips/mipsn32r5900/Makefile
@@ -10,6 +10,7 @@ CFLAGS  = -Wall -mabi=n32 -march=r5900 -static
 
 TESTCASES = lq.tst
 TESTCASES += pcpyuld.tst
+TESTCASES += sq.tst
 
 all: $(TESTCASES)
 
diff --git a/tests/tcg/mips/mipsn32r5900/sq.c b/tests/tcg/mips/mipsn32r5900/sq.c
new file mode 100644
index 0000000000..97b21711ba
--- /dev/null
+++ b/tests/tcg/mips/mipsn32r5900/sq.c
@@ -0,0 +1,105 @@
+/*
+ * Test SQ.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+#include <assert.h>
+
+#define GUARD_BYTE 0xA9
+
+/* 128-bit multimedia register */
+struct mmr { uint64_t hi, lo; } __attribute__((aligned(16)));
+
+static uint8_t data[64];
+
+#define SQ(value, base, offset) \
+        __asm__ __volatile__ ( \
+            "    pcpyld  %0, %0, %1\n" \
+            "    sq %0, %3(%2)\n" \
+            : \
+            : "r" (value.hi), "r" (value.lo), \
+              "r" (base), "i" (offset))
+
+static void verify_sq(struct mmr value, const void *base, int16_t offset)
+{
+    /*
+     * The least significant four bits of the effective address are
+     * masked to zero, effectively creating an aligned address. No
+     * address exceptions due to alignment are possible.
+     */
+    const uint8_t *b = base;
+    const uint8_t *o = &b[offset];
+    const uint8_t *a = (const uint8_t*)((unsigned long)o & ~0xFUL);
+    size_t i;
+
+    for (i = 0; i < sizeof(data); i++) {
+        ssize_t d = &data[i] - &a[0];
+
+        if (d < 0) {
+            assert(data[i] == GUARD_BYTE);
+        } else if (d < 8) {
+            assert(data[i] == ((value.lo >> (8 * (d - 0))) & 0xFF));
+        } else if (d < 16) {
+            assert(data[i] == ((value.hi >> (8 * (d - 8))) & 0xFF));
+        } else {
+            assert(data[i] == GUARD_BYTE);
+        }
+    }
+}
+
+#define VERIFY_SQ(base, offset) \
+    do { \
+        struct mmr value = { \
+            .hi = 0x6665646362613938, \
+            .lo = 0x3736353433323130 \
+        }; \
+    \
+        memset(data, GUARD_BYTE, sizeof(data)); \
+        SQ(value, base, offset); \
+        verify_sq(value, base, offset); \
+    } while (0)
+
+int main()
+{
+    int i;
+
+    for (i = 16; i < 48; i++) {
+        VERIFY_SQ(&data[i], -16);
+        VERIFY_SQ(&data[i], -15);
+        VERIFY_SQ(&data[i], -14);
+        VERIFY_SQ(&data[i], -13);
+        VERIFY_SQ(&data[i], -12);
+        VERIFY_SQ(&data[i], -11);
+        VERIFY_SQ(&data[i], -10);
+        VERIFY_SQ(&data[i], -9);
+        VERIFY_SQ(&data[i], -8);
+        VERIFY_SQ(&data[i], -7);
+        VERIFY_SQ(&data[i], -6);
+        VERIFY_SQ(&data[i], -5);
+        VERIFY_SQ(&data[i], -4);
+        VERIFY_SQ(&data[i], -3);
+        VERIFY_SQ(&data[i], -2);
+        VERIFY_SQ(&data[i], -1);
+        VERIFY_SQ(&data[i],  0);
+        VERIFY_SQ(&data[i],  1);
+        VERIFY_SQ(&data[i],  2);
+        VERIFY_SQ(&data[i],  3);
+        VERIFY_SQ(&data[i],  4);
+        VERIFY_SQ(&data[i],  5);
+        VERIFY_SQ(&data[i],  6);
+        VERIFY_SQ(&data[i],  7);
+        VERIFY_SQ(&data[i],  8);
+        VERIFY_SQ(&data[i],  9);
+        VERIFY_SQ(&data[i],  10);
+        VERIFY_SQ(&data[i],  11);
+        VERIFY_SQ(&data[i],  12);
+        VERIFY_SQ(&data[i],  13);
+        VERIFY_SQ(&data[i],  14);
+        VERIFY_SQ(&data[i],  15);
+        VERIFY_SQ(&data[i],  16);
+    }
+
+    return 0;
+}
-- 
2.19.2
