Received: from eggs.gnu.org ([2001:4830:134:3::10]:53621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjh-0002Ug-9X
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjg-000452-Fg
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:33 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:52257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDpjg-00044Y-9D
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:32 -0500
Received: by mail-wr0-x241.google.com with SMTP id j23so12013623wra.9
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 02:43:32 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 11:42:42 +0100
Message-Id: <20171112104246.10007-5-makovick@gmail.com>
In-Reply-To: <20171112104246.10007-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171112104246.10007-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 4/8] sdl2: Do not hide the cursor on auxilliary
 windows
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

---
 ui/sdl2.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9cf4b1772b..677c22282d 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -465,6 +465,10 @@ static void handle_mousemotion(SDL_Event *ev)
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (qemu_input_is_absolute() || absolute_enabled) {
         int scr_w, scr_h;
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
@@ -492,6 +496,10 @@ static void handle_mousebutton(SDL_Event *ev)
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     bev = &ev->button;
     if (!gui_grab && !qemu_input_is_absolute()) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
@@ -514,6 +522,10 @@ static void handle_mousewheel(SDL_Event *ev)
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+    
     if (wev->y > 0) {
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (wev->y < 0) {
@@ -655,6 +667,11 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
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
2.15.0
