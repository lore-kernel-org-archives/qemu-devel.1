Received: from eggs.gnu.org ([209.51.188.92]:53578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyIuk-0003Jn-MU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyIue-0005jK-Qr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:15:34 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 25 Feb 2019 17:14:58 +0100
Message-Id: <1551111298-8445-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/nvram/fw_cfg: Move boot_splash_filedata
 variables into fw_cfg.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

The global boot_splash_filedata and boot_splash_filedata_size variables
are only used in fw_cfg.c. So there is really no need that these need
to be global and reside in vl.c. Move them to fw_cfg.c instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/nvram/fw_cfg.c         |  9 +++++++++
 include/hw/nvram/fw_cfg.h |  1 +
 include/sysemu/sysemu.h   |  2 --
 vl.c                      | 10 +---------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7fdf04a..15f0023 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -63,6 +63,9 @@ struct FWCfgEntry {
 #define JPG_FILE 0
 #define BMP_FILE 1
 
+static uint8_t *boot_splash_filedata;
+static size_t boot_splash_filedata_size;
+
 static char *read_splashfile(char *filename, gsize *file_sizep,
                              int *file_typep)
 {
@@ -175,6 +178,12 @@ static void fw_cfg_bootsplash(FWCfgState *s)
     }
 }
 
+void fw_cfg_res_free(void)
+{
+    g_free(boot_splash_filedata);
+    boot_splash_filedata = NULL;
+}
+
 static void fw_cfg_reboot(FWCfgState *s)
 {
     const char *reboot_timeout = NULL;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f5a6895..16d237c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -225,5 +225,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
 
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
+void fw_cfg_res_free(void);
 
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4b5a6b7..63a5eed 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -111,8 +111,6 @@ extern int no_shutdown;
 extern int old_param;
 extern int boot_menu;
 extern bool boot_strict;
-extern uint8_t *boot_splash_filedata;
-extern size_t boot_splash_filedata_size;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
diff --git a/vl.c b/vl.c
index 502857a..f769cce 100644
--- a/vl.c
+++ b/vl.c
@@ -187,8 +187,6 @@ unsigned int nb_prom_envs = 0;
 const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
 bool boot_strict;
-uint8_t *boot_splash_filedata;
-size_t boot_splash_filedata_size;
 bool wakeup_suspend_enabled;
 
 int icount_align_option;
@@ -559,12 +557,6 @@ const char *qemu_get_vm_name(void)
     return qemu_name;
 }
 
-static void res_free(void)
-{
-    g_free(boot_splash_filedata);
-    boot_splash_filedata = NULL;
-}
-
 static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
 {
     const char *driver = qemu_opt_get(opts, "driver");
@@ -4585,7 +4577,7 @@ int main(int argc, char **argv, char **envp)
     job_cancel_sync_all();
     bdrv_close_all();
 
-    res_free();
+    fw_cfg_res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
     tpm_cleanup();
-- 
1.8.3.1
