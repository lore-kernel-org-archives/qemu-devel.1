Received: from eggs.gnu.org ([2001:4830:134:3::10]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6BQ-0005kF-I3
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6BL-0003kj-LD
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:10:20 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI6BL-0003kT-Ex
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:10:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id r9-v6so8522482pgv.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 23:10:15 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 31 Oct 2018 23:10:09 -0700
Message-Id: <1541052609-29212-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] hw: fw_cfg: use qemu_opt_get_number to get
 splash-time and reboot-timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Currently the splash-time and reboot-timeout in boot_opts
uses qemu_opt_get() to get a string, then convert it to a number
ourselves. This is wrong. Change the opt's type to QEMU_OPT_NUMBER
and use qemu_opt_get_number to parse it.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/nvram/fw_cfg.c | 29 ++++++++---------------------
 vl.c              |  4 ++--
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index dff6e06..282dc6a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -117,9 +117,8 @@ error:
 
 static void fw_cfg_bootsplash(FWCfgState *s)
 {
-    int boot_splash_time = -1;
+    uint64_t boot_splash_time = -1;
     const char *boot_splash_filename = NULL;
-    char *p;
     char *filename, *file_data;
     gsize file_size;
     int file_type;
@@ -133,18 +132,14 @@ static void fw_cfg_bootsplash(FWCfgState *s)
         if (temp != NULL) {
             boot_splash_filename = temp;
         }
-        temp = qemu_opt_get(opts, "splash-time");
-        if (temp != NULL) {
-            p = (char *)temp;
-            boot_splash_time = strtol(p, &p, 10);
-        }
+        boot_splash_time = qemu_opt_get_number(opts, "splash-time", -1);
     }
 
     /* insert splash time if user configurated */
-    if (boot_splash_time >= 0) {
+    if ((int64_t)boot_splash_time >= 0) {
         /* validate the input */
         if (boot_splash_time > 0xffff) {
-            error_report("splash time is big than 65535, force it to 65535.");
+            error_report("splash time is big than 65535, force it to 65535");
             boot_splash_time = 0xffff;
         }
         /* use little endian format */
@@ -185,26 +180,18 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 
 static void fw_cfg_reboot(FWCfgState *s)
 {
-    int reboot_timeout = -1;
-    char *p;
-    const char *temp;
+    uint64_t reboot_timeout = -1;
 
     /* get user configuration */
     QemuOptsList *plist = qemu_find_opts("boot-opts");
     QemuOpts *opts = QTAILQ_FIRST(&plist->head);
-    if (opts != NULL) {
-        temp = qemu_opt_get(opts, "reboot-timeout");
-        if (temp != NULL) {
-            p = (char *)temp;
-            reboot_timeout = strtol(p, &p, 10);
-        }
-    }
+    reboot_timeout = qemu_opt_get_number(opts, "reboot-timeout", -1);
 
-    if (reboot_timeout >= 0) {
+    if ((int64_t)reboot_timeout >= 0) {
         /* validate the input */
         if (reboot_timeout > 0xffff) {
             error_report("reboot timeout is larger than 65535,"
-                         "force it to 65535.");
+                         "force it to 65535");
             reboot_timeout = 0xffff;
         }
         fw_cfg_add_file(s, "etc/boot-fail-wait",
diff --git a/vl.c b/vl.c
index f0bd899..60daa17 100644
--- a/vl.c
+++ b/vl.c
@@ -336,10 +336,10 @@ static QemuOptsList qemu_boot_opts = {
             .type = QEMU_OPT_STRING,
         }, {
             .name = "splash-time",
-            .type = QEMU_OPT_STRING,
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "reboot-timeout",
-            .type = QEMU_OPT_STRING,
+            .type = QEMU_OPT_NUMBER,
         }, {
             .name = "strict",
             .type = QEMU_OPT_BOOL,
-- 
1.8.3.1
