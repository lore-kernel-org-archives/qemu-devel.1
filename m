Received: from eggs.gnu.org ([2001:4830:134:3::10]:52745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLls-0004FF-7h
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLlp-0007uW-RC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:7314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLlp-0007fT-Do
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:05 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:31:58 +0800
Message-Id: <1519900322-30263-9-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds pci_device_notify_iommu() for notify virtual IOMMU
emulator when assigned device is added. And adds a new notify_func
in PCIBus. vIOMMU emulator provides the instance of this notify_func.

Reason:
When virtual IOMMU is exposed to guest, vIOMMU emulator needs to
programm host IOMMU to setup DMA mapping for assigned devices. This
is a per-device operation, to be efficient, vIOMMU emulator needs
to record the assigned devices.

Example: devices assigned thru vfio, vfio_realize would call
pci_device_notify_iommu() to notify vIOMMU emulator to record necessary
info for assigned device.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/alpha/typhoon.c       |  2 +-
 hw/hppa/dino.c           |  2 +-
 hw/i386/amd_iommu.c      |  2 +-
 hw/i386/intel_iommu.c    | 22 +++++++++++++++++++++-
 hw/pci-host/ppce500.c    |  2 +-
 hw/pci-host/prep.c       |  2 +-
 hw/pci-host/sabre.c      |  2 +-
 hw/pci/pci.c             | 25 +++++++++++++++++++++++--
 hw/ppc/spapr_pci.c       |  2 +-
 hw/s390x/s390-pci-bus.c  |  4 ++--
 hw/vfio/pci.c            |  3 +++
 include/hw/pci/pci.h     | 12 +++++++++++-
 include/hw/pci/pci_bus.h |  1 +
 13 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 6a40869..a7b02cd 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -894,7 +894,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
                              "iommu-typhoon", UINT64_MAX);
     address_space_init(&s->pchip.iommu_as, MEMORY_REGION(&s->pchip.iommu),
                        "pchip0-pci");
-    pci_setup_iommu(b, typhoon_pci_dma_iommu, s);
+    pci_setup_iommu(b, typhoon_pci_dma_iommu, NULL, s);
 
     /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
     memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 15aefde..7867b46 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -481,7 +481,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
                                 0xf0000000 + DINO_MEM_CHUNK_SIZE,
                                 &s->bm_pci_alias);
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
-    pci_setup_iommu(b, dino_pcihost_set_iommu, s);
+    pci_setup_iommu(b, dino_pcihost_set_iommu, NULL, s);
 
     *p_rtc_irq = qemu_allocate_irq(dino_set_timer_irq, s, 0);
     *p_ser_irq = qemu_allocate_irq(dino_set_serial_irq, s, 0);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7bfde37..341a14d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1178,7 +1178,7 @@ static void amdvi_realize(DeviceState *dev, Error **err)
 
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
-    pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
+    pci_setup_iommu(bus, amdvi_host_dma_iommu, NULL, s);
     s->devid = object_property_get_int(OBJECT(&s->pci), "addr", err);
     msi_init(&s->pci.dev, 0, 1, true, false, err);
     amdvi_init(s);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9edf392..2fd0a6d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3005,6 +3005,26 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static int vtd_device_notify(PCIBus *bus,
+                             void *opaque,
+                             int devfn,
+                             PCIDevNotifyType type)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_as = vtd_find_add_as(s, bus, devfn);
+
+    if (vtd_as == NULL) {
+        return -1;
+    }
+
+    /* TODO: record assigned device in IOMMU Emulator */
+    return 0;
+}
+
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -3075,7 +3095,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                               g_free, g_free);
     vtd_init(s);
     sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, Q35_HOST_BRIDGE_IOMMU_ADDR);
-    pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
+    pci_setup_iommu(bus, vtd_host_dma_iommu, vtd_device_notify, dev);
     /* Pseudo address space under root PCI bus. */
     pcms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
 }
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index eb75e08..8175df5 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -469,7 +469,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
     memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
-    pci_setup_iommu(b, e500_pcihost_set_iommu, s);
+    pci_setup_iommu(b, e500_pcihost_set_iommu, NULL, s);
 
     pci_create_simple(b, 0, "e500-host-bridge");
 
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 01f67f9..b4d02cf 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -282,7 +282,7 @@ static void raven_pcihost_initfn(Object *obj)
     memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
     memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
     address_space_init(&s->bm_as, &s->bm, "raven-bm");
-    pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, s);
+    pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, NULL, s);
 
     h->bus = &s->pci_bus;
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index e2f4ee4..e119753 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -399,7 +399,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     /* IOMMU */
     memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
-    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
+    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, NULL, s->iommu);
 
     /* APB secondary busses */
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 157fe21..0f2db02 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2567,9 +2567,30 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
-void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
+void pci_device_notify_iommu(PCIDevice *dev, PCIDevNotifyType type)
 {
-    bus->iommu_fn = fn;
+    PCIBus *bus = PCI_BUS(pci_get_bus(dev));
+    PCIBus *iommu_bus = bus;
+
+    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
+        iommu_bus = PCI_BUS(pci_get_bus(iommu_bus->parent_dev));
+    }
+    if (iommu_bus && iommu_bus->notify_fn) {
+        iommu_bus->notify_fn(bus,
+                             iommu_bus->iommu_opaque,
+                             dev->devfn,
+                             type);
+    }
+    return;
+}
+
+void pci_setup_iommu(PCIBus *bus,
+                     PCIIOMMUFunc iommu_fn,
+                     PCIIOMMUNotifyFunc notify_fn,
+                     void *opaque)
+{
+    bus->iommu_fn = iommu_fn;
+    bus->notify_fn = notify_fn;
     bus->iommu_opaque = opaque;
 }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39a1498..2be0a0f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1687,7 +1687,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&sphb->iommu_root, SPAPR_PCI_MSI_WINDOW,
                                 &sphb->msiwindow);
 
-    pci_setup_iommu(bus, spapr_pci_dma_iommu, sphb);
+    pci_setup_iommu(bus, spapr_pci_dma_iommu, NULL, sphb);
 
     pci_bus_set_route_irq_fn(bus, spapr_route_intx_pin_to_irq);
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 1bad7ab..cc650c4 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -705,7 +705,7 @@ static int s390_pcihost_init(SysBusDevice *dev)
                               s390_pci_set_irq, s390_pci_map_irq, NULL,
                               get_system_memory(), get_system_io(), 0, 64,
                               TYPE_PCI_BUS);
-    pci_setup_iommu(b, s390_pci_dma_iommu, s);
+    pci_setup_iommu(b, s390_pci_dma_iommu, NULL, s);
 
     bus = BUS(b);
     qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
@@ -817,7 +817,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         PCIDevice *pdev = PCI_DEVICE(dev);
 
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
-        pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
+        pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, NULL, s);
 
         bus = BUS(&pb->sec_bus);
         qbus_set_hotplug_handler(bus, DEVICE(s), errp);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b7297cc..a9c0898 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3098,6 +3098,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    pci_device_notify_iommu(pdev, PCI_NTY_DEV_ADD);
+
     pci_setup_sva_ops(pdev, &vfio_pci_sva_ops);
 
     return;
@@ -3134,6 +3136,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
 
+    pci_device_notify_iommu(pdev, PCI_NTY_DEV_DEL);
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 32889a4..964be2b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -485,10 +485,20 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
 
+enum PCIDevNotifyType {
+    PCI_NTY_DEV_ADD = 0,
+    PCI_NTY_DEV_DEL,
+};
+typedef enum PCIDevNotifyType PCIDevNotifyType;
 typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
+typedef int (*PCIIOMMUNotifyFunc)(PCIBus *, void *, int, PCIDevNotifyType);
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
-void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
+void pci_device_notify_iommu(PCIDevice *dev, PCIDevNotifyType type);
+void pci_setup_iommu(PCIBus *bus,
+                     PCIIOMMUFunc iommu_fn,
+                     PCIIOMMUNotifyFunc notify_fn,
+                     void *opaque);
 
 void pci_setup_sva_ops(PCIDevice *dev, PCISVAOps *ops);
 void pci_device_sva_bind_pasid_table(PCIBus *bus, int32_t devfn,
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index b7da8f5..54a0c8e 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -21,6 +21,7 @@ typedef struct PCIBusClass {
 struct PCIBus {
     BusState qbus;
     PCIIOMMUFunc iommu_fn;
+    PCIIOMMUNotifyFunc notify_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
-- 
1.9.1
