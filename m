Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEC-0008Dn-MR
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEB-00078i-Vy
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:18 +0100
Message-Id: <1505580378-9044-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] hw/arm/omap2.c: Don't use old_mmio
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
 hw/arm/omap2.c | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index ece25ae..f35d265 100644
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
