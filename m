Received: from eggs.gnu.org ([2001:4830:134:3::10]:60812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gD-0003Ci-GK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8g8-00029m-L4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8g8-00027l-Cj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:56 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:12 +0800
Message-Id: <1504836324-4871-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 06/18] net: rtl8139: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Matt Parker <mtparkr@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Matt Parker <mtparkr@gmail.com>

Both io and memory use the same mmio functions in the rtl8139 device.
This patch removes the separate MemoryRegionOps and old_mmio accessors
for memory, and replaces it with an alias to the io memory region.

Signed-off-by: Matt Parker <mtparkr@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rtl8139.c | 53 +++--------------------------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 671c7e4..3be24bb 100644
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
2.7.4
