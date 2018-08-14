Received: from eggs.gnu.org ([2001:4830:134:3::10]:48668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYx-0005x1-Qo
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpaYw-0004CN-Sd
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:44:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 15:44:32 +0100
Message-Id: <20180814144436.679-5-peter.maydell@linaro.org>
In-Reply-To: <20180814144436.679-1-peter.maydell@linaro.org>
References: <20180814144436.679-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/8] hw/display/bcm2835_fb: Reset resolution,
 etc correctly
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

The bcm2835_fb's initial resolution and other parameters are set
via QOM properties. We should reset to those initial values on
device reset, which means we need to save the QOM property
values somewhere that they are not overwritten by guest
changes to the framebuffer configuration.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/display/bcm2835_fb.h |  1 +
 hw/display/bcm2835_fb.c         | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 69cbf2d1fd9..374de546121 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -47,6 +47,7 @@ typedef struct {
     bool lock, invalidate, pending;
 
     BCM2835FBConfig config;
+    BCM2835FBConfig initial_config;
 } BCM2835FBState;
 
 void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig);
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 9faabf0d0b4..d95686c74c8 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -329,11 +329,7 @@ static void bcm2835_fb_reset(DeviceState *dev)
 
     s->pending = false;
 
-    s->config.xres_virtual = s->config.xres;
-    s->config.yres_virtual = s->config.yres;
-    s->config.xoffset = 0;
-    s->config.yoffset = 0;
-    s->config.base = s->vcram_base + BCM2835_FB_OFFSET;
+    s->config = s->initial_config;
 
     s->invalidate = true;
     s->lock = false;
@@ -357,6 +353,13 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Fill in the parts of initial_config that are not set by QOM properties */
+    s->initial_config.xres_virtual = s->initial_config.xres;
+    s->initial_config.yres_virtual = s->initial_config.yres;
+    s->initial_config.xoffset = 0;
+    s->initial_config.yoffset = 0;
+    s->initial_config.base = s->vcram_base + BCM2835_FB_OFFSET;
+
     s->dma_mr = MEMORY_REGION(obj);
     address_space_init(&s->dma_as, s->dma_mr, NULL);
 
@@ -370,13 +373,13 @@ static Property bcm2835_fb_props[] = {
     DEFINE_PROP_UINT32("vcram-base", BCM2835FBState, vcram_base, 0),/*required*/
     DEFINE_PROP_UINT32("vcram-size", BCM2835FBState, vcram_size,
                        DEFAULT_VCRAM_SIZE),
-    DEFINE_PROP_UINT32("xres", BCM2835FBState, config.xres, 640),
-    DEFINE_PROP_UINT32("yres", BCM2835FBState, config.yres, 480),
-    DEFINE_PROP_UINT32("bpp", BCM2835FBState, config.bpp, 16),
-    DEFINE_PROP_UINT32("pixo",
-                       BCM2835FBState, config.pixo, 1), /* 1=RGB, 0=BGR */
-    DEFINE_PROP_UINT32("alpha",
-                       BCM2835FBState, config.alpha, 2), /* alpha ignored */
+    DEFINE_PROP_UINT32("xres", BCM2835FBState, initial_config.xres, 640),
+    DEFINE_PROP_UINT32("yres", BCM2835FBState, initial_config.yres, 480),
+    DEFINE_PROP_UINT32("bpp", BCM2835FBState, initial_config.bpp, 16),
+    DEFINE_PROP_UINT32("pixo", BCM2835FBState,
+                       initial_config.pixo, 1), /* 1=RGB, 0=BGR */
+    DEFINE_PROP_UINT32("alpha", BCM2835FBState,
+                       initial_config.alpha, 2), /* alpha ignored */
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.18.0
