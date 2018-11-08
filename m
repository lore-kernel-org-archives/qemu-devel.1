Received: from eggs.gnu.org ([2001:4830:134:3::10]:43286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF8-00058r-U4
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF2-0003aA-Ui
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:27 +1100
Message-Id: <20181108121646.26173-4-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/22] ppc4xx_pci: convert SysBus init method to
 a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc4xx_pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index b7642bac01..86981be710 100644
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
2.19.1
