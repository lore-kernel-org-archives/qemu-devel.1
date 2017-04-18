Received: from eggs.gnu.org ([2001:4830:134:3::10]:56771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRs-0000zm-Ek
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRp-0002as-0e
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:18:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 18 Apr 2017 19:17:24 -0300
Message-Id: <20170418221724.5707-7-ehabkost@redhat.com>
In-Reply-To: <20170418221724.5707-1-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 6/6] pci: Remove unnecessary PCIBus variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org

"phb->bus" is a short expression, there's no need for an extra variable
just to hold its value.

Generated using the following Coccinelle patch:

    @@
    identifier b;
    identifier phb;
    typedef PCIBus;
    @@
    -PCIBus *b;
     ... when != b
    -b = phb->bus;
     <...
    -b
    +phb->bus
     ...>

Cc: Richard Henderson <rth@twiddle.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/alpha/typhoon.c                  | 10 ++++------
 hw/pci-bridge/pci_expander_bridge.c |  4 +---
 hw/pci-host/piix.c                  | 26 +++++++++++++-------------
 hw/pci-host/ppce500.c               |  8 +++-----
 hw/ppc/ppc4xx_pci.c                 |  4 +---
 hw/ppc/spapr_pci.c                  |  6 ++----
 hw/s390x/s390-pci-bus.c             |  6 ++----
 7 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index a35fac5381..051de095e0 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -820,7 +820,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
     DeviceState *dev;
     TyphoonState *s;
     PCIHostState *phb;
-    PCIBus *b;
     int i;
 
     dev = qdev_create(NULL, TYPE_TYPHOON_PCI_HOST_BRIDGE);
@@ -886,24 +885,23 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
     pci_host_bus_init_irqs(phb, "pci", typhoon_set_irq, sys_map_irq, s,
                            &s->pchip.reg_mem, &s->pchip.reg_io, 0, 64,
                            TYPE_PCI_BUS);
-    b = phb->bus;
     qdev_init_nofail(dev);
 
     /* Host memory as seen from the PCI side, via the IOMMU.  */
     memory_region_init_iommu(&s->pchip.iommu, OBJECT(s), &typhoon_iommu_ops,
                              "iommu-typhoon", UINT64_MAX);
     address_space_init(&s->pchip.iommu_as, &s->pchip.iommu, "pchip0-pci");
-    pci_setup_iommu(b, typhoon_pci_dma_iommu, s);
+    pci_setup_iommu(phb->bus, typhoon_pci_dma_iommu, s);
 
     /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
     memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
-                          b, "pci0-iack", 64*MB);
+                          phb->bus, "pci0-iack", 64 * MB);
     memory_region_add_subregion(addr_space, 0x801f8000000ULL,
                                 &s->pchip.reg_iack);
 
     /* Pchip0 PCI configuration, 0x801.FE00.0000, 16MB.  */
     memory_region_init_io(&s->pchip.reg_conf, OBJECT(s), &alpha_pci_conf1_ops,
-                          b, "pci0-conf", 16*MB);
+                          phb->bus, "pci0-conf", 16 * MB);
     memory_region_add_subregion(addr_space, 0x801fe000000ULL,
                                 &s->pchip.reg_conf);
 
@@ -928,7 +926,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
         isa_bus_irqs(*isa_bus, isa_irqs);
     }
 
-    return b;
+    return phb->bus;
 }
 
 static int typhoon_pcihost_init(SysBusDevice *dev)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index e88b0aa682..bdd03f661a 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -114,7 +114,6 @@ static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
 static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
 {
     const PCIHostState *pxb_host;
-    const PCIBus *pxb_bus;
     const PXBDev *pxb_dev;
     int position;
     const DeviceState *pxb_dev_base;
@@ -122,8 +121,7 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
     const SysBusDevice *main_host_sbd;
 
     pxb_host = PCI_HOST_BRIDGE(dev);
-    pxb_bus = pxb_host->bus;
-    pxb_dev = convert_to_pxb(pxb_bus->parent_dev);
+    pxb_dev = convert_to_pxb(pxb_host->bus->parent_dev);
     position = g_list_index(pxb_dev_list, pxb_dev);
     assert(position >= 0);
 
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index ec5a39706e..7b623f5d1b 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -330,7 +330,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     MemoryRegion *ram_memory)
 {
     DeviceState *dev;
-    PCIBus *b;
     PCIDevice *d;
     PCIHostState *s;
     PIIX3State *piix3;
@@ -342,11 +341,10 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     s = PCI_HOST_BRIDGE(dev);
     pci_host_bus_init(s, NULL, pci_address_space, address_space_io, 0,
                       TYPE_PCI_BUS);
-    b = s->bus;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev), NULL);
     qdev_init_nofail(dev);
 
-    d = pci_create_simple(b, 0, pci_type);
+    d = pci_create_simple(s->bus, 0, pci_type);
     *pi440fx_state = I440FX_PCI_DEVICE(d);
     f = *pi440fx_state;
     f->system_memory = address_space_mem;
@@ -391,18 +389,20 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
      * connected to the IOAPIC directly.
      * These additional routes can be discovered through ACPI. */
     if (xen_enabled()) {
-        PCIDevice *pci_dev = pci_create_simple_multifunction(b,
-                             -1, true, "PIIX3-xen");
+        PCIDevice *pci_dev = pci_create_simple_multifunction(s->bus,
+                                                             -1, true,
+                                                             "PIIX3-xen");
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, xen_piix3_set_irq, xen_pci_slot_get_pirq,
-                piix3, XEN_PIIX_NUM_PIRQS);
+        pci_bus_irqs(s->bus, xen_piix3_set_irq, xen_pci_slot_get_pirq,
+                     piix3, XEN_PIIX_NUM_PIRQS);
     } else {
-        PCIDevice *pci_dev = pci_create_simple_multifunction(b,
-                             -1, true, "PIIX3");
+        PCIDevice *pci_dev = pci_create_simple_multifunction(s->bus,
+                                                             -1, true,
+                                                             "PIIX3");
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        pci_bus_irqs(b, piix3_set_irq, pci_slot_get_pirq, piix3,
-                PIIX_NUM_PIRQS);
-        pci_bus_set_route_irq_fn(b, piix3_route_intx_pin_to_irq);
+        pci_bus_irqs(s->bus, piix3_set_irq, pci_slot_get_pirq, piix3,
+                     PIIX_NUM_PIRQS);
+        pci_bus_set_route_irq_fn(s->bus, piix3_route_intx_pin_to_irq);
     }
     piix3->pic = pic;
     *isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
@@ -417,7 +417,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
 
     i440fx_update_memory_mappings(f);
 
-    return b;
+    return s->bus;
 }
 
 PCIBus *find_i440fx(void)
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index d7091709d2..24decdbbbc 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -445,7 +445,6 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
 {
     PCIHostState *h;
     PPCE500PCIState *s;
-    PCIBus *b;
     int i;
 
     h = PCI_HOST_BRIDGE(dev);
@@ -468,15 +467,14 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     pci_host_bus_init_irqs(h, NULL, mpc85xx_pci_set_irq, mpc85xx_pci_map_irq,
                            s, &s->busmem, &s->pio,
                            PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
-    b = h->bus;
 
     /* Set up PCI view of memory */
     memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
-    pci_setup_iommu(b, e500_pcihost_set_iommu, s);
+    pci_setup_iommu(h->bus, e500_pcihost_set_iommu, s);
 
-    pci_create_simple(b, 0, "e500-host-bridge");
+    pci_create_simple(h->bus, 0, "e500-host-bridge");
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
@@ -489,7 +487,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     memory_region_add_subregion(&s->container, PCIE500_CFGDATA, &h->data_mem);
     memory_region_add_subregion(&s->container, PCIE500_REG_BASE, &s->iomem);
     sysbus_init_mmio(dev, &s->container);
-    pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
+    pci_bus_set_route_irq_fn(h->bus, e500_route_intx_pin_to_irq);
 
     return 0;
 }
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 992be1bce9..80516a387c 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -304,7 +304,6 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
 {
     PPC4xxPCIState *s;
     PCIHostState *h;
-    PCIBus *b;
     int i;
 
     h = PCI_HOST_BRIDGE(dev);
@@ -317,9 +316,8 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
     pci_host_bus_init_irqs(h, NULL, ppc4xx_pci_set_irq, ppc4xx_pci_map_irq,
                            s->irq, get_system_memory(), get_system_io(), 0, 4,
                            TYPE_PCI_BUS);
-    b = h->bus;
 
-    pci_create_simple(b, 0, "ppc4xx-host-bridge");
+    pci_create_simple(h->bus, 0, "ppc4xx-host-bridge");
 
     /* XXX split into 2 memory regions, one for config space, one for regs */
     memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 06e8a8740b..b1ce50427c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1570,7 +1570,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     char *namebuf;
     int i;
-    PCIBus *bus;
     uint64_t msi_window_size = 4096;
     sPAPRTCETable *tcet;
     const unsigned windows_supported =
@@ -1700,7 +1699,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     pci_host_bus_init_irqs(phb, NULL, pci_spapr_set_irq, pci_spapr_map_irq,
                            sphb, &sphb->memspace, &sphb->iospace,
                            PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
-    bus = phb->bus;
     qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
 
     /*
@@ -1739,9 +1737,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
                                 &sphb->msiwindow);
 
-    pci_setup_iommu(bus, spapr_pci_dma_iommu, sphb);
+    pci_setup_iommu(phb->bus, spapr_pci_dma_iommu, sphb);
 
-    pci_bus_set_route_irq_fn(bus, spapr_route_intx_pin_to_irq);
+    pci_bus_set_route_irq_fn(phb->bus, spapr_route_intx_pin_to_irq);
 
     QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5e174e90f4..c2776ba221 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -553,7 +553,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
 
 static int s390_pcihost_init(SysBusDevice *dev)
 {
-    PCIBus *b;
     BusState *bus;
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
@@ -563,10 +562,9 @@ static int s390_pcihost_init(SysBusDevice *dev)
     pci_host_bus_init_irqs(phb, NULL, s390_pci_set_irq, s390_pci_map_irq,
                            NULL, get_system_memory(), get_system_io(), 0, 64,
                            TYPE_PCI_BUS);
-    b = phb->bus;
-    pci_setup_iommu(b, s390_pci_dma_iommu, s);
+    pci_setup_iommu(phb->bus, s390_pci_dma_iommu, s);
 
-    bus = BUS(b);
+    bus = BUS(phb->bus);
     qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
 
     s->bus = S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NULL));
-- 
2.11.0.259.g40922b1
