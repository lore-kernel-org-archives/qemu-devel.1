Received: from eggs.gnu.org ([2001:4830:134:3::10]:56770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRs-0000zl-Ef
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0bRo-0002ag-7m
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 18:18:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 18 Apr 2017 19:17:23 -0300
Message-Id: <20170418221724.5707-6-ehabkost@redhat.com>
In-Reply-To: <20170418221724.5707-1-ehabkost@redhat.com>
References: <20170418221724.5707-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 5/6] pci: Set phb->bus inside
 pci_host_bus_init_inplace()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

Every single caller of pci_host_bus_init*() sets phb->bus to point to
'bus'. Do that inside pci_bus_new_inplace() to avoid code duplication
and make it harder to break.

Generated using the following Coccinelle patch:

    @@
    identifier b;
    expression phb;
    expression list ARGS;
    @@
    -b =3D pci_host_bus_init(phb, ARGS);
    +pci_host_bus_init(phb, ARGS);
    +b =3D phb->bus;
     ...
    -phb->bus =3D b;

    @@
    expression phb;
    expression list ARGS;
    @@
    -phb->bus =3D pci_host_bus_init(phb, ARGS);
    +pci_host_bus_init(phb, ARGS);

    @@
    expression PHB, BUS;
    expression list ARGS;
    @@
     pci_host_bus_init_inplace(PHB, BUS, ARGS);
     ...
    -PHB->bus =3D BUS;

    @@
    typedef PCIHostState;
    typedef PCIBus;
    identifier phb, BUS;
    @@
     void pci_host_bus_init_inplace(PCIHostState *phb, PCIBus *BUS, ...)
     {
         ...
    +    phb->bus =3D BUS;
     }

    @@
    identifier b;
    expression phb;
    expression list ARGS;
    @@
    -b =3D pci_host_bus_init_irqs(phb, ARGS);
    +pci_host_bus_init_irqs(phb, ARGS);
    +b =3D phb->bus;
     ...
    -phb->bus =3D b;

    @@
    expression phb;
    expression list ARGS;
    @@
    -phb->bus =3D pci_host_bus_init_irqs(phb, ARGS);
    +pci_host_bus_init_irqs(phb, ARGS);

Cc: Alexander Graf <agraf@suse.de>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-arm@nongnu.org
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/alpha/typhoon.c                  |  8 ++++----
 hw/mips/gt64xxx_pci.c               |  8 +++-----
 hw/pci-bridge/pci_expander_bridge.c | 12 ++++++------
 hw/pci-host/apb.c                   |  6 ++----
 hw/pci-host/bonito.c                |  7 +++----
 hw/pci-host/gpex.c                  |  7 +++----
 hw/pci-host/grackle.c               |  7 +++----
 hw/pci-host/piix.c                  |  6 +++---
 hw/pci-host/ppce500.c               |  9 ++++-----
 hw/pci-host/prep.c                  |  2 --
 hw/pci-host/q35.c                   |  5 ++---
 hw/pci-host/uninorth.c              | 14 ++++++--------
 hw/pci-host/versatile.c             |  1 -
 hw/pci-host/xilinx-pcie.c           |  7 +++----
 hw/pci/pci.c                        |  2 +-
 hw/ppc/ppc4xx_pci.c                 |  9 ++++-----
 hw/ppc/spapr_pci.c                  |  9 ++++-----
 hw/s390x/s390-pci-bus.c             |  9 ++++-----
 hw/sh4/sh_pci.c                     |  7 +++----
 19 files changed, 58 insertions(+), 77 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 24f1959ab8..a35fac5381 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -883,10 +883,10 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **=
isa_bus,
     memory_region_add_subregion(addr_space, 0x801fc000000ULL,
                                 &s->pchip.reg_io);
=20
-    b =3D pci_host_bus_init_irqs(phb, "pci", typhoon_set_irq,
-                               sys_map_irq, s, &s->pchip.reg_mem,
-                               &s->pchip.reg_io, 0, 64, TYPE_PCI_BUS);
-    phb->bus =3D b;
+    pci_host_bus_init_irqs(phb, "pci", typhoon_set_irq, sys_map_irq, s,
+                           &s->pchip.reg_mem, &s->pchip.reg_io, 0, 64,
+                           TYPE_PCI_BUS);
+    b =3D phb->bus;
     qdev_init_nofail(dev);
=20
     /* Host memory as seen from the PCI side, via the IOMMU.  */
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5ca9f07031..428d5e2dd9 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1171,11 +1171,9 @@ PCIBus *gt64120_register(qemu_irq *pic)
     phb =3D PCI_HOST_BRIDGE(dev);
     memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", UINT32_MAX=
);
     address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
-    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
-                                      gt64120_pci_set_irq,
-                                      gt64120_pci_map_irq, pic, &d->pci0=
_mem,
-                                      get_system_io(), PCI_DEVFN(18, 0),=
 4,
-                                      TYPE_PCI_BUS);
+    pci_host_bus_init_irqs(phb, "pci", gt64120_pci_set_irq,
+                           gt64120_pci_map_irq, pic, &d->pci0_mem,
+                           get_system_io(), PCI_DEVFN(18, 0), 4, TYPE_PC=
I_BUS);
     qdev_init_nofail(dev);
     memory_region_init_io(&d->ISD_mem, OBJECT(dev), &isd_mem_ops, d, "is=
d-mem", 0x1000);
=20
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
index 853448ef70..e88b0aa682 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -230,11 +230,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, =
bool pcie, Error **errp)
=20
     ds =3D qdev_create(NULL, TYPE_PXB_HOST);
     if (pcie) {
-        bus =3D pci_host_bus_init(PCI_HOST_BRIDGE(ds), dev_name, NULL, N=
ULL, 0,
-                                TYPE_PXB_PCIE_BUS);
+        pci_host_bus_init(PCI_HOST_BRIDGE(ds), dev_name, NULL, NULL, 0,
+                          TYPE_PXB_PCIE_BUS);
+        bus =3D PCI_HOST_BRIDGE(ds)->bus;
     } else {
-        bus =3D pci_host_bus_init(PCI_HOST_BRIDGE(ds), "pxb-internal", N=
ULL,
-                                NULL, 0, TYPE_PXB_BUS);
+        pci_host_bus_init(PCI_HOST_BRIDGE(ds), "pxb-internal", NULL, NUL=
L, 0,
+                          TYPE_PXB_BUS);
+        bus =3D PCI_HOST_BRIDGE(ds)->bus;
         bds =3D qdev_create(BUS(bus), "pci-bridge");
         bds->id =3D dev_name;
         qdev_prop_set_uint8(bds, PCI_BRIDGE_DEV_PROP_CHASSIS_NR, pxb->bu=
s_nr);
@@ -246,8 +248,6 @@ static void pxb_dev_realize_common(PCIDevice *dev, bo=
ol pcie, Error **errp)
     bus->address_space_io =3D dev->bus->address_space_io;
     bus->map_irq =3D pxb_map_irq_fn;
=20
-    PCI_HOST_BRIDGE(ds)->bus =3D bus;
-
     pxb_register_bus(dev, bus, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 38d08c661c..ebcb93d9ac 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -671,10 +671,8 @@ PCIBus *pci_apb_init(hwaddr special_base,
     dev =3D qdev_create(NULL, TYPE_APB);
     d =3D APB_DEVICE(dev);
     phb =3D PCI_HOST_BRIDGE(dev);
-    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
-                                      pci_apb_set_irq, pci_pbm_map_irq, =
d,
-                                      &d->pci_mmio, get_system_io(), 0, =
32,
-                                      TYPE_PCI_BUS);
+    pci_host_bus_init_irqs(phb, "pci", pci_apb_set_irq, pci_pbm_map_irq,=
 d,
+                           &d->pci_mmio, get_system_io(), 0, 32, TYPE_PC=
I_BUS);
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     /* apb_config */
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 8b6e80aa82..ff3db73900 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -714,10 +714,9 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
 {
     PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
=20
-    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
-                                      pci_bonito_set_irq, pci_bonito_map=
_irq,
-                                      dev, get_system_memory(),
-                                      get_system_io(), 0x28, 32, TYPE_PC=
I_BUS);
+    pci_host_bus_init_irqs(phb, "pci", pci_bonito_set_irq, pci_bonito_ma=
p_irq,
+                           dev, get_system_memory(), get_system_io(), 0x=
28,
+                           32, TYPE_PCI_BUS);
=20
     return 0;
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 9ea9927cf8..9e5d2e2dc4 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -62,10 +62,9 @@ static void gpex_host_realize(DeviceState *dev, Error =
**errp)
         sysbus_init_irq(sbd, &s->irq[i]);
     }
=20
-    pci->bus =3D pci_host_bus_init_irqs(pci, "pcie.0",
-                                      gpex_set_irq, pci_swizzle_map_irq_=
fn, s,
-                                      &s->io_mmio, &s->io_ioport, 0, 4,
-                                      TYPE_PCIE_BUS);
+    pci_host_bus_init_irqs(pci, "pcie.0", gpex_set_irq,
+                           pci_swizzle_map_irq_fn, s, &s->io_mmio,
+                           &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
=20
     qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
     qdev_init_nofail(DEVICE(&s->gpex_root));
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 0844c30d9a..b3126852de 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -82,10 +82,9 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
=20
-    phb->bus =3D pci_host_bus_init_irqs(phb, NULL,
-                                      pci_grackle_set_irq,
-                                      pci_grackle_map_irq, pic, &d->pci_=
mmio,
-                                      address_space_io, 0, 4, TYPE_PCI_B=
US);
+    pci_host_bus_init_irqs(phb, NULL, pci_grackle_set_irq,
+                           pci_grackle_map_irq, pic, &d->pci_mmio,
+                           address_space_io, 0, 4, TYPE_PCI_BUS);
=20
     pci_create_simple(phb->bus, 0, "grackle");
     qdev_init_nofail(dev);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 364d57039b..ec5a39706e 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -340,9 +340,9 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
=20
     dev =3D qdev_create(NULL, host_type);
     s =3D PCI_HOST_BRIDGE(dev);
-    b =3D pci_host_bus_init(s, NULL, pci_address_space,
-                          address_space_io, 0, TYPE_PCI_BUS);
-    s->bus =3D b;
+    pci_host_bus_init(s, NULL, pci_address_space, address_space_io, 0,
+                      TYPE_PCI_BUS);
+    b =3D s->bus;
     object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev),=
 NULL);
     qdev_init_nofail(dev);
=20
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index babb12af31..d7091709d2 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -465,11 +465,10 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     /* PIO lives at the bottom of our bus space */
     memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
=20
-    b =3D pci_host_bus_init_irqs(h, NULL,
-                               mpc85xx_pci_set_irq, mpc85xx_pci_map_irq,=
 s,
-                               &s->busmem, &s->pio,
-                               PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_=
BUS);
-    h->bus =3D b;
+    pci_host_bus_init_irqs(h, NULL, mpc85xx_pci_set_irq, mpc85xx_pci_map=
_irq,
+                           s, &s->busmem, &s->pio,
+                           PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_BUS)=
;
+    b =3D h->bus;
=20
     /* Set up PCI view of memory */
     memory_region_init(&s->bm, OBJECT(s), "bm-e500", UINT64_MAX);
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 65add936c7..da151fc051 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -285,8 +285,6 @@ static void raven_pcihost_initfn(Object *obj)
     address_space_init(&s->bm_as, &s->bm, "raven-bm");
     pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, s);
=20
-    h->bus =3D &s->pci_bus;
-
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DE=
VICE);
     pci_dev =3D DEVICE(&s->pci_dev);
     qdev_set_parent_bus(pci_dev, BUS(&s->pci_bus));
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 4258076979..c285d2caca 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -49,9 +49,8 @@ static void q35_host_realize(DeviceState *dev, Error **=
errp)
     sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
=20
-    pci->bus =3D pci_host_bus_init(pci, "pcie.0",
-                                 s->mch.pci_address_space,
-                                 s->mch.address_space_io, 0, TYPE_PCIE_B=
US);
+    pci_host_bus_init(pci, "pcie.0", s->mch.pci_address_space,
+                      s->mch.address_space_io, 0, TYPE_PCIE_BUS);
     PC_MACHINE(qdev_get_machine())->bus =3D pci->bus;
     qdev_set_parent_bus(DEVICE(&s->mch), BUS(pci->bus));
     qdev_init_nofail(DEVICE(&s->mch));
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index d9fb5fdc93..febabeaec7 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -233,10 +233,9 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
=20
-    h->bus =3D pci_host_bus_init_irqs(h, NULL,
-                                    pci_unin_set_irq, pci_unin_map_irq, =
pic,
-                                    &d->pci_mmio, address_space_io,
-                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+    pci_host_bus_init_irqs(h, NULL, pci_unin_set_irq, pci_unin_map_irq, =
pic,
+                           &d->pci_mmio, address_space_io, PCI_DEVFN(11,=
 0),
+                           4, TYPE_PCI_BUS);
=20
 #if 0
     pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north");
@@ -297,10 +296,9 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
                                 &d->pci_hole);
=20
-    h->bus =3D pci_host_bus_init_irqs(h, NULL,
-                                    pci_unin_set_irq, pci_unin_map_irq, =
pic,
-                                    &d->pci_mmio, address_space_io,
-                                    PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
+    pci_host_bus_init_irqs(h, NULL, pci_unin_set_irq, pci_unin_map_irq, =
pic,
+                           &d->pci_mmio, address_space_io, PCI_DEVFN(11,=
 0),
+                           4, TYPE_PCI_BUS);
=20
     sysbus_mmio_map(s, 0, 0xf0800000);
     sysbus_mmio_map(s, 1, 0xf0c00000);
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index cad8848723..caf7f6407a 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -390,7 +390,6 @@ static void pci_vpb_init(Object *obj)
                               sizeof(s->pci_bus), "pci", &s->pci_mem_spa=
ce,
                               &s->pci_io_space, PCI_DEVFN(11, 0),
                               TYPE_PCI_BUS);
-    h->bus =3D &s->pci_bus;
=20
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PC=
I_HOST);
     qdev_set_parent_bus(DEVICE(&s->pci_dev), BUS(&s->pci_bus));
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 0a3d19b22c..f988c7e58e 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -129,10 +129,9 @@ static void xilinx_pcie_host_realize(DeviceState *de=
v, Error **errp)
     sysbus_init_mmio(sbd, &pex->mmio);
     sysbus_init_mmio(sbd, &s->mmio);
=20
-    pci->bus =3D pci_host_bus_init_irqs(pci, s->name,
-                                      xilinx_pcie_set_irq,
-                                      pci_swizzle_map_irq_fn, s, &s->mmi=
o,
-                                      &s->io, 0, 4, TYPE_PCIE_BUS);
+    pci_host_bus_init_irqs(pci, s->name, xilinx_pcie_set_irq,
+                           pci_swizzle_map_irq_fn, s, &s->mmio, &s->io, =
0, 4,
+                           TYPE_PCIE_BUS);
=20
     qdev_set_parent_bus(DEVICE(&s->root), BUS(pci->bus));
     qdev_init_nofail(DEVICE(&s->root));
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 37d65eaf7e..dd065a0881 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -384,7 +384,7 @@ void pci_host_bus_init_inplace(PCIHostState *phb, PCI=
Bus *bus,
     QLIST_INIT(&bus->child);
=20
     QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
-
+    phb->bus =3D bus;
 }
=20
 PCIBus *pci_host_bus_init(PCIHostState *phb, const char *name,
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 0d767a1a23..992be1bce9 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -314,11 +314,10 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
         sysbus_init_irq(dev, &s->irq[i]);
     }
=20
-    b =3D pci_host_bus_init_irqs(h, NULL,
-                               ppc4xx_pci_set_irq, ppc4xx_pci_map_irq, s=
->irq,
-                               get_system_memory(), get_system_io(), 0, =
4,
-                               TYPE_PCI_BUS);
-    h->bus =3D b;
+    pci_host_bus_init_irqs(h, NULL, ppc4xx_pci_set_irq, ppc4xx_pci_map_i=
rq,
+                           s->irq, get_system_memory(), get_system_io(),=
 0, 4,
+                           TYPE_PCI_BUS);
+    b =3D h->bus;
=20
     pci_create_simple(b, 0, "ppc4xx-host-bridge");
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ce132c5eea..06e8a8740b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1697,11 +1697,10 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
=20
-    bus =3D pci_host_bus_init_irqs(phb, NULL,
-                                 pci_spapr_set_irq, pci_spapr_map_irq, s=
phb,
-                                 &sphb->memspace, &sphb->iospace,
-                                 PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI=
_BUS);
-    phb->bus =3D bus;
+    pci_host_bus_init_irqs(phb, NULL, pci_spapr_set_irq, pci_spapr_map_i=
rq,
+                           sphb, &sphb->memspace, &sphb->iospace,
+                           PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
+    bus =3D phb->bus;
     qbus_set_hotplug_handler(BUS(phb->bus), DEVICE(sphb), NULL);
=20
     /*
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 267e1de510..5e174e90f4 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -560,15 +560,14 @@ static int s390_pcihost_init(SysBusDevice *dev)
=20
     DPRINTF("host_init\n");
=20
-    b =3D pci_host_bus_init_irqs(phb, NULL,
-                               s390_pci_set_irq, s390_pci_map_irq, NULL,
-                               get_system_memory(), get_system_io(), 0, =
64,
-                               TYPE_PCI_BUS);
+    pci_host_bus_init_irqs(phb, NULL, s390_pci_set_irq, s390_pci_map_irq=
,
+                           NULL, get_system_memory(), get_system_io(), 0=
, 64,
+                           TYPE_PCI_BUS);
+    b =3D phb->bus;
     pci_setup_iommu(b, s390_pci_dma_iommu, s);
=20
     bus =3D BUS(b);
     qbus_set_hotplug_handler(bus, DEVICE(dev), NULL);
-    phb->bus =3D b;
=20
     s->bus =3D S390_PCI_BUS(qbus_create(TYPE_S390_PCI_BUS, DEVICE(s), NU=
LL));
     qbus_set_hotplug_handler(BUS(s->bus), DEVICE(s), NULL);
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 8be2e830e9..5745738fb9 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -131,10 +131,9 @@ static int sh_pci_device_init(SysBusDevice *dev)
     for (i =3D 0; i < 4; i++) {
         sysbus_init_irq(dev, &s->irq[i]);
     }
-    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
-                                      sh_pci_set_irq, sh_pci_map_irq, s-=
>irq,
-                                      get_system_memory(), get_system_io=
(),
-                                      PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
+    pci_host_bus_init_irqs(phb, "pci", sh_pci_set_irq, sh_pci_map_irq, s=
->irq,
+                           get_system_memory(), get_system_io(),
+                           PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
     memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, =
s,
                           "sh_pci", 0x224);
     memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
--=20
2.11.0.259.g40922b1
