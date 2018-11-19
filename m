Received: from eggs.gnu.org ([2001:4830:134:3::10]:41444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmU-0003TI-Vr
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmU-00016S-4U
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:10 -0500
Received: from m12-16.163.com ([220.181.12.16]:52021)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmT-00014u-GX
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:10 -0500
From: Li Qiang <liq3ea@163.com>
Date: Mon, 19 Nov 2018 07:47:35 -0800
Message-Id: <20181119154737.9840-2-liq3ea@163.com>
In-Reply-To: <20181119154737.9840-1-liq3ea@163.com>
References: <20181119154737.9840-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 1/3] fw_cfg: fix -boot bootsplash error checking
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

fw_cfg_bootsplash() gets option parameter "splash-time"
with qemu_opt_get(), then converts it to an integer by hand.
It neglects to check that conversion for errors. This is
needlessly complicated and error-prone. But as "splash-time
not specified" is not the same as "splash-time=T" for any T,
we need use qemu_opt_get() to check if splash time exists.
This patch also make the qemu exit when finding or loading
splash file failed.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/nvram/fw_cfg.c | 40 ++++++++++++++++------------------------
 vl.c              |  2 +-
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 946f765f7f..78f43dad93 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -118,55 +118,47 @@ error:
 
 static void fw_cfg_bootsplash(FWCfgState *s)
 {
-    int boot_splash_time = -1;
     const char *boot_splash_filename = NULL;
-    char *p;
+    const char *boot_splash_time = NULL;
     char *filename, *file_data;
     gsize file_size;
     int file_type;
-    const char *temp;
 
     /* get user configuration */
     QemuOptsList *plist = qemu_find_opts("boot-opts");
     QemuOpts *opts = QTAILQ_FIRST(&plist->head);
-    if (opts != NULL) {
-        temp = qemu_opt_get(opts, "splash");
-        if (temp != NULL) {
-            boot_splash_filename = temp;
-        }
-        temp = qemu_opt_get(opts, "splash-time");
-        if (temp != NULL) {
-            p = (char *)temp;
-            boot_splash_time = strtol(p, &p, 10);
-        }
-    }
+    boot_splash_filename = qemu_opt_get(opts, "splash");
+    boot_splash_time = qemu_opt_get(opts, "splash-time");
 
     /* insert splash time if user configurated */
-    if (boot_splash_time >= 0) {
+    if (boot_splash_time) {
+        int64_t bst_val = qemu_opt_get_number(opts, "splash-time", -1);
         /* validate the input */
-        if (boot_splash_time > 0xffff) {
-            error_report("splash time is big than 65535, force it to 65535.");
-            boot_splash_time = 0xffff;
+        if (bst_val < 0 || bst_val > 0xffff) {
+            error_report("splash time is invalid,"
+                         "it should be a value between 0 and 65535");
+            exit(1);
         }
         /* use little endian format */
-        qemu_extra_params_fw[0] = (uint8_t)(boot_splash_time & 0xff);
-        qemu_extra_params_fw[1] = (uint8_t)((boot_splash_time >> 8) & 0xff);
+        qemu_extra_params_fw[0] = (uint8_t)(bst_val & 0xff);
+        qemu_extra_params_fw[1] = (uint8_t)((bst_val >> 8) & 0xff);
         fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw, 2);
     }
 
     /* insert splash file if user configurated */
-    if (boot_splash_filename != NULL) {
+    if (boot_splash_filename) {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, boot_splash_filename);
         if (filename == NULL) {
-            error_report("failed to find file '%s'.", boot_splash_filename);
-            return;
+            error_report("failed to find file '%s'", boot_splash_filename);
+            exit(1);
         }
 
         /* loading file data */
         file_data = read_splashfile(filename, &file_size, &file_type);
         if (file_data == NULL) {
             g_free(filename);
-            return;
+            error_report("failed to read file '%s'", boot_splash_filename);
+            exit(1);
         }
         g_free(boot_splash_filedata);
         boot_splash_filedata = (uint8_t *)file_data;
diff --git a/vl.c b/vl.c
index fa25d1ae2d..96ac0ddcf6 100644
--- a/vl.c
+++ b/vl.c
@@ -336,7 +336,7 @@ static QemuOptsList qemu_boot_opts = {
             .type = QEMU_OPT_STRING,
         }, {
             .name = "splash-time",
-            .type = QEMU_OPT_STRING,
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "reboot-timeout",
             .type = QEMU_OPT_STRING,
-- 
2.17.1
