Received: from eggs.gnu.org ([2001:4830:134:3::10]:36151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dhi6w-0007tN-3C
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dhi6s-0006SR-Vq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:06:46 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dhi6s-0006QS-OX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:06:42 -0400
Received: by mail-wm0-x242.google.com with SMTP id x64so2558546wmg.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 13:06:41 -0700 (PDT)
From: Matt Parker <mtparkr@gmail.com>
Date: Tue, 15 Aug 2017 21:06:07 +0100
Message-Id: <20170815200607.16232-1-mtparkr@gmail.com>
Subject: [Qemu-devel] [PATCH v2] net: rtl8139: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, pbonzini@redhat.com

Both io and memory use the same mmio functions in the rtl8139 device.
This patch removes the separate MemoryRegionOps and old_mmio accessors
for memory, and replaces it with an alias to the io memory region.

Signed-off-by: Matt Parker <mtparkr@gmail.com>
---
 hw/net/rtl8139.c | 53 +++--------------------------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 671c7e48c6..3be24bbee7 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3132,38 +3132,6 @@ static uint32_t rtl8139_io_readl(void *opaque, uint8_t addr)
 
 /* */
 
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
@@ -3344,22 +3312,6 @@ static const MemoryRegionOps rtl8139_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const MemoryRegionOps rtl8139_mmio_ops = {
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
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void rtl8139_timer(void *opaque)
 {
     RTL8139State *s = opaque;
@@ -3422,8 +3374,9 @@ static void pci_rtl8139_realize(PCIDevice *dev, Error **errp)
 
     memory_region_init_io(&s->bar_io, OBJECT(s), &rtl8139_io_ops, s,
                           "rtl8139", 0x100);
-    memory_region_init_io(&s->bar_mem, OBJECT(s), &rtl8139_mmio_ops, s,
-                          "rtl8139", 0x100);
+    memory_region_init_alias(&s->bar_mem, OBJECT(s), "rtl8139-mem", &s->bar_io,
+                             0, 0x100);
+
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->bar_io);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar_mem);
 
-- 
2.13.2
