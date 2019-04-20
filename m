Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmrK-000119-56
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoD-000586-F0
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:22 -0400
Received: from m12-14.163.com ([220.181.12.14]:59714)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoC-00056s-Th
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:21 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 20 Apr 2019 03:00:56 -0700
Message-Id: <20190420100056.116305-5-liq3ea@163.com>
In-Reply-To: <20190420100056.116305-1-liq3ea@163.com>
References: <20190420100056.116305-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 4/4] tests: fw_cfg: add splash time test case
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

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/fw_cfg-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 9f75dbb5f4..de8e81ea9d 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -192,6 +192,24 @@ static void test_fw_cfg_reboot_timeout(void)
     qtest_quit(s);
 }
 
+static void test_fw_cfg_splash_time(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint16_t splash_time = 0;
+    size_t filesize;
+
+    s = qtest_init("-boot splash-time=12");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
+                     &splash_time, sizeof(splash_time));
+    g_assert_cmpint(filesize, ==, sizeof(splash_time));
+    g_assert_cmpint(splash_time, ==, 12);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -214,6 +232,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
     qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
+    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
 
     ret = g_test_run();
 
-- 
2.17.1
