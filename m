Received: from eggs.gnu.org ([2001:4830:134:3::10]:39947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxt-0001hA-NH
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxs-0008G0-Lw
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:45 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDxxs-0008Fq-Fb
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:44 -0500
Received: by mail-wr0-x242.google.com with SMTP id u97so12662942wrc.1
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 11:30:44 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 20:30:32 +0100
Message-Id: <20171112193032.9724-9-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 8/8] sdl2: Ignore UI hotkeys after a focus
 change when GUI modifier is held
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>
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
 ui/sdl2.c         | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

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
index 6feb637739..2d48686b83 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -310,22 +310,26 @@ static void toggle_full_screen(struct sdl2_console *scon)
     sdl2_redraw(scon);
 }
 
-static void handle_keydown(SDL_Event *ev)
+static int get_mod_state(void)
 {
-    int mod_state, win;
-    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
-
     if (alt_grab) {
-        mod_state = (SDL_GetModState() & (gui_grab_code | KMOD_LSHIFT)) ==
+        return (SDL_GetModState() & (gui_grab_code | KMOD_LSHIFT)) ==
             (gui_grab_code | KMOD_LSHIFT);
     } else if (ctrl_grab) {
-        mod_state = (SDL_GetModState() & KMOD_RCTRL) == KMOD_RCTRL;
+        return (SDL_GetModState() & KMOD_RCTRL) == KMOD_RCTRL;
     } else {
-        mod_state = (SDL_GetModState() & gui_grab_code) == gui_grab_code;
+        return (SDL_GetModState() & gui_grab_code) == gui_grab_code;
     }
-    gui_key_modifier_pressed = mod_state;
+}
+
+static void handle_keydown(SDL_Event *ev)
+{
+    int win;
+    struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
-    if (gui_key_modifier_pressed) {
+    gui_key_modifier_pressed = get_mod_state();
+
+    if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
         switch (ev->key.keysym.scancode) {
         case SDL_SCANCODE_2:
         case SDL_SCANCODE_3:
@@ -399,6 +403,8 @@ static void handle_keyup(SDL_Event *ev)
     int mod_state;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    scon->ignore_hotkeys = false;
+
     if (!alt_grab) {
         mod_state = (ev->key.keysym.mod & gui_grab_code);
     } else {
@@ -545,6 +551,7 @@ static void handle_windowevent(SDL_Event *ev)
         if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled)) {
             absolute_mouse_grab(scon);
         }
+        scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
         if (gui_grab && !gui_fullscreen) {
-- 
2.15.0
