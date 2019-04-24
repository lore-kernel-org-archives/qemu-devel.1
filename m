Received: from eggs.gnu.org ([209.51.188.92]:39025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002XO-9D
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY4-0006iH-5O
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:57 -0400
Received: from m12-14.163.com ([220.181.12.14]:54701)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY2-0006gJ-HF
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:56 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 24 Apr 2019 07:06:42 -0700
Message-Id: <20190424140643.62457-5-liq3ea@163.com>
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
References: <20190424140643.62457-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 4/5] tests: fw_cfg: add reboot_timeout test
 case
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
Converting little endian reboot_timeout to cpu endian

 tests/fw_cfg-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index c22503619f..6c6add54db 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -15,6 +15,7 @@
 #include "libqtest.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
 
 static uint64_t ram_size = 128 << 20;
 static uint16_t nb_cpus = 1;
@@ -174,6 +175,25 @@ static void test_fw_cfg_boot_menu(void)
     qtest_quit(s);
 }
 
+static void test_fw_cfg_reboot_timeout(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint32_t reboot_timeout = 0;
+    size_t filesize;
+
+    s = qtest_init("-boot reboot-timeout=15");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    filesize = qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+                     &reboot_timeout, sizeof(reboot_timeout));
+    g_assert_cmpint(filesize, ==, sizeof(reboot_timeout));
+    reboot_timeout = le32_to_cpu(reboot_timeout);
+    g_assert_cmpint(reboot_timeout, ==, 15);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -195,6 +215,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
+    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
 
     ret = g_test_run();
 
-- 
2.17.1
