Received: from eggs.gnu.org ([2001:4830:134:3::10]:43242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF4-000587-4i
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjF2-0003aO-Vo
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:16:57 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:26 +1100
Message-Id: <20181108121646.26173-3-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/22] ppc440_pcix: convert SysBus init method
 to a realize method
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
 hw/ppc/ppc440_pcix.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 64ed07afa6..42ef76b6f5 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -466,17 +466,18 @@ const MemoryRegionOps ppc440_pcix_host_data_ops =3D=
 {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
-static int ppc440_pcix_initfn(SysBusDevice *dev)
+static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
 {
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     PPC440PCIXState *s;
     PCIHostState *h;
=20
     h =3D PCI_HOST_BRIDGE(dev);
     s =3D PPC440_PCIX_HOST_BRIDGE(dev);
=20
-    sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(sbd, &s->irq);
     memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64=
_MAX);
-    h->bus =3D pci_register_root_bus(DEVICE(dev), NULL, ppc440_pcix_set_=
irq,
+    h->bus =3D pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
                          ppc440_pcix_map_irq, &s->irq, &s->busmem,
                          get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_B=
US);
=20
@@ -497,17 +498,14 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
     memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_m=
em);
     memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_m=
em);
     memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iome=
m);
-    sysbus_init_mmio(dev, &s->container);
-
-    return 0;
+    sysbus_init_mmio(sbd, &s->container);
 }
=20
 static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    k->init =3D ppc440_pcix_initfn;
+    dc->realize =3D ppc440_pcix_realize;
     dc->reset =3D ppc440_pcix_reset;
 }
=20
--=20
2.19.1
