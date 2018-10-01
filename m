Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6zkN-0006WO-MB
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6zkJ-0000sf-7V
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:04:31 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:56167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6zkH-0000rj-It
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:04:26 -0400
Received: from player750.ha.ovh.net (unknown [10.109.143.183])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D5D83FC981
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 17:04:23 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 17:04:13 +0200
Message-Id: <20181001150413.12955-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] PPC: e500: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/pci-host/ppce500.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index eb75e080fc10..b8f8c112e662 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -436,8 +436,9 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus *b=
us, void *opaque,
     return &s->bm_as;
 }
=20
-static int e500_pcihost_initfn(SysBusDevice *dev)
+static void e500_pcihost_realize(DeviceState *dev, Error **errp)
 {
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     PCIHostState *h;
     PPCE500PCIState *s;
     PCIBus *b;
@@ -447,7 +448,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     s =3D PPC_E500_PCI_HOST_BRIDGE(dev);
=20
     for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_init_irq(sbd, &s->irq[i]);
     }
=20
     for (i =3D 0; i < PCI_NUM_PINS; i++) {
@@ -460,7 +461,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     /* PIO lives at the bottom of our bus space */
     memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
=20
-    b =3D pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
+    b =3D pci_register_root_bus(dev, NULL, mpc85xx_pci_set_irq,
                               mpc85xx_pci_map_irq, s, &s->busmem, &s->pi=
o,
                               PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_B=
US);
     h->bus =3D b;
@@ -483,10 +484,8 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
     memory_region_add_subregion(&s->container, PCIE500_CFGADDR, &h->conf=
_mem);
     memory_region_add_subregion(&s->container, PCIE500_CFGDATA, &h->data=
_mem);
     memory_region_add_subregion(&s->container, PCIE500_REG_BASE, &s->iom=
em);
-    sysbus_init_mmio(dev, &s->container);
+    sysbus_init_mmio(sbd, &s->container);
     pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
-
-    return 0;
 }
=20
 static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
@@ -526,9 +525,8 @@ static Property pcihost_properties[] =3D {
 static void e500_pcihost_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
=20
-    k->init =3D e500_pcihost_initfn;
+    dc->realize =3D e500_pcihost_realize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->props =3D pcihost_properties;
     dc->vmsd =3D &vmstate_ppce500_pci;
--=20
2.17.1
