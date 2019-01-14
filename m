Received: from eggs.gnu.org ([209.51.188.92]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4r-0005Zr-PL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4p-0007Sx-AF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4n-0007RL-1b
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:37 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:02 +0100
Message-Id: <1547460140-1473-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 07/25] tests/endianesss: Make test independent
 of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

Pass around the test state explicitly, to be able to use the qtest_in*()
and qtest_out*() function in this test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/endianness-test.c | 329 ++++++++++++++++++++++++------------------------
 1 file changed, 166 insertions(+), 163 deletions(-)

diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index 48680cd..5852795 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -48,65 +48,68 @@ static const TestCase test_cases[] = {
     {}
 };
 
-static uint8_t isa_inb(const TestCase *test, uint16_t addr)
+static uint8_t isa_inb(QTestState *qts, const TestCase *test, uint16_t addr)
 {
     uint8_t value;
     if (test->isa_base == -1) {
-        value = inb(addr);
+        value = qtest_inb(qts, addr);
     } else {
-        value = readb(test->isa_base + addr);
+        value = qtest_readb(qts, test->isa_base + addr);
     }
     return value;
 }
 
-static uint16_t isa_inw(const TestCase *test, uint16_t addr)
+static uint16_t isa_inw(QTestState *qts, const TestCase *test, uint16_t addr)
 {
     uint16_t value;
     if (test->isa_base == -1) {
-        value = inw(addr);
+        value = qtest_inw(qts, addr);
     } else {
-        value = readw(test->isa_base + addr);
+        value = qtest_readw(qts, test->isa_base + addr);
     }
     return test->bswap ? bswap16(value) : value;
 }
 
-static uint32_t isa_inl(const TestCase *test, uint16_t addr)
+static uint32_t isa_inl(QTestState *qts, const TestCase *test, uint16_t addr)
 {
     uint32_t value;
     if (test->isa_base == -1) {
-        value = inl(addr);
+        value = qtest_inl(qts, addr);
     } else {
-        value = readl(test->isa_base + addr);
+        value = qtest_readl(qts, test->isa_base + addr);
     }
     return test->bswap ? bswap32(value) : value;
 }
 
-static void isa_outb(const TestCase *test, uint16_t addr, uint8_t value)
+static void isa_outb(QTestState *qts, const TestCase *test, uint16_t addr,
+                     uint8_t value)
 {
     if (test->isa_base == -1) {
-        outb(addr, value);
+        qtest_outb(qts, addr, value);
     } else {
-        writeb(test->isa_base + addr, value);
+        qtest_writeb(qts, test->isa_base + addr, value);
     }
 }
 
-static void isa_outw(const TestCase *test, uint16_t addr, uint16_t value)
+static void isa_outw(QTestState *qts, const TestCase *test, uint16_t addr,
+                     uint16_t value)
 {
     value = test->bswap ? bswap16(value) : value;
     if (test->isa_base == -1) {
-        outw(addr, value);
+        qtest_outw(qts, addr, value);
     } else {
-        writew(test->isa_base + addr, value);
+        qtest_writew(qts, test->isa_base + addr, value);
     }
 }
 
-static void isa_outl(const TestCase *test, uint16_t addr, uint32_t value)
+static void isa_outl(QTestState *qts, const TestCase *test, uint16_t addr,
+                     uint32_t value)
 {
     value = test->bswap ? bswap32(value) : value;
     if (test->isa_base == -1) {
-        outl(addr, value);
+        qtest_outl(qts, addr, value);
     } else {
-        writel(test->isa_base + addr, value);
+        qtest_writel(qts, test->isa_base + addr, value);
     }
 }
 
@@ -114,161 +117,161 @@ static void isa_outl(const TestCase *test, uint16_t addr, uint32_t value)
 static void test_endianness(gconstpointer data)
 {
     const TestCase *test = data;
-
-    global_qtest = qtest_initf("-M %s%s%s -device pc-testdev",
-                               test->machine,
-                               test->superio ? " -device " : "",
-                               test->superio ?: "");
-    isa_outl(test, 0xe0, 0x87654321);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x87);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x65);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x43);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x21);
-
-    isa_outw(test, 0xe2, 0x8866);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x88664321);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8866);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x88);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x66);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x43);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x21);
-
-    isa_outw(test, 0xe0, 0x4422);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x88664422);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8866);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4422);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x88);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x66);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x44);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x22);
-
-    isa_outb(test, 0xe3, 0x87);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87664422);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8766);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x87);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x66);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x44);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x22);
-
-    isa_outb(test, 0xe2, 0x65);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654422);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4422);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x87);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x65);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x44);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x22);
-
-    isa_outb(test, 0xe1, 0x43);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654322);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4322);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x87);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x65);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x43);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x22);
-
-    isa_outb(test, 0xe0, 0x21);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
-    g_assert_cmphex(isa_inb(test, 0xe3), ==, 0x87);
-    g_assert_cmphex(isa_inb(test, 0xe2), ==, 0x65);
-    g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x43);
-    g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x21);
-    qtest_quit(global_qtest);
+    QTestState *qts;
+
+    qts = qtest_initf("-M %s%s%s -device pc-testdev", test->machine,
+                      test->superio ? " -device " : "",
+                      test->superio ?: "");
+    isa_outl(qts, test, 0xe0, 0x87654321);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654321);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4321);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x87);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x65);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x43);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x21);
+
+    isa_outw(qts, test, 0xe2, 0x8866);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x88664321);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8866);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4321);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x88);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x66);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x43);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x21);
+
+    isa_outw(qts, test, 0xe0, 0x4422);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x88664422);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8866);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4422);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x88);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x66);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x44);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x22);
+
+    isa_outb(qts, test, 0xe3, 0x87);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87664422);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8766);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x87);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x66);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x44);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x22);
+
+    isa_outb(qts, test, 0xe2, 0x65);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654422);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4422);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x87);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x65);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x44);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x22);
+
+    isa_outb(qts, test, 0xe1, 0x43);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654322);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4322);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x87);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x65);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x43);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x22);
+
+    isa_outb(qts, test, 0xe0, 0x21);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654321);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4321);
+    g_assert_cmphex(isa_inb(qts, test, 0xe3), ==, 0x87);
+    g_assert_cmphex(isa_inb(qts, test, 0xe2), ==, 0x65);
+    g_assert_cmphex(isa_inb(qts, test, 0xe1), ==, 0x43);
+    g_assert_cmphex(isa_inb(qts, test, 0xe0), ==, 0x21);
+    qtest_quit(qts);
 }
 
 static void test_endianness_split(gconstpointer data)
 {
     const TestCase *test = data;
-
-    global_qtest = qtest_initf("-M %s%s%s -device pc-testdev",
-                               test->machine,
-                               test->superio ? " -device " : "",
-                               test->superio ?: "");
-    isa_outl(test, 0xe8, 0x87654321);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
-
-    isa_outw(test, 0xea, 0x8866);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x88664321);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8866);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
-
-    isa_outw(test, 0xe8, 0x4422);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x88664422);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8866);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4422);
-
-    isa_outb(test, 0xeb, 0x87);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87664422);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8766);
-
-    isa_outb(test, 0xea, 0x65);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654422);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4422);
-
-    isa_outb(test, 0xe9, 0x43);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654322);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4322);
-
-    isa_outb(test, 0xe8, 0x21);
-    g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
-    g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
-    qtest_quit(global_qtest);
+    QTestState *qts;
+
+    qts = qtest_initf("-M %s%s%s -device pc-testdev", test->machine,
+                      test->superio ? " -device " : "",
+                      test->superio ?: "");
+    isa_outl(qts, test, 0xe8, 0x87654321);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654321);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4321);
+
+    isa_outw(qts, test, 0xea, 0x8866);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x88664321);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8866);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4321);
+
+    isa_outw(qts, test, 0xe8, 0x4422);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x88664422);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8866);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4422);
+
+    isa_outb(qts, test, 0xeb, 0x87);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87664422);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8766);
+
+    isa_outb(qts, test, 0xea, 0x65);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654422);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4422);
+
+    isa_outb(qts, test, 0xe9, 0x43);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654322);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4322);
+
+    isa_outb(qts, test, 0xe8, 0x21);
+    g_assert_cmphex(isa_inl(qts, test, 0xe0), ==, 0x87654321);
+    g_assert_cmphex(isa_inw(qts, test, 0xe2), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe0), ==, 0x4321);
+    qtest_quit(qts);
 }
 
 static void test_endianness_combine(gconstpointer data)
 {
     const TestCase *test = data;
-
-    global_qtest = qtest_initf("-M %s%s%s -device pc-testdev",
-                               test->machine,
-                               test->superio ? " -device " : "",
-                               test->superio ?: "");
-    isa_outl(test, 0xe0, 0x87654321);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654321);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4321);
-
-    isa_outw(test, 0xe2, 0x8866);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x88664321);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8866);
-    g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4321);
-
-    isa_outw(test, 0xe0, 0x4422);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x88664422);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8866);
-    g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4422);
-
-    isa_outb(test, 0xe3, 0x87);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87664422);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8766);
-
-    isa_outb(test, 0xe2, 0x65);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654422);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4422);
-
-    isa_outb(test, 0xe1, 0x43);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654322);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4322);
-
-    isa_outb(test, 0xe0, 0x21);
-    g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654321);
-    g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
-    g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4321);
-    qtest_quit(global_qtest);
+    QTestState *qts;
+
+    qts = qtest_initf("-M %s%s%s -device pc-testdev", test->machine,
+                      test->superio ? " -device " : "",
+                      test->superio ?: "");
+    isa_outl(qts, test, 0xe0, 0x87654321);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x87654321);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe8), ==, 0x4321);
+
+    isa_outw(qts, test, 0xe2, 0x8866);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x88664321);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8866);
+    g_assert_cmphex(isa_inw(qts, test, 0xe8), ==, 0x4321);
+
+    isa_outw(qts, test, 0xe0, 0x4422);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x88664422);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8866);
+    g_assert_cmphex(isa_inw(qts, test, 0xe8), ==, 0x4422);
+
+    isa_outb(qts, test, 0xe3, 0x87);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x87664422);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8766);
+
+    isa_outb(qts, test, 0xe2, 0x65);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x87654422);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe8), ==, 0x4422);
+
+    isa_outb(qts, test, 0xe1, 0x43);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x87654322);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe8), ==, 0x4322);
+
+    isa_outb(qts, test, 0xe0, 0x21);
+    g_assert_cmphex(isa_inl(qts, test, 0xe8), ==, 0x87654321);
+    g_assert_cmphex(isa_inw(qts, test, 0xea), ==, 0x8765);
+    g_assert_cmphex(isa_inw(qts, test, 0xe8), ==, 0x4321);
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1
