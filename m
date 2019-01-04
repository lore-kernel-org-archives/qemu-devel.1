Received: from eggs.gnu.org ([208.118.235.92]:54241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSJ6-0006By-2X
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSJ2-00038X-Qd
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfSJ2-00038F-JQ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:44 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 17:25:58 +0100
Message-Id: <20190104162559.20760-4-philmd@redhat.com>
In-Reply-To: <20190104162559.20760-1-philmd@redhat.com>
References: <20190104162559.20760-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] fw_cfg: Fix -boot reboot-timeout error
 checking
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

fw_cfg_reboot() gets option parameter "reboot-timeout" with
qemu_opt_get(), then converts it to an integer by hand. It neglects to
check that conversion for errors, and fails to reject negative values.
Positive values above the limit get reported and replaced by the limit.
This patch checks for conversion errors properly, and reject all values
outside 0...0xffff.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1542777026-2788-3-git-send-email-liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 27 +++++++++++++--------------
 vl.c              |  2 +-
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index ad91abdbb7..cba58344f5 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -176,26 +176,25 @@ static void fw_cfg_bootsplash(FWCfgState *s)
=20
 static void fw_cfg_reboot(FWCfgState *s)
 {
-    int reboot_timeout =3D -1;
-    char *p;
-    const char *temp;
+    const char *reboot_timeout =3D NULL;
+    int64_t rt_val =3D -1;
=20
     /* get user configuration */
     QemuOptsList *plist =3D qemu_find_opts("boot-opts");
     QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
-    if (opts !=3D NULL) {
-        temp =3D qemu_opt_get(opts, "reboot-timeout");
-        if (temp !=3D NULL) {
-            p =3D (char *)temp;
-            reboot_timeout =3D strtol(p, &p, 10);
+    reboot_timeout =3D qemu_opt_get(opts, "reboot-timeout");
+
+    if (reboot_timeout) {
+        rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
+        /* validate the input */
+        if (rt_val < 0 || rt_val > 0xffff) {
+            error_report("reboot timeout is invalid,"
+                         "it should be a value between 0 and 65535");
+            exit(1);
         }
     }
-    /* validate the input */
-    if (reboot_timeout > 0xffff) {
-        error_report("reboot timeout is larger than 65535, force it to 6=
5535.");
-        reboot_timeout =3D 0xffff;
-    }
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&reboot_timeout, 4=
), 4);
+
+    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
 }
=20
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
diff --git a/vl.c b/vl.c
index a24e5e076d..efa4ff9da5 100644
--- a/vl.c
+++ b/vl.c
@@ -341,7 +341,7 @@ static QemuOptsList qemu_boot_opts =3D {
             .type =3D QEMU_OPT_NUMBER,
         }, {
             .name =3D "reboot-timeout",
-            .type =3D QEMU_OPT_STRING,
+            .type =3D QEMU_OPT_NUMBER,
         }, {
             .name =3D "strict",
             .type =3D QEMU_OPT_BOOL,
--=20
2.17.2
