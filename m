Received: from eggs.gnu.org ([2001:4830:134:3::10]:41474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmW-0003YU-Ox
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmW-00017b-19
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:12 -0500
Received: from m12-16.163.com ([220.181.12.16]:52301)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmV-00016a-F9
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:11 -0500
From: Li Qiang <liq3ea@163.com>
Date: Mon, 19 Nov 2018 07:47:36 -0800
Message-Id: <20181119154737.9840-3-liq3ea@163.com>
In-Reply-To: <20181119154737.9840-1-liq3ea@163.com>
References: <20181119154737.9840-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/3] fw_cfg: fix -boot reboot-timeout error
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

fw_cfg_reboot() gets option parameter "reboot-timeout" with
qemu_opt_get(), then converts it to an integer by hand. It neglects to
check that conversion for errors, and fails to reject negative values.
Positive values above the limit get reported and replaced by the limit.
This patch checks for conversion errors properly, and reject all valus
outside 0...0xffff.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/nvram/fw_cfg.c | 27 +++++++++++++--------------
 vl.c              |  2 +-
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 78f43dad93..0489d63a1b 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -178,26 +178,25 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 
 static void fw_cfg_reboot(FWCfgState *s)
 {
-    int reboot_timeout = -1;
-    char *p;
-    const char *temp;
+    const char *reboot_timeout = NULL;
+    int64_t rt_val = -1;
 
     /* get user configuration */
     QemuOptsList *plist = qemu_find_opts("boot-opts");
     QemuOpts *opts = QTAILQ_FIRST(&plist->head);
-    if (opts != NULL) {
-        temp = qemu_opt_get(opts, "reboot-timeout");
-        if (temp != NULL) {
-            p = (char *)temp;
-            reboot_timeout = strtol(p, &p, 10);
+    reboot_timeout = qemu_opt_get(opts, "reboot-timeout");
+
+    if (reboot_timeout) {
+        rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
+        /* validate the input */
+        if (rt_val < 0 || rt_val > 0xffff) {
+            error_report("reboot timeout is invalid,"
+                         "it should be a value between 0 and 65535");
+            exit(1);
         }
     }
-    /* validate the input */
-    if (reboot_timeout > 0xffff) {
-        error_report("reboot timeout is larger than 65535, force it to 65535.");
-        reboot_timeout = 0xffff;
-    }
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4), 4);
+
+    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
 }
 
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
diff --git a/vl.c b/vl.c
index 96ac0ddcf6..38a1759461 100644
--- a/vl.c
+++ b/vl.c
@@ -339,7 +339,7 @@ static QemuOptsList qemu_boot_opts = {
             .type = QEMU_OPT_NUMBER,
         }, {
             .name = "reboot-timeout",
-            .type = QEMU_OPT_STRING,
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "strict",
             .type = QEMU_OPT_BOOL,
-- 
2.17.1
