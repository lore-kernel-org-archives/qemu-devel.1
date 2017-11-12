Received: from eggs.gnu.org ([2001:4830:134:3::10]:39914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxq-0001e4-LI
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxp-0008F6-RI
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:42 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDxxp-0008Ew-LN
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id r68so11705502wmr.0
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 11:30:41 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 20:30:29 +0100
Message-Id: <20171112193032.9724-6-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 5/8] sdl2 uses surface relative coordinates
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

This patch fixes mouse positioning with -device usb-tablet and fullscreen
or resized window.

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/sdl2.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 677c22282d..51721d764e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -276,32 +276,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
     }
 
     if (qemu_input_is_absolute()) {
-        int scr_w, scr_h;
-        int max_w = 0, max_h = 0;
-        int off_x = 0, off_y = 0;
-        int cur_off_x = 0, cur_off_y = 0;
-        int i;
-
-        for (i = 0; i < sdl2_num_outputs; i++) {
-            struct sdl2_console *thiscon = &sdl2_console[i];
-            if (thiscon->real_window && thiscon->surface) {
-                SDL_GetWindowSize(thiscon->real_window, &scr_w, &scr_h);
-                cur_off_x = thiscon->x;
-                cur_off_y = thiscon->y;
-                if (scr_w + cur_off_x > max_w) {
-                    max_w = scr_w + cur_off_x;
-                }
-                if (scr_h + cur_off_y > max_h) {
-                    max_h = scr_h + cur_off_y;
-                }
-                if (i == scon->idx) {
-                    off_x = cur_off_x;
-                    off_y = cur_off_y;
-                }
-            }
-        }
-        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X, off_x + x, 0, max_w);
-        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y, off_y + y, 0, max_h);
+        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X, x, 0, surface_width(scon->surface));
+        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y, y, 0, surface_height(scon->surface));
     } else {
         if (guest_cursor) {
             x -= guest_x;
-- 
2.15.0
