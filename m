Received: from eggs.gnu.org ([209.51.188.92]:42335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkcgP-0003pJ-6W
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gkcgN-0007bN-Aj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:32:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gkcgI-0007Rs-Hb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:32:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F325CA396
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 22:32:03 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 18 Jan 2019 23:31:52 +0100
Message-Id: <20190118223152.24183-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] fw_cfg: fix the life cycle and the name of
 "qemu_extra_params_fw"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
2019-01-04) changed the storage duration of the "qemu_extra_params_fw"
array from static to automatic. This broke the interface contract on the
fw_cfg_add_file() function, which is documented as follows, in
"include/hw/nvram/fw_cfg.h":

> [...] The data referenced by the starting pointer is only linked, NOT
> copied, into the data structure of the fw_cfg device. [...]

As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_cfg
file, it now sees garbage. Fix the regression by changing the storage
duration to allocated. (The call is reached at most once, on the realize
path of the board-specific fw_cfg sysbus device.)

While at it, clean up the name and the assignment of the object as well.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/nvram/fw_cfg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 53e8e010a8b7..7fdf04adc97f 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -118,7 +118,6 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 {
     const char *boot_splash_filename =3D NULL;
     const char *boot_splash_time =3D NULL;
-    uint8_t qemu_extra_params_fw[2];
     char *filename, *file_data;
     gsize file_size;
     int file_type;
@@ -132,6 +131,8 @@ static void fw_cfg_bootsplash(FWCfgState *s)
     /* insert splash time if user configurated */
     if (boot_splash_time) {
         int64_t bst_val =3D qemu_opt_get_number(opts, "splash-time", -1)=
;
+        uint16_t bst_le16;
+
         /* validate the input */
         if (bst_val < 0 || bst_val > 0xffff) {
             error_report("splash-time is invalid,"
@@ -139,9 +140,9 @@ static void fw_cfg_bootsplash(FWCfgState *s)
             exit(1);
         }
         /* use little endian format */
-        qemu_extra_params_fw[0] =3D (uint8_t)(bst_val & 0xff);
-        qemu_extra_params_fw[1] =3D (uint8_t)((bst_val >> 8) & 0xff);
-        fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw, 2=
);
+        bst_le16 =3D cpu_to_le16(bst_val);
+        fw_cfg_add_file(s, "etc/boot-menu-wait",
+                        g_memdup(&bst_le16, sizeof bst_le16), sizeof bst=
_le16);
     }
=20
     /* insert splash file if user configurated */
--=20
2.19.1.3.g30247aa5d201
