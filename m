Received: from eggs.gnu.org ([2001:4830:134:3::10]:39779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsY-0000Tf-GD
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoXsW-0005dX-IE
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoXsW-0005cZ-Bh
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:08:24 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 18:08:19 +0100
Message-Id: <20180221170820.15365-5-kraxel@redhat.com>
In-Reply-To: <20180221170820.15365-1-kraxel@redhat.com>
References: <20180221170820.15365-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/5] kbd-state: register sdl2 hotkeys
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

Register SDL2 hotkeys in keyboard state tracker, use it to check for
hotkeys.  Drop even more modifier code.

This also changes behavior a bit.  The Ctrl-Alt-<key> hotkey
combinations accept both ctrl keys now.  Likewise the
Ctrl-Alt-Shift-<key> mode you can enable with -alt-grab accepts both
ctrl and shift keys.  The -ctrl-grab mode (use right ctrl key) is not
supported.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-input.c |  1 -
 ui/sdl2.c       | 98 ++++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index d970655616..82ec375ea2 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -61,7 +61,6 @@ void sdl2_process_key(struct sdl2_console *scon,
                 break;
             }
         }
-        return;
     }
 
     kbd_state_key_event(scon->kbd, qcode, ev->type == SDL_KEYDOWN);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 50f5fca0f6..0f48f5a546 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -39,8 +39,6 @@ static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_key_modifier_pressed;
-static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
 static SDL_Cursor *sdl_cursor_normal;
 static SDL_Cursor *sdl_cursor_hidden;
 static int absolute_enabled;
@@ -312,43 +310,35 @@ static void toggle_full_screen(struct sdl2_console *scon)
     sdl2_redraw(scon);
 }
 
-static int get_mod_state(void)
-{
-    SDL_Keymod mod = SDL_GetModState();
-
-    if (alt_grab) {
-        return (mod & (gui_grab_code | KMOD_LSHIFT)) ==
-            (gui_grab_code | KMOD_LSHIFT);
-    } else if (ctrl_grab) {
-        return (mod & KMOD_RCTRL) == KMOD_RCTRL;
-    } else {
-        return (mod & gui_grab_code) == gui_grab_code;
-    }
-}
-
 static void handle_keydown(SDL_Event *ev)
 {
     int win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
-    int gui_keysym = 0;
+    KbdHotkey hotkey;
+    QKeyCode qcode;
 
-    gui_key_modifier_pressed = get_mod_state();
+    if (ev->key.keysym.scancode >= qemu_input_map_usb_to_qcode_len) {
+        return;
+    }
+    qcode = qemu_input_map_usb_to_qcode[ev->key.keysym.scancode];
 
-    if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
-        switch (ev->key.keysym.scancode) {
-        case SDL_SCANCODE_2:
-        case SDL_SCANCODE_3:
-        case SDL_SCANCODE_4:
-        case SDL_SCANCODE_5:
-        case SDL_SCANCODE_6:
-        case SDL_SCANCODE_7:
-        case SDL_SCANCODE_8:
-        case SDL_SCANCODE_9:
+    if (!scon->ignore_hotkeys && !ev->key.repeat) {
+        hotkey = kbd_state_hotkey_get(scon->kbd, qcode);
+        switch (hotkey) {
+        case KBD_HOTKEY_CONSOLE_2:
+        case KBD_HOTKEY_CONSOLE_3:
+        case KBD_HOTKEY_CONSOLE_4:
+        case KBD_HOTKEY_CONSOLE_5:
+        case KBD_HOTKEY_CONSOLE_6:
+        case KBD_HOTKEY_CONSOLE_7:
+        case KBD_HOTKEY_CONSOLE_8:
+        case KBD_HOTKEY_CONSOLE_9:
             if (gui_grab) {
                 sdl_grab_end(scon);
             }
+            sdl2_reset_keys(scon);
 
-            win = ev->key.keysym.scancode - SDL_SCANCODE_1;
+            win = hotkey - KBD_HOTKEY_CONSOLE_1;
             if (win < sdl2_num_outputs) {
                 sdl2_console[win].hidden = !sdl2_console[win].hidden;
                 if (sdl2_console[win].real_window) {
@@ -358,29 +348,25 @@ static void handle_keydown(SDL_Event *ev)
                         SDL_ShowWindow(sdl2_console[win].real_window);
                     }
                 }
-                gui_keysym = 1;
             }
             break;
-        case SDL_SCANCODE_F:
+        case KBD_HOTKEY_FULLSCREEN:
             toggle_full_screen(scon);
-            gui_keysym = 1;
             break;
-        case SDL_SCANCODE_G:
-            gui_keysym = 1;
+        case KBD_HOTKEY_GRAB:
             if (!gui_grab) {
                 sdl_grab_start(scon);
             } else if (!gui_fullscreen) {
                 sdl_grab_end(scon);
             }
             break;
-        case SDL_SCANCODE_U:
+        case KBD_HOTKEY_REDRAW:
             sdl2_window_destroy(scon);
             sdl2_window_create(scon);
             if (!scon->opengl) {
                 /* re-create scon->texture */
                 sdl2_2d_switch(&scon->dcl, scon->surface);
             }
-            gui_keysym = 1;
             break;
 #if 0
         case SDL_SCANCODE_KP_PLUS:
@@ -402,11 +388,14 @@ static void handle_keydown(SDL_Event *ev)
                 gui_keysym = 1;
             }
 #endif
+        case KBD_HOTKEY_NONE:
+            sdl2_process_key(scon, &ev->key);
+            break;
         default:
+            /* keep gcc happy */
             break;
         }
-    }
-    if (!gui_keysym) {
+    } else {
         sdl2_process_key(scon, &ev->key);
     }
 }
@@ -546,7 +535,7 @@ static void handle_windowevent(SDL_Event *ev)
          * Work around this by ignoring further hotkey events until a
          * key is released.
          */
-        scon->ignore_hotkeys = get_mod_state();
+        scon->ignore_hotkeys = SDL_GetModState();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
         if (gui_grab && !gui_fullscreen) {
@@ -756,6 +745,36 @@ void sdl_display_early_init(DisplayOptions *o)
     }
 }
 
+static void sdl2_hotkey_init(KbdState *kbd)
+{
+    /*
+     * Register traditional SDL hotkeys for now.
+     *
+     * Making this configurable is left as an
+     * excercise for another day ...
+     */
+    KbdModifier m1 = KBD_MOD_CTRL;
+    KbdModifier m2 = KBD_MOD_ALT;
+    KbdModifier m3 = KBD_MOD_NONE;
+    int i;
+
+    if (alt_grab) {
+        m3 = KBD_MOD_SHIFT;
+    }
+
+    kbd_state_hotkey_register(kbd, KBD_HOTKEY_FULLSCREEN,
+                              Q_KEY_CODE_F, m1, m2, m3);
+    kbd_state_hotkey_register(kbd, KBD_HOTKEY_GRAB,
+                              Q_KEY_CODE_G, m1, m2, m3);
+    kbd_state_hotkey_register(kbd, KBD_HOTKEY_REDRAW,
+                              Q_KEY_CODE_U, m1, m2, m3);
+    for (i = 0; i <= 7; i++) {
+        /* keys 2 ... 9 */
+        kbd_state_hotkey_register(kbd, KBD_HOTKEY_CONSOLE_2 + i,
+                                  Q_KEY_CODE_2 + i, m1, m2, m3);
+    }
+}
+
 void sdl_display_init(DisplayState *ds, DisplayOptions *o)
 {
     int flags;
@@ -817,6 +836,7 @@ void sdl_display_init(DisplayState *ds, DisplayOptions *o)
 #endif
         sdl2_console[i].dcl.con = con;
         sdl2_console[i].kbd = kbd_state_init(con);
+        sdl2_hotkey_init(sdl2_console[i].kbd);
         register_displaychangelistener(&sdl2_console[i].dcl);
 
 #if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
-- 
2.9.3
