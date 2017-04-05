Received: from eggs.gnu.org ([2001:4830:134:3::10]:59740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgWD-0007kU-CX
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgWC-0008UJ-AF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:21 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42867
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgWC-0008Tu-2Q
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:20 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:26 +0100
Message-Id: <1491381329-3995-12-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 11/14] tcx: remove TARGET_PAGE_SIZE from
 tcx24_update_display()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

Now that page alignment is handled by the memory API, there is no need to
duplicate the code 4 times (4 * 1024 == 4096 == TARGET_PAGE_SIZE).

Finally we have now removed all traces of TARGET_PAGE_SIZE.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |   46 ++++++----------------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 14a17fe..0dd007e 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "cpu.h" /* FIXME shouldn't use TARGET_PAGE_SIZE */
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "hw/loader.h"
@@ -423,8 +422,8 @@ static void tcx24_update_display(void *opaque)
     ds = 1024;
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
-    for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE) {
-        if (tcx_check_dirty(ts, page, TARGET_PAGE_SIZE)) {
+    for (y = 0; y < ts->height; y++, page += ds) {
+        if (tcx_check_dirty(ts, page, ds)) {
             if (y_start < 0)
                 y_start = y;
             if (page < page_min)
@@ -435,38 +434,6 @@ static void tcx24_update_display(void *opaque)
             if (y >= ts->cursy && y < ts->cursy+32 && ts->cursx < ts->width) {
                 tcx_draw_cursor32(ts, d, y, ts->width);
             }
-            d += dd;
-            s += ds;
-            cptr += ds;
-            s24 += ds;
-            y++;
-            tcx24_draw_line32(ts, d, s, ts->width, cptr, s24);
-            if (y >= ts->cursy && y < ts->cursy+32 && ts->cursx < ts->width) {
-                tcx_draw_cursor32(ts, d, y, ts->width);
-            }
-            d += dd;
-            s += ds;
-            cptr += ds;
-            s24 += ds;
-            y++;
-            tcx24_draw_line32(ts, d, s, ts->width, cptr, s24);
-            if (y >= ts->cursy && y < ts->cursy+32 && ts->cursx < ts->width) {
-                tcx_draw_cursor32(ts, d, y, ts->width);
-            }
-            d += dd;
-            s += ds;
-            cptr += ds;
-            s24 += ds;
-            y++;
-            tcx24_draw_line32(ts, d, s, ts->width, cptr, s24);
-            if (y >= ts->cursy && y < ts->cursy+32 && ts->cursx < ts->width) {
-                tcx_draw_cursor32(ts, d, y, ts->width);
-            }
-            d += dd;
-            s += ds;
-            cptr += ds;
-            s24 += ds;
-            y++;
         } else {
             if (y_start >= 0) {
                 /* flush to display */
@@ -474,12 +441,11 @@ static void tcx24_update_display(void *opaque)
                                ts->width, y - y_start);
                 y_start = -1;
             }
-            d += dd * 4;
-            s += ds * 4;
-            cptr += ds * 4;
-            s24 += ds * 4;
-            y += 4;
         }
+        d += dd;
+        s += ds;
+        cptr += ds;
+        s24 += ds;
     }
     if (y_start >= 0) {
         /* flush to display */
-- 
1.7.10.4
