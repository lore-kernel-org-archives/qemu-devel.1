Received: from eggs.gnu.org ([2001:4830:134:3::10]:35860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UN-0007gv-CJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UM-0004pm-1l
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UL-0004PP-Jm
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UJ-0006fj-Ui
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:38 +0100
Message-Id: <20180824093343.11346-48-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 47/52] hw/display/bcm2835_fb: Reset resolution,
 etc correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The bcm2835_fb's initial resolution and other parameters are set
via QOM properties. We should reset to those initial values on
device reset, which means we need to save the QOM property
values somewhere that they are not overwritten by guest
changes to the framebuffer configuration.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180814144436.679-5-peter.maydell@linaro.org
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
