Received: from eggs.gnu.org ([2001:4830:134:3::10]:59717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgWB-0007iI-1X
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgWA-0008T8-4b
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:19 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42865
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgW9-0008ST-Tb
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:18 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:25 +0100
Message-Id: <1491381329-3995-11-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 10/14] tcx: remove TARGET_PAGE_SIZE from
 tcx_update_display()
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |   36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 4f4f03f..14a17fe 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -363,8 +363,8 @@ static void tcx_update_display(void *opaque)
     }
 
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
-    for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE) {
-        if (tcx_check_dirty(ts, page, TARGET_PAGE_SIZE)) {
+    for (y = 0; y < ts->height; y++, page += ds) {
+        if (tcx_check_dirty(ts, page, ds)) {
             if (y_start < 0)
                 y_start = y;
             if (page < page_min)
@@ -376,33 +376,6 @@ static void tcx_update_display(void *opaque)
             if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
                 fc(ts, d, y, ts->width);
             }
-            d += dd;
-            s += ds;
-            y++;
-
-            f(ts, d, s, ts->width);
-            if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
-                fc(ts, d, y, ts->width);
-            }
-            d += dd;
-            s += ds;
-            y++;
-
-            f(ts, d, s, ts->width);
-            if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
-                fc(ts, d, y, ts->width);
-            }
-            d += dd;
-            s += ds;
-            y++;
-
-            f(ts, d, s, ts->width);
-            if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
-                fc(ts, d, y, ts->width);
-            }
-            d += dd;
-            s += ds;
-            y++;
         } else {
             if (y_start >= 0) {
                 /* flush to display */
@@ -410,10 +383,9 @@ static void tcx_update_display(void *opaque)
                                ts->width, y - y_start);
                 y_start = -1;
             }
-            d += dd * 4;
-            s += ds * 4;
-            y += 4;
         }
+        s += ds;
+        d += dd;
     }
     if (y_start >= 0) {
         /* flush to display */
-- 
1.7.10.4
