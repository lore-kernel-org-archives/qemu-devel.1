Received: from eggs.gnu.org ([2001:4830:134:3::10]:60393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XS-0003Ai-NF
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XQ-0003Ja-Qq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XQ-0003FA-Fx
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XP-0005Cy-B0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:32 +0100
Message-Id: <1506012099-13605-25-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/31] hw/timer/omap_gptimer: Don't use old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Don't use the old_mmio struct in memory region ops.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505580378-9044-5-git-send-email-peter.maydell@linaro.org
---
 hw/timer/omap_gptimer.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index 5e3e8a6..6d7c8a3 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -450,19 +450,44 @@ static void omap_gp_timer_writeh(void *opaque, hwaddr addr,
         s->writeh = (uint16_t) value;
 }
 
+static uint64_t omap_gp_timer_readfn(void *opaque, hwaddr addr,
+                                     unsigned size)
+{
+    switch (size) {
+    case 1:
+        return omap_badwidth_read32(opaque, addr);
+    case 2:
+        return omap_gp_timer_readh(opaque, addr);
+    case 4:
+        return omap_gp_timer_readw(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void omap_gp_timer_writefn(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        omap_badwidth_write32(opaque, addr, value);
+        break;
+    case 2:
+        omap_gp_timer_writeh(opaque, addr, value);
+        break;
+    case 4:
+        omap_gp_timer_write(opaque, addr, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const MemoryRegionOps omap_gp_timer_ops = {
-    .old_mmio = {
-        .read = {
-            omap_badwidth_read32,
-            omap_gp_timer_readh,
-            omap_gp_timer_readw,
-        },
-        .write = {
-            omap_badwidth_write32,
-            omap_gp_timer_writeh,
-            omap_gp_timer_write,
-        },
-    },
+    .read = omap_gp_timer_readfn,
+    .write = omap_gp_timer_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
