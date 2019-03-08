Received: from eggs.gnu.org ([209.51.188.92]:58834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24Q1-00045g-Hi
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24Pz-0002xh-HT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:25 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:16 +0100
Message-Id: <20190308013222.12524-13-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/18] hw/nvram/fw_cfg: Keep reference of
 file_data in FWCfgState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

The 'file_data' is allocated by read_splashfile() (introduced in
commit 3d3b8303c6f8).  It is then used by fw_cfg_add_file(). Due
to the contract interface of fw_cfg_add_file(), it has to be valid
for the lifetime of the FwCfg object.

Keep a reference of 'file_data' in FWCfgState to be able to
free this memory in fw_cfg_common_unrealize().
We can now remove the res_free() from the main() loop.
The global boot_splash_filedata is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c         | 10 ++++++----
 include/hw/nvram/fw_cfg.h |  1 +
 include/sysemu/sysemu.h   |  1 -
 vl.c                      |  9 ---------
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3ac6687a04..fc392cb7e0 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -215,16 +215,16 @@ static void fw_cfg_bootsplash(FWCfgState *s)
             g_free(filename);
             return;
         }
-        g_free(boot_splash_filedata);
-        boot_splash_filedata =3D (uint8_t *)file_data;
+        g_free(s->boot_splash.file_data);
+        s->boot_splash.file_data =3D file_data;
=20
         /* insert data */
         if (file_type =3D=3D JPG_FILE) {
             fw_cfg_add_file(s, "bootsplash.jpg",
-                            boot_splash_filedata, file_size);
+                            s->boot_splash.file_data, file_size);
         } else {
             fw_cfg_add_file(s, "bootsplash.bmp",
-                            boot_splash_filedata, file_size);
+                            s->boot_splash.file_data, file_size);
         }
         g_free(filename);
     }
@@ -974,6 +974,8 @@ static void fw_cfg_common_unrealize(DeviceState *dev,=
 Error **errp)
=20
     g_free(s->files);
=20
+    g_free(s->boot_splash.file_data);
+
     g_free(s->entries[0]);
     g_free(s->entries[1]);
     g_free(s->entry_order);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index fcb771186c..83a0540b6c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -56,6 +56,7 @@ struct FWCfgState {
=20
     uint32_t reboot_timeout;
     struct {
+        char *file_data;
         uint16_t time_le16;
     } boot_splash;
 };
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 6065d9e420..3cd856b015 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -109,7 +109,6 @@ extern int no_shutdown;
 extern int old_param;
 extern int boot_menu;
 extern bool boot_strict;
-extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
diff --git a/vl.c b/vl.c
index fad6fec38c..47dd63a309 100644
--- a/vl.c
+++ b/vl.c
@@ -187,7 +187,6 @@ unsigned int nb_prom_envs =3D 0;
 const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
 bool boot_strict;
-uint8_t *boot_splash_filedata;
 bool wakeup_suspend_enabled;
=20
 int icount_align_option;
@@ -558,12 +557,6 @@ const char *qemu_get_vm_name(void)
     return qemu_name;
 }
=20
-static void res_free(void)
-{
-    g_free(boot_splash_filedata);
-    boot_splash_filedata =3D NULL;
-}
-
 static int default_driver_check(void *opaque, QemuOpts *opts, Error **er=
rp)
 {
     const char *driver =3D qemu_opt_get(opts, "driver");
@@ -4591,8 +4584,6 @@ int main(int argc, char **argv, char **envp)
     job_cancel_sync_all();
     bdrv_close_all();
=20
-    res_free();
-
     /* vhost-user must be cleaned up before chardevs.  */
     tpm_cleanup();
     net_cleanup();
--=20
2.20.1
