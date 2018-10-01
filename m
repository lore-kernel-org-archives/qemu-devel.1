Received: from eggs.gnu.org ([2001:4830:134:3::10]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6wd7-0006bV-Ie
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6wd2-0004D8-0t
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:44:49 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:60968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6wd1-0004CI-Q8
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:44:43 -0400
Received: from player791.ha.ovh.net (unknown [10.109.146.76])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 64CD5CCBB6
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 13:44:42 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 13:44:21 +0200
Message-Id: <20181001114421.1377-3-clg@kaod.org>
In-Reply-To: <20181001114421.1377-1-clg@kaod.org>
References: <20181001114421.1377-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] ppc4xx_pci: convert SysBus init method to
 a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc4xx_pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index b7642bac016b..86981be71024 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -300,8 +300,9 @@ static const VMStateDescription vmstate_ppc4xx_pci =3D=
 {
 };
=20
 /* XXX Interrupt acknowledge cycles not supported. */
-static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
+static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
 {
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     PPC4xxPCIState *s;
     PCIHostState *h;
     PCIBus *b;
@@ -311,10 +312,10 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
     s =3D PPC4xx_PCI_HOST_BRIDGE(dev);
=20
     for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
+        sysbus_init_irq(sbd, &s->irq[i]);
     }
=20
-    b =3D pci_register_root_bus(DEVICE(dev), NULL, ppc4xx_pci_set_irq,
+    b =3D pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
                               ppc4xx_pci_map_irq, s->irq, get_system_mem=
ory(),
                               get_system_io(), 0, 4, TYPE_PCI_BUS);
     h->bus =3D b;
@@ -332,10 +333,8 @@ static int ppc4xx_pcihost_initfn(SysBusDevice *dev)
     memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_m=
em);
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_m=
em);
     memory_region_add_subregion(&s->container, PCI_REG_BASE, &s->iomem);
-    sysbus_init_mmio(dev, &s->container);
+    sysbus_init_mmio(sbd, &s->container);
     qemu_register_reset(ppc4xx_pci_reset, s);
-
-    return 0;
 }
=20
 static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data=
)
@@ -367,10 +366,9 @@ static const TypeInfo ppc4xx_host_bridge_info =3D {
=20
 static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    k->init =3D ppc4xx_pcihost_initfn;
+    dc->realize =3D ppc4xx_pcihost_realize;
     dc->vmsd =3D &vmstate_ppc4xx_pci;
 }
=20
--=20
2.17.1
