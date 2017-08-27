Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dm37E-0002I0-Jz
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 15:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dm37B-0001zk-En
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 15:21:00 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dm37B-0001zN-8I
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 15:20:57 -0400
Received: by mail-wm0-x243.google.com with SMTP id r187so4995105wma.2
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 12:20:55 -0700 (PDT)
From: Matt Parker <mtparkr@gmail.com>
Date: Sun, 27 Aug 2017 20:20:38 +0100
Message-Id: <20170827192038.28930-1-mtparkr@gmail.com>
Subject: [Qemu-devel] [PATCH v3] audio: intel-hda: do not use old_mmio
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

intel-hda is currently using the old_mmio accessors for io.
This updates the device to use .read and .write accessors instead.

Signed-off-by: Matt Parker <mtparkr@gmail.com>
---
v3:
 * use MAKE_64BIT_MASK
---
 hw/audio/intel-hda.c | 58 ++++++++++------------------------------------------
 1 file changed, 11 insertions(+), 47 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 06acc98f7b..18a50a8f83 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -22,6 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
+#include "qemu/bitops.h"
 #include "hw/audio/soundhw.h"
 #include "intel-hda.h"
 #include "intel-hda-defs.h"
@@ -1043,66 +1044,29 @@ static void intel_hda_regs_reset(IntelHDAState *d)
 
 /* --------------------------------------------------------------------- */
 
-static void intel_hda_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
+static void intel_hda_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
 {
     IntelHDAState *d = opaque;
     const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
 
-    intel_hda_reg_write(d, reg, val, 0xff);
+    intel_hda_reg_write(d, reg, val, MAKE_64BIT_MASK(0, size * 8));
 }
 
-static void intel_hda_mmio_writew(void *opaque, hwaddr addr, uint32_t val)
+static uint64_t intel_hda_mmio_read(void *opaque, hwaddr addr, unsigned size)
 {
     IntelHDAState *d = opaque;
     const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
 
-    intel_hda_reg_write(d, reg, val, 0xffff);
-}
-
-static void intel_hda_mmio_writel(void *opaque, hwaddr addr, uint32_t val)
-{
-    IntelHDAState *d = opaque;
-    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
-
-    intel_hda_reg_write(d, reg, val, 0xffffffff);
-}
-
-static uint32_t intel_hda_mmio_readb(void *opaque, hwaddr addr)
-{
-    IntelHDAState *d = opaque;
-    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
-
-    return intel_hda_reg_read(d, reg, 0xff);
-}
-
-static uint32_t intel_hda_mmio_readw(void *opaque, hwaddr addr)
-{
-    IntelHDAState *d = opaque;
-    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
-
-    return intel_hda_reg_read(d, reg, 0xffff);
-}
-
-static uint32_t intel_hda_mmio_readl(void *opaque, hwaddr addr)
-{
-    IntelHDAState *d = opaque;
-    const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
-
-    return intel_hda_reg_read(d, reg, 0xffffffff);
+    return intel_hda_reg_read(d, reg, MAKE_64BIT_MASK(0, size * 8));
 }
 
 static const MemoryRegionOps intel_hda_mmio_ops = {
-    .old_mmio = {
-        .read = {
-            intel_hda_mmio_readb,
-            intel_hda_mmio_readw,
-            intel_hda_mmio_readl,
-        },
-        .write = {
-            intel_hda_mmio_writeb,
-            intel_hda_mmio_writew,
-            intel_hda_mmio_writel,
-        },
+    .read = intel_hda_mmio_read,
+    .write = intel_hda_mmio_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
     },
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
-- 
2.13.2
