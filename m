Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIl-0007dd-J3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIk-0002uK-L1
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIk-0002tZ-D4
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:06 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79C1F8FCF5
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:54:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:28 +0100
Message-Id: <20170105165329.17227-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/20] vc: use a common prefix for chr callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

vc_chr_write() is more appropriate than _puts() since no newline is
appended, even though it's not used only as a callback.

Keep "qemu_chr_parse" prefix, most chardev parse functions use this
prefix atm.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index d8bc8a63cb..c8ee164ffe 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1051,7 +1051,7 @@ typedef struct VCChardev {
     QemuConsole *console;
 } VCChardev;
=20
-static int console_puts(Chardev *chr, const uint8_t *buf, int len)
+static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     VCChardev *drv =3D (VCChardev *)chr;
     QemuConsole *s =3D drv->console;
@@ -1139,13 +1139,13 @@ void kbd_put_keysym_console(QemuConsole *s, int k=
eysym)
             *q++ =3D '[';
             *q++ =3D keysym & 0xff;
         } else if (s->echo && (keysym =3D=3D '\r' || keysym =3D=3D '\n')=
) {
-            console_puts(s->chr, (const uint8_t *) "\r", 1);
+            vc_chr_write(s->chr, (const uint8_t *) "\r", 1);
             *q++ =3D '\n';
         } else {
             *q++ =3D keysym;
         }
         if (s->echo) {
-            console_puts(s->chr, buf, q - buf);
+            vc_chr_write(s->chr, buf, q - buf);
         }
         be =3D s->chr->be;
         if (be && be->chr_read) {
@@ -1962,7 +1962,7 @@ int qemu_console_get_height(QemuConsole *con, int f=
allback)
     return con ? surface_height(con->surface) : fallback;
 }
=20
-static void text_console_set_echo(Chardev *chr, bool echo)
+static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
     VCChardev *drv =3D (VCChardev *)chr;
     QemuConsole *s =3D drv->console;
@@ -2049,7 +2049,7 @@ static void text_console_do_init(Chardev *chr, Disp=
layState *ds)
=20
         s->t_attrib.bgcol =3D QEMU_COLOR_BLUE;
         len =3D snprintf(msg, sizeof(msg), "%s console\r\n", chr->label)=
;
-        console_puts(chr, (uint8_t*)msg, len);
+        vc_chr_write(chr, (uint8_t *)msg, len);
         s->t_attrib =3D s->t_attrib_default;
     }
=20
@@ -2058,10 +2058,10 @@ static void text_console_do_init(Chardev *chr, Di=
splayState *ds)
=20
 static const CharDriver vc_driver;
=20
-static Chardev *vc_init(const CharDriver *driver,
-                        const char *id, ChardevBackend *backend,
-                        ChardevReturn *ret, bool *be_opened,
-                        Error **errp)
+static Chardev *vc_chr_init(const CharDriver *driver,
+                            const char *id, ChardevBackend *backend,
+                            ChardevReturn *ret, bool *be_opened,
+                            Error **errp)
 {
     ChardevVC *vc =3D backend->u.vc.data;
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
@@ -2197,9 +2197,9 @@ static const CharDriver vc_driver =3D {
     .instance_size =3D sizeof(VCChardev),
     .kind =3D CHARDEV_BACKEND_KIND_VC,
     .parse =3D qemu_chr_parse_vc,
-    .create =3D vc_init,
-    .chr_write =3D console_puts,
-    .chr_set_echo =3D text_console_set_echo,
+    .create =3D vc_chr_init,
+    .chr_write =3D vc_chr_write,
+    .chr_set_echo =3D vc_chr_set_echo,
 };
=20
 static void register_types(void)
--=20
2.11.0
