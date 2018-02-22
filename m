Received: from eggs.gnu.org ([2001:4830:134:3::10]:50276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2E-0003J6-Lx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-00020B-F1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yM-6U
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4CEF40FB639
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:09 +0100
Message-Id: <20180222102317.25776-2-kraxel@redhat.com>
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] sdl2: fix hotkey keyup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

After some hotkey was pressed sdl2 doesn't forward the first modifier
keyup event to the guest, resulting in stuck modifier keys.

Fix the logic in handle_keyup().  Also gui_key_modifier_pressed doesn't
need to be a global variable.

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180220150444.784-1-kraxel@redhat.com
---
 ui/sdl2.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 6e96a4a24c..b5a0fa1d13 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -39,7 +39,6 @@ static int gui_grab; /* if true, all keyboard/mouse eve=
nts are grabbed */
=20
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_key_modifier_pressed;
 static int gui_keysym;
 static int gui_grab_code =3D KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
@@ -331,8 +330,7 @@ static void handle_keydown(SDL_Event *ev)
 {
     int win;
     struct sdl2_console *scon =3D get_scon_from_window(ev->key.windowID)=
;
-
-    gui_key_modifier_pressed =3D get_mod_state();
+    int gui_key_modifier_pressed =3D get_mod_state();
=20
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.re=
peat) {
         switch (ev->key.keysym.scancode) {
@@ -413,18 +411,12 @@ static void handle_keydown(SDL_Event *ev)
=20
 static void handle_keyup(SDL_Event *ev)
 {
-    int mod_state;
     struct sdl2_console *scon =3D get_scon_from_window(ev->key.windowID)=
;
+    int gui_key_modifier_pressed =3D get_mod_state();
=20
     scon->ignore_hotkeys =3D false;
=20
-    if (!alt_grab) {
-        mod_state =3D (ev->key.keysym.mod & gui_grab_code);
-    } else {
-        mod_state =3D (ev->key.keysym.mod & (gui_grab_code | KMOD_LSHIFT=
));
-    }
-    if (!mod_state && gui_key_modifier_pressed) {
-        gui_key_modifier_pressed =3D 0;
+    if (!gui_key_modifier_pressed) {
         gui_keysym =3D 0;
     }
     if (!gui_keysym) {
--=20
2.9.3
