Received: from eggs.gnu.org ([2001:4830:134:3::10]:48736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaZ0-00060q-Hu
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYy-0004DL-9a
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:50 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:44:29 +0100
Message-Id: <20180814144436.679-2-peter.maydell@linaro.org>
In-Reply-To: <20180814144436.679-1-peter.maydell@linaro.org>
References: <20180814144436.679-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/8] hw/misc/bcm2835_fb: Move config fields to
 their own struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The handling of framebuffer properties in the bcm2835_property code
is a bit clumsy, because for each of the many fb related properties
we try to track the value we're about to set and whether we're going
to be setting a value, and then we hand all the new values off
to the framebuffer via a function which takes them all as separate
arguments. It would be simpler if the property code could easily
copy all the framebuffer's current settings, update them with
the new specified values and then ask the framebuffer to switch
to the new set.

As the first part of this refactoring, pull all the fb config
settings fields in BCM2835FBState out into their own struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/display/bcm2835_fb.h |  26 ++++++--
 hw/display/bcm2835_fb.c         | 114 +++++++++++++++++---------------
 hw/misc/bcm2835_property.c      |  28 ++++----
 3 files changed, 94 insertions(+), 74 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index ae0a3807f2c..8485825ba5f 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -17,6 +17,20 @@
 #define TYPE_BCM2835_FB "bcm2835-fb"
 #define BCM2835_FB(obj) OBJECT_CHECK(BCM2835FBState, (obj), TYPE_BCM2835_FB)
 
+/*
+ * Configuration information about the fb which the guest can program
+ * via the mailbox property interface.
+ */
+typedef struct {
+    uint32_t xres, yres;
+    uint32_t xres_virtual, yres_virtual;
+    uint32_t xoffset, yoffset;
+    uint32_t bpp;
+    uint32_t base;
+    uint32_t pixo;
+    uint32_t alpha;
+} BCM2835FBConfig;
+
 typedef struct {
     /*< private >*/
     SysBusDevice busdev;
@@ -31,12 +45,12 @@ typedef struct {
     qemu_irq mbox_irq;
 
     bool lock, invalidate, pending;
-    uint32_t xres, yres;
-    uint32_t xres_virtual, yres_virtual;
-    uint32_t xoffset, yoffset;
-    uint32_t bpp;
-    uint32_t base, pitch, size;
-    uint32_t pixo, alpha;
+
+    BCM2835FBConfig config;
+
+    /* These are just cached values calculated from the config settings */
+    uint32_t size;
+    uint32_t pitch;
 } BCM2835FBState;
 
 void bcm2835_fb_reconfigure(BCM2835FBState *s, uint32_t *xres, uint32_t *yres,
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 3355f4c131b..0ffad49ab8f 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -52,7 +52,7 @@ static void draw_line_src16(void *opaque, uint8_t *dst, const uint8_t *src,
     int bpp = surface_bits_per_pixel(surface);
 
     while (width--) {
-        switch (s->bpp) {
+        switch (s->config.bpp) {
         case 8:
             /* lookup palette starting at video ram base
              * TODO: cache translation, rather than doing this each time!
@@ -91,7 +91,7 @@ static void draw_line_src16(void *opaque, uint8_t *dst, const uint8_t *src,
             break;
         }
 
-        if (s->pixo == 0) {
+        if (s->config.pixo == 0) {
             /* swap to BGR pixel format */
             uint8_t tmp = r;
             r = b;
@@ -135,12 +135,12 @@ static void fb_update_display(void *opaque)
     int src_width = 0;
     int dest_width = 0;
 
-    if (s->lock || !s->xres) {
+    if (s->lock || !s->config.xres) {
         return;
     }
 
-    src_width = s->xres * (s->bpp >> 3);
-    dest_width = s->xres;
+    src_width = s->config.xres * (s->config.bpp >> 3);
+    dest_width = s->config.xres;
 
     switch (surface_bits_per_pixel(surface)) {
     case 0:
@@ -165,16 +165,18 @@ static void fb_update_display(void *opaque)
     }
 
     if (s->invalidate) {
-        framebuffer_update_memory_section(&s->fbsection, s->dma_mr, s->base,
-                                          s->yres, src_width);
+        framebuffer_update_memory_section(&s->fbsection, s->dma_mr,
+                                          s->config.base,
+                                          s->config.yres, src_width);
     }
 
-    framebuffer_update_display(surface, &s->fbsection, s->xres, s->yres,
+    framebuffer_update_display(surface, &s->fbsection,
+                               s->config.xres, s->config.yres,
                                src_width, dest_width, 0, s->invalidate,
                                draw_line_src16, s, &first, &last);
 
     if (first >= 0) {
-        dpy_gfx_update(s->con, 0, first, s->xres, last - first + 1);
+        dpy_gfx_update(s->con, 0, first, s->config.xres, last - first + 1);
     }
 
     s->invalidate = false;
@@ -186,28 +188,28 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
 
     s->lock = true;
 
-    s->xres = ldl_le_phys(&s->dma_as, value);
-    s->yres = ldl_le_phys(&s->dma_as, value + 4);
-    s->xres_virtual = ldl_le_phys(&s->dma_as, value + 8);
-    s->yres_virtual = ldl_le_phys(&s->dma_as, value + 12);
-    s->bpp = ldl_le_phys(&s->dma_as, value + 20);
-    s->xoffset = ldl_le_phys(&s->dma_as, value + 24);
-    s->yoffset = ldl_le_phys(&s->dma_as, value + 28);
+    s->config.xres = ldl_le_phys(&s->dma_as, value);
+    s->config.yres = ldl_le_phys(&s->dma_as, value + 4);
+    s->config.xres_virtual = ldl_le_phys(&s->dma_as, value + 8);
+    s->config.yres_virtual = ldl_le_phys(&s->dma_as, value + 12);
+    s->config.bpp = ldl_le_phys(&s->dma_as, value + 20);
+    s->config.xoffset = ldl_le_phys(&s->dma_as, value + 24);
+    s->config.yoffset = ldl_le_phys(&s->dma_as, value + 28);
 
-    s->base = s->vcram_base | (value & 0xc0000000);
-    s->base += BCM2835_FB_OFFSET;
+    s->config.base = s->vcram_base | (value & 0xc0000000);
+    s->config.base += BCM2835_FB_OFFSET;
 
     /* TODO - Manage properly virtual resolution */
 
-    s->pitch = s->xres * (s->bpp >> 3);
-    s->size = s->yres * s->pitch;
+    s->pitch = s->config.xres * (s->config.bpp >> 3);
+    s->size = s->config.yres * s->pitch;
 
     stl_le_phys(&s->dma_as, value + 16, s->pitch);
-    stl_le_phys(&s->dma_as, value + 32, s->base);
+    stl_le_phys(&s->dma_as, value + 32, s->config.base);
     stl_le_phys(&s->dma_as, value + 36, s->size);
 
     s->invalidate = true;
-    qemu_console_resize(s->con, s->xres, s->yres);
+    qemu_console_resize(s->con, s->config.xres, s->config.yres);
     s->lock = false;
 }
 
@@ -219,34 +221,34 @@ void bcm2835_fb_reconfigure(BCM2835FBState *s, uint32_t *xres, uint32_t *yres,
 
     /* TODO: input validation! */
     if (xres) {
-        s->xres = *xres;
+        s->config.xres = *xres;
     }
     if (yres) {
-        s->yres = *yres;
+        s->config.yres = *yres;
     }
     if (xoffset) {
-        s->xoffset = *xoffset;
+        s->config.xoffset = *xoffset;
     }
     if (yoffset) {
-        s->yoffset = *yoffset;
+        s->config.yoffset = *yoffset;
     }
     if (bpp) {
-        s->bpp = *bpp;
+        s->config.bpp = *bpp;
     }
     if (pixo) {
-        s->pixo = *pixo;
+        s->config.pixo = *pixo;
     }
     if (alpha) {
-        s->alpha = *alpha;
+        s->config.alpha = *alpha;
     }
 
     /* TODO - Manage properly virtual resolution */
 
-    s->pitch = s->xres * (s->bpp >> 3);
-    s->size = s->yres * s->pitch;
+    s->pitch = s->config.xres * (s->config.bpp >> 3);
+    s->size = s->config.yres * s->pitch;
 
     s->invalidate = true;
-    qemu_console_resize(s->con, s->xres, s->yres);
+    qemu_console_resize(s->con, s->config.xres, s->config.yres);
     s->lock = false;
 }
 
@@ -312,18 +314,18 @@ static const VMStateDescription vmstate_bcm2835_fb = {
         VMSTATE_BOOL(lock, BCM2835FBState),
         VMSTATE_BOOL(invalidate, BCM2835FBState),
         VMSTATE_BOOL(pending, BCM2835FBState),
-        VMSTATE_UINT32(xres, BCM2835FBState),
-        VMSTATE_UINT32(yres, BCM2835FBState),
-        VMSTATE_UINT32(xres_virtual, BCM2835FBState),
-        VMSTATE_UINT32(yres_virtual, BCM2835FBState),
-        VMSTATE_UINT32(xoffset, BCM2835FBState),
-        VMSTATE_UINT32(yoffset, BCM2835FBState),
-        VMSTATE_UINT32(bpp, BCM2835FBState),
-        VMSTATE_UINT32(base, BCM2835FBState),
+        VMSTATE_UINT32(config.xres, BCM2835FBState),
+        VMSTATE_UINT32(config.yres, BCM2835FBState),
+        VMSTATE_UINT32(config.xres_virtual, BCM2835FBState),
+        VMSTATE_UINT32(config.yres_virtual, BCM2835FBState),
+        VMSTATE_UINT32(config.xoffset, BCM2835FBState),
+        VMSTATE_UINT32(config.yoffset, BCM2835FBState),
+        VMSTATE_UINT32(config.bpp, BCM2835FBState),
+        VMSTATE_UINT32(config.base, BCM2835FBState),
         VMSTATE_UINT32(pitch, BCM2835FBState),
         VMSTATE_UINT32(size, BCM2835FBState),
-        VMSTATE_UINT32(pixo, BCM2835FBState),
-        VMSTATE_UINT32(alpha, BCM2835FBState),
+        VMSTATE_UINT32(config.pixo, BCM2835FBState),
+        VMSTATE_UINT32(config.alpha, BCM2835FBState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -349,13 +351,13 @@ static void bcm2835_fb_reset(DeviceState *dev)
 
     s->pending = false;
 
-    s->xres_virtual = s->xres;
-    s->yres_virtual = s->yres;
-    s->xoffset = 0;
-    s->yoffset = 0;
-    s->base = s->vcram_base + BCM2835_FB_OFFSET;
-    s->pitch = s->xres * (s->bpp >> 3);
-    s->size = s->yres * s->pitch;
+    s->config.xres_virtual = s->config.xres;
+    s->config.yres_virtual = s->config.yres;
+    s->config.xoffset = 0;
+    s->config.yoffset = 0;
+    s->config.base = s->vcram_base + BCM2835_FB_OFFSET;
+    s->pitch = s->config.xres * (s->config.bpp >> 3);
+    s->size = s->config.yres * s->pitch;
 
     s->invalidate = true;
     s->lock = false;
@@ -385,18 +387,20 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
     bcm2835_fb_reset(dev);
 
     s->con = graphic_console_init(dev, 0, &vgafb_ops, s);
-    qemu_console_resize(s->con, s->xres, s->yres);
+    qemu_console_resize(s->con, s->config.xres, s->config.yres);
 }
 
 static Property bcm2835_fb_props[] = {
     DEFINE_PROP_UINT32("vcram-base", BCM2835FBState, vcram_base, 0),/*required*/
     DEFINE_PROP_UINT32("vcram-size", BCM2835FBState, vcram_size,
                        DEFAULT_VCRAM_SIZE),
-    DEFINE_PROP_UINT32("xres", BCM2835FBState, xres, 640),
-    DEFINE_PROP_UINT32("yres", BCM2835FBState, yres, 480),
-    DEFINE_PROP_UINT32("bpp", BCM2835FBState, bpp, 16),
-    DEFINE_PROP_UINT32("pixo", BCM2835FBState, pixo, 1), /* 1=RGB, 0=BGR */
-    DEFINE_PROP_UINT32("alpha", BCM2835FBState, alpha, 2), /* alpha ignored */
+    DEFINE_PROP_UINT32("xres", BCM2835FBState, config.xres, 640),
+    DEFINE_PROP_UINT32("yres", BCM2835FBState, config.yres, 480),
+    DEFINE_PROP_UINT32("bpp", BCM2835FBState, config.bpp, 16),
+    DEFINE_PROP_UINT32("pixo",
+                       BCM2835FBState, config.pixo, 1), /* 1=RGB, 0=BGR */
+    DEFINE_PROP_UINT32("alpha",
+                       BCM2835FBState, config.alpha, 2), /* alpha ignored */
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 70eaafd325f..c79f358702d 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -141,10 +141,10 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* Frame buffer */
 
         case 0x00040001: /* Allocate buffer */
-            stl_le_phys(&s->dma_as, value + 12, s->fbdev->base);
-            tmp_xres = newxres != NULL ? *newxres : s->fbdev->xres;
-            tmp_yres = newyres != NULL ? *newyres : s->fbdev->yres;
-            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->bpp;
+            stl_le_phys(&s->dma_as, value + 12, s->fbdev->config.base);
+            tmp_xres = newxres != NULL ? *newxres : s->fbdev->config.xres;
+            tmp_yres = newyres != NULL ? *newyres : s->fbdev->config.yres;
+            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->config.bpp;
             stl_le_phys(&s->dma_as, value + 16,
                         tmp_xres * tmp_yres * tmp_bpp / 8);
             resplen = 8;
@@ -157,8 +157,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00040003: /* Get display width/height */
         case 0x00040004:
-            tmp_xres = newxres != NULL ? *newxres : s->fbdev->xres;
-            tmp_yres = newyres != NULL ? *newyres : s->fbdev->yres;
+            tmp_xres = newxres != NULL ? *newxres : s->fbdev->config.xres;
+            tmp_yres = newyres != NULL ? *newyres : s->fbdev->config.yres;
             stl_le_phys(&s->dma_as, value + 12, tmp_xres);
             stl_le_phys(&s->dma_as, value + 16, tmp_yres);
             resplen = 8;
@@ -176,7 +176,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
         case 0x00040005: /* Get depth */
-            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->bpp;
+            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->config.bpp;
             stl_le_phys(&s->dma_as, value + 12, tmp_bpp);
             resplen = 4;
             break;
@@ -189,7 +189,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 4;
             break;
         case 0x00040006: /* Get pixel order */
-            tmp_pixo = newpixo != NULL ? *newpixo : s->fbdev->pixo;
+            tmp_pixo = newpixo != NULL ? *newpixo : s->fbdev->config.pixo;
             stl_le_phys(&s->dma_as, value + 12, tmp_pixo);
             resplen = 4;
             break;
@@ -202,7 +202,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 4;
             break;
         case 0x00040007: /* Get alpha */
-            tmp_alpha = newalpha != NULL ? *newalpha : s->fbdev->alpha;
+            tmp_alpha = newalpha != NULL ? *newalpha : s->fbdev->config.alpha;
             stl_le_phys(&s->dma_as, value + 12, tmp_alpha);
             resplen = 4;
             break;
@@ -215,14 +215,16 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 4;
             break;
         case 0x00040008: /* Get pitch */
-            tmp_xres = newxres != NULL ? *newxres : s->fbdev->xres;
-            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->bpp;
+            tmp_xres = newxres != NULL ? *newxres : s->fbdev->config.xres;
+            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->config.bpp;
             stl_le_phys(&s->dma_as, value + 12, tmp_xres * tmp_bpp / 8);
             resplen = 4;
             break;
         case 0x00040009: /* Get virtual offset */
-            tmp_xoffset = newxoffset != NULL ? *newxoffset : s->fbdev->xoffset;
-            tmp_yoffset = newyoffset != NULL ? *newyoffset : s->fbdev->yoffset;
+            tmp_xoffset = newxoffset != NULL ?
+                *newxoffset : s->fbdev->config.xoffset;
+            tmp_yoffset = newyoffset != NULL ?
+                *newyoffset : s->fbdev->config.yoffset;
             stl_le_phys(&s->dma_as, value + 12, tmp_xoffset);
             stl_le_phys(&s->dma_as, value + 16, tmp_yoffset);
             resplen = 8;
-- 
2.18.0
