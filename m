Received: from eggs.gnu.org ([2001:4830:134:3::10]:41083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hf-0003mP-Qv
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hd-0005g2-0E
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0hc-0005fE-QD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:04 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:57 +0100
Message-Id: <20180112145258.10578-9-kraxel@redhat.com>
In-Reply-To: <20180112145258.10578-1-kraxel@redhat.com>
References: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] sdl2 uses surface relative coordinates
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

This patch fixes mouse positioning with -device usb-tablet and fullscreen
or resized window.

Fixes: 46522a82236ea0cf9011b89896d2d8f8ddaf2443
Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Message-Id: <20171117112258.5888-3-makovick@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 62a75318dd..8a0bd9149b 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -276,32 +276,10 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
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
+        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X,
+                             x, 0, surface_width(scon->surface));
+        qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y,
+                             y, 0, surface_height(scon->surface));
     } else {
         if (guest_cursor) {
             x -= guest_x;
-- 
2.9.3
