Received: from eggs.gnu.org ([209.51.188.92]:60177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL6-0005PE-VN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL6-0003Xz-2d
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:56 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Mar 2019 20:11:25 +0100
Message-Id: <20190311191128.30562-3-laurent@vivier.eu>
In-Reply-To: <20190311191128.30562-1-laurent@vivier.eu>
References: <20190311191128.30562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] hw/nvram/fw_cfg: Remove the unnecessary
 boot_splash_filedata_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'boot_splash_filedata_size' was introduced as a global variable
in 3d3b8303c6f. This variable is used as a 'size' argument to the
fw_cfg_add_file(). This function has an interface contract with its
'data' argument, but there is no such contract for 'size' (this is
not a referenced pointer).  We can simply remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20190308013222.12524-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/nvram/fw_cfg.c       | 5 ++---
 include/sysemu/sysemu.h | 1 -
 vl.c                    | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7fdf04adc97f..13aab122889d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -161,15 +161,14 @@ static void fw_cfg_bootsplash(FWCfgState *s)
         }
         g_free(boot_splash_filedata);
         boot_splash_filedata = (uint8_t *)file_data;
-        boot_splash_filedata_size = file_size;
 
         /* insert data */
         if (file_type == JPG_FILE) {
             fw_cfg_add_file(s, "bootsplash.jpg",
-                    boot_splash_filedata, boot_splash_filedata_size);
+                            boot_splash_filedata, file_size);
         } else {
             fw_cfg_add_file(s, "bootsplash.bmp",
-                    boot_splash_filedata, boot_splash_filedata_size);
+                            boot_splash_filedata, file_size);
         }
         g_free(filename);
     }
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 89604a83282b..6065d9e4203a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -110,7 +110,6 @@ extern int old_param;
 extern int boot_menu;
 extern bool boot_strict;
 extern uint8_t *boot_splash_filedata;
-extern size_t boot_splash_filedata_size;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
diff --git a/vl.c b/vl.c
index f46f8d769a5c..483ca17c6830 100644
--- a/vl.c
+++ b/vl.c
@@ -185,7 +185,6 @@ const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
 bool boot_strict;
 uint8_t *boot_splash_filedata;
-size_t boot_splash_filedata_size;
 bool wakeup_suspend_enabled;
 
 int icount_align_option;
-- 
2.20.1
