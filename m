Received: from eggs.gnu.org ([2001:4830:134:3::10]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMPA-0005R8-AJ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMP7-0004UB-7N
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:37:04 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Tue, 31 Jul 2018 06:36:34 +0200
Message-Id: <20180731043635.9802-2-mail@sebastianbauer.info>
In-Reply-To: <20180731043635.9802-1-mail@sebastianbauer.info>
References: <20180731043635.9802-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH 1/2] ppc: Allow clients of the 440 pcix bus to
 specify the number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, balaton@eik.bme.hu

This can be done by using the newly introduced num_irqs property. In
particular, this change introduces a special case if num_irqs is 1 in which
case any interrupt pin will be connected to the single irq. The default
case is untouched (but note that the only client is the Sam460ex board for
which the special case was actually created).

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
---
 hw/ppc/ppc440_pcix.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index d8af04b70f..cb7d7cfd2b 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -57,6 +57,7 @@ typedef struct PPC440PCIXState {
     struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
     struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
     uint32_t sts;
+    uint16_t num_irqs;
     qemu_irq irq[PCI_NUM_PINS];
     AddressSpace bm_as;
     MemoryRegion bm;
@@ -423,6 +424,12 @@ static int ppc440_pcix_map_irq(PCIDevice *pci_dev, int irq_num)
     return slot - 1;
 }
 
+/* All pins from each slot are tied the same and only board IRQ. */
+static int ppc440_pcix_map_irq_single(PCIDevice *pci_dev, int irq_num)
+{
+    return 0;
+}
+
 static void ppc440_pcix_set_irq(void *opaque, int irq_num, int level)
 {
     qemu_irq *pci_irqs = opaque;
@@ -469,6 +476,7 @@ const MemoryRegionOps ppc440_pcix_host_data_ops = {
 
 static int ppc440_pcix_initfn(SysBusDevice *dev)
 {
+    pci_map_irq_fn map_irq;
     PPC440PCIXState *s;
     PCIHostState *h;
     int i;
@@ -476,14 +484,22 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
     h = PCI_HOST_BRIDGE(dev);
     s = PPC440_PCIX_HOST_BRIDGE(dev);
 
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
+    if (s->num_irqs > 4) {
+        fprintf(stderr, "%s: Number of irqs must not exceed 4\n", __func__);
+        return -1;
+    }
+
+    for (i = 0; i < s->num_irqs; i++) {
         sysbus_init_irq(dev, &s->irq[i]);
     }
 
     memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
+
+    map_irq = s->num_irqs == 1 ?
+            ppc440_pcix_map_irq_single : ppc440_pcix_map_irq;
     h->bus = pci_register_root_bus(DEVICE(dev), NULL, ppc440_pcix_set_irq,
-                         ppc440_pcix_map_irq, s->irq, &s->busmem,
-                         get_system_io(), PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
+                         map_irq, s->irq, &s->busmem, get_system_io(),
+                         PCI_DEVFN(0, 0), s->num_irqs, TYPE_PCI_BUS);
 
     s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
 
@@ -507,6 +523,11 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
     return 0;
 }
 
+static Property ppc440_pcix_properties[] = {
+    DEFINE_PROP_UINT16("num-irqs", PPC440PCIXState, num_irqs, 4),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
 {
     SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
@@ -514,6 +535,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
 
     k->init = ppc440_pcix_initfn;
     dc->reset = ppc440_pcix_reset;
+    dc->props = ppc440_pcix_properties;
 }
 
 static const TypeInfo ppc440_pcix_info = {
-- 
2.18.0
