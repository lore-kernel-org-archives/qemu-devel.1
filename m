Received: from eggs.gnu.org ([2001:4830:134:3::10]:55867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIa-0007DP-5X
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIY-0001hV-Aj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:24 -0500
Message-Id: <20170901180340.30009-14-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 13/29] libqos: Use explicit QTestState for
 pci operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:sPAPR" <qemu-ppc@nongnu.org>

Now that the QPCIBus tracks QTestState, use that state instead
of an implicit reliance on global_qtest.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/pci-pc.c    | 47 ++++++++++++++++++++++++-----------------------
 tests/libqos/pci-spapr.c | 20 ++++++++++----------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 85b34c6d13..9545f881ee 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -29,90 +29,91 @@ typedef struct QPCIBusPC

 static uint8_t qpci_pc_pio_readb(QPCIBus *bus, uint32_t addr)
 {
-    return inb(addr);
+    return qtest_inb(bus->qts, addr);
 }

 static void qpci_pc_pio_writeb(QPCIBus *bus, uint32_t addr, uint8_t val)
 {
-    outb(addr, val);
+    qtest_outb(bus->qts, addr, val);
 }

 static uint16_t qpci_pc_pio_readw(QPCIBus *bus, uint32_t addr)
 {
-    return inw(addr);
+    return qtest_inw(bus->qts, addr);
 }

 static void qpci_pc_pio_writew(QPCIBus *bus, uint32_t addr, uint16_t val)
 {
-    outw(addr, val);
+    qtest_outw(bus->qts, addr, val);
 }

 static uint32_t qpci_pc_pio_readl(QPCIBus *bus, uint32_t addr)
 {
-    return inl(addr);
+    return qtest_inl(bus->qts, addr);
 }

 static void qpci_pc_pio_writel(QPCIBus *bus, uint32_t addr, uint32_t val)
 {
-    outl(addr, val);
+    qtest_outl(bus->qts, addr, val);
 }

 static uint64_t qpci_pc_pio_readq(QPCIBus *bus, uint32_t addr)
 {
-    return (uint64_t)inl(addr) + ((uint64_t)inl(addr + 4) << 32);
+    return (uint64_t)qtest_inl(bus->qts, addr) +
+        ((uint64_t)qtest_inl(bus->qts, addr + 4) << 32);
 }

 static void qpci_pc_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)
 {
-    outl(addr, val & 0xffffffff);
-    outl(addr + 4, val >> 32);
+    qtest_outl(bus->qts, addr, val & 0xffffffff);
+    qtest_outl(bus->qts, addr + 4, val >> 32);
 }

 static void qpci_pc_memread(QPCIBus *bus, uint32_t addr, void *buf, size_t len)
 {
-    memread(addr, buf, len);
+    qtest_memread(bus->qts, addr, buf, len);
 }

 static void qpci_pc_memwrite(QPCIBus *bus, uint32_t addr,
                              const void *buf, size_t len)
 {
-    memwrite(addr, buf, len);
+    qtest_memwrite(bus->qts, addr, buf, len);
 }

 static uint8_t qpci_pc_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return inb(0xcfc);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return qtest_inb(bus->qts, 0xcfc);
 }

 static uint16_t qpci_pc_config_readw(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return inw(0xcfc);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return qtest_inw(bus->qts, 0xcfc);
 }

 static uint32_t qpci_pc_config_readl(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return inl(0xcfc);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return qtest_inl(bus->qts, 0xcfc);
 }

 static void qpci_pc_config_writeb(QPCIBus *bus, int devfn, uint8_t offset, uint8_t value)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    outb(0xcfc, value);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    qtest_outb(bus->qts, 0xcfc, value);
 }

 static void qpci_pc_config_writew(QPCIBus *bus, int devfn, uint8_t offset, uint16_t value)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    outw(0xcfc, value);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    qtest_outw(bus->qts, 0xcfc, value);
 }

 static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint32_t value)
 {
-    outl(0xcf8, (1U << 31) | (devfn << 8) | offset);
-    outl(0xcfc, value);
+    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    qtest_outl(bus->qts, 0xcfc, value);
 }

 QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index cd9b8f52d2..d7b2aa75e6 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -45,63 +45,63 @@ typedef struct QPCIBusSPAPR {
 static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return readb(s->pio_cpu_base + addr);
+    return qtest_readb(bus->qts, s->pio_cpu_base + addr);
 }

 static void qpci_spapr_pio_writeb(QPCIBus *bus, uint32_t addr, uint8_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writeb(s->pio_cpu_base + addr, val);
+    qtest_writeb(bus->qts, s->pio_cpu_base + addr, val);
 }

 static uint16_t qpci_spapr_pio_readw(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap16(readw(s->pio_cpu_base + addr));
+    return bswap16(qtest_readw(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writew(QPCIBus *bus, uint32_t addr, uint16_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writew(s->pio_cpu_base + addr, bswap16(val));
+    qtest_writew(bus->qts, s->pio_cpu_base + addr, bswap16(val));
 }

 static uint32_t qpci_spapr_pio_readl(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap32(readl(s->pio_cpu_base + addr));
+    return bswap32(qtest_readl(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writel(QPCIBus *bus, uint32_t addr, uint32_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writel(s->pio_cpu_base + addr, bswap32(val));
+    qtest_writel(bus->qts, s->pio_cpu_base + addr, bswap32(val));
 }

 static uint64_t qpci_spapr_pio_readq(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap64(readq(s->pio_cpu_base + addr));
+    return bswap64(qtest_readq(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    writeq(s->pio_cpu_base + addr, bswap64(val));
+    qtest_writeq(bus->qts, s->pio_cpu_base + addr, bswap64(val));
 }

 static void qpci_spapr_memread(QPCIBus *bus, uint32_t addr,
                                void *buf, size_t len)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    memread(s->mmio32_cpu_base + addr, buf, len);
+    qtest_memread(bus->qts, s->mmio32_cpu_base + addr, buf, len);
 }

 static void qpci_spapr_memwrite(QPCIBus *bus, uint32_t addr,
                                 const void *buf, size_t len)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    memwrite(s->mmio32_cpu_base + addr, buf, len);
+    qtest_memwrite(bus->qts, s->mmio32_cpu_base + addr, buf, len);
 }

 static uint8_t qpci_spapr_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
-- 
2.13.5
