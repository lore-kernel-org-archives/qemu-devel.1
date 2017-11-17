Received: from eggs.gnu.org ([2001:4830:134:3::10]:40031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eFek9-0000mc-7k
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eFek4-0006oW-Qa
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:33 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:40122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eFek4-0006nV-JW
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:23:28 -0500
Received: by mail-lf0-x244.google.com with SMTP id a132so2298636lfa.7
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 03:23:28 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Fri, 17 Nov 2017 12:22:56 +0100
Message-Id: <20171117112258.5888-2-makovick@gmail.com>
In-Reply-To: <20171117112258.5888-1-makovick@gmail.com>
References: <20171117112258.5888-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] sdl2: Do not hide the cursor on auxilliary
 windows
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

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/sdl2.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 53dd447fd2..290b57b1b3 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -463,6 +463,10 @@ static void handle_mousemotion(SDL_Event *ev)
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+
     if (qemu_input_is_absolute() || absolute_enabled) {
         int scr_w, scr_h;
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
@@ -490,6 +494,10 @@ static void handle_mousebutton(SDL_Event *ev)
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+
     bev = &ev->button;
     if (!gui_grab && !qemu_input_is_absolute()) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
@@ -512,6 +520,10 @@ static void handle_mousewheel(SDL_Event *ev)
     SDL_MouseWheelEvent *wev = &ev->wheel;
     InputButton btn;
 
+    if (!qemu_console_is_graphic(scon->dcl.con)) {
+        return;
+    }
+
     if (wev->y > 0) {
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (wev->y < 0) {
@@ -652,6 +664,11 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
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
