Received: from eggs.gnu.org ([209.51.188.92]:39161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002cB-5w
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIYT-0006wA-2k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:07:21 -0400
Received: from m12-14.163.com ([220.181.12.14]:54855)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY5-0006i8-Kb
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:07:21 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 24 Apr 2019 07:06:43 -0700
Message-Id: <20190424140643.62457-6-liq3ea@163.com>
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
References: <20190424140643.62457-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 5/5] tests: fw_cfg: add splash time test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v1:
Converting little endian splash time to cpu endian

 tests/fw_cfg-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 6c6add54db..c6a3d6bb23 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -194,6 +194,25 @@ static void test_fw_cfg_reboot_timeout(void)
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
+    splash_time = le16_to_cpu(splash_time);
+    g_assert_cmpint(splash_time, ==, 12);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -216,6 +235,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
     qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
+    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
 
     ret = g_test_run();
 
-- 
2.17.1
