Received: from eggs.gnu.org ([2001:4830:134:3::10]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2Iv-00058c-JX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds2It-0003MV-4t
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds2Is-0003KX-Sg
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F079F4ACBB
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:41:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 09:41:36 +0200
Message-Id: <20170913074140.5160-3-kraxel@redhat.com>
In-Reply-To: <20170913074140.5160-1-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] vga: stop passing pointers to
 vga_draw_line* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

Instead pass around the address (aka offset into vga memory).
Add vga_read_* helper functions which apply vbe_size_mask to
the address, to make sure the address stays within the valid
range, similar to the cirrus blitter fixes (commits ffaf857778
and 026aeffcb4).

Impact:  DoS for privileged guest users.  qemu crashes with
a segfault, when hitting the guard page after vga memory
allocation, while reading vga memory for display updates.

Fixes: CVE-2017-13672
Cc: P J P <ppandit@redhat.com>
Reported-by: David Buchanan <d@vidbuchanan.co.uk>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170828122906.18993-1-kraxel@redhat.com
---
 hw/display/vga-helpers.h | 202 ++++++++++++++++++++++++++---------------------
 hw/display/vga_int.h     |   1 +
 hw/display/vga.c         |   5 +-
 3 files changed, 114 insertions(+), 94 deletions(-)

diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
index 94f6de2046..5a752b3f9e 100644
--- a/hw/display/vga-helpers.h
+++ b/hw/display/vga-helpers.h
@@ -95,20 +95,46 @@ static void vga_draw_glyph9(uint8_t *d, int linesize,
     } while (--h);
 }
 
+static inline uint8_t vga_read_byte(VGACommonState *vga, uint32_t addr)
+{
+    return vga->vram_ptr[addr & vga->vbe_size_mask];
+}
+
+static inline uint16_t vga_read_word_le(VGACommonState *vga, uint32_t addr)
+{
+    uint32_t offset = addr & vga->vbe_size_mask & ~1;
+    uint16_t *ptr = (uint16_t *)(vga->vram_ptr + offset);
+    return lduw_le_p(ptr);
+}
+
+static inline uint16_t vga_read_word_be(VGACommonState *vga, uint32_t addr)
+{
+    uint32_t offset = addr & vga->vbe_size_mask & ~1;
+    uint16_t *ptr = (uint16_t *)(vga->vram_ptr + offset);
+    return lduw_be_p(ptr);
+}
+
+static inline uint32_t vga_read_dword_le(VGACommonState *vga, uint32_t addr)
+{
+    uint32_t offset = addr & vga->vbe_size_mask & ~3;
+    uint32_t *ptr = (uint32_t *)(vga->vram_ptr + offset);
+    return ldl_le_p(ptr);
+}
+
 /*
  * 4 color mode
  */
-static void vga_draw_line2(VGACommonState *s1, uint8_t *d,
-                           const uint8_t *s, int width)
+static void vga_draw_line2(VGACommonState *vga, uint8_t *d,
+                           uint32_t addr, int width)
 {
     uint32_t plane_mask, *palette, data, v;
     int x;
 
-    palette = s1->last_palette;
-    plane_mask = mask16[s1->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    palette = vga->last_palette;
+    plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = ((uint32_t *)s)[0];
+        data = vga_read_dword_le(vga, addr);
         data &= plane_mask;
         v = expand2[GET_PLANE(data, 0)];
         v |= expand2[GET_PLANE(data, 2)] << 2;
@@ -124,7 +150,7 @@ static void vga_draw_line2(VGACommonState *s1, uint8_t *d,
         ((uint32_t *)d)[6] = palette[(v >> 4) & 0xf];
         ((uint32_t *)d)[7] = palette[(v >> 0) & 0xf];
         d += 32;
-        s += 4;
+        addr += 4;
     }
 }
 
@@ -134,17 +160,17 @@ static void vga_draw_line2(VGACommonState *s1, uint8_t *d,
 /*
  * 4 color mode, dup2 horizontal
  */
-static void vga_draw_line2d2(VGACommonState *s1, uint8_t *d,
-                             const uint8_t *s, int width)
+static void vga_draw_line2d2(VGACommonState *vga, uint8_t *d,
+                             uint32_t addr, int width)
 {
     uint32_t plane_mask, *palette, data, v;
     int x;
 
-    palette = s1->last_palette;
-    plane_mask = mask16[s1->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    palette = vga->last_palette;
+    plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = ((uint32_t *)s)[0];
+        data = vga_read_dword_le(vga, addr);
         data &= plane_mask;
         v = expand2[GET_PLANE(data, 0)];
         v |= expand2[GET_PLANE(data, 2)] << 2;
@@ -160,24 +186,24 @@ static void vga_draw_line2d2(VGACommonState *s1, uint8_t *d,
         PUT_PIXEL2(d, 6, palette[(v >> 4) & 0xf]);
         PUT_PIXEL2(d, 7, palette[(v >> 0) & 0xf]);
         d += 64;
-        s += 4;
+        addr += 4;
     }
 }
 
 /*
  * 16 color mode
  */
-static void vga_draw_line4(VGACommonState *s1, uint8_t *d,
-                           const uint8_t *s, int width)
+static void vga_draw_line4(VGACommonState *vga, uint8_t *d,
+                           uint32_t addr, int width)
 {
     uint32_t plane_mask, data, v, *palette;
     int x;
 
-    palette = s1->last_palette;
-    plane_mask = mask16[s1->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    palette = vga->last_palette;
+    plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = ((uint32_t *)s)[0];
+        data = vga_read_dword_le(vga, addr);
         data &= plane_mask;
         v = expand4[GET_PLANE(data, 0)];
         v |= expand4[GET_PLANE(data, 1)] << 1;
@@ -192,24 +218,24 @@ static void vga_draw_line4(VGACommonState *s1, uint8_t *d,
         ((uint32_t *)d)[6] = palette[(v >> 4) & 0xf];
         ((uint32_t *)d)[7] = palette[(v >> 0) & 0xf];
         d += 32;
-        s += 4;
+        addr += 4;
     }
 }
 
 /*
  * 16 color mode, dup2 horizontal
  */
-static void vga_draw_line4d2(VGACommonState *s1, uint8_t *d,
-                             const uint8_t *s, int width)
+static void vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
+                             uint32_t addr, int width)
 {
     uint32_t plane_mask, data, v, *palette;
     int x;
 
-    palette = s1->last_palette;
-    plane_mask = mask16[s1->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    palette = vga->last_palette;
+    plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = ((uint32_t *)s)[0];
+        data = vga_read_dword_le(vga, addr);
         data &= plane_mask;
         v = expand4[GET_PLANE(data, 0)];
         v |= expand4[GET_PLANE(data, 1)] << 1;
@@ -224,7 +250,7 @@ static void vga_draw_line4d2(VGACommonState *s1, uint8_t *d,
         PUT_PIXEL2(d, 6, palette[(v >> 4) & 0xf]);
         PUT_PIXEL2(d, 7, palette[(v >> 0) & 0xf]);
         d += 64;
-        s += 4;
+        addr += 4;
     }
 }
 
@@ -233,21 +259,21 @@ static void vga_draw_line4d2(VGACommonState *s1, uint8_t *d,
  *
  * XXX: add plane_mask support (never used in standard VGA modes)
  */
-static void vga_draw_line8d2(VGACommonState *s1, uint8_t *d,
-                             const uint8_t *s, int width)
+static void vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
+                             uint32_t addr, int width)
 {
     uint32_t *palette;
     int x;
 
-    palette = s1->last_palette;
+    palette = vga->last_palette;
     width >>= 3;
     for(x = 0; x < width; x++) {
-        PUT_PIXEL2(d, 0, palette[s[0]]);
-        PUT_PIXEL2(d, 1, palette[s[1]]);
-        PUT_PIXEL2(d, 2, palette[s[2]]);
-        PUT_PIXEL2(d, 3, palette[s[3]]);
+        PUT_PIXEL2(d, 0, palette[vga_read_byte(vga, addr + 0)]);
+        PUT_PIXEL2(d, 1, palette[vga_read_byte(vga, addr + 1)]);
+        PUT_PIXEL2(d, 2, palette[vga_read_byte(vga, addr + 2)]);
+        PUT_PIXEL2(d, 3, palette[vga_read_byte(vga, addr + 3)]);
         d += 32;
-        s += 4;
+        addr += 4;
     }
 }
 
@@ -256,63 +282,63 @@ static void vga_draw_line8d2(VGACommonState *s1, uint8_t *d,
  *
  * XXX: add plane_mask support (never used in standard VGA modes)
  */
-static void vga_draw_line8(VGACommonState *s1, uint8_t *d,
-                           const uint8_t *s, int width)
+static void vga_draw_line8(VGACommonState *vga, uint8_t *d,
+                           uint32_t addr, int width)
 {
     uint32_t *palette;
     int x;
 
-    palette = s1->last_palette;
+    palette = vga->last_palette;
     width >>= 3;
     for(x = 0; x < width; x++) {
-        ((uint32_t *)d)[0] = palette[s[0]];
-        ((uint32_t *)d)[1] = palette[s[1]];
-        ((uint32_t *)d)[2] = palette[s[2]];
-        ((uint32_t *)d)[3] = palette[s[3]];
-        ((uint32_t *)d)[4] = palette[s[4]];
-        ((uint32_t *)d)[5] = palette[s[5]];
-        ((uint32_t *)d)[6] = palette[s[6]];
-        ((uint32_t *)d)[7] = palette[s[7]];
+        ((uint32_t *)d)[0] = palette[vga_read_byte(vga, addr + 0)];
+        ((uint32_t *)d)[1] = palette[vga_read_byte(vga, addr + 1)];
+        ((uint32_t *)d)[2] = palette[vga_read_byte(vga, addr + 2)];
+        ((uint32_t *)d)[3] = palette[vga_read_byte(vga, addr + 3)];
+        ((uint32_t *)d)[4] = palette[vga_read_byte(vga, addr + 4)];
+        ((uint32_t *)d)[5] = palette[vga_read_byte(vga, addr + 5)];
+        ((uint32_t *)d)[6] = palette[vga_read_byte(vga, addr + 6)];
+        ((uint32_t *)d)[7] = palette[vga_read_byte(vga, addr + 7)];
         d += 32;
-        s += 8;
+        addr += 8;
     }
 }
 
 /*
  * 15 bit color
  */
-static void vga_draw_line15_le(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line15_le(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
     int w;
     uint32_t v, r, g, b;
 
     w = width;
     do {
-        v = lduw_le_p((void *)s);
+        v = vga_read_word_le(vga, addr);
         r = (v >> 7) & 0xf8;
         g = (v >> 2) & 0xf8;
         b = (v << 3) & 0xf8;
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 2;
+        addr += 2;
         d += 4;
     } while (--w != 0);
 }
 
-static void vga_draw_line15_be(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line15_be(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
     int w;
     uint32_t v, r, g, b;
 
     w = width;
     do {
-        v = lduw_be_p((void *)s);
+        v = vga_read_word_be(vga, addr);
         r = (v >> 7) & 0xf8;
         g = (v >> 2) & 0xf8;
         b = (v << 3) & 0xf8;
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 2;
+        addr += 2;
         d += 4;
     } while (--w != 0);
 }
@@ -320,38 +346,38 @@ static void vga_draw_line15_be(VGACommonState *s1, uint8_t *d,
 /*
  * 16 bit color
  */
-static void vga_draw_line16_le(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line16_le(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
     int w;
     uint32_t v, r, g, b;
 
     w = width;
     do {
-        v = lduw_le_p((void *)s);
+        v = vga_read_word_le(vga, addr);
         r = (v >> 8) & 0xf8;
         g = (v >> 3) & 0xfc;
         b = (v << 3) & 0xf8;
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 2;
+        addr += 2;
         d += 4;
     } while (--w != 0);
 }
 
-static void vga_draw_line16_be(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line16_be(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
     int w;
     uint32_t v, r, g, b;
 
     w = width;
     do {
-        v = lduw_be_p((void *)s);
+        v = vga_read_word_be(vga, addr);
         r = (v >> 8) & 0xf8;
         g = (v >> 3) & 0xfc;
         b = (v << 3) & 0xf8;
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 2;
+        addr += 2;
         d += 4;
     } while (--w != 0);
 }
@@ -359,36 +385,36 @@ static void vga_draw_line16_be(VGACommonState *s1, uint8_t *d,
 /*
  * 24 bit color
  */
-static void vga_draw_line24_le(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line24_le(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
     int w;
     uint32_t r, g, b;
 
     w = width;
     do {
-        b = s[0];
-        g = s[1];
-        r = s[2];
+        b = vga_read_byte(vga, addr + 0);
+        g = vga_read_byte(vga, addr + 1);
+        r = vga_read_byte(vga, addr + 2);
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 3;
+        addr += 3;
         d += 4;
     } while (--w != 0);
 }
 
-static void vga_draw_line24_be(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line24_be(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
     int w;
     uint32_t r, g, b;
 
     w = width;
     do {
-        r = s[0];
-        g = s[1];
-        b = s[2];
+        r = vga_read_byte(vga, addr + 0);
+        g = vga_read_byte(vga, addr + 1);
+        b = vga_read_byte(vga, addr + 2);
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 3;
+        addr += 3;
         d += 4;
     } while (--w != 0);
 }
@@ -396,44 +422,36 @@ static void vga_draw_line24_be(VGACommonState *s1, uint8_t *d,
 /*
  * 32 bit color
  */
-static void vga_draw_line32_le(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line32_le(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
-#ifndef HOST_WORDS_BIGENDIAN
-    memcpy(d, s, width * 4);
-#else
     int w;
     uint32_t r, g, b;
 
     w = width;
     do {
-        b = s[0];
-        g = s[1];
-        r = s[2];
+        b = vga_read_byte(vga, addr + 0);
+        g = vga_read_byte(vga, addr + 1);
+        r = vga_read_byte(vga, addr + 2);
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 4;
+        addr += 4;
         d += 4;
     } while (--w != 0);
-#endif
 }
 
-static void vga_draw_line32_be(VGACommonState *s1, uint8_t *d,
-                               const uint8_t *s, int width)
+static void vga_draw_line32_be(VGACommonState *vga, uint8_t *d,
+                               uint32_t addr, int width)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    memcpy(d, s, width * 4);
-#else
     int w;
     uint32_t r, g, b;
 
     w = width;
     do {
-        r = s[1];
-        g = s[2];
-        b = s[3];
+        r = vga_read_byte(vga, addr + 1);
+        g = vga_read_byte(vga, addr + 2);
+        b = vga_read_byte(vga, addr + 3);
         ((uint32_t *)d)[0] = rgb_to_pixel32(r, g, b);
-        s += 4;
+        addr += 4;
         d += 4;
     } while (--w != 0);
-#endif
 }
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index dd6c958da3..ad34a1f048 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -94,6 +94,7 @@ typedef struct VGACommonState {
     uint32_t vram_size;
     uint32_t vram_size_mb; /* property */
     uint32_t vbe_size;
+    uint32_t vbe_size_mask;
     uint32_t latch;
     bool has_chain4_alias;
     MemoryRegion chain4_alias;
diff --git a/hw/display/vga.c b/hw/display/vga.c
index ad7a46563c..6fc8c8708a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1005,7 +1005,7 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
 }
 
 typedef void vga_draw_line_func(VGACommonState *s1, uint8_t *d,
-                                const uint8_t *s, int width);
+                                uint32_t srcaddr, int width);
 
 #include "vga-helpers.h"
 
@@ -1666,7 +1666,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             if (y_start < 0)
                 y_start = y;
             if (!(is_buffer_shared(surface))) {
-                vga_draw_line(s, d, s->vram_ptr + addr, width);
+                vga_draw_line(s, d, addr, width);
                 if (s->cursor_draw_line)
                     s->cursor_draw_line(s, d, y);
             }
@@ -2170,6 +2170,7 @@ void vga_common_init(VGACommonState *s, Object *obj, bool global_vmstate)
     if (!s->vbe_size) {
         s->vbe_size = s->vram_size;
     }
+    s->vbe_size_mask = s->vbe_size - 1;
 
     s->is_vbe_vmstate = 1;
     memory_region_init_ram_nomigrate(&s->vram, obj, "vga.vram", s->vram_size,
-- 
2.9.3
