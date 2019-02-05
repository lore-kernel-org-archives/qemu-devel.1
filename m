Received: from eggs.gnu.org ([209.51.188.92]:42700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQz-0007Vy-KF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQt-0006L2-B0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQs-0006BK-QP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:26 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:54 +0100
Message-Id: <20190205105758.4230-11-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] sdl2: use only QKeyCode in
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Also: sdl2_process_key is never called with scon =3D=3D NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190122092814.14919-5-kraxel@redhat.com
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
