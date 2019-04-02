Received: from eggs.gnu.org ([209.51.188.92]:36774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBCVO-0000z0-27
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBCVM-0004Kz-LE
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:02:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  2 Apr 2019 16:40:25 +1100
Message-Id: <20190402054028.20926-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190402054028.20926-1-david@gibson.dropbear.id.au>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC for-4.1 2/5] spapr_pci: Fix extended config space
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The PAPR PHB acts as a legacy PCI bus but it allows PCIe extended
config space accesses anyway (for pseries-2.9 and newer machine
types).

Introduce a specific PCI bus subtype to inform the common PCI code
about that.

Fixes: c2077e2ca0da7
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155414130834.574858.16502276132110219890.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b63ed9d8da..2e76d8cbd8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1638,6 +1638,28 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
     memory_region_del_subregion(get_system_memory(), &sphb->mem32window)=
;
 }
=20
+static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
+{
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
+
+    return sphb->pcie_ecs;
+}
+
+static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data=
)
+{
+    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
+
+    pbc->allows_extended_config_space =3D spapr_phb_allows_extended_conf=
ig_space;
+}
+
+#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+
+static const TypeInfo spapr_phb_root_bus_info =3D {
+    .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
+    .parent =3D TYPE_PCI_BUS,
+    .class_init =3D spapr_phb_root_bus_class_init,
+};
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
@@ -1742,7 +1764,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     bus =3D pci_register_root_bus(dev, NULL,
                                 pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
                                 &sphb->memspace, &sphb->iospace,
-                                PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_=
BUS);
+                                PCI_DEVFN(0, 0), PCI_NUM_PINS,
+                                TYPE_SPAPR_PHB_ROOT_BUS);
     phb->bus =3D bus;
     qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
=20
@@ -2325,6 +2348,7 @@ void spapr_pci_rtas_init(void)
 static void spapr_pci_register_types(void)
 {
     type_register_static(&spapr_phb_info);
+    type_register_static(&spapr_phb_root_bus_info);
 }
=20
 type_init(spapr_pci_register_types)
--=20
2.20.1
