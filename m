Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmrA-000119-Nw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoC-00057g-Ey
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:21 -0400
Received: from m12-14.163.com ([220.181.12.14]:59356)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoB-00055l-HT
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:20 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 03:00:53 -0700
Message-Id: <20190420100056.116305-2-liq3ea@163.com>
In-Reply-To: <20190420100056.116305-1-liq3ea@163.com>
References: <20190420100056.116305-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 1/4] tests: refactor fw_cfg_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Currently, fw_cfg_test uses one QTestState for every test case.
This will add all command lines for every test case and
this is unnecessary. This patch split the test cases and for
every test case it uses his own QTestState. This patch does following
things:

1. Get rid of the global 'fw_cfg', this need add a uninit function

2. Convert every test case in a separate QTestState

After this patch, we can add fw_cfg test case freely and will not
have efect other test cases.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/fw_cfg-test.c   | 86 ++++++++++++++++++++++++++++++++++++++-----
 tests/libqos/fw_cfg.c | 10 +++++
 tests/libqos/fw_cfg.h |  7 ++++
 3 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1c5103fe1c..c22503619f 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -21,62 +21,127 @@ static uint16_t nb_cpus = 1;
 static uint16_t max_cpus = 1;
 static uint64_t nb_nodes = 0;
 static uint16_t boot_menu = 0;
-static QFWCFG *fw_cfg = NULL;
 
 static void test_fw_cfg_signature(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
     char buf[5];
 
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
     buf[4] = 0;
 
     g_assert_cmpstr(buf, ==, "QEMU");
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_id(void)
 {
-    uint32_t id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint32_t id;
+
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
     g_assert((id == 1) ||
              (id == 3));
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_uuid(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
     uint8_t buf[16];
     static const uint8_t uuid[16] = {
         0x46, 0x00, 0xcb, 0x32, 0x38, 0xec, 0x4b, 0x2f,
         0x8a, 0xcb, 0x81, 0xc6, 0xea, 0x54, 0xf2, 0xd8,
     };
 
+    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    fw_cfg = pc_fw_cfg_init(s);
+
     qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
     g_assert(memcmp(buf, uuid, sizeof(buf)) == 0);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+
 }
 
 static void test_fw_cfg_ram_size(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), ==, ram_size);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_nographic(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), ==, 0);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_nb_cpus(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), ==, nb_cpus);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_max_cpus(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), ==, max_cpus);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_numa(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
     uint64_t *cpu_mask;
     uint64_t *node_mask;
 
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), ==, nb_nodes);
 
     cpu_mask = g_new0(uint64_t, max_cpus);
@@ -92,24 +157,29 @@ static void test_fw_cfg_numa(void)
 
     g_free(node_mask);
     g_free(cpu_mask);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 static void test_fw_cfg_boot_menu(void)
 {
+    QFWCFG *fw_cfg;
+    QTestState *s;
+
+    s = qtest_init("");
+    fw_cfg = pc_fw_cfg_init(s);
+
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
 }
 
 int main(int argc, char **argv)
 {
-    QTestState *s;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
-
-    fw_cfg = pc_fw_cfg_init(s);
-
     qtest_add_func("fw_cfg/signature", test_fw_cfg_signature);
     qtest_add_func("fw_cfg/id", test_fw_cfg_id);
     qtest_add_func("fw_cfg/uuid", test_fw_cfg_uuid);
@@ -128,7 +198,5 @@ int main(int argc, char **argv)
 
     ret = g_test_run();
 
-    qtest_quit(s);
-
     return ret;
 }
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index d0889d1e22..c6839c53c8 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -81,6 +81,11 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)
     return fw_cfg;
 }
 
+void mm_fw_cfg_uninit(QFWCFG *fw_cfg)
+{
+    g_free(fw_cfg);
+}
+
 static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
     qtest_outw(fw_cfg->qts, fw_cfg->base, key);
@@ -107,3 +112,8 @@ QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)
 
     return fw_cfg;
 }
+
+void io_fw_cfg_uninit(QFWCFG *fw_cfg)
+{
+    g_free(fw_cfg);
+}
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 0353416af0..60de81e863 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -33,11 +33,18 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
+void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
 QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
+void io_fw_cfg_uninit(QFWCFG *fw_cfg);
 
 static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
 {
     return io_fw_cfg_init(qts, 0x510);
 }
 
+static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
+{
+    io_fw_cfg_uninit(fw_cfg);
+}
+
 #endif
-- 
2.17.1
