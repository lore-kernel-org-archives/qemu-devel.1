Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flHay-0004Tb-B3
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flHaw-0003g9-HF
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flHaw-0003Ke-7n
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 18:40:41 +0100
Message-Id: <20180802174042.29234-2-peter.maydell@linaro.org>
In-Reply-To: <20180802174042.29234-1-peter.maydell@linaro.org>
References: <20180802174042.29234-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/net/pcnet-pci: Convert away from
 old_mmio accessors
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

Convert the pcnet-pci device away from using the old_mmio
MemoryRegionOps accessor functions.

This commit is a no-behaviour-change API conversion.
(Since PCNET_PNPMMIO_SIZE is 0x20, the old "addr & 0x10"
check and the new "addr < 0x10" check are exact opposites;
the new code is phrased to be parallel with the
pcnet_io_read/write functions.)

I have left a TODO comment marker because the similarity
between the MMIO and IO accessor behaviour is suspicious
and they could be combined, but this will be left to a
different patch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/pcnet-pci.c  | 133 ++++++++++++++++++--------------------------
 hw/net/trace-events |   8 +--
 2 files changed, 57 insertions(+), 84 deletions(-)

diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 70dc8b3f0cd..248fb3ba299 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -139,92 +139,67 @@ static const MemoryRegionOps pcnet_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void pcnet_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
+/*
+ * TODO: should MMIO accesses to the addresses corresponding to the
+ * APROM also honour the BCR_DWIO() setting? If so, then these functions
+ * and pcnet_ioport_write/pcnet_ioport_read could be merged.
+ * If not, then should pcnet_ioport_{read,write}{w,l} really check
+ * BCR_DWIO() for MMIO writes ?
+ */
+static void pcnet_mmio_write(void *opaque, hwaddr addr, uint64_t value,
+                             unsigned size)
 {
     PCNetState *d = opaque;
 
-    trace_pcnet_mmio_writeb(opaque, addr, val);
-    if (!(addr & 0x10))
-        pcnet_aprom_writeb(d, addr & 0x0f, val);
-}
+    trace_pcnet_mmio_write(opaque, addr, size, val);
 
-static uint32_t pcnet_mmio_readb(void *opaque, hwaddr addr)
-{
-    PCNetState *d = opaque;
-    uint32_t val = -1;
-
-    if (!(addr & 0x10))
-        val = pcnet_aprom_readb(d, addr & 0x0f);
-    trace_pcnet_mmio_readb(opaque, addr, val);
-    return val;
-}
-
-static void pcnet_mmio_writew(void *opaque, hwaddr addr, uint32_t val)
-{
-    PCNetState *d = opaque;
-
-    trace_pcnet_mmio_writew(opaque, addr, val);
-    if (addr & 0x10)
-        pcnet_ioport_writew(d, addr & 0x0f, val);
-    else {
-        addr &= 0x0f;
-        pcnet_aprom_writeb(d, addr, val & 0xff);
-        pcnet_aprom_writeb(d, addr+1, (val & 0xff00) >> 8);
+    if (addr < 0x10) {
+        if (size == 1) {
+            pcnet_aprom_writeb(d, addr, data);
+        } else if ((addr & 1) == 0 && size == 2) {
+            pcnet_aprom_writeb(d, addr, data & 0xff);
+            pcnet_aprom_writeb(d, addr + 1, data >> 8);
+        } else if ((addr & 3) == 0 && size == 4) {
+            pcnet_aprom_writeb(d, addr, data & 0xff);
+            pcnet_aprom_writeb(d, addr + 1, (data >> 8) & 0xff);
+            pcnet_aprom_writeb(d, addr + 2, (data >> 16) & 0xff);
+            pcnet_aprom_writeb(d, addr + 3, data >> 24);
+        }
+    } else {
+        if (size == 2) {
+            pcnet_ioport_writew(d, addr, data);
+        } else if (size == 4) {
+            pcnet_ioport_writel(d, addr, data);
+        }
     }
 }
 
-static uint32_t pcnet_mmio_readw(void *opaque, hwaddr addr)
-{
-    PCNetState *d = opaque;
-    uint32_t val = -1;
-
-    if (addr & 0x10)
-        val = pcnet_ioport_readw(d, addr & 0x0f);
-    else {
-        addr &= 0x0f;
-        val = pcnet_aprom_readb(d, addr+1);
-        val <<= 8;
-        val |= pcnet_aprom_readb(d, addr);
-    }
-    trace_pcnet_mmio_readw(opaque, addr, val);
-    return val;
-}
-
-static void pcnet_mmio_writel(void *opaque, hwaddr addr, uint32_t val)
+static uint64_t pcnet_mmio_read(void *opque, hwaddr addr, unsigned size)
 {
     PCNetState *d = opaque;
 
-    trace_pcnet_mmio_writel(opaque, addr, val);
-    if (addr & 0x10)
-        pcnet_ioport_writel(d, addr & 0x0f, val);
-    else {
-        addr &= 0x0f;
-        pcnet_aprom_writeb(d, addr, val & 0xff);
-        pcnet_aprom_writeb(d, addr+1, (val & 0xff00) >> 8);
-        pcnet_aprom_writeb(d, addr+2, (val & 0xff0000) >> 16);
-        pcnet_aprom_writeb(d, addr+3, (val & 0xff000000) >> 24);
-    }
-}
+    trace_pcnet_ioport_read(opaque, addr, size);
 
-static uint32_t pcnet_mmio_readl(void *opaque, hwaddr addr)
-{
-    PCNetState *d = opaque;
-    uint32_t val;
-
-    if (addr & 0x10)
-        val = pcnet_ioport_readl(d, addr & 0x0f);
-    else {
-        addr &= 0x0f;
-        val = pcnet_aprom_readb(d, addr+3);
-        val <<= 8;
-        val |= pcnet_aprom_readb(d, addr+2);
-        val <<= 8;
-        val |= pcnet_aprom_readb(d, addr+1);
-        val <<= 8;
-        val |= pcnet_aprom_readb(d, addr);
+    if (addr < 0x10) {
+        if (size == 1) {
+            return pcnet_aprom_readb(d, addr);
+        } else if ((addr & 1) == 0 && size == 2) {
+            return pcnet_aprom_readb(d, addr) |
+                   (pcnet_aprom_readb(d, addr + 1) << 8);
+        } else if ((addr & 3) == 0 && size == 4) {
+            return pcnet_aprom_readb(d, addr) |
+                   (pcnet_aprom_readb(d, addr + 1) << 8) |
+                   (pcnet_aprom_readb(d, addr + 2) << 16) |
+                   (pcnet_aprom_readb(d, addr + 3) << 24);
+        }
+    } else {
+        if (size == 2) {
+            return pcnet_ioport_readw(d, addr);
+        } else if (size == 4) {
+            return pcnet_ioport_readl(d, addr);
+        }
     }
-    trace_pcnet_mmio_readl(opaque, addr, val);
-    return val;
+    return ((uint64_t)1 << (size * 8)) - 1;
 }
 
 static const VMStateDescription vmstate_pci_pcnet = {
@@ -241,10 +216,12 @@ static const VMStateDescription vmstate_pci_pcnet = {
 /* PCI interface */
 
 static const MemoryRegionOps pcnet_mmio_ops = {
-    .old_mmio = {
-        .read = { pcnet_mmio_readb, pcnet_mmio_readw, pcnet_mmio_readl },
-        .write = { pcnet_mmio_writeb, pcnet_mmio_writew, pcnet_mmio_writel },
-    },
+    .read = pcnet_mmio_read,
+    .write = pcnet_mmio_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 663bea1b748..5cd0ad50ce2 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -61,12 +61,8 @@ pcnet_aprom_writeb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x
 pcnet_aprom_readb(void *opaque, uint32_t addr, uint32_t val) "opaque=%p addr=0x%08x val=0x%02x"
 pcnet_ioport_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=0x%"PRIx64" size=%d"
 pcnet_ioport_write(void *opaque, uint64_t addr, uint64_t data, unsigned size) "opaque=%p addr=0x%"PRIx64" data=0x%"PRIx64" size=%d"
-pcnet_mmio_writeb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
-pcnet_mmio_writew(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
-pcnet_mmio_writel(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
-pcnet_mmio_readb(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
-pcnet_mmio_readw(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
-pcnet_mmio_readl(void *opaque, uint64_t addr, uint32_t val) "opaque=%p addr=0x%"PRIx64" val=0x%x"
+pcnet_mmio_write(void *opaque, uint64_t addr, uint32_t val, unsigned size) "opaque=%p addr=0x%"PRIx64" val=0x%x size=%d"
+pcnet_mmio_read(void *opaque, uint64_t addr, unsigned size) "opaque=%p addr=0x%"PRIx64" size=%d"
 
 # hw/net/net_rx_pkt.c
 net_rx_pkt_parsed(bool ip4, bool ip6, bool udp, bool tcp, size_t l3o, size_t l4o, size_t l5o) "RX packet parsed: ip4: %d, ip6: %d, udp: %d, tcp: %d, l3 offset: %zu, l4 offset: %zu, l5 offset: %zu"
-- 
2.17.1
