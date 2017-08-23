Received: from eggs.gnu.org ([2001:4830:134:3::10]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dkbT9-0006c2-My
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dkbT4-0008Sz-HK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:37:39 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dkbT4-0008Qx-AC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:37:34 -0400
Received: by mail-wm0-x244.google.com with SMTP id x79so551329wma.2
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:37:32 -0700 (PDT)
From: Matt Parker <mtparkr@gmail.com>
Date: Wed, 23 Aug 2017 20:37:03 +0100
Message-Id: <20170823193703.10808-1-mtparkr@gmail.com>
Subject: [Qemu-devel] [PATCH v2] audio: intel-hda: do not use old_mmio
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
 hw/audio/intel-hda.c | 57 +++++++++-------------------------------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 06acc98f7b..95e3e460fb 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1043,66 +1043,29 @@ static void intel_hda_regs_reset(IntelHDAState *d)
 
 /* --------------------------------------------------------------------- */
 
-static void intel_hda_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
+static void intel_hda_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
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
