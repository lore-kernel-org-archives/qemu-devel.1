Received: from eggs.gnu.org ([2001:4830:134:3::10]:35920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UR-0007qK-Kp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UQ-0004t5-KH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UQ-0004sY-8t
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:46 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UP-0006iK-Ay
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:45 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:42 +0100
Message-Id: <20180824093343.11346-52-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 51/52] hw/display/bcm2835_fb: Validate
 bcm2835_fb_mbox_push() config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Refactor bcm2835_fb_mbox_push() to work by calling
bcm2835_fb_validate_config() and bcm2835_fb_reconfigure(),
so that config set this way is also validated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180814144436.679-9-peter.maydell@linaro.org
---
 hw/display/bcm2835_fb.c | 63 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 3edb8b5cfcb..d534d00a65f 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -248,38 +248,6 @@ void bcm2835_fb_validate_config(BCM2835FBConfig *config)
     }
 }
 
-static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
-{
-    uint32_t pitch;
-    uint32_t size;
-
-    value &= ~0xf;
-
-    s->lock = true;
-
-    s->config.xres = ldl_le_phys(&s->dma_as, value);
-    s->config.yres = ldl_le_phys(&s->dma_as, value + 4);
-    s->config.xres_virtual = ldl_le_phys(&s->dma_as, value + 8);
-    s->config.yres_virtual = ldl_le_phys(&s->dma_as, value + 12);
-    s->config.bpp = ldl_le_phys(&s->dma_as, value + 20);
-    s->config.xoffset = ldl_le_phys(&s->dma_as, value + 24);
-    s->config.yoffset = ldl_le_phys(&s->dma_as, value + 28);
-
-    s->config.base = s->vcram_base | (value & 0xc0000000);
-    s->config.base += BCM2835_FB_OFFSET;
-
-    pitch = bcm2835_fb_get_pitch(&s->config);
-    size = bcm2835_fb_get_size(&s->config);
-
-    stl_le_phys(&s->dma_as, value + 16, pitch);
-    stl_le_phys(&s->dma_as, value + 32, s->config.base);
-    stl_le_phys(&s->dma_as, value + 36, size);
-
-    s->invalidate = true;
-    qemu_console_resize(s->con, s->config.xres, s->config.yres);
-    s->lock = false;
-}
-
 void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig)
 {
     s->lock = true;
@@ -291,6 +259,37 @@ void bcm2835_fb_reconfigure(BCM2835FBState *s, BCM2835FBConfig *newconfig)
     s->lock = false;
 }
 
+static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
+{
+    uint32_t pitch;
+    uint32_t size;
+    BCM2835FBConfig newconf;
+
+    value &= ~0xf;
+
+    newconf.xres = ldl_le_phys(&s->dma_as, value);
+    newconf.yres = ldl_le_phys(&s->dma_as, value + 4);
+    newconf.xres_virtual = ldl_le_phys(&s->dma_as, value + 8);
+    newconf.yres_virtual = ldl_le_phys(&s->dma_as, value + 12);
+    newconf.bpp = ldl_le_phys(&s->dma_as, value + 20);
+    newconf.xoffset = ldl_le_phys(&s->dma_as, value + 24);
+    newconf.yoffset = ldl_le_phys(&s->dma_as, value + 28);
+
+    newconf.base = s->vcram_base | (value & 0xc0000000);
+    newconf.base += BCM2835_FB_OFFSET;
+
+    bcm2835_fb_validate_config(&newconf);
+
+    pitch = bcm2835_fb_get_pitch(&newconf);
+    size = bcm2835_fb_get_size(&newconf);
+
+    stl_le_phys(&s->dma_as, value + 16, pitch);
+    stl_le_phys(&s->dma_as, value + 32, newconf.base);
+    stl_le_phys(&s->dma_as, value + 36, size);
+
+    bcm2835_fb_reconfigure(s, &newconf);
+}
+
 static uint64_t bcm2835_fb_read(void *opaque, hwaddr offset, unsigned size)
 {
     BCM2835FBState *s = opaque;
-- 
2.18.0
