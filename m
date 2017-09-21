Received: from eggs.gnu.org ([2001:4830:134:3::10]:60451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XU-0003Ao-2T
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XS-0003NX-2c
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XR-0003Kb-OL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XQ-0005E1-N9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:34 +0100
Message-Id: <1506012099-13605-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/31] hw/arm/omap2.c: Don't use old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Don't use old_mmio in the memory region ops struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505580378-9044-7-git-send-email-peter.maydell@linaro.org
---
 hw/arm/omap2.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 3f6076e..f5b1488 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2087,19 +2087,44 @@ static void omap_sysctl_write(void *opaque, hwaddr addr,
     }
 }
 
+static uint64_t omap_sysctl_readfn(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    switch (size) {
+    case 1:
+        return omap_sysctl_read8(opaque, addr);
+    case 2:
+        return omap_badwidth_read32(opaque, addr); /* TODO */
+    case 4:
+        return omap_sysctl_read(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void omap_sysctl_writefn(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        omap_sysctl_write8(opaque, addr, value);
+        break;
+    case 2:
+        omap_badwidth_write32(opaque, addr, value); /* TODO */
+        break;
+    case 4:
+        omap_sysctl_write(opaque, addr, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const MemoryRegionOps omap_sysctl_ops = {
-    .old_mmio = {
-        .read = {
-            omap_sysctl_read8,
-            omap_badwidth_read32,	/* TODO */
-            omap_sysctl_read,
-        },
-        .write = {
-            omap_sysctl_write8,
-            omap_badwidth_write32,	/* TODO */
-            omap_sysctl_write,
-        },
-    },
+    .read = omap_sysctl_readfn,
+    .write = omap_sysctl_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
