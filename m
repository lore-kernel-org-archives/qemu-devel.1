Received: from eggs.gnu.org ([2001:4830:134:3::10]:35858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UN-0007gu-9v
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UM-0004qB-7p
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UL-0004eK-UX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UK-0006g9-Tg
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:39 +0100
Message-Id: <20180824093343.11346-49-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 48/52] hw/display/bcm2835_fb: Abstract out
 calculation of pitch, size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Abstract out the calculation of the pitch and size of the
framebuffer into functions that operate on the BCM2835FBConfig
struct -- these are about to get a little more complicated
when we add support for virtual and physical sizes differing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180814144436.679-6-peter.maydell@linaro.org
---
 include/hw/display/bcm2835_fb.h | 22 ++++++++++++++++++++++
 hw/display/bcm2835_fb.c         |  6 +++---
 hw/misc/bcm2835_property.c      |  4 ++--
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 374de546121..95bcec7fe33 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -52,4 +52,26 @@ typedef struct {
 
 void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig);
 
+/**
+ * bcm2835_fb_get_pitch: return number of bytes per line of the framebuffer
+ * @config: configuration info for the framebuffer
+ *
+ * Return the number of bytes per line of the framebuffer, ie the number
+ * that must be added to a pixel address to get the address of the pixel
+ * directly below it on screen.
+ */
+static inline uint32_t bcm2835_fb_get_pitch(BCM2835FBConfig *config)
+{
+    return config->xres * (config->bpp >> 3);
+}
+
+/**
+ * bcm2835_fb_get_size: return total size of framebuffer in bytes
+ * @config: configuration info for the framebuffer
+ */
+static inline uint32_t bcm2835_fb_get_size(BCM2835FBConfig *config)
+{
+    return config->yres * bcm2835_fb_get_pitch(config);
+}
+
 #endif
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index d95686c74c8..a6c0a0cc942 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -139,7 +139,7 @@ static void fb_update_display(void *opaque)
         return;
     }
 
-    src_width = s->config.xres * (s->config.bpp >> 3);
+    src_width = bcm2835_fb_get_pitch(&s->config);
     dest_width = s->config.xres;
 
     switch (surface_bits_per_pixel(surface)) {
@@ -204,8 +204,8 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
 
     /* TODO - Manage properly virtual resolution */
 
-    pitch = s->config.xres * (s->config.bpp >> 3);
-    size = s->config.yres * pitch;
+    pitch = bcm2835_fb_get_pitch(&s->config);
+    size = bcm2835_fb_get_size(&s->config);
 
     stl_le_phys(&s->dma_as, value + 16, pitch);
     stl_le_phys(&s->dma_as, value + 32, s->config.base);
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index df0645d1b84..c8c4979bd26 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -146,7 +146,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00040001: /* Allocate buffer */
             stl_le_phys(&s->dma_as, value + 12, fbconfig.base);
             stl_le_phys(&s->dma_as, value + 16,
-                        fbconfig.xres * fbconfig.yres * fbconfig.bpp / 8);
+                        bcm2835_fb_get_size(&fbconfig));
             resplen = 8;
             break;
         case 0x00048001: /* Release buffer */
@@ -210,7 +210,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00040008: /* Get pitch */
             stl_le_phys(&s->dma_as, value + 12,
-                        fbconfig.xres * fbconfig.bpp / 8);
+                        bcm2835_fb_get_pitch(&fbconfig));
             resplen = 4;
             break;
         case 0x00040009: /* Get virtual offset */
-- 
2.18.0
