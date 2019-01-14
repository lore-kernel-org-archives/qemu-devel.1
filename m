Received: from eggs.gnu.org ([209.51.188.92]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4v-0005c8-P8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4p-0007TZ-R9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4p-0007SG-8s
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:03 +0100
Message-Id: <1547460140-1473-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 08/25] tests/boot-order: Make test independent
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

Pass around the QTestState from function to function, so that we can finally
get rid of the out-of-favor global_qtest variable in this file, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-order-test.c | 59 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index c60ebcf..a725bce 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -17,7 +17,7 @@
 #include "standard-headers/linux/qemu_fw_cfg.h"
 
 /* TODO actually test the results and get rid of this */
-#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+#define qmp_discard_response(qs, ...) qobject_unref(qtest_qmp(qs, __VA_ARGS__))
 
 typedef struct {
     const char *args;
@@ -27,31 +27,30 @@ typedef struct {
 
 static void test_a_boot_order(const char *machine,
                               const char *test_args,
-                              uint64_t (*read_boot_order)(void),
+                              uint64_t (*read_boot_order)(QTestState *),
                               uint64_t expected_boot,
                               uint64_t expected_reboot)
 {
     uint64_t actual;
+    QTestState *qts;
 
-    global_qtest = qtest_initf("-nodefaults%s%s %s",
-                               machine ? " -M " : "",
-                               machine ?: "",
-                               test_args);
-    actual = read_boot_order();
+    qts = qtest_initf("-nodefaults%s%s %s", machine ? " -M " : "",
+                      machine ?: "", test_args);
+    actual = read_boot_order(qts);
     g_assert_cmphex(actual, ==, expected_boot);
-    qmp_discard_response("{ 'execute': 'system_reset' }");
+    qmp_discard_response(qts, "{ 'execute': 'system_reset' }");
     /*
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
      */
-    qmp_eventwait("RESET");
-    actual = read_boot_order();
+    qtest_qmp_eventwait(qts, "RESET");
+    actual = read_boot_order(qts);
     g_assert_cmphex(actual, ==, expected_reboot);
-    qtest_quit(global_qtest);
+    qtest_quit(qts);
 }
 
 static void test_boot_orders(const char *machine,
-                             uint64_t (*read_boot_order)(void),
+                             uint64_t (*read_boot_order)(QTestState *),
                              const boot_order_test *tests)
 {
     int i;
@@ -64,16 +63,16 @@ static void test_boot_orders(const char *machine,
     }
 }
 
-static uint8_t read_mc146818(uint16_t port, uint8_t reg)
+static uint8_t read_mc146818(QTestState *qts, uint16_t port, uint8_t reg)
 {
-    outb(port, reg);
-    return inb(port + 1);
+    qtest_outb(qts, port, reg);
+    return qtest_inb(qts, port + 1);
 }
 
-static uint64_t read_boot_order_pc(void)
+static uint64_t read_boot_order_pc(QTestState *qts)
 {
-    uint8_t b1 = read_mc146818(0x70, 0x38);
-    uint8_t b2 = read_mc146818(0x70, 0x3d);
+    uint8_t b1 = read_mc146818(qts, 0x70, 0x38);
+    uint8_t b2 = read_mc146818(qts, 0x70, 0x3d);
 
     return b1 | (b2 << 8);
 }
@@ -109,16 +108,16 @@ static void test_pc_boot_order(void)
     test_boot_orders(NULL, read_boot_order_pc, test_cases_pc);
 }
 
-static uint8_t read_m48t59(uint64_t addr, uint16_t reg)
+static uint8_t read_m48t59(QTestState *qts, uint64_t addr, uint16_t reg)
 {
-    writeb(addr, reg & 0xff);
-    writeb(addr + 1, reg >> 8);
-    return readb(addr + 3);
+    qtest_writeb(qts, addr, reg & 0xff);
+    qtest_writeb(qts, addr + 1, reg >> 8);
+    return qtest_readb(qts, addr + 3);
 }
 
-static uint64_t read_boot_order_prep(void)
+static uint64_t read_boot_order_prep(QTestState *qts)
 {
-    return read_m48t59(0x80000000 + 0x74, 0x34);
+    return read_m48t59(qts, 0x80000000 + 0x74, 0x34);
 }
 
 static const boot_order_test test_cases_prep[] = {
@@ -133,9 +132,9 @@ static void test_prep_boot_order(void)
     test_boot_orders("prep", read_boot_order_prep, test_cases_prep);
 }
 
-static uint64_t read_boot_order_pmac(void)
+static uint64_t read_boot_order_pmac(QTestState *qts)
 {
-    QFWCFG *fw_cfg = mm_fw_cfg_init(global_qtest, 0xf0000510);
+    QFWCFG *fw_cfg = mm_fw_cfg_init(qts, 0xf0000510);
 
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
@@ -158,9 +157,9 @@ static void test_pmac_newworld_boot_order(void)
     test_boot_orders("mac99", read_boot_order_pmac, test_cases_fw_cfg);
 }
 
-static uint64_t read_boot_order_sun4m(void)
+static uint64_t read_boot_order_sun4m(QTestState *qts)
 {
-    QFWCFG *fw_cfg = mm_fw_cfg_init(global_qtest, 0xd00000510ULL);
+    QFWCFG *fw_cfg = mm_fw_cfg_init(qts, 0xd00000510ULL);
 
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
@@ -170,9 +169,9 @@ static void test_sun4m_boot_order(void)
     test_boot_orders("SS-5", read_boot_order_sun4m, test_cases_fw_cfg);
 }
 
-static uint64_t read_boot_order_sun4u(void)
+static uint64_t read_boot_order_sun4u(QTestState *qts)
 {
-    QFWCFG *fw_cfg = io_fw_cfg_init(global_qtest, 0x510);
+    QFWCFG *fw_cfg = io_fw_cfg_init(qts, 0x510);
 
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
-- 
1.8.3.1
