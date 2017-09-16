Received: from eggs.gnu.org ([2001:4830:134:3::10]:52621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEG-0008Fh-PE
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEF-0007AR-VK
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:17 +0100
Message-Id: <1505580378-9044-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/6] hw/i2c/omap_i2c.c: Don't use old_mmio
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

Don't use old_mmio in the memory region ops struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
