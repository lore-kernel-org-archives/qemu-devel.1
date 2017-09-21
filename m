Received: from eggs.gnu.org ([2001:4830:134:3::10]:60434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XT-0003Al-NZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XR-0003MS-Nn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XR-0003FA-Db
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XQ-0005DP-2F
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:33 +0100
Message-Id: <1506012099-13605-26-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/31] hw/i2c/omap_i2c.c: Don't use old_mmio
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
Message-id: 1505580378-9044-6-git-send-email-peter.maydell@linaro.org
---
 hw/i2c/omap_i2c.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index f6e80be..12264ee 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -430,19 +430,39 @@ static void omap_i2c_writeb(void *opaque, hwaddr addr,
     }
 }
 
+static uint64_t omap_i2c_readfn(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    switch (size) {
+    case 2:
+        return omap_i2c_read(opaque, addr);
+    default:
+        return omap_badwidth_read16(opaque, addr);
+    }
+}
+
+static void omap_i2c_writefn(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        /* Only the last fifo write can be 8 bit. */
+        omap_i2c_writeb(opaque, addr, value);
+        break;
+    case 2:
+        omap_i2c_write(opaque, addr, value);
+        break;
+    default:
+        omap_badwidth_write16(opaque, addr, value);
+        break;
+    }
+}
+
 static const MemoryRegionOps omap_i2c_ops = {
-    .old_mmio = {
-        .read = {
-            omap_badwidth_read16,
-            omap_i2c_read,
-            omap_badwidth_read16,
-        },
-        .write = {
-            omap_i2c_writeb, /* Only the last fifo write can be 8 bit.  */
-            omap_i2c_write,
-            omap_badwidth_write16,
-        },
-    },
+    .read = omap_i2c_readfn,
+    .write = omap_i2c_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
