Received: from eggs.gnu.org ([2001:4830:134:3::10]:52627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEG-0008Fx-Ru
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEF-0007Ac-Vv
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:16 +0100
Message-Id: <1505580378-9044-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] hw/timer/omap_gptimer: Don't use old_mmio
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

Don't use the old_mmio struct in memory region ops.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
