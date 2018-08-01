Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkiDG-0000yt-Qf
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 23:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkiDF-0005wM-RI
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 23:54:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Aug 2018 13:53:57 +1000
Message-Id: <20180801035357.7804-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180801035357.7804-1-david@gibson.dropbear.id.au>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/2] sam460ex: Fix PCI interrupts with multiple
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, BALATON Zoltan <balaton@eik.bme.hu>, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

The four interrupts of the PCI bus are connected to the same UIC pin
on the real Sam460ex. Evidence for this can be found in the UBoot
source for the Sam460ex in the Sam460ex.c file where
PCI_INTERRUPT_LINE is written. Change the ppc440_pcix model to behave
more like this.

This fixes the problem that can be observed when adding further PCI
cards that got their interrupt rotated to other interrupts than PCI
INT A. In particular, the bug was observed with an additional OHCI PCI
card or an ES1370 sound device.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_pcix.c | 21 ++++++++-------------
 hw/ppc/sam460ex.c    |  6 ++----
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index d8af04b70f..64ed07afa6 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -57,7 +57,7 @@ typedef struct PPC440PCIXState {
     struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
     struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
     uint32_t sts;
-    qemu_irq irq[PCI_NUM_PINS];
+    qemu_irq irq;
     AddressSpace bm_as;
     MemoryRegion bm;
 
@@ -418,21 +418,20 @@ static void ppc440_pcix_reset(DeviceState *dev)
  * This may need further refactoring for other boards. */
 static int ppc440_pcix_map_irq(PCIDevice *pci_dev, int irq_num)
 {
-    int slot = pci_dev->devfn >> 3;
-    trace_ppc440_pcix_map_irq(pci_dev->devfn, irq_num, slot);
-    return slot - 1;
+    trace_ppc440_pcix_map_irq(pci_dev->devfn, irq_num, 0);
+    return 0;
 }
 
 static void ppc440_pcix_set_irq(void *opaque, int irq_num, int level)
 {
-    qemu_irq *pci_irqs = opaque;
+    qemu_irq *pci_irq = opaque;
 
     trace_ppc440_pcix_set_irq(irq_num);
     if (irq_num < 0) {
         error_report("%s: PCI irq %d", __func__, irq_num);
         return;
     }
-    qemu_set_irq(pci_irqs[irq_num], level);
+    qemu_set_irq(*pci_irq, level);
 }
 
 static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, int devfn)
@@ -471,19 +470,15 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
 {
     PPC440PCIXState *s;
     PCIHostState *h;
-    int i;
 
     h = PCI_HOST_BRIDGE(dev);
     s = PPC440_PCIX_HOST_BRIDGE(dev);
 
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
-    }
-
+    sysbus_init_irq(dev, &s->irq);
     memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
     h->bus = pci_register_root_bus(DEVICE(dev), NULL, ppc440_pcix_set_irq,
-                         ppc440_pcix_map_irq, s->irq, &s->busmem,
-                         get_system_io(), PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
+                         ppc440_pcix_map_irq, &s->irq, &s->busmem,
+                         get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
 
     s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 0999efcc1e..9c77183006 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -515,10 +515,8 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI bus */
     ppc460ex_pcie_init(env);
-    /* FIXME: is this correct? */
-    dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
-                                uic[1][0], uic[1][20], uic[1][21], uic[1][22],
-                                NULL);
+    /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
+    dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000, uic[1][0]);
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pci_bus) {
         error_report("couldn't create PCI controller!");
-- 
2.17.1
