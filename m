Received: from eggs.gnu.org ([2001:4830:134:3::10]:48674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYy-0005xG-0l
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYv-0004BU-IZ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:48 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:44:30 +0100
Message-Id: <20180814144436.679-3-peter.maydell@linaro.org>
In-Reply-To: <20180814144436.679-1-peter.maydell@linaro.org>
References: <20180814144436.679-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/8] hw/misc/bcm2835_property: Track fb
 settings using BCM2835FBConfig
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

Refactor the fb property setting code so that rather than
using a set of pointers to local variables to track
whether a config value has been updated in the current
mbox and if so what its new value is, we just copy
all the current settings of the fb at the start, and
then update that copy as we go along, before asking
the fb to switch to it at the end.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/display/bcm2835_fb.h |  4 +-
 hw/display/bcm2835_fb.c         | 27 ++---------
 hw/misc/bcm2835_property.c      | 80 ++++++++++++++-------------------
 3 files changed, 37 insertions(+), 74 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 8485825ba5f..b965698d28a 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -53,8 +53,6 @@ typedef struct {
     uint32_t pitch;
 } BCM2835FBState;
 
-void bcm2835_fb_reconfigure(BCM2835FBState *s, uint32_t *xres, uint32_t *yres,
-                            uint32_t *xoffset, uint32_t *yoffset, uint32_t *bpp,
-                            uint32_t *pixo, uint32_t *alpha);
+void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig);
 
 #endif
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 0ffad49ab8f..8155de5d0b1 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -213,34 +213,13 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
     s->lock = false;
 }
 
-void bcm2835_fb_reconfigure(BCM2835FBState *s, uint32_t *xres, uint32_t *yres,
-                            uint32_t *xoffset, uint32_t *yoffset, uint32_t *bpp,
-                            uint32_t *pixo, uint32_t *alpha)
+void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig)
 {
     s->lock = true;
 
     /* TODO: input validation! */
-    if (xres) {
-        s->config.xres = *xres;
-    }
-    if (yres) {
-        s->config.yres = *yres;
-    }
-    if (xoffset) {
-        s->config.xoffset = *xoffset;
-    }
-    if (yoffset) {
-        s->config.yoffset = *yoffset;
-    }
-    if (bpp) {
-        s->config.bpp = *bpp;
-    }
-    if (pixo) {
-        s->config.pixo = *pixo;
-    }
-    if (alpha) {
-        s->config.alpha = *alpha;
-    }
+
+    s->config = *newconfig;
 
     /* TODO - Manage properly virtual resolution */
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index c79f358702d..df0645d1b84 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -21,11 +21,14 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
-    uint32_t xres, yres, xoffset, yoffset, bpp, pixo, alpha;
-    uint32_t tmp_xres, tmp_yres, tmp_xoffset, tmp_yoffset;
-    uint32_t tmp_bpp, tmp_pixo, tmp_alpha;
-    uint32_t *newxres = NULL, *newyres = NULL, *newxoffset = NULL,
-        *newyoffset = NULL, *newbpp = NULL, *newpixo = NULL, *newalpha = NULL;
+
+    /*
+     * Copy the current state of the framebuffer config; we will update
+     * this copy as we process tags and then ask the framebuffer to use
+     * it at the end.
+     */
+    BCM2835FBConfig fbconfig = s->fbdev->config;
+    bool fbconfig_updated = false;
 
     value &= ~0xf;
 
@@ -141,12 +144,9 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* Frame buffer */
 
         case 0x00040001: /* Allocate buffer */
-            stl_le_phys(&s->dma_as, value + 12, s->fbdev->config.base);
-            tmp_xres = newxres != NULL ? *newxres : s->fbdev->config.xres;
-            tmp_yres = newyres != NULL ? *newyres : s->fbdev->config.yres;
-            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->config.bpp;
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.base);
             stl_le_phys(&s->dma_as, value + 16,
-                        tmp_xres * tmp_yres * tmp_bpp / 8);
+                        fbconfig.xres * fbconfig.yres * fbconfig.bpp / 8);
             resplen = 8;
             break;
         case 0x00048001: /* Release buffer */
@@ -157,10 +157,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00040003: /* Get display width/height */
         case 0x00040004:
-            tmp_xres = newxres != NULL ? *newxres : s->fbdev->config.xres;
-            tmp_yres = newyres != NULL ? *newyres : s->fbdev->config.yres;
-            stl_le_phys(&s->dma_as, value + 12, tmp_xres);
-            stl_le_phys(&s->dma_as, value + 16, tmp_yres);
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
+            stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
             resplen = 8;
             break;
         case 0x00044003: /* Test display width/height */
@@ -169,74 +167,64 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00048003: /* Set display width/height */
         case 0x00048004:
-            xres = ldl_le_phys(&s->dma_as, value + 12);
-            newxres = &xres;
-            yres = ldl_le_phys(&s->dma_as, value + 16);
-            newyres = &yres;
+            fbconfig.xres = ldl_le_phys(&s->dma_as, value + 12);
+            fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
+            fbconfig_updated = true;
             resplen = 8;
             break;
         case 0x00040005: /* Get depth */
-            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->config.bpp;
-            stl_le_phys(&s->dma_as, value + 12, tmp_bpp);
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
             break;
         case 0x00044005: /* Test depth */
             resplen = 4;
             break;
         case 0x00048005: /* Set depth */
-            bpp = ldl_le_phys(&s->dma_as, value + 12);
-            newbpp = &bpp;
+            fbconfig.bpp = ldl_le_phys(&s->dma_as, value + 12);
+            fbconfig_updated = true;
             resplen = 4;
             break;
         case 0x00040006: /* Get pixel order */
-            tmp_pixo = newpixo != NULL ? *newpixo : s->fbdev->config.pixo;
-            stl_le_phys(&s->dma_as, value + 12, tmp_pixo);
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
             resplen = 4;
             break;
         case 0x00044006: /* Test pixel order */
             resplen = 4;
             break;
         case 0x00048006: /* Set pixel order */
-            pixo = ldl_le_phys(&s->dma_as, value + 12);
-            newpixo = &pixo;
+            fbconfig.pixo = ldl_le_phys(&s->dma_as, value + 12);
+            fbconfig_updated = true;
             resplen = 4;
             break;
         case 0x00040007: /* Get alpha */
-            tmp_alpha = newalpha != NULL ? *newalpha : s->fbdev->config.alpha;
-            stl_le_phys(&s->dma_as, value + 12, tmp_alpha);
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
             resplen = 4;
             break;
         case 0x00044007: /* Test pixel alpha */
             resplen = 4;
             break;
         case 0x00048007: /* Set alpha */
-            alpha = ldl_le_phys(&s->dma_as, value + 12);
-            newalpha = &alpha;
+            fbconfig.alpha = ldl_le_phys(&s->dma_as, value + 12);
+            fbconfig_updated = true;
             resplen = 4;
             break;
         case 0x00040008: /* Get pitch */
-            tmp_xres = newxres != NULL ? *newxres : s->fbdev->config.xres;
-            tmp_bpp = newbpp != NULL ? *newbpp : s->fbdev->config.bpp;
-            stl_le_phys(&s->dma_as, value + 12, tmp_xres * tmp_bpp / 8);
+            stl_le_phys(&s->dma_as, value + 12,
+                        fbconfig.xres * fbconfig.bpp / 8);
             resplen = 4;
             break;
         case 0x00040009: /* Get virtual offset */
-            tmp_xoffset = newxoffset != NULL ?
-                *newxoffset : s->fbdev->config.xoffset;
-            tmp_yoffset = newyoffset != NULL ?
-                *newyoffset : s->fbdev->config.yoffset;
-            stl_le_phys(&s->dma_as, value + 12, tmp_xoffset);
-            stl_le_phys(&s->dma_as, value + 16, tmp_yoffset);
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
+            stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
             resplen = 8;
             break;
         case 0x00044009: /* Test virtual offset */
             resplen = 8;
             break;
         case 0x00048009: /* Set virtual offset */
-            xoffset = ldl_le_phys(&s->dma_as, value + 12);
-            newxoffset = &xoffset;
-            yoffset = ldl_le_phys(&s->dma_as, value + 16);
-            newyoffset = &yoffset;
+            fbconfig.xoffset = ldl_le_phys(&s->dma_as, value + 12);
+            fbconfig.yoffset = ldl_le_phys(&s->dma_as, value + 16);
+            fbconfig_updated = true;
             resplen = 8;
             break;
         case 0x0004000a: /* Get/Test/Set overscan */
@@ -287,10 +275,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     }
 
     /* Reconfigure framebuffer if required */
-    if (newxres || newyres || newxoffset || newyoffset || newbpp || newpixo
-        || newalpha) {
-        bcm2835_fb_reconfigure(s->fbdev, newxres, newyres, newxoffset,
-                               newyoffset, newbpp, newpixo, newalpha);
+    if (fbconfig_updated) {
+        bcm2835_fb_reconfigure(s->fbdev, &fbconfig);
     }
 
     /* Buffer response code */
-- 
2.18.0
