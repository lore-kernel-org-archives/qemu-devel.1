Received: from eggs.gnu.org ([2001:4830:134:3::10]:57243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ5-0002I1-Pr
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ4-0005WZ-Qt
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:01 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42824
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgQ4-0005VY-JD
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:00 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:18 +0100
Message-Id: <1491381329-3995-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 03/14] cg3: remove unused width and height
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

These aren't required since we can use the display width and height directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index b42f60e..178a6dd 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -93,14 +93,11 @@ static void cg3_update_display(void *opaque)
     uint32_t *data;
     uint32_t dval;
     int x, y, y_start;
-    unsigned int width, height;
     ram_addr_t page, page_min, page_max;
 
     if (surface_bits_per_pixel(surface) != 32) {
         return;
     }
-    width = s->width;
-    height = s->height;
 
     y_start = -1;
     page_min = -1;
@@ -110,11 +107,11 @@ static void cg3_update_display(void *opaque)
     data = (uint32_t *)surface_data(surface);
 
     memory_region_sync_dirty_bitmap(&s->vram_mem);
-    for (y = 0; y < height; y++) {
+    for (y = 0; y < s->height; y++) {
         int update = s->full_update;
 
-        page = y * width;
-        update |= memory_region_get_dirty(&s->vram_mem, page, width,
+        page = y * s->width;
+        update |= memory_region_get_dirty(&s->vram_mem, page, s->width,
                                           DIRTY_MEMORY_VGA);
         if (update) {
             if (y_start < 0) {
@@ -127,7 +124,7 @@ static void cg3_update_display(void *opaque)
                 page_max = page;
             }
 
-            for (x = 0; x < width; x++) {
+            for (x = 0; x < s->width; x++) {
                 dval = *pix++;
                 dval = (s->r[dval] << 16) | (s->g[dval] << 8) | s->b[dval];
                 *data++ = dval;
@@ -137,8 +134,8 @@ static void cg3_update_display(void *opaque)
                 dpy_gfx_update(s->con, 0, y_start, s->width, y - y_start);
                 y_start = -1;
             }
-            pix += width;
-            data += width;
+            pix += s->width;
+            data += s->width;
         }
     }
     s->full_update = 0;
-- 
1.7.10.4
