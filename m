Received: from eggs.gnu.org ([2001:4830:134:3::10]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UO-0007iQ-D6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UN-0004qn-4D
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UM-0004q5-QP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:43 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UL-0006gu-Sc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:40 +0100
Message-Id: <20180824093343.11346-50-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 49/52] hw/display/bcm2835_fb: Fix handling of
 virtual framebuffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The raspi framebuffir in bcm2835_fb supports the definition
of a virtual "viewport", which is smaller than the full
physical framebuffer size and at an adjustable offset within
it. Only the viewport area is sent to the screen. This allows
the guest to do things like double buffering, or scrolling
by adjusting the viewport origin. Currently QEMU doesn't
implement this at all.

Add support for this feature:
 * the property mailbox code needs to distinguish the
   virtual width/height from the physical width/height
 * the framebuffer code needs to do something with the
   virtual width/height/origin information

Note that the wiki documentation on the semantics of the
virtual and physical height and width has it the wrong way
around -- the virtual size is the size of the allocated
buffer, and the physical size is the size of the display,
so the virtual size is always the same as or larger than
the physical.

If the viewport size is set smaller than the physical
screen size, we ignore the viewport settings completely
and just display the physical screen area.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180814144436.679-7-peter.maydell@linaro.org
---
 include/hw/display/bcm2835_fb.h |  6 ++++--
 hw/display/bcm2835_fb.c         | 28 ++++++++++++++++++++++------
 hw/misc/bcm2835_property.c      | 21 +++++++++++++++------
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 95bcec7fe33..d992c60c120 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -62,7 +62,8 @@ void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig);
  */
 static inline uint32_t bcm2835_fb_get_pitch(BCM2835FBConfig *config)
 {
-    return config->xres * (config->bpp >> 3);
+    uint32_t xres = MAX(config->xres, config->xres_virtual);
+    return xres * (config->bpp >> 3);
 }
 
 /**
@@ -71,7 +72,8 @@ static inline uint32_t bcm2835_fb_get_pitch(BCM2835FBConfig *config)
  */
 static inline uint32_t bcm2835_fb_get_size(BCM2835FBConfig *config)
 {
-    return config->yres * bcm2835_fb_get_pitch(config);
+    uint32_t yres = MAX(config->yres, config->yres_virtual);
+    return yres * bcm2835_fb_get_pitch(config);
 }
 
 #endif
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index a6c0a0cc942..76a10072b46 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -126,6 +126,18 @@ static void draw_line_src16(void *opaque, uint8_t *dst, const uint8_t *src,
     }
 }
 
+static bool fb_use_offsets(BCM2835FBConfig *config)
+{
+    /*
+     * Return true if we should use the viewport offsets.
+     * Experimentally, the hardware seems to do this only if the
+     * viewport size is larger than the physical screen. (It doesn't
+     * prevent the guest setting this silly viewport setting, though...)
+     */
+    return config->xres_virtual > config->xres &&
+        config->yres_virtual > config->yres;
+}
+
 static void fb_update_display(void *opaque)
 {
     BCM2835FBState *s = opaque;
@@ -134,12 +146,18 @@ static void fb_update_display(void *opaque)
     int last = 0;
     int src_width = 0;
     int dest_width = 0;
+    uint32_t xoff = 0, yoff = 0;
 
     if (s->lock || !s->config.xres) {
         return;
     }
 
     src_width = bcm2835_fb_get_pitch(&s->config);
+    if (fb_use_offsets(&s->config)) {
+        xoff = s->config.xoffset;
+        yoff = s->config.yoffset;
+    }
+
     dest_width = s->config.xres;
 
     switch (surface_bits_per_pixel(surface)) {
@@ -165,8 +183,9 @@ static void fb_update_display(void *opaque)
     }
 
     if (s->invalidate) {
+        hwaddr base = s->config.base + xoff + yoff * src_width;
         framebuffer_update_memory_section(&s->fbsection, s->dma_mr,
-                                          s->config.base,
+                                          base,
                                           s->config.yres, src_width);
     }
 
@@ -176,7 +195,8 @@ static void fb_update_display(void *opaque)
                                draw_line_src16, s, &first, &last);
 
     if (first >= 0) {
-        dpy_gfx_update(s->con, 0, first, s->config.xres, last - first + 1);
+        dpy_gfx_update(s->con, 0, first, s->config.xres,
+                       last - first + 1);
     }
 
     s->invalidate = false;
@@ -202,8 +222,6 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
     s->config.base = s->vcram_base | (value & 0xc0000000);
     s->config.base += BCM2835_FB_OFFSET;
 
-    /* TODO - Manage properly virtual resolution */
-
     pitch = bcm2835_fb_get_pitch(&s->config);
     size = bcm2835_fb_get_size(&s->config);
 
@@ -224,8 +242,6 @@ void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig)
 
     s->config = *newconfig;
 
-    /* TODO - Manage properly virtual resolution */
-
     s->invalidate = true;
     qemu_console_resize(s->con, s->config.xres, s->config.yres);
     s->lock = false;
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index c8c4979bd26..e3ab677891b 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -155,23 +155,32 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00040002: /* Blank screen */
             resplen = 4;
             break;
-        case 0x00040003: /* Get display width/height */
-        case 0x00040004:
+        case 0x00040003: /* Get physical display width/height */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
             stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
             resplen = 8;
             break;
-        case 0x00044003: /* Test display width/height */
-        case 0x00044004:
+        case 0x00040004: /* Get virtual display width/height */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
+            stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
             resplen = 8;
             break;
-        case 0x00048003: /* Set display width/height */
-        case 0x00048004:
+        case 0x00044003: /* Test physical display width/height */
+        case 0x00044004: /* Test virtual display width/height */
+            resplen = 8;
+            break;
+        case 0x00048003: /* Set physical display width/height */
             fbconfig.xres = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
             fbconfig_updated = true;
             resplen = 8;
             break;
+        case 0x00048004: /* Set virtual display width/height */
+            fbconfig.xres_virtual = ldl_le_phys(&s->dma_as, value + 12);
+            fbconfig.yres_virtual = ldl_le_phys(&s->dma_as, value + 16);
+            fbconfig_updated = true;
+            resplen = 8;
+            break;
         case 0x00040005: /* Get depth */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
-- 
2.18.0
