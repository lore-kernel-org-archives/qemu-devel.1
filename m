Received: from eggs.gnu.org ([2001:4830:134:3::10]:52623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEG-0008Fr-QE
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEF-0007AM-TB
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:15 +0100
Message-Id: <1505580378-9044-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] hw/timer/omap_synctimer.c: Don't use
 old_mmio
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

Don't use the old_mmio in the memory region ops struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/omap_synctimer.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c
index 9ee6519..0d75a90 100644
--- a/hw/timer/omap_synctimer.c
+++ b/hw/timer/omap_synctimer.c
@@ -68,25 +68,32 @@ static uint32_t omap_synctimer_readh(void *opaque, hwaddr addr)
     }
 }
 
-static void omap_synctimer_write(void *opaque, hwaddr addr,
-                uint32_t value)
+static uint64_t omap_synctimer_readfn(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    switch (size) {
+    case 1:
+        return omap_badwidth_read32(opaque, addr);
+    case 2:
+        return omap_synctimer_readh(opaque, addr);
+    case 4:
+        return omap_synctimer_readw(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void omap_synctimer_writefn(void *opaque, hwaddr addr,
+                                   uint64_t value, unsigned size)
 {
     OMAP_BAD_REG(addr);
 }
 
 static const MemoryRegionOps omap_synctimer_ops = {
-    .old_mmio = {
-        .read = {
-            omap_badwidth_read32,
-            omap_synctimer_readh,
-            omap_synctimer_readw,
-        },
-        .write = {
-            omap_badwidth_write32,
-            omap_synctimer_write,
-            omap_synctimer_write,
-        },
-    },
+    .read = omap_synctimer_readfn,
+    .write = omap_synctimer_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
