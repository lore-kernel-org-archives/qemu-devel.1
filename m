Received: from eggs.gnu.org ([2001:4830:134:3::10]:45450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pv-0007Fn-3N
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1ps-00058v-BZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:39 -0500
Date: Thu, 21 Dec 2017 16:28:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-6-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 05/25] pci: Rename root bus initialization
 functions for clarity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Alexander Graf <agraf@suse.de>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Paul Burton <paul.burton@mips.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org

From: David Gibson <david@gibson.dropbear.id.au>

pci_bus_init(), pci_bus_new_inplace(), pci_bus_new() and pci_register_bus()
are misleadingly named.  They're not used for initializing *any* PCI bus,
but only for a root PCI bus.

Non-root buses - i.e. ones under a logical PCI to PCI bridge - are instead
created with a direct qbus_create_inplace() (see pci_bridge_initfn()).

This patch renames the functions to make it clear they're only used for
a root bus.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/hw/pci/pci.h                | 25 ++++++++++---------
 hw/alpha/typhoon.c                  |  8 +++---
 hw/mips/gt64xxx_pci.c               | 12 ++++-----
 hw/pci-bridge/pci_expander_bridge.c |  4 +--
 hw/pci-host/apb.c                   | 10 ++++----
 hw/pci-host/bonito.c                |  8 +++---
 hw/pci-host/gpex.c                  |  6 ++---
 hw/pci-host/grackle.c               | 14 +++++------
 hw/pci-host/piix.c                  |  4 +--
 hw/pci-host/ppce500.c               |  6 ++---
 hw/pci-host/prep.c                  |  4 +--
 hw/pci-host/q35.c                   |  7 +++---
 hw/pci-host/uninorth.c              | 24 +++++++++---------
 hw/pci-host/versatile.c             |  6 ++---
 hw/pci-host/xilinx-pcie.c           |  6 ++---
 hw/pci/pci.c                        | 49 ++++++++++++++++++++-----------------
 hw/ppc/ppc4xx_pci.c                 |  6 ++---
 hw/ppc/spapr_pci.c                  |  8 +++---
 hw/s390x/s390-pci-bus.c             |  8 +++---
 hw/sh4/sh_pci.c                     | 12 ++++-----
 20 files changed, 116 insertions(+), 111 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d02a0a..870ebcf 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -400,26 +400,27 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 
 bool pci_bus_is_express(PCIBus *bus);
 bool pci_bus_is_root(PCIBus *bus);
-void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
-                         const char *name,
+void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
+                              const char *name,
+                              MemoryRegion *address_space_mem,
+                              MemoryRegion *address_space_io,
+                              uint8_t devfn_min, const char *typename);
+PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min, const char *typename);
-PCIBus *pci_bus_new(DeviceState *parent, const char *name,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    uint8_t devfn_min, const char *typename);
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                   void *irq_opaque, int nirq);
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
-PCIBus *pci_register_bus(DeviceState *parent, const char *name,
-                         pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
-                         void *irq_opaque,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
-                         uint8_t devfn_min, int nirq, const char *typename);
+PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
+                              pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
+                              void *irq_opaque,
+                              MemoryRegion *address_space_mem,
+                              MemoryRegion *address_space_io,
+                              uint8_t devfn_min, int nirq,
+                              const char *typename);
 void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
 PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
 bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index ae11e01..6a40869 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -881,10 +881,10 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
     memory_region_add_subregion(addr_space, 0x801fc000000ULL,
                                 &s->pchip.reg_io);
 
-    b = pci_register_bus(dev, "pci",
-                         typhoon_set_irq, sys_map_irq, s,
-                         &s->pchip.reg_mem, &s->pchip.reg_io,
-                         0, 64, TYPE_PCI_BUS);
+    b = pci_register_root_bus(dev, "pci",
+                              typhoon_set_irq, sys_map_irq, s,
+                              &s->pchip.reg_mem, &s->pchip.reg_io,
+                              0, 64, TYPE_PCI_BUS);
     phb->bus = b;
     qdev_init_nofail(dev);
 
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5a9dad9..a9c222a 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1171,12 +1171,12 @@ PCIBus *gt64120_register(qemu_irq *pic)
     phb = PCI_HOST_BRIDGE(dev);
     memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", UINT32_MAX);
     address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
-    phb->bus = pci_register_bus(dev, "pci",
-                                gt64120_pci_set_irq, gt64120_pci_map_irq,
-                                pic,
-                                &d->pci0_mem,
-                                get_system_io(),
-                                PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
+    phb->bus = pci_register_root_bus(dev, "pci",
+                                     gt64120_pci_set_irq, gt64120_pci_map_irq,
+                                     pic,
+                                     &d->pci0_mem,
+                                     get_system_io(),
+                                     PCI_DEVFN(18, 0), 4, TYPE_PCI_BUS);
     qdev_init_nofail(dev);
     memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d, "isd-mem", 0x1000);
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 8c8ac73..b2fa829 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -230,9 +230,9 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
 
     ds = qdev_create(NULL, TYPE_PXB_HOST);
     if (pcie) {
-        bus = pci_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
+        bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
     } else {
-        bus = pci_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
+        bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
         bds = qdev_create(BUS(bus), "pci-bridge");
         bds->id = dev_name;
         qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->bus_nr);
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 64025cd..1df9984 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -714,11 +714,11 @@ PCIBus *pci_apb_init(hwaddr special_base,
     dev = qdev_create(NULL, TYPE_APB);
     d = APB_DEVICE(dev);
     phb = PCI_HOST_BRIDGE(dev);
-    phb->bus = pci_register_bus(DEVICE(phb), "pci",
-                                pci_apb_set_irq, pci_apb_map_irq, d,
-                                &d->pci_mmio,
-                                &d->pci_ioport,
-                                0, 32, TYPE_PCI_BUS);
+    phb->bus = pci_register_root_bus(DEVICE(phb), "pci",
+                                     pci_apb_set_irq, pci_apb_map_irq, d,
+                                     &d->pci_mmio,
+                                     &d->pci_ioport,
+                                     0, 32, TYPE_PCI_BUS);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
     /* apb_config */
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9f61e27..f08593f 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -714,10 +714,10 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
 {
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
 
-    phb->bus = pci_register_bus(DEVICE(dev), "pci",
-                                pci_bonito_set_irq, pci_bonito_map_irq, dev,
-                                get_system_memory(), get_system_io(),
-                                0x28, 32, TYPE_PCI_BUS);
+    phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
+                                     pci_bonito_set_irq, pci_bonito_map_irq,
+                                     dev, get_system_memory(), get_system_io(),
+                                     0x28, 32, TYPE_PCI_BUS);
 
     return 0;
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index edf305b..2583b15 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -89,9 +89,9 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
         s->irq_num[i] = -1;
     }
 
-    pci->bus = pci_register_bus(dev, "pcie.0", gpex_set_irq,
-                                pci_swizzle_map_irq_fn, s, &s->io_mmio,
-                                &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
+    pci->bus = pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
+                                     pci_swizzle_map_irq_fn, s, &s->io_mmio,
+                                     &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
 
     qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
     pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 38cd279..3caf1cc 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -82,13 +82,13 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    phb->bus = pci_register_bus(dev, NULL,
-                                pci_grackle_set_irq,
-                                pci_grackle_map_irq,
-                                pic,
-                                &d->pci_mmio,
-                                address_space_io,
-                                0, 4, TYPE_PCI_BUS);
+    phb->bus = pci_register_root_bus(dev, NULL,
+                                     pci_grackle_set_irq,
+                                     pci_grackle_map_irq,
+                                     pic,
+                                     &d->pci_mmio,
+                                     address_space_io,
+                                     0, 4, TYPE_PCI_BUS);
 
     pci_create_simple(phb->bus, 0, "grackle");
     qdev_init_nofail(dev);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index a684a7c..cf90701 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -361,8 +361,8 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
 
     dev = qdev_create(NULL, host_type);
     s = PCI_HOST_BRIDGE(dev);
-    b = pci_bus_new(dev, NULL, pci_address_space,
-                    address_space_io, 0, TYPE_PCI_BUS);
+    b = pci_root_bus_new(dev, NULL, pci_address_space,
+                         address_space_io, 0, TYPE_PCI_BUS);
     s->bus = b;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev), NULL);
     qdev_init_nofail(dev);
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 39cd244..67edbf7 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -465,9 +465,9 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     /* PIO lives at the bottom of our bus space */
     memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
 
-    b = pci_register_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
-                         mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
-                         PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
+    b = pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
+                              mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
+                              PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
     h->bus = b;
 
     /* Set up PCI view of memory */
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 92eed0f..01f67f9 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -269,8 +269,8 @@ static void raven_pcihost_initfn(Object *obj)
     memory_region_add_subregion_overlap(address_space_mem, 0x80000000,
                                         &s->pci_io_non_contiguous, 1);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
-                        &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
+    pci_root_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
+                             &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
 
     /* Bus master address space */
     memory_region_init(&s->bm, obj, "bm-raven", UINT32_MAX);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 6cb9a8d..a36a119 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -51,9 +51,10 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
     sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
 
-    pci->bus = pci_bus_new(DEVICE(s), "pcie.0",
-                           s->mch.pci_address_space, s->mch.address_space_io,
-                           0, TYPE_PCIE_BUS);
+    pci->bus = pci_root_bus_new(DEVICE(s), "pcie.0",
+                                s->mch.pci_address_space,
+                                s->mch.address_space_io,
+                                0, TYPE_PCIE_BUS);
     PC_MACHINE(qdev_get_machine())->bus = pci->bus;
     qdev_set_parent_bus(DEVICE(&s->mch), BUS(pci->bus));
     qdev_init_nofail(DEVICE(&s->mch));
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index ea5c265..5d8ccaa 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -233,12 +233,12 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    h->bus = pci_register_bus(dev, NULL,
-                              pci_unin_set_irq, pci_unin_map_irq,
-                              pic,
-                              &d->pci_mmio,
-                              address_space_io,
-                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+    h->bus = pci_register_root_bus(dev, NULL,
+                                   pci_unin_set_irq, pci_unin_map_irq,
+                                   pic,
+                                   &d->pci_mmio,
+                                   address_space_io,
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
 #if 0
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
@@ -299,12 +299,12 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    h->bus = pci_register_bus(dev, NULL,
-                              pci_unin_set_irq, pci_unin_map_irq,
-                              pic,
-                              &d->pci_mmio,
-                              address_space_io,
-                              PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+    h->bus = pci_register_root_bus(dev, NULL,
+                                   pci_unin_set_irq, pci_unin_map_irq,
+                                   pic,
+                                   &d->pci_mmio,
+                                   address_space_io,
+                                   PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
 
     sysbus_mmio_map(s, 0, 0xf0800000);
     sysbus_mmio_map(s, 1, 0xf0c00000);
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 6394a52..8803ada 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -399,9 +399,9 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->pci_io_space, OBJECT(s), "pci_io", 1ULL << 32);
     memory_region_init(&s->pci_mem_space, OBJECT(s), "pci_mem", 1ULL << 32);
 
-    pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), dev, "pci",
-                        &s->pci_mem_space, &s->pci_io_space,
-                        PCI_DEVFN(11, 0), TYPE_PCI_BUS);
+    pci_root_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), dev, "pci",
+                             &s->pci_mem_space, &s->pci_io_space,
+                             PCI_DEVFN(11, 0), TYPE_PCI_BUS);
     h->bus = &s->pci_bus;
 
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 7659253..d2f88d1 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -129,9 +129,9 @@ static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &pex->mmio);
     sysbus_init_mmio(sbd, &s->mmio);
 
-    pci->bus = pci_register_bus(dev, s->name, xilinx_pcie_set_irq,
-                                pci_swizzle_map_irq_fn, s, &s->mmio,
-                                &s->io, 0, 4, TYPE_PCIE_BUS);
+    pci->bus = pci_register_root_bus(dev, s->name, xilinx_pcie_set_irq,
+                                     pci_swizzle_map_irq_fn, s, &s->mmio,
+                                     &s->io, 0, 4, TYPE_PCIE_BUS);
 
     qdev_set_parent_bus(DEVICE(&s->root), BUS(pci->bus));
     qdev_init_nofail(DEVICE(&s->root));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b2d139b..232e7da 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -376,10 +376,10 @@ const char *pci_root_bus_path(PCIDevice *dev)
     return rootbus->qbus.name;
 }
 
-static void pci_bus_init(PCIBus *bus, DeviceState *parent,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
-                         uint8_t devfn_min)
+static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
+                              MemoryRegion *address_space_mem,
+                              MemoryRegion *address_space_io,
+                              uint8_t devfn_min)
 {
     assert(PCI_FUNC(devfn_min) == 0);
     bus->devfn_min = devfn_min;
@@ -403,25 +403,27 @@ bool pci_bus_is_root(PCIBus *bus)
     return PCI_BUS_GET_CLASS(bus)->is_root(bus);
 }
 
-void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
-                         const char *name,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
-                         uint8_t devfn_min, const char *typename)
+void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
+                              const char *name,
+                              MemoryRegion *address_space_mem,
+                              MemoryRegion *address_space_io,
+                              uint8_t devfn_min, const char *typename)
 {
     qbus_create_inplace(bus, bus_size, typename, parent, name);
-    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
+    pci_root_bus_init(bus, parent, address_space_mem, address_space_io,
+                      devfn_min);
 }
 
-PCIBus *pci_bus_new(DeviceState *parent, const char *name,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    uint8_t devfn_min, const char *typename)
+PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
+                         MemoryRegion *address_space_mem,
+                         MemoryRegion *address_space_io,
+                         uint8_t devfn_min, const char *typename)
 {
     PCIBus *bus;
 
     bus = PCI_BUS(qbus_create(typename, parent, name));
-    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
+    pci_root_bus_init(bus, parent, address_space_mem, address_space_io,
+                      devfn_min);
     return bus;
 }
 
@@ -435,17 +437,18 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
     bus->irq_count = g_malloc0(nirq * sizeof(bus->irq_count[0]));
 }
 
-PCIBus *pci_register_bus(DeviceState *parent, const char *name,
-                         pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
-                         void *irq_opaque,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io,
-                         uint8_t devfn_min, int nirq, const char *typename)
+PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
+                              pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
+                              void *irq_opaque,
+                              MemoryRegion *address_space_mem,
+                              MemoryRegion *address_space_io,
+                              uint8_t devfn_min, int nirq,
+                              const char *typename)
 {
     PCIBus *bus;
 
-    bus = pci_bus_new(parent, name, address_space_mem,
-                      address_space_io, devfn_min, typename);
+    bus = pci_root_bus_new(parent, name, address_space_mem,
+                           address_space_io, devfn_min, typename);
     pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
     return bus;
 }
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 4765dce..b7642ba 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -314,9 +314,9 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
         sysbus_init_irq(dev, &s->irq[i]);
     }
 
-    b = pci_register_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
-                         ppc4xx_pci_map_irq, s->irq, get_system_memory(),
-                         get_system_io(), 0, 4, TYPE_PCI_BUS);
+    b = pci_register_root_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
+                              ppc4xx_pci_map_irq, s->irq, get_system_memory(),
+                              get_system_io(), 0, 4, TYPE_PCI_BUS);
     h->bus = b;
 
     pci_create_simple(b, 0, "ppc4xx-host-bridge");
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5a3122a..9262682 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1621,10 +1621,10 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
 
-    bus = pci_register_bus(dev, NULL,
-                           pci_spapr_set_irq, pci_spapr_map_irq, sphb,
-                           &sphb->memspace, &sphb->iospace,
-                           PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
+    bus = pci_register_root_bus(dev, NULL,
+                                pci_spapr_set_irq, pci_spapr_map_irq, sphb,
+                                &sphb->memspace, &sphb->iospace,
+                                PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
     phb->bus = bus;
     qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2b1e140..347329d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -554,10 +554,10 @@ static int s390_pcihost_init(SysBusDevice *dev)
 
     DPRINTF("host_init\n");
 
-    b = pci_register_bus(DEVICE(dev), NULL,
-                         s390_pci_set_irq, s390_pci_map_irq, NULL,
-                         get_system_memory(), get_system_io(), 0, 64,
-                         TYPE_PCI_BUS);
+    b = pci_register_root_bus(DEVICE(dev), NULL,
+                              s390_pci_set_irq, s390_pci_map_irq, NULL,
+                              get_system_memory(), get_system_io(), 0, 64,
+                              TYPE_PCI_BUS);
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
 
     bus = BUS(b);
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index cbb01af..4ec2e35 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -131,12 +131,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(dev, &s->irq[i]);
     }
-    phb->bus = pci_register_bus(DEVICE(dev), "pci",
-                                sh_pci_set_irq, sh_pci_map_irq,
-                                s->irq,
-                                get_system_memory(),
-                                get_system_io(),
-                                PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
+    phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
+                                     sh_pci_set_irq, sh_pci_map_irq,
+                                     s->irq,
+                                     get_system_memory(),
+                                     get_system_io(),
+                                     PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
     memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, s,
                           "sh_pci", 0x224);
     memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
-- 
MST
