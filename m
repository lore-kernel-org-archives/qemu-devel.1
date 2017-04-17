Received: from eggs.gnu.org ([2001:4830:134:3::10]:54249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgW-0000WJ-F8
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgT-0005o8-CS
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Apr 2017 18:59:13 -0300
Message-Id: <20170417215916.12431-5-ehabkost@redhat.com>
In-Reply-To: <20170417215916.12431-1-ehabkost@redhat.com>
References: <20170417215916.12431-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 4/7] pci: Change pci_register_bus() 'parent'
 parameter to PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Paul Burton <paul.burton@imgtec.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-ppc@nongnu.org

pci_register_bus() already requires the 'parent' argument to be a
PCI_HOST_BRIDGE object. Change the parameter type to reflect that.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/pci/pci.h      | 2 +-
 hw/alpha/typhoon.c        | 2 +-
 hw/mips/gt64xxx_pci.c     | 2 +-
 hw/pci-host/apb.c         | 2 +-
 hw/pci-host/bonito.c      | 2 +-
 hw/pci-host/gpex.c        | 2 +-
 hw/pci-host/grackle.c     | 2 +-
 hw/pci-host/ppce500.c     | 2 +-
 hw/pci-host/uninorth.c    | 4 ++--
 hw/pci-host/xilinx-pcie.c | 2 +-
 hw/pci/pci.c              | 4 ++--
 hw/ppc/ppc4xx_pci.c       | 2 +-
 hw/ppc/spapr_pci.c        | 2 +-
 hw/s390x/s390-pci-bus.c   | 2 +-
 hw/sh4/sh_pci.c           | 2 +-
 15 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 2242aa25eb..56387ccb0c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -408,7 +408,7 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
-PCIBus *pci_register_bus(DeviceState *parent, const char *name,
+PCIBus *pci_register_bus(PCIHostState *phb, const char *name,
                          pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                          void *irq_opaque,
                          MemoryRegion *address_space_mem,
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index f50f5cf186..ac0633a55e 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -883,7 +883,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
     memory_region_add_subregion(addr_space, 0x801fc000000ULL,
                                 &s->pchip.reg_io);
 
-    b = pci_register_bus(dev, "pci",
+    b = pci_register_bus(phb, "pci",
                          typhoon_set_irq, sys_map_irq, s,
                          &s->pchip.reg_mem, &s->pchip.reg_io,
                          0, 64, TYPE_PCI_BUS);
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 4811843ab6..bd131bcdc6 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1171,7 +1171,7 @@ PCIBus *gt64120_register(qemu_irq *pic)
     phb = PCI_HOST_BRIDGE(dev);
     memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", UINT32_MAX);
     address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
-    phb->bus = pci_register_bus(dev, "pci",
+    phb->bus = pci_register_bus(phb, "pci",
                                 gt64120_pci_set_irq, gt64120_pci_map_irq,
                                 pic,
                                 &d->pci0_mem,
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 653e711121..1156a54224 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -671,7 +671,7 @@ PCIBus *pci_apb_init(hwaddr special_base,
     dev = qdev_create(NULL, TYPE_APB);
     d = APB_DEVICE(dev);
     phb = PCI_HOST_BRIDGE(dev);
-    phb->bus = pci_register_bus(DEVICE(phb), "pci",
+    phb->bus = pci_register_bus(phb, "pci",
                                 pci_apb_set_irq, pci_pbm_map_irq, d,
                                 &d->pci_mmio,
                                 get_system_io(),
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1999ece590..27842edc04 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -714,7 +714,7 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
 {
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
 
-    phb->bus = pci_register_bus(DEVICE(dev), "pci",
+    phb->bus = pci_register_bus(phb, "pci",
                                 pci_bonito_set_irq, pci_bonito_map_irq, dev,
                                 get_system_memory(), get_system_io(),
                                 0x28, 32, TYPE_PCI_BUS);
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 66055ee5cc..042d127271 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -62,7 +62,7 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->irq[i]);
     }
 
-    pci->bus = pci_register_bus(dev, "pcie.0", gpex_set_irq,
+    pci->bus = pci_register_bus(pci, "pcie.0", gpex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->io_mmio,
                                 &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
 
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 2c8acdaaca..a56c063be9 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -82,7 +82,7 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    phb->bus = pci_register_bus(dev, NULL,
+    phb->bus = pci_register_bus(phb, NULL,
                                 pci_grackle_set_irq,
                                 pci_grackle_map_irq,
                                 pic,
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index e502bc0505..4a1e99f426 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -465,7 +465,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     /* PIO lives at the bottom of our bus space */
     memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
 
-    b = pci_register_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
+    b = pci_register_bus(h, NULL, mpc85xx_pci_set_irq,
                          mpc85xx_pci_map_irq, s, &s->busmem, &s->pio,
                          PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS);
     h->bus = b;
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index df342ac3cb..b1b89183fc 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -233,7 +233,7 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    h->bus = pci_register_bus(dev, NULL,
+    h->bus = pci_register_bus(h, NULL,
                               pci_unin_set_irq, pci_unin_map_irq,
                               pic,
                               &d->pci_mmio,
@@ -299,7 +299,7 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
 
-    h->bus = pci_register_bus(dev, NULL,
+    h->bus = pci_register_bus(h, NULL,
                               pci_unin_set_irq, pci_unin_map_irq,
                               pic,
                               &d->pci_mmio,
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 8b71e2d950..c951684148 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -129,7 +129,7 @@ static void xilinx_pcie_host_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &pex->mmio);
     sysbus_init_mmio(sbd, &s->mmio);
 
-    pci->bus = pci_register_bus(dev, s->name, xilinx_pcie_set_irq,
+    pci->bus = pci_register_bus(pci, s->name, xilinx_pcie_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->mmio,
                                 &s->io, 0, 4, TYPE_PCIE_BUS);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f4488b46fc..f60d0497ef 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -421,7 +421,7 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
     bus->irq_count = g_malloc0(nirq * sizeof(bus->irq_count[0]));
 }
 
-PCIBus *pci_register_bus(DeviceState *parent, const char *name,
+PCIBus *pci_register_bus(PCIHostState *phb, const char *name,
                          pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                          void *irq_opaque,
                          MemoryRegion *address_space_mem,
@@ -430,7 +430,7 @@ PCIBus *pci_register_bus(DeviceState *parent, const char *name,
 {
     PCIBus *bus;
 
-    bus = pci_bus_new(PCI_HOST_BRIDGE(parent), name, address_space_mem,
+    bus = pci_bus_new(phb, name, address_space_mem,
                       address_space_io, devfn_min, typename);
     pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
     return bus;
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index dc19682970..f755c6faae 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -314,7 +314,7 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
         sysbus_init_irq(dev, &s->irq[i]);
     }
 
-    b = pci_register_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
+    b = pci_register_bus(h, NULL, ppc4xx_pci_set_irq,
                          ppc4xx_pci_map_irq, s->irq, get_system_memory(),
                          get_system_io(), 0, 4, TYPE_PCI_BUS);
     h->bus = b;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e411f..0f293f9e75 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1697,7 +1697,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
 
-    bus = pci_register_bus(dev, NULL,
+    bus = pci_register_bus(phb, NULL,
                            pci_spapr_set_irq, pci_spapr_map_irq, sphb,
                            &sphb->memspace, &sphb->iospace,
                            PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69b0291e8a..99aae965bb 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -560,7 +560,7 @@ static int s390_pcihost_init(SysBusDevice *dev)
 
     DPRINTF("host_init\n");
 
-    b = pci_register_bus(DEVICE(dev), NULL,
+    b = pci_register_bus(phb, NULL,
                          s390_pci_set_irq, s390_pci_map_irq, NULL,
                          get_system_memory(), get_system_io(), 0, 64,
                          TYPE_PCI_BUS);
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 1747628f3d..bca849c10f 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -131,7 +131,7 @@ static int sh_pci_device_init(SysBusDevice *dev)
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(dev, &s->irq[i]);
     }
-    phb->bus = pci_register_bus(DEVICE(dev), "pci",
+    phb->bus = pci_register_bus(phb, "pci",
                                 sh_pci_set_irq, sh_pci_map_irq,
                                 s->irq,
                                 get_system_memory(),
-- 
2.11.0.259.g40922b1
