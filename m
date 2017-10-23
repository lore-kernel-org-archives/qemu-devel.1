Received: from eggs.gnu.org ([2001:4830:134:3::10]:58777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxO-00084B-MC
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxN-0000us-Rs
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:22 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxN-0000uY-Lx
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:21 -0400
Received: by mail-wm0-x244.google.com with SMTP id r68so12369802wmr.3
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:21 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:07:59 +0200
Message-Id: <20171023210803.20998-4-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 3/7] sdl2: Do not hide the cursor on auxilliary
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jindrich Makovicka <makovick@gmail.com>

---
 ui/sdl2.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aa37b39547..685e4fabec 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -169,10 +169,10 @@ static void sdl_hide_cursor(void)
         return;
     }
 
-    if (qemu_input_is_absolute()) {
-        SDL_ShowCursor(1);
-        SDL_SetCursor(sdl_cursor_hidden);
-    } else {
+    SDL_ShowCursor(SDL_DISABLE);
+    SDL_SetCursor(sdl_cursor_hidden);
+
+    if (!qemu_input_is_absolute()) {
         SDL_SetRelativeMouseMode(SDL_TRUE);
     }
 }
@@ -185,14 +185,16 @@ static void sdl_show_cursor(void)
 
     if (!qemu_input_is_absolute()) {
         SDL_SetRelativeMouseMode(SDL_FALSE);
-        SDL_ShowCursor(1);
-        if (guest_cursor &&
-            (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
-            SDL_SetCursor(guest_sprite);
-        } else {
-            SDL_SetCursor(sdl_cursor_normal);
-        }
     }
+
+    if (guest_cursor &&
+        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
+        SDL_SetCursor(guest_sprite);
+    } else {
+        SDL_SetCursor(sdl_cursor_normal);
+    }
+
+    SDL_ShowCursor(SDL_ENABLE);
 }
 
 static void sdl_grab_start(struct sdl2_console *scon)
@@ -463,6 +465,10 @@ static void handle_mousemotion(SDL_Event *ev)
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (qemu_input_is_absolute() || absolute_enabled) {
         int scr_w, scr_h;
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
@@ -490,6 +496,10 @@ static void handle_mousebutton(SDL_Event *ev)
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     bev = &ev->button;
     if (!gui_grab && !qemu_input_is_absolute()) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
@@ -512,6 +522,10 @@ static void handle_mousewheel(SDL_Event *ev)
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (wev->y > 0) {
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (wev->y < 0) {
@@ -651,6 +665,11 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
                            int x, int y, int on)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (on) {
         if (!guest_cursor) {
             sdl_show_cursor();
-- 
2.15.0.rc0
