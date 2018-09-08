Received: from eggs.gnu.org ([2001:4830:134:3::10]:35314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyZEV-0002nB-Jr
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fyZES-0003Ol-I3
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:08:47 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  8 Sep 2018 10:08:18 +0100
Message-Id: <20180908090820.15591-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 1/3] raven: some minor IRQ-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This really lays the groundwork for the upcoming patches: it renames the
irqs PREPPCIState struct member to pci_irqs (as soon there will be a
distinction) and then changes the raven IRQ opaque to use PREPPCIState
instead of just irqs array.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/prep.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 88f035c20b..9b36f19c97 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -55,7 +55,7 @@ typedef struct RavenPCIState {
 typedef struct PRePPCIState {
     PCIHostState parent_obj;
 
-    qemu_irq irq[PCI_NUM_PINS];
+    qemu_irq pci_irqs[PCI_NUM_PINS];
     PCIBus pci_bus;
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
@@ -194,9 +194,9 @@ static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
 
 static void raven_set_irq(void *opaque, int irq_num, int level)
 {
-    qemu_irq *pic = opaque;
+    PREPPCIState *s = opaque;
 
-    qemu_set_irq(pic[irq_num] , level);
+    qemu_set_irq(s->pci_irqs[irq_num], level);
 }
 
 static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
@@ -223,13 +223,12 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     int i;
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_init_irq(dev, &s->pci_irqs[i]);
     }
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
 
-    pci_bus_irqs(&s->pci_bus, raven_set_irq, raven_map_irq, s->irq,
-                 PCI_NUM_PINS);
+    pci_bus_irqs(&s->pci_bus, raven_set_irq, raven_map_irq, s, PCI_NUM_PINS);
 
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
                           "pci-conf-idx", 4);
-- 
2.11.0
