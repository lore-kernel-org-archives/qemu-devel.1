Received: from eggs.gnu.org ([2001:4830:134:3::10]:53557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gLK9N-0003uH-Oa
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gLK9M-0003vz-Le
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:41:33 -0500
Received: from m12-14.163.com ([220.181.12.14]:47065)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gLK9I-0003uq-Or
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:41:30 -0500
From: Li Qiang <liq3ea@163.com>
Date: Fri,  9 Nov 2018 19:41:15 -0800
Message-Id: <20181110034115.103335-3-liq3ea@163.com>
In-Reply-To: <20181110034115.103335-1-liq3ea@163.com>
References: <20181110034115.103335-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/2] hw: fw_cfg: refactor fw_cfg_reboot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, kraxel@redhat.com, armbru@redhat.com, lersek@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Currently the user can set a negative reboot_timeout.
Also it is wrong to parse 'reboot-timeout' with qemu_opt_get() and then
convert it to number. This patch refactor this function by following:
1. ensure reboot_timeout is in 0~0xffff
2. use qemu_opt_get_number() to parse reboot_timeout
3. simlify code

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/nvram/fw_cfg.c | 23 +++++++++++------------
 vl.c              |  2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 78f43dad93..6aca80846a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -178,24 +178,23 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 
 static void fw_cfg_reboot(FWCfgState *s)
 {
-    int reboot_timeout = -1;
-    char *p;
-    const char *temp;
+    const char *reboot_timeout = NULL;
 
     /* get user configuration */
     QemuOptsList *plist = qemu_find_opts("boot-opts");
     QemuOpts *opts = QTAILQ_FIRST(&plist->head);
-    if (opts != NULL) {
-        temp = qemu_opt_get(opts, "reboot-timeout");
-        if (temp != NULL) {
-            p = (char *)temp;
-            reboot_timeout = strtol(p, &p, 10);
-        }
+    reboot_timeout = qemu_opt_get(opts, "reboot-timeout");
+
+    if (reboot_timeout == NULL) {
+        return;
     }
+    int64_t rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
+
     /* validate the input */
-    if (reboot_timeout > 0xffff) {
-        error_report("reboot timeout is larger than 65535, force it to 65535.");
-        reboot_timeout = 0xffff;
+    if (rt_val < 0 || rt_val > 0xffff) {
+        error_report("reboot timeout is invalid,"
+                     "it should be a value between 0 and 65535");
+        exit(1);
     }
     fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4), 4);
 }
diff --git a/vl.c b/vl.c
index be37da46f0..086127ff0b 100644
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
