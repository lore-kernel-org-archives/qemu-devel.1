Received: from eggs.gnu.org ([2001:4830:134:3::10]:50096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gGkMh-0006pX-2v
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gGkMd-0002I6-Af
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:21 -0400
Received: from m12-12.163.com ([220.181.12.12]:34789)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gGkMc-00028d-Fs
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 08:40:19 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sun, 28 Oct 2018 05:40:04 -0700
Message-Id: <20181028124004.30494-3-liq3ea@163.com>
In-Reply-To: <20181028124004.30494-1-liq3ea@163.com>
References: <20181028124004.30494-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: philmd@redhat.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/fw_cfg-test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1c5103fe1c..37765f15f8 100644
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
+    g_assert_cmpint(reboot_timeout, <=, 65535);
+}
+
 int main(int argc, char **argv)
 {
     QTestState *s;
@@ -106,7 +115,8 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"
+                   " -boot reboot-timeout=4294967295");
 
     fw_cfg = pc_fw_cfg_init(s);
 
@@ -125,6 +135,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
+    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
 
     ret = g_test_run();
 
-- 
2.17.1
