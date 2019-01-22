Received: from eggs.gnu.org ([209.51.188.92]:59386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsVy-0006Mz-GS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsM0-0003O7-OW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glsM0-0003MH-IR
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4761D753F9
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:28:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 10:28:10 +0100
Message-Id: <20190122092814.14919-5-kraxel@redhat.com>
In-Reply-To: <20190122092814.14919-1-kraxel@redhat.com>
References: <20190122092814.14919-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 4/8] sdl2: use only QKeyCode in
 sdl2_process_key()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Also: sdl2_process_key is never called with scon =3D=3D NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/sdl2-input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 22e3336aab..664364a5e5 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -34,20 +34,19 @@ void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
 {
     int qcode;
-    QemuConsole *con =3D scon ? scon->dcl.con : NULL;
+    QemuConsole *con =3D scon->dcl.con;
=20
     if (ev->keysym.scancode >=3D qemu_input_map_usb_to_qcode_len) {
         return;
     }
-
     qcode =3D qemu_input_map_usb_to_qcode[ev->keysym.scancode];
     qkbd_state_key_event(scon->kbd, qcode, ev->type =3D=3D SDL_KEYDOWN);
=20
     if (!qemu_console_is_graphic(con)) {
         bool ctrl =3D qkbd_state_modifier_get(scon->kbd, QKBD_MOD_CTRL);
         if (ev->type =3D=3D SDL_KEYDOWN) {
-            switch (ev->keysym.scancode) {
-            case SDL_SCANCODE_RETURN:
+            switch (qcode) {
+            case Q_KEY_CODE_RET:
                 kbd_put_keysym_console(con, '\n');
                 break;
             default:
--=20
2.9.3
