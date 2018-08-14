Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYw-0005vZ-JD
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYv-0004BE-C3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:44:31 +0100
Message-Id: <20180814144436.679-4-peter.maydell@linaro.org>
In-Reply-To: <20180814144436.679-1-peter.maydell@linaro.org>
References: <20180814144436.679-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/8] hw/display/bcm2835_fb: Drop unused size
 and pitch fields
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

The BCM2835FBState struct has a 'pitch' field which is a
cached copy of xres * (bpp >> 3), and a 'size' field which is
a cached copy of pitch * yres. However we don't actually do
anything with these fields; delete them. We retain the
now-unused slots in the VMState struct for migration
compatibility.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/display/bcm2835_fb.h |  4 ----
 hw/display/bcm2835_fb.c         | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index b965698d28a..69cbf2d1fd9 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -47,10 +47,6 @@ typedef struct {
     bool lock, invalidate, pending;
 
     BCM2835FBConfig config;
-
-    /* These are just cached values calculated from the config settings */
-    uint32_t size;
-    uint32_t pitch;
 } BCM2835FBState;
 
 void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig);
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8155de5d0b1..9faabf0d0b4 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -184,6 +184,9 @@ static void fb_update_display(void *opaque)
 
 static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
 {
+    uint32_t pitch;
+    uint32_t size;
+
     value &= ~0xf;
 
     s->lock = true;
@@ -201,12 +204,12 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
 
     /* TODO - Manage properly virtual resolution */
 
-    s->pitch = s->config.xres * (s->config.bpp >> 3);
-    s->size = s->config.yres * s->pitch;
+    pitch = s->config.xres * (s->config.bpp >> 3);
+    size = s->config.yres * pitch;
 
-    stl_le_phys(&s->dma_as, value + 16, s->pitch);
+    stl_le_phys(&s->dma_as, value + 16, pitch);
     stl_le_phys(&s->dma_as, value + 32, s->config.base);
-    stl_le_phys(&s->dma_as, value + 36, s->size);
+    stl_le_phys(&s->dma_as, value + 36, size);
 
     s->invalidate = true;
     qemu_console_resize(s->con, s->config.xres, s->config.yres);
@@ -223,9 +226,6 @@ void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig)
 
     /* TODO - Manage properly virtual resolution */
 
-    s->pitch = s->config.xres * (s->config.bpp >> 3);
-    s->size = s->config.yres * s->pitch;
-
     s->invalidate = true;
     qemu_console_resize(s->con, s->config.xres, s->config.yres);
     s->lock = false;
@@ -301,8 +301,7 @@ static const VMStateDescription vmstate_bcm2835_fb = {
         VMSTATE_UINT32(config.yoffset, BCM2835FBState),
         VMSTATE_UINT32(config.bpp, BCM2835FBState),
         VMSTATE_UINT32(config.base, BCM2835FBState),
-        VMSTATE_UINT32(pitch, BCM2835FBState),
-        VMSTATE_UINT32(size, BCM2835FBState),
+        VMSTATE_UNUSED(8), /* Was pitch and size */
         VMSTATE_UINT32(config.pixo, BCM2835FBState),
         VMSTATE_UINT32(config.alpha, BCM2835FBState),
         VMSTATE_END_OF_LIST()
@@ -335,8 +334,6 @@ static void bcm2835_fb_reset(DeviceState *dev)
     s->config.xoffset = 0;
     s->config.yoffset = 0;
     s->config.base = s->vcram_base + BCM2835_FB_OFFSET;
-    s->pitch = s->config.xres * (s->config.bpp >> 3);
-    s->size = s->config.yres * s->pitch;
 
     s->invalidate = true;
     s->lock = false;
-- 
2.18.0
