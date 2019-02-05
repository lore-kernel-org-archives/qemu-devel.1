Received: from eggs.gnu.org ([209.51.188.92]:42663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQw-0007Sr-HQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQv-0006Lv-08
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQt-00067Z-8t
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:53 +0100
Message-Id: <20190205105758.4230-10-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/14] kbd-state: use state tracker for sdl2
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

Use the new keyboard state tracked for sdl2.  We can drop the modifier
state tracking from sdl2.  Also keyup code is simpler, the state tracker
will take care to not send suspious keyup events to the guest.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190122092814.14919-4-kraxel@redhat.com
---
 include/ui/sdl2.h |  2 ++
 ui/sdl2-input.c   | 27 ++-------------------------
 ui/sdl2.c         | 12 +++---------
 3 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 71f5cfc6e3..0875b8d56b 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -10,6 +10,7 @@
 # include <SDL_image.h>
 #endif
=20
+#include "ui/kbd-state.h"
 #ifdef CONFIG_OPENGL
 # include "ui/egl-helpers.h"
 #endif
@@ -30,6 +31,7 @@ struct sdl2_console {
     int idle_counter;
     int ignore_hotkeys;
     SDL_GLContext winctx;
+    QKbdState *kbd;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 208266c6a5..22e3336aab 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -30,8 +30,6 @@
 #include "ui/sdl2.h"
 #include "sysemu/sysemu.h"
=20
-static uint8_t modifiers_state[SDL_NUM_SCANCODES];
-
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
 {
@@ -43,31 +41,10 @@ void sdl2_process_key(struct sdl2_console *scon,
     }
=20
     qcode =3D qemu_input_map_usb_to_qcode[ev->keysym.scancode];
-
-    /* modifier state tracking */
-    switch (ev->keysym.scancode) {
-    case SDL_SCANCODE_LCTRL:
-    case SDL_SCANCODE_LSHIFT:
-    case SDL_SCANCODE_LALT:
-    case SDL_SCANCODE_LGUI:
-    case SDL_SCANCODE_RCTRL:
-    case SDL_SCANCODE_RSHIFT:
-    case SDL_SCANCODE_RALT:
-    case SDL_SCANCODE_RGUI:
-        if (ev->type =3D=3D SDL_KEYUP) {
-            modifiers_state[ev->keysym.scancode] =3D 0;
-        } else {
-            modifiers_state[ev->keysym.scancode] =3D 1;
-        }
-        break;
-    default:
-        /* nothing */
-        break;
-    }
+    qkbd_state_key_event(scon->kbd, qcode, ev->type =3D=3D SDL_KEYDOWN);
=20
     if (!qemu_console_is_graphic(con)) {
-        bool ctrl =3D (modifiers_state[SDL_SCANCODE_LCTRL] ||
-                     modifiers_state[SDL_SCANCODE_RCTRL]);
+        bool ctrl =3D qkbd_state_modifier_get(scon->kbd, QKBD_MOD_CTRL);
         if (ev->type =3D=3D SDL_KEYDOWN) {
             switch (ev->keysym.scancode) {
             case SDL_SCANCODE_RETURN:
diff --git a/ui/sdl2.c b/ui/sdl2.c
index cde7feba91..1277cf28fb 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -38,7 +38,6 @@ static int gui_grab; /* if true, all keyboard/mouse eve=
nts are grabbed */
=20
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_keysym;
 static int gui_grab_code =3D KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
 static SDL_Cursor *sdl_cursor_hidden;
@@ -330,6 +329,7 @@ static void handle_keydown(SDL_Event *ev)
     int win;
     struct sdl2_console *scon =3D get_scon_from_window(ev->key.windowID)=
;
     int gui_key_modifier_pressed =3D get_mod_state();
+    int gui_keysym =3D 0;
=20
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.re=
peat) {
         switch (ev->key.keysym.scancode) {
@@ -410,16 +410,9 @@ static void handle_keydown(SDL_Event *ev)
 static void handle_keyup(SDL_Event *ev)
 {
     struct sdl2_console *scon =3D get_scon_from_window(ev->key.windowID)=
;
-    int gui_key_modifier_pressed =3D get_mod_state();
=20
     scon->ignore_hotkeys =3D false;
-
-    if (!gui_key_modifier_pressed) {
-        gui_keysym =3D 0;
-    }
-    if (!gui_keysym) {
-        sdl2_process_key(scon, &ev->key);
-    }
+    sdl2_process_key(scon, &ev->key);
 }
=20
 static void handle_textinput(SDL_Event *ev)
@@ -823,6 +816,7 @@ static void sdl2_display_init(DisplayState *ds, Displ=
ayOptions *o)
         sdl2_console[i].dcl.ops =3D &dcl_2d_ops;
 #endif
         sdl2_console[i].dcl.con =3D con;
+        sdl2_console[i].kbd =3D qkbd_state_init(con);
         register_displaychangelistener(&sdl2_console[i].dcl);
=20
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
--=20
2.9.3
