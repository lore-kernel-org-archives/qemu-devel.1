Received: from eggs.gnu.org ([2001:4830:134:3::10]:33017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dju0o-0003E5-D4
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dju0l-0006M9-7u
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:13:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dju0l-0006L8-0x
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:13:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id p8so16923240wrf.2
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:13:25 -0700 (PDT)
From: Matt Parker <mtparkr@gmail.com>
Date: Mon, 21 Aug 2017 22:13:20 +0100
Message-Id: <20170821211320.7026-1-mtparkr@gmail.com>
Subject: [Qemu-devel] [PATCH] audio: intel-hda: do not use old_mmio accesses
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

intel-hda is still using the old_mmio accessors for io.
This updates the device to use .read and .write accessors instead.
---
 hw/audio/intel-hda.c | 56 +++++++++-------------------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 06acc98f7b..c0f002f744 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1043,66 +1043,28 @@ static void intel_hda_regs_reset(IntelHDAState *d)
 
 /* --------------------------------------------------------------------- */
 
-static void intel_hda_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
+static void intel_hda_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     IntelHDAState *d = opaque;
     const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
 
-    intel_hda_reg_write(d, reg, val, 0xff);
+    intel_hda_reg_write(d, reg, val, (1UL << (size * 8)) - 1);
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
+    return intel_hda_reg_read(d, reg, (1UL << (size * 8)) - 1);
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
