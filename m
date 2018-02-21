Received: from eggs.gnu.org ([2001:4830:134:3::10]:39780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsY-0000Tg-GH
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsV-0005bz-FF
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoXsV-0005be-90
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:23 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 18:08:18 +0100
Message-Id: <20180221170820.15365-4-kraxel@redhat.com>
In-Reply-To: <20180221170820.15365-1-kraxel@redhat.com>
References: <20180221170820.15365-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/5] kbd-state: use state tracker for sdl2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, berrange@redhat.com, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

Use the new keyboard state tracked for sdl2.  We can drop the modifier
state tracking from sdl2.  Also keyup code is simpler, the state tracker
will take care to not send suspious keyup events to the guest.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/sdl2.h |  2 ++
 ui/sdl2-input.c   | 43 ++-----------------------------------------
 ui/sdl2.c         | 18 +++---------------
 3 files changed, 7 insertions(+), 56 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 51084e6320..c316e42706 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -7,6 +7,7 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
 
+#include "ui/kbd-state.h"
 #ifdef CONFIG_OPENGL
 # include "ui/egl-helpers.h"
 #endif
@@ -26,6 +27,7 @@ struct sdl2_console {
     int idle_counter;
     int ignore_hotkeys;
     SDL_GLContext winctx;
+    KbdState *kbd;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 605d781971..d970655616 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -30,22 +30,9 @@
 #include "ui/sdl2.h"
 #include "sysemu/sysemu.h"
 
-static uint8_t modifiers_state[SDL_NUM_SCANCODES];
-
 void sdl2_reset_keys(struct sdl2_console *scon)
 {
-    QemuConsole *con = scon ? scon->dcl.con : NULL;
-    int i;
-
-    for (i = 0 ;
-         i < SDL_NUM_SCANCODES && i < qemu_input_map_usb_to_qcode_len ;
-         i++) {
-        if (modifiers_state[i]) {
-            int qcode = qemu_input_map_usb_to_qcode[i];
-            qemu_input_event_send_key_qcode(con, qcode, false);
-            modifiers_state[i] = 0;
-        }
-    }
+    kbd_state_lift_all_keys(scon->kbd);
 }
 
 void sdl2_process_key(struct sdl2_console *scon,
@@ -77,31 +64,5 @@ void sdl2_process_key(struct sdl2_console *scon,
         return;
     }
 
-    switch (ev->keysym.scancode) {
-#if 0
-    case SDL_SCANCODE_NUMLOCKCLEAR:
-    case SDL_SCANCODE_CAPSLOCK:
-        /* SDL does not send the key up event, so we generate it */
-        qemu_input_event_send_key_qcode(con, qcode, true);
-        qemu_input_event_send_key_qcode(con, qcode, false);
-        return;
-#endif
-    case SDL_SCANCODE_LCTRL:
-    case SDL_SCANCODE_LSHIFT:
-    case SDL_SCANCODE_LALT:
-    case SDL_SCANCODE_LGUI:
-    case SDL_SCANCODE_RCTRL:
-    case SDL_SCANCODE_RSHIFT:
-    case SDL_SCANCODE_RALT:
-    case SDL_SCANCODE_RGUI:
-        if (ev->type == SDL_KEYUP) {
-            modifiers_state[ev->keysym.scancode] = 0;
-        } else {
-            modifiers_state[ev->keysym.scancode] = 1;
-        }
-        /* fall though */
-    default:
-        qemu_input_event_send_key_qcode(con, qcode,
-                                        ev->type == SDL_KEYDOWN);
-    }
+    kbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
 }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 6e96a4a24c..50f5fca0f6 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -40,7 +40,6 @@ static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 static int gui_saved_grab;
 static int gui_fullscreen;
 static int gui_key_modifier_pressed;
-static int gui_keysym;
 static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
 static SDL_Cursor *sdl_cursor_hidden;
@@ -331,6 +330,7 @@ static void handle_keydown(SDL_Event *ev)
 {
     int win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    int gui_keysym = 0;
 
     gui_key_modifier_pressed = get_mod_state();
 
@@ -413,23 +413,10 @@ static void handle_keydown(SDL_Event *ev)
 
 static void handle_keyup(SDL_Event *ev)
 {
-    int mod_state;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
     scon->ignore_hotkeys = false;
-
-    if (!alt_grab) {
-        mod_state = (ev->key.keysym.mod & gui_grab_code);
-    } else {
-        mod_state = (ev->key.keysym.mod & (gui_grab_code | KMOD_LSHIFT));
-    }
-    if (!mod_state && gui_key_modifier_pressed) {
-        gui_key_modifier_pressed = 0;
-        gui_keysym = 0;
-    }
-    if (!gui_keysym) {
-        sdl2_process_key(scon, &ev->key);
-    }
+    sdl2_process_key(scon, &ev->key);
 }
 
 static void handle_textinput(SDL_Event *ev)
@@ -829,6 +816,7 @@ void sdl_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].dcl.ops = &dcl_2d_ops;
 #endif
         sdl2_console[i].dcl.con = con;
+        sdl2_console[i].kbd = kbd_state_init(con);
         register_displaychangelistener(&sdl2_console[i].dcl);
 
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
-- 
2.9.3
