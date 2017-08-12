Received: from eggs.gnu.org ([2001:4830:134:3::10]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dge3c-00008t-IS
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 17:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dge3Z-00034P-Ej
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 17:34:56 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dge3Z-000347-8T
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 17:34:53 -0400
Received: by mail-wr0-x243.google.com with SMTP id g32so4705672wrd.5
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 14:34:53 -0700 (PDT)
From: Matt Parker <mtparkr@gmail.com>
Date: Sat, 12 Aug 2017 22:34:48 +0100
Message-Id: <20170812213448.20624-1-mtparkr@gmail.com>
Subject: [Qemu-devel] [PATCH] net: rtl8139: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

This updates the current MemoryRegionOps for the bar 1 memory region
from using the old_mmio accessors to the .read and .write accessors.

Signed-off-by: Matt Parker <mtparkr@gmail.com>
---
 hw/net/rtl8139.c | 60 +++++++++++++++-----------------------------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 671c7e48c6..b3aefda291 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3131,39 +3131,6 @@ static uint32_t rtl8139_io_readl(void *opaque, uint8_t addr)
 }
 
 /* */
-
-static void rtl8139_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
-{
-    rtl8139_io_writeb(opaque, addr & 0xFF, val);
-}
-
-static void rtl8139_mmio_writew(void *opaque, hwaddr addr, uint32_t val)
-{
-    rtl8139_io_writew(opaque, addr & 0xFF, val);
-}
-
-static void rtl8139_mmio_writel(void *opaque, hwaddr addr, uint32_t val)
-{
-    rtl8139_io_writel(opaque, addr & 0xFF, val);
-}
-
-static uint32_t rtl8139_mmio_readb(void *opaque, hwaddr addr)
-{
-    return rtl8139_io_readb(opaque, addr & 0xFF);
-}
-
-static uint32_t rtl8139_mmio_readw(void *opaque, hwaddr addr)
-{
-    uint32_t val = rtl8139_io_readw(opaque, addr & 0xFF);
-    return val;
-}
-
-static uint32_t rtl8139_mmio_readl(void *opaque, hwaddr addr)
-{
-    uint32_t val = rtl8139_io_readl(opaque, addr & 0xFF);
-    return val;
-}
-
 static int rtl8139_post_load(void *opaque, int version_id)
 {
     RTL8139State* s = opaque;
@@ -3344,18 +3311,23 @@ static const MemoryRegionOps rtl8139_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static uint64_t rtl8139_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+   return rtl8139_ioport_read(opaque, addr & 0xFF, size);
+}
+
+static void rtl8139_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    return rtl8139_ioport_write(opaque, addr & 0xFF, val, size);
+}
+
 static const MemoryRegionOps rtl8139_mmio_ops = {
-    .old_mmio = {
-        .read = {
-            rtl8139_mmio_readb,
-            rtl8139_mmio_readw,
-            rtl8139_mmio_readl,
-        },
-        .write = {
-            rtl8139_mmio_writeb,
-            rtl8139_mmio_writew,
-            rtl8139_mmio_writel,
-        },
+    .read = rtl8139_mmio_read,
+    .write = rtl8139_mmio_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
     },
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
-- 
2.13.2
