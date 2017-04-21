Received: from eggs.gnu.org ([2001:4830:134:3::10]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1U00-0002iK-Qm
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1Tzy-0002q5-NU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:33:04 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50207
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1Tzy-0002pk-Gf
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:33:02 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Apr 2017 09:28:45 +0100
Message-Id: <1492763327-12742-12-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 11/13] tcx: remove primitives for non-32-bit
 surfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

As all surfaces in QEMU are now either shared or 32-bit ARGB regardless of
the guest depth, remove all non-32-bit primitives from tcx_update_display()
and consequence their implementation which are no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/tcx.c |  126 ++++--------------------------------------------------
 1 file changed, 8 insertions(+), 118 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 0dd007e..6da6dfb 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -140,25 +140,12 @@ static void update_palette_entries(TCXState *s, int start, int end)
     int i;
 
     for (i = start; i < end; i++) {
-        switch (surface_bits_per_pixel(surface)) {
-        default:
-        case 8:
-            s->palette[i] = rgb_to_pixel8(s->r[i], s->g[i], s->b[i]);
-            break;
-        case 15:
-            s->palette[i] = rgb_to_pixel15(s->r[i], s->g[i], s->b[i]);
-            break;
-        case 16:
-            s->palette[i] = rgb_to_pixel16(s->r[i], s->g[i], s->b[i]);
-            break;
-        case 32:
-            if (is_surface_bgr(surface)) {
-                s->palette[i] = rgb_to_pixel32bgr(s->r[i], s->g[i], s->b[i]);
-            } else {
-                s->palette[i] = rgb_to_pixel32(s->r[i], s->g[i], s->b[i]);
-            }
-            break;
+        if (is_surface_bgr(surface)) {
+            s->palette[i] = rgb_to_pixel32bgr(s->r[i], s->g[i], s->b[i]);
+        } else {
+            s->palette[i] = rgb_to_pixel32(s->r[i], s->g[i], s->b[i]);
         }
+        break;
     }
     tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
 }
@@ -176,31 +163,6 @@ static void tcx_draw_line32(TCXState *s1, uint8_t *d,
     }
 }
 
-static void tcx_draw_line16(TCXState *s1, uint8_t *d,
-                            const uint8_t *s, int width)
-{
-    int x;
-    uint8_t val;
-    uint16_t *p = (uint16_t *)d;
-
-    for (x = 0; x < width; x++) {
-        val = *s++;
-        *p++ = s1->palette[val];
-    }
-}
-
-static void tcx_draw_line8(TCXState *s1, uint8_t *d,
-                           const uint8_t *s, int width)
-{
-    int x;
-    uint8_t val;
-
-    for(x = 0; x < width; x++) {
-        val = *s++;
-        *d++ = s1->palette[val];
-    }
-}
-
 static void tcx_draw_cursor32(TCXState *s1, uint8_t *d,
                               int y, int width)
 {
@@ -227,57 +189,6 @@ static void tcx_draw_cursor32(TCXState *s1, uint8_t *d,
     }
 }
 
-static void tcx_draw_cursor16(TCXState *s1, uint8_t *d,
-                              int y, int width)
-{
-    int x, len;
-    uint32_t mask, bits;
-    uint16_t *p = (uint16_t *)d;
-
-    y = y - s1->cursy;
-    mask = s1->cursmask[y];
-    bits = s1->cursbits[y];
-    len = MIN(width - s1->cursx, 32);
-    p = &p[s1->cursx];
-    for (x = 0; x < len; x++) {
-        if (mask & 0x80000000) {
-            if (bits & 0x80000000) {
-                *p = s1->palette[259];
-            } else {
-                *p = s1->palette[258];
-            }
-        }
-        p++;
-        mask <<= 1;
-        bits <<= 1;
-    }
-}
-
-static void tcx_draw_cursor8(TCXState *s1, uint8_t *d,
-                              int y, int width)
-{
-    int x, len;
-    uint32_t mask, bits;
-
-    y = y - s1->cursy;
-    mask = s1->cursmask[y];
-    bits = s1->cursbits[y];
-    len = MIN(width - s1->cursx, 32);
-    d = &d[s1->cursx];
-    for (x = 0; x < len; x++) {
-        if (mask & 0x80000000) {
-            if (bits & 0x80000000) {
-                *d = s1->palette[259];
-            } else {
-                *d = s1->palette[258];
-            }
-        }
-        d++;
-        mask <<= 1;
-        bits <<= 1;
-    }
-}
-
 /*
   XXX Could be much more optimal:
   * detect if line/page/whole screen is in 24 bit mode
@@ -326,10 +237,8 @@ static void tcx_update_display(void *opaque)
     ram_addr_t page, page_min, page_max;
     int y, y_start, dd, ds;
     uint8_t *d, *s;
-    void (*f)(TCXState *s1, uint8_t *dst, const uint8_t *src, int width);
-    void (*fc)(TCXState *s1, uint8_t *dst, int y, int width);
 
-    if (surface_bits_per_pixel(surface) == 0) {
+    if (surface_bits_per_pixel(surface) != 32) {
         return;
     }
 
@@ -342,25 +251,6 @@ static void tcx_update_display(void *opaque)
     dd = surface_stride(surface);
     ds = 1024;
 
-    switch (surface_bits_per_pixel(surface)) {
-    case 32:
-        f = tcx_draw_line32;
-        fc = tcx_draw_cursor32;
-        break;
-    case 15:
-    case 16:
-        f = tcx_draw_line16;
-        fc = tcx_draw_cursor16;
-        break;
-    default:
-    case 8:
-        f = tcx_draw_line8;
-        fc = tcx_draw_cursor8;
-        break;
-    case 0:
-        return;
-    }
-
     memory_region_sync_dirty_bitmap(&ts->vram_mem);
     for (y = 0; y < ts->height; y++, page += ds) {
         if (tcx_check_dirty(ts, page, ds)) {
@@ -371,9 +261,9 @@ static void tcx_update_display(void *opaque)
             if (page > page_max)
                 page_max = page;
 
-            f(ts, d, s, ts->width);
+            tcx_draw_line32(ts, d, s, ts->width);
             if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
-                fc(ts, d, y, ts->width);
+                tcx_draw_cursor32(ts, d, y, ts->width);
             }
         } else {
             if (y_start >= 0) {
-- 
1.7.10.4
