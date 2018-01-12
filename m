Received: from eggs.gnu.org ([2001:4830:134:3::10]:41097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hg-0003nM-Hx
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hf-0005j6-Fb
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0hf-0005iH-7o
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:07 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:56 +0100
Message-Id: <20180112145258.10578-8-kraxel@redhat.com>
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] sdl2: Do not hide the cursor on auxilliary
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
Cc: Jindrich Makovicka <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jindrich Makovicka <makovick@gmail.com>

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Message-Id: <20171117112258.5888-2-makovick@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 8718cf36b5..62a75318dd 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -466,6 +466,10 @@ static void handle_mousemotion(SDL_Event *ev)
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+
     if (qemu_input_is_absolute() || absolute_enabled) {
         int scr_w, scr_h;
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
@@ -494,6 +498,10 @@ static void handle_mousebutton(SDL_Event *ev)
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+
     bev = &ev->button;
     if (!gui_grab && !qemu_input_is_absolute()) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
@@ -516,6 +524,10 @@ static void handle_mousewheel(SDL_Event *ev)
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+
     if (wev->y > 0) {
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (wev->y < 0) {
@@ -657,6 +669,11 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
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
2.9.3
