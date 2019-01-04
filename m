Received: from eggs.gnu.org ([208.118.235.92]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSIq-0005uG-7V
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSIn-0002sK-FR
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfSIn-0002pd-7v
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 17:25:57 +0100
Message-Id: <20190104162559.20760-3-philmd@redhat.com>
In-Reply-To: <20190104162559.20760-1-philmd@redhat.com>
References: <20190104162559.20760-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] fw_cfg: Fix -boot bootsplash error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

fw_cfg_bootsplash() gets option parameter "splash-time"
with qemu_opt_get(), then converts it to an integer by hand.
It neglects to check that conversion for errors. This is
needlessly complicated and error-prone. But as "splash-time
not specified" is not the same as "splash-time=3DT" for any T,
we need use qemu_opt_get() to check if splash time exists.
This patch also make the qemu exit when finding or loading
splash file failed.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1542777026-2788-2-git-send-email-liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 35 +++++++++++++----------------------
 vl.c              |  2 +-
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 9c4409be5e..ad91abdbb7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -117,47 +117,38 @@ error:
=20
 static void fw_cfg_bootsplash(FWCfgState *s)
 {
-    int boot_splash_time =3D -1;
     const char *boot_splash_filename =3D NULL;
-    char *p;
+    const char *boot_splash_time =3D NULL;
     char *filename, *file_data;
     gsize file_size;
     int file_type;
-    const char *temp;
=20
     /* get user configuration */
     QemuOptsList *plist =3D qemu_find_opts("boot-opts");
     QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
-    if (opts !=3D NULL) {
-        temp =3D qemu_opt_get(opts, "splash");
-        if (temp !=3D NULL) {
-            boot_splash_filename =3D temp;
-        }
-        temp =3D qemu_opt_get(opts, "splash-time");
-        if (temp !=3D NULL) {
-            p =3D (char *)temp;
-            boot_splash_time =3D strtol(p, &p, 10);
-        }
-    }
+    boot_splash_filename =3D qemu_opt_get(opts, "splash");
+    boot_splash_time =3D qemu_opt_get(opts, "splash-time");
=20
     /* insert splash time if user configurated */
-    if (boot_splash_time >=3D 0) {
+    if (boot_splash_time) {
+        int64_t bst_val =3D qemu_opt_get_number(opts, "splash-time", -1)=
;
         /* validate the input */
-        if (boot_splash_time > 0xffff) {
-            error_report("splash time is big than 65535, force it to 655=
35.");
-            boot_splash_time =3D 0xffff;
+        if (bst_val < 0 || bst_val > 0xffff) {
+            error_report("splash-time is invalid,"
+                         "it should be a value between 0 and 65535");
+            exit(1);
         }
         /* use little endian format */
-        qemu_extra_params_fw[0] =3D (uint8_t)(boot_splash_time & 0xff);
-        qemu_extra_params_fw[1] =3D (uint8_t)((boot_splash_time >> 8) & =
0xff);
+        qemu_extra_params_fw[0] =3D (uint8_t)(bst_val & 0xff);
+        qemu_extra_params_fw[1] =3D (uint8_t)((bst_val >> 8) & 0xff);
         fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw, 2=
);
     }
=20
     /* insert splash file if user configurated */
-    if (boot_splash_filename !=3D NULL) {
+    if (boot_splash_filename) {
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, boot_splash_fil=
ename);
         if (filename =3D=3D NULL) {
-            error_report("failed to find file '%s'.", boot_splash_filena=
me);
+            error_report("failed to find file '%s'", boot_splash_filenam=
e);
             return;
         }
=20
diff --git a/vl.c b/vl.c
index 8353d3c718..a24e5e076d 100644
--- a/vl.c
+++ b/vl.c
@@ -338,7 +338,7 @@ static QemuOptsList qemu_boot_opts =3D {
             .type =3D QEMU_OPT_STRING,
         }, {
             .name =3D "splash-time",
-            .type =3D QEMU_OPT_STRING,
+            .type =3D QEMU_OPT_NUMBER,
         }, {
             .name =3D "reboot-timeout",
             .type =3D QEMU_OPT_STRING,
--=20
2.17.2
