Received: from eggs.gnu.org ([2001:4830:134:3::10]:40030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eFek9-0000mb-7e
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eFek7-0006qv-2t
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:33 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:40123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eFek6-0006pz-Qx
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:30 -0500
Received: by mail-lf0-x241.google.com with SMTP id a132so2298737lfa.7
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 03:23:30 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Fri, 17 Nov 2017 12:22:58 +0100
Message-Id: <20171117112258.5888-4-makovick@gmail.com>
In-Reply-To: <20171117112258.5888-1-makovick@gmail.com>
References: <20171117112258.5888-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] sdl2: Ignore UI hotkeys after a focus
 change when GUI modifier is held
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>

When SDL2 windows change focus while a key is held, the window that
receives the focus also receives a new KeyDown event, without an
autorepeat flag. This means that if a WM places the qemu console
over the main window after Ctrl-Alt-2, the console closes immediately
after opening. Then, the main window receives the KeyDown event again
and the whole process repeats.

This patch makes the SDL2 UI ignore the KeyDown events on a window that
just received the focus, if the GUI modifier was held. The ignore flag
is reset on a first KeyUp event. This effectively works around the issue
above.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 include/ui/sdl2.h |  1 +
 ui/sdl2.c         | 32 ++++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index b29cf803c9..51084e6320 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -24,6 +24,7 @@ struct sdl2_console {
     int opengl;
     int updates;
     int idle_counter;
+    int ignore_hotkeys;
     SDL_GLContext winctx;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4810f1fc43..414b1c71d9 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -310,22 +310,28 @@ static void toggle_full_screen(struct sdl2_console *scon)
     sdl2_redraw(scon);
 }
 
-static void handle_keydown(SDL_Event *ev)
+static int get_mod_state(void)
 {
-    int mod_state, win;
-    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+    SDL_Keymod mod = SDL_GetModState();
 
     if (alt_grab) {
-        mod_state = (SDL_GetModState() & (gui_grab_code | KMOD_LSHIFT)) ==
+        return (mod & (gui_grab_code | KMOD_LSHIFT)) ==
             (gui_grab_code | KMOD_LSHIFT);
     } else if (ctrl_grab) {
-        mod_state = (SDL_GetModState() & KMOD_RCTRL) == KMOD_RCTRL;
+        return (mod & KMOD_RCTRL) == KMOD_RCTRL;
     } else {
-        mod_state = (SDL_GetModState() & gui_grab_code) == gui_grab_code;
+        return (mod & gui_grab_code) == gui_grab_code;
     }
-    gui_key_modifier_pressed = mod_state;
+}
 
-    if (gui_key_modifier_pressed) {
+static void handle_keydown(SDL_Event *ev)
+{
+    int win;
+    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
+
+    gui_key_modifier_pressed = get_mod_state();
+
+    if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
         case SDL_SCANCODE_3:
@@ -399,6 +405,8 @@ static void handle_keyup(SDL_Event *ev)
     int mod_state;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    scon->ignore_hotkeys = false;
+
     if (!alt_grab) {
         mod_state = (ev->key.keysym.mod & gui_grab_code);
     } else {
@@ -543,6 +551,14 @@ static void handle_windowevent(SDL_Event *ev)
         if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled)) {
             absolute_mouse_grab(scon);
         }
+        /* If a new console window opened using a hotkey receives the
+         * focus, SDL sends another KEYDOWN event to the new window,
+         * closing the console window immediately after.
+         *
+         * Work around this by ignoring further hotkey events until a
+         * key is released.
+         */
+        scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
         if (gui_grab && !gui_fullscreen) {
-- 
2.15.0
