Received: from eggs.gnu.org ([209.51.188.92]:39159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl7Jl-0004fG-ED
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 02:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl7Jk-0004QZ-Of
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 02:14:53 -0500
Received: from m12-15.163.com ([220.181.12.15]:59836)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gl7Jj-0004Nl-VV
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 02:14:52 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 19 Jan 2019 23:13:37 -0800
Message-Id: <20190120071337.55595-3-liq3ea@163.com>
In-Reply-To: <20190120071337.55595-1-liq3ea@163.com>
References: <20190120071337.55595-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test case
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
 tests/fw_cfg-test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1c5103fe1c..c28e6c3fb5 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
     g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
 }
 
+static void test_fw_cfg_reboot_timeout(void)
+{
+    uint32_t reboot_timeout;
+
+    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+                     &reboot_timeout, sizeof(reboot_timeout));
+    g_assert_cmpint(reboot_timeout, ==, 15);
+}
+
 int main(int argc, char **argv)
 {
     QTestState *s;
@@ -106,7 +115,8 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 "
+                   "-boot reboot-timeout=15");
 
     fw_cfg = pc_fw_cfg_init(s);
 
@@ -125,6 +135,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
+    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
 
     ret = g_test_run();
 
-- 
2.17.1
