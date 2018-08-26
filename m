Received: from eggs.gnu.org ([208.118.235.92]:33096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mslade@binks.home>) id 1ftsRH-0001n8-PY
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 06:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mslade@binks.home>) id 1ftsMt-0002tu-DA
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 06:34:04 -0400
Received: from
	2001-44b8-3110-2100-e41e-9e7c-7050-f9ff.static.ipv6.internode.on.net
	([2001:44b8:3110:2100:e41e:9e7c:7050:f9ff]:60846 helo=binks.home)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mslade@binks.home>) id 1ftsMs-0002t0-Vj
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 06:34:03 -0400
From: Michael Slade <mslade@epic-code.com.au>
Date: Sun, 26 Aug 2018 18:59:56 +1000
Message-Id: <20180826102438.0CF8E760833@binks.home>
Subject: [Qemu-devel] [PATCH 1/1] vga: honor blink attribute in text modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>

Signed-off-by: Michael Slade <mslade@epic-code.com.au>
---
 hw/display/vga.c     | 50 +++++++++++++++++++++++++++++++++-----------
 hw/display/vga_int.h |  2 ++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 72181330b8..03d9181d58 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -36,8 +36,10 @@
 //#define DEBUG_VGA_MEM
 //#define DEBUG_VGA_REG
 
-/* 16 state changes per vertical frame @60 Hz */
+/* state change per 16 frames @60 Hz */
 #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
+/* state change per 32 frames @60 Hz */
+#define VGA_TEXT_BLINK_PERIOD_MS        (1000 * 2 * 32 / 60)
 
 /*
  * Video Graphics Array (VGA)
@@ -1165,6 +1167,7 @@ static void vga_get_text_resolution(VGACommonState *s, int *pwidth, int *pheight
     *pcheight = cheight;
 }
 
+
 /*
  * Text mode update
  * Missing:
@@ -1185,6 +1188,8 @@ static void vga_draw_text(VGACommonState *s, int full_update)
     uint32_t *palette;
     uint32_t *ch_attr_ptr;
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    bool cursor_blink = 0;
+    bool attr_blink = 0;
 
     /* compute font data address (in plane 2) */
     v = sr(s, VGA_SEQ_CHARACTER_MAP);
@@ -1266,6 +1271,13 @@ static void vga_draw_text(VGACommonState *s, int full_update)
     if (now >= s->cursor_blink_time) {
         s->cursor_blink_time = now + VGA_TEXT_CURSOR_PERIOD_MS / 2;
         s->cursor_visible_phase = !s->cursor_visible_phase;
+        cursor_blink = 1;
+    }
+    bool blink_active = s->ar[VGA_ATC_MODE] & 0x08;
+    if (now >= s->attr_blink_time) {
+        s->attr_blink_time = now + VGA_TEXT_BLINK_PERIOD_MS / 2;
+        s->attr_blink_visible_phase = !s->attr_blink_visible_phase;
+        attr_blink = blink_active;
     }
 
     dest = surface_data(surface);
@@ -1283,23 +1295,36 @@ static void vga_draw_text(VGACommonState *s, int full_update)
                 break;
             }
             ch_attr = *(uint16_t *)src;
-            if (full_update || ch_attr != *ch_attr_ptr || src == cursor_ptr) {
+#ifdef HOST_WORDS_BIGENDIAN
+            ch = ch_attr >> 8;
+            cattr = ch_attr & 0xff;
+#else
+            ch = ch_attr & 0xff;
+            cattr = ch_attr >> 8;
+#endif
+
+            if (
+                full_update ||
+                    ch_attr != *ch_attr_ptr ||
+                    (src == cursor_ptr && cursor_blink) ||
+                    (attr_blink && (cattr & 0x80))
+                ) {
                 if (cx < cx_min)
                     cx_min = cx;
                 if (cx > cx_max)
                     cx_max = cx;
                 *ch_attr_ptr = ch_attr;
-#ifdef HOST_WORDS_BIGENDIAN
-                ch = ch_attr >> 8;
-                cattr = ch_attr & 0xff;
-#else
-                ch = ch_attr & 0xff;
-                cattr = ch_attr >> 8;
-#endif
                 font_ptr = font_base[(cattr >> 3) & 1];
                 font_ptr += 32 * 4 * ch;
-                bgcol = palette[cattr >> 4];
-                fgcol = palette[cattr & 0x0f];
+                if (blink_active) {
+                    bgcol = palette[(cattr >> 4) & 7];
+                    fgcol = (!(cattr & 0x80) || s->attr_blink_visible_phase) ?
+                        palette[cattr & 0x0f] :
+                        bgcol;
+                } else {
+                    bgcol = palette[cattr >> 4];
+                    fgcol = palette[cattr & 0x0f];
+                }
                 if (cw == 16) {
                     vga_draw_glyph16(d1, linesize,
                                      font_ptr, cheight, fgcol, bgcol);
@@ -1756,7 +1781,8 @@ static void vga_update_display(void *opaque)
         }
         if (graphic_mode != s->graphic_mode) {
             s->graphic_mode = graphic_mode;
-            s->cursor_blink_time = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+            s->cursor_blink_time = s->attr_blink_time =
+                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
             full_update = 1;
         }
         switch(graphic_mode) {
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index fe23b81442..775b3e7aa9 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -157,7 +157,9 @@ typedef struct VGACommonState {
     bool force_shadow;
     uint8_t cursor_start, cursor_end;
     bool cursor_visible_phase;
+    bool attr_blink_visible_phase;
     int64_t cursor_blink_time;
+    int64_t attr_blink_time;
     uint32_t cursor_offset;
     const GraphicHwOps *hw_ops;
     bool full_update_text;
-- 
2.17.1
