Received: from eggs.gnu.org ([2001:4830:134:3::10]:44769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafA-0003Ih-5F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf6-0000B9-8s
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf2-00009S-Gl
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46EA43D96D
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:08:59 +0100
Message-Id: <20181219120904.17643-3-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/7] kbd-state: use state tracker for
 sdl2
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

Use the new keyboard state tracked for sdl2.  We can drop the modifier
state tracking from sdl2.  Also keyup code is simpler, the state tracker
will take care to not send suspious keyup events to the guest.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/sdl2.h |  2 ++
 ui/sdl2-input.c   | 40 +++-------------------------------------
 ui/sdl2.c         | 12 +++---------
 3 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index f43eecdbd6..393f4b0fd5 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -7,6 +7,7 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
 
+#include "ui/kbd-state.h"
 #ifdef CONFIG_OPENGL
 # include "ui/egl-helpers.h"
 #endif
@@ -27,6 +28,7 @@ struct sdl2_console {
     int idle_counter;
     int ignore_hotkeys;
     SDL_GLContext winctx;
+    KbdState *kbd;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index 1378b63dd9..ae52d548f6 100644
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
@@ -59,31 +46,10 @@ void sdl2_process_key(struct sdl2_console *scon,
     }
 
     qcode = qemu_input_map_usb_to_qcode[ev->keysym.scancode];
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
-        if (ev->type == SDL_KEYUP) {
-            modifiers_state[ev->keysym.scancode] = 0;
-        } else {
-            modifiers_state[ev->keysym.scancode] = 1;
-        }
-        break;
-    default:
-        /* nothing */
-        break;
-    }
+    kbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
 
     if (!qemu_console_is_graphic(con)) {
-        bool ctrl = (modifiers_state[SDL_SCANCODE_LCTRL] ||
-                     modifiers_state[SDL_SCANCODE_RCTRL]);
+        bool ctrl = kbd_state_modifier_get(scon->kbd, KBD_MOD_CTRL);
         if (ev->type == SDL_KEYDOWN) {
             switch (ev->keysym.scancode) {
             case SDL_SCANCODE_RETURN:
diff --git a/ui/sdl2.c b/ui/sdl2.c
index a10b6e3a08..ee1a2445d6 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -38,7 +38,6 @@ static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_keysym;
 static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
 static SDL_Cursor *sdl_cursor_hidden;
@@ -330,6 +329,7 @@ static void handle_keydown(SDL_Event *ev)
     int win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
     int gui_key_modifier_pressed = get_mod_state();
+    int gui_keysym = 0;
 
     if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
@@ -410,16 +410,9 @@ static void handle_keydown(SDL_Event *ev)
 static void handle_keyup(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
-    int gui_key_modifier_pressed = get_mod_state();
 
     scon->ignore_hotkeys = false;
-
-    if (!gui_key_modifier_pressed) {
-        gui_keysym = 0;
-    }
-    if (!gui_keysym) {
-        sdl2_process_key(scon, &ev->key);
-    }
+    sdl2_process_key(scon, &ev->key);
 }
 
 static void handle_textinput(SDL_Event *ev)
@@ -823,6 +816,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].dcl.ops = &dcl_2d_ops;
 #endif
         sdl2_console[i].dcl.con = con;
+        sdl2_console[i].kbd = kbd_state_init(con);
         register_displaychangelistener(&sdl2_console[i].dcl);
 
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
-- 
2.9.3
