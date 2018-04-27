Received: from eggs.gnu.org ([2001:4830:134:3::10]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fC7IA-0004VZ-Ed
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fC7I9-0007uK-IC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 13:36:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 18:36:11 +0100
Message-Id: <20180427173611.10281-3-peter.maydell@linaro.org>
In-Reply-To: <20180427173611.10281-1-peter.maydell@linaro.org>
References: <20180427173611.10281-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] hw/net/smc91c111: Convert away from
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

Convert the smc91c111 device away from using the old_mmio field of
MemoryRegionOps. This device is used by several Arm board models.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/smc91c111.c | 54 +++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3b16dcf5a1..c8cc5379b7 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -625,37 +625,33 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
     return 0;
 }
 
-static void smc91c111_writew(void *opaque, hwaddr offset,
-                             uint32_t value)
+static uint64_t smc91c111_readfn(void *opaque, hwaddr addr, unsigned size)
 {
-    smc91c111_writeb(opaque, offset, value & 0xff);
-    smc91c111_writeb(opaque, offset + 1, value >> 8);
+    int i;
+    uint32_t val = 0;
+
+    for (i = 0; i < size; i++) {
+        val |= smc91c111_readb(opaque, addr + i) << (i * 8);
+    }
+    return val;
 }
 
-static void smc91c111_writel(void *opaque, hwaddr offset,
-                             uint32_t value)
+static void smc91c111_writefn(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned size)
 {
+    int i = 0;
+
     /* 32-bit writes to offset 0xc only actually write to the bank select
-       register (offset 0xe)  */
-    if (offset != 0xc)
-        smc91c111_writew(opaque, offset, value & 0xffff);
-    smc91c111_writew(opaque, offset + 2, value >> 16);
-}
+     * register (offset 0xe), so skip the first two bytes we would write.
+     */
+    if (addr == 0xc && size == 4) {
+        i += 2;
+    }
 
-static uint32_t smc91c111_readw(void *opaque, hwaddr offset)
-{
-    uint32_t val;
-    val = smc91c111_readb(opaque, offset);
-    val |= smc91c111_readb(opaque, offset + 1) << 8;
-    return val;
-}
-
-static uint32_t smc91c111_readl(void *opaque, hwaddr offset)
-{
-    uint32_t val;
-    val = smc91c111_readw(opaque, offset);
-    val |= smc91c111_readw(opaque, offset + 2) << 16;
-    return val;
+    for (; i < size; i++) {
+        smc91c111_writeb(opaque, addr + i,
+                         extract32(value, i * 8, 8));
+    }
 }
 
 static int smc91c111_can_receive_nc(NetClientState *nc)
@@ -747,10 +743,10 @@ static const MemoryRegionOps smc91c111_mem_ops = {
     /* The special case for 32 bit writes to 0xc means we can't just
      * set .impl.min/max_access_size to 1, unfortunately
      */
-    .old_mmio = {
-        .read = { smc91c111_readb, smc91c111_readw, smc91c111_readl, },
-        .write = { smc91c111_writeb, smc91c111_writew, smc91c111_writel, },
-    },
+    .read = smc91c111_readfn,
+    .write = smc91c111_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.0
