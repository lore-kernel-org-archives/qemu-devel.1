Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flHax-0004TY-Be
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flHav-0003db-I3
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flHav-0003Ke-6q
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 18:40:42 +0100
Message-Id: <20180802174042.29234-3-peter.maydell@linaro.org>
In-Reply-To: <20180802174042.29234-1-peter.maydell@linaro.org>
References: <20180802174042.29234-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] hw/net/pcnet-pci: Unify
 pcnet_ioport_read/write and pcnet_mmio_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Jason Wang <jasowang@redhat.com>

The only difference between our implementation of the pcnet ioport
accessors and the mmio accessors is that the former check BCR_DWIO to
see what access widths are permitted for addresses in the aprom range
(0x0..0xf). In fact our failure to do this in the mmio accessors
is a bug (one which was fixed for the ioport accessors in
commit 7ba79741970 in 2011).

The data sheet for the Am79C970A does not describe the DWIO
bit as only applying for I/O space mapped I/O resources and
not memory mapped I/O resources, and our MMIO accessors already
honour DWIO for accesses in the 0x10..0x1f range (since the
pcnet_ioport_{read,write}{w,l} functions check it).

The data sheet for the later but compatible Am79C976 is clearer:
it states specifically "DWIO mode applies to both I/O- and
memory-mapped acceses." This seems to be reasonable evidence
in favour of interpretating the Am79C970A spec as being the same.

(NB: Linux's pcnet driver only supports I/O accesses, so the
MMIO access part of this device is probably untested anyway.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/pcnet-pci.c  | 67 ++-------------------------------------------
 hw/net/trace-events |  2 --
 2 files changed, 2 insertions(+), 67 deletions(-)

diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 248fb3ba299..7c738557830 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -139,69 +139,6 @@ static const MemoryRegionOps pcnet_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-/*
- * TODO: should MMIO accesses to the addresses corresponding to the
- * APROM also honour the BCR_DWIO() setting? If so, then these functions
- * and pcnet_ioport_write/pcnet_ioport_read could be merged.
- * If not, then should pcnet_ioport_{read,write}{w,l} really check
- * BCR_DWIO() for MMIO writes ?
- */
-static void pcnet_mmio_write(void *opaque, hwaddr addr, uint64_t value,
-                             unsigned size)
-{
-    PCNetState *d = opaque;
-
-    trace_pcnet_mmio_write(opaque, addr, size, val);
-
-    if (addr < 0x10) {
-        if (size == 1) {
-            pcnet_aprom_writeb(d, addr, data);
-        } else if ((addr & 1) == 0 && size == 2) {
-            pcnet_aprom_writeb(d, addr, data & 0xff);
-            pcnet_aprom_writeb(d, addr + 1, data >> 8);
-        } else if ((addr & 3) == 0 && size == 4) {
-            pcnet_aprom_writeb(d, addr, data & 0xff);
-            pcnet_aprom_writeb(d, addr + 1, (data >> 8) & 0xff);
-            pcnet_aprom_writeb(d, addr + 2, (data >> 16) & 0xff);
-            pcnet_aprom_writeb(d, addr + 3, data >> 24);
-        }
-    } else {
-        if (size == 2) {
-            pcnet_ioport_writew(d, addr, data);
-        } else if (size == 4) {
-            pcnet_ioport_writel(d, addr, data);
-        }
-    }
-}
-
-static uint64_t pcnet_mmio_read(void *opque, hwaddr addr, unsigned size)
-{
-    PCNetState *d = opaque;
-
-    trace_pcnet_ioport_read(opaque, addr, size);
-
-    if (addr < 0x10) {
-        if (size == 1) {
-            return pcnet_aprom_readb(d, addr);
-        } else if ((addr & 1) == 0 && size == 2) {
-            return pcnet_aprom_readb(d, addr) |
-                   (pcnet_aprom_readb(d, addr + 1) << 8);
-        } else if ((addr & 3) == 0 && size == 4) {
-            return pcnet_aprom_readb(d, addr) |
-                   (pcnet_aprom_readb(d, addr + 1) << 8) |
-                   (pcnet_aprom_readb(d, addr + 2) << 16) |
-                   (pcnet_aprom_readb(d, addr + 3) << 24);
-        }
-    } else {
-        if (size == 2) {
-            return pcnet_ioport_readw(d, addr);
-        } else if (size == 4) {
-            return pcnet_ioport_readl(d, addr);
-        }
-    }
-    return ((uint64_t)1 << (size * 8)) - 1;
-}
-
 static const VMStateDescription vmstate_pci_pcnet = {
     .name = "pcnet",
     .version_id = 3,
@@ -216,8 +153,8 @@ static const VMStateDescription vmstate_pci_pcnet = {
 /* PCI interface */
 
 static const MemoryRegionOps pcnet_mmio_ops = {
-    .read = pcnet_mmio_read,
-    .write = pcnet_mmio_write,
+    .read = pcnet_ioport_read,
+    .write = pcnet_ioport_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 5cd0ad50ce2..c1dea4b1562 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -61,8 +61,6 @@ pcnet_aprom_writeb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x
 pcnet_aprom_readb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x%08x val=0x%02x"
 pcnet_ioport_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=0x%"PRIx64" size=%d"
 pcnet_ioport_write(void *opaque, uint64_t addr, uint64_t data, unsigned size) "opaque=%p addr=0x%"PRIx64" data=0x%"PRIx64" size=%d"
-pcnet_mmio_write(void *opaque, uint64_t addr, uint32_t val, unsigned size) "opaque=%p addr=0x%"PRIx64" val=0x%x size=%d"
-pcnet_mmio_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=0x%"PRIx64" size=%d"
 
 # hw/net/net_rx_pkt.c
 net_rx_pkt_parsed(bool ip4, bool ip6, bool udp, bool tcp, size_t l3o, size_t l4o, size_t l5o) "RX packet parsed: ip4: %d, ip6: %d, udp: %d, tcp: %d, l3 offset: %zu, l4 offset: %zu, l5 offset: %zu"
-- 
2.17.1
