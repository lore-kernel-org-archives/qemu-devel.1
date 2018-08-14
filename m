Received: from eggs.gnu.org ([2001:4830:134:3::10]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaZ1-000622-Kv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaZ0-0004ES-48
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:51 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:44:35 +0100
Message-Id: <20180814144436.679-8-peter.maydell@linaro.org>
In-Reply-To: <20180814144436.679-1-peter.maydell@linaro.org>
References: <20180814144436.679-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 7/8] hw/display/bcm2835_fb: Validate config
 settings
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

Validate the config settings that the guest tries to set.

The wiki page documentation is not really accurate here:
generally rather than failing requests to set bad parameters,
the hardware will just clip them to something sensible.

Validate the most important parameters: sizes and
the viewport offsets. This prevents the framebuffer
code from trying to read out-of-range memory.

In the property handling code, we validate the new parameters every
time we encounter a tag that sets them. This means we validate the
config multiple times if the request includes multiple config-setting
tags, but the code would require significant restructuring to do a
validation only once but still return the clipped settings for
get-parameter tags and the buffer allocation tag.

Validation of settings made via the older bcm2835_fb_mbox_push()
function will be done in the next commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/display/bcm2835_fb.h |  8 +++++
 hw/display/bcm2835_fb.c         | 48 +++++++++++++++++++++++++++--
 hw/misc/bcm2835_property.c      | 54 ++++++++++++++++-----------------
 3 files changed, 81 insertions(+), 29 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index d992c60c120..228988ba056 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -76,4 +76,12 @@ static inline uint32_t bcm2835_fb_get_size(BCM2835FBConfig *config)
     return yres * bcm2835_fb_get_pitch(config);
 }
 
+/**
+ * bcm2835_fb_validate_config: check provided config
+ *
+ * Validates the configuration information provided by the guest and
+ * adjusts it if necessary.
+ */
+void bcm2835_fb_validate_config(BCM2835FBConfig *config);
+
 #endif
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 76a10072b46..3edb8b5cfcb 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -34,6 +34,13 @@
 #define DEFAULT_VCRAM_SIZE 0x4000000
 #define BCM2835_FB_OFFSET  0x00100000
 
+/* Maximum permitted framebuffer size; experimentally determined on an rpi2 */
+#define XRES_MAX 3840
+#define YRES_MAX 2560
+/* Framebuffer size used if guest requests zero size */
+#define XRES_SMALL 592
+#define YRES_SMALL 488
+
 static void fb_invalidate_display(void *opaque)
 {
     BCM2835FBState *s = BCM2835_FB(opaque);
@@ -202,6 +209,45 @@ static void fb_update_display(void *opaque)
     s->invalidate = false;
 }
 
+void bcm2835_fb_validate_config(BCM2835FBConfig *config)
+{
+    /*
+     * Validate the config, and clip any bogus values into range,
+     * as the hardware does. Note that fb_update_display() relies on
+     * this happening to prevent it from performing out-of-range
+     * accesses on redraw.
+     */
+    config->xres = MIN(config->xres, XRES_MAX);
+    config->xres_virtual = MIN(config->xres_virtual, XRES_MAX);
+    config->yres = MIN(config->yres, YRES_MAX);
+    config->yres_virtual = MIN(config->yres_virtual, YRES_MAX);
+
+    /*
+     * These are not minima: a 40x40 framebuffer will be accepted.
+     * They're only used as defaults if the guest asks for zero size.
+     */
+    if (config->xres == 0) {
+        config->xres = XRES_SMALL;
+    }
+    if (config->yres == 0) {
+        config->yres = YRES_SMALL;
+    }
+    if (config->xres_virtual == 0) {
+        config->xres_virtual = config->xres;
+    }
+    if (config->yres_virtual == 0) {
+        config->yres_virtual = config->yres;
+    }
+
+    if (fb_use_offsets(config)) {
+        /* Clip the offsets so the viewport is within the physical screen */
+        config->xoffset = MIN(config->xoffset,
+                              config->xres_virtual - config->xres);
+        config->yoffset = MIN(config->yoffset,
+                              config->yres_virtual - config->yres);
+    }
+}
+
 static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
 {
     uint32_t pitch;
@@ -238,8 +284,6 @@ void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig)
 {
     s->lock = true;
 
-    /* TODO: input validation! */
-
     s->config = *newconfig;
 
     s->invalidate = true;
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index e3ab677891b..145427ae0f8 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -155,16 +155,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00040002: /* Blank screen */
             resplen = 4;
             break;
-        case 0x00040003: /* Get physical display width/height */
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
-            stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
-            resplen = 8;
-            break;
-        case 0x00040004: /* Get virtual display width/height */
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
-            stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
-            resplen = 8;
-            break;
         case 0x00044003: /* Test physical display width/height */
         case 0x00044004: /* Test virtual display width/height */
             resplen = 8;
@@ -172,29 +162,35 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00048003: /* Set physical display width/height */
             fbconfig.xres = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres = ldl_le_phys(&s->dma_as, value + 16);
+            bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
+            /* fall through */
+        case 0x00040003: /* Get physical display width/height */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.xres);
+            stl_le_phys(&s->dma_as, value + 16, fbconfig.yres);
             resplen = 8;
             break;
         case 0x00048004: /* Set virtual display width/height */
             fbconfig.xres_virtual = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yres_virtual = ldl_le_phys(&s->dma_as, value + 16);
+            bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
+            /* fall through */
+        case 0x00040004: /* Get virtual display width/height */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.xres_virtual);
+            stl_le_phys(&s->dma_as, value + 16, fbconfig.yres_virtual);
             resplen = 8;
             break;
-        case 0x00040005: /* Get depth */
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
-            resplen = 4;
-            break;
         case 0x00044005: /* Test depth */
             resplen = 4;
             break;
         case 0x00048005: /* Set depth */
             fbconfig.bpp = ldl_le_phys(&s->dma_as, value + 12);
+            bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            resplen = 4;
-            break;
-        case 0x00040006: /* Get pixel order */
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
+            /* fall through */
+        case 0x00040005: /* Get depth */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.bpp);
             resplen = 4;
             break;
         case 0x00044006: /* Test pixel order */
@@ -202,11 +198,11 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00048006: /* Set pixel order */
             fbconfig.pixo = ldl_le_phys(&s->dma_as, value + 12);
+            bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
-            resplen = 4;
-            break;
-        case 0x00040007: /* Get alpha */
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
+            /* fall through */
+        case 0x00040006: /* Get pixel order */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.pixo);
             resplen = 4;
             break;
         case 0x00044007: /* Test pixel alpha */
@@ -214,7 +210,11 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00048007: /* Set alpha */
             fbconfig.alpha = ldl_le_phys(&s->dma_as, value + 12);
+            bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
+            /* fall through */
+        case 0x00040007: /* Get alpha */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.alpha);
             resplen = 4;
             break;
         case 0x00040008: /* Get pitch */
@@ -222,18 +222,18 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                         bcm2835_fb_get_pitch(&fbconfig));
             resplen = 4;
             break;
-        case 0x00040009: /* Get virtual offset */
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
-            stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
-            resplen = 8;
-            break;
         case 0x00044009: /* Test virtual offset */
             resplen = 8;
             break;
         case 0x00048009: /* Set virtual offset */
             fbconfig.xoffset = ldl_le_phys(&s->dma_as, value + 12);
             fbconfig.yoffset = ldl_le_phys(&s->dma_as, value + 16);
+            bcm2835_fb_validate_config(&fbconfig);
             fbconfig_updated = true;
+            /* fall through */
+        case 0x00040009: /* Get virtual offset */
+            stl_le_phys(&s->dma_as, value + 12, fbconfig.xoffset);
+            stl_le_phys(&s->dma_as, value + 16, fbconfig.yoffset);
             resplen = 8;
             break;
         case 0x0004000a: /* Get/Test/Set overscan */
-- 
2.18.0
