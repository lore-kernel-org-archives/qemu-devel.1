Received: from eggs.gnu.org ([2001:4830:134:3::10]:42314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHw-0000ww-IV
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHs-0001b9-Kz
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:52 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:49257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkHs-0001am-Ez
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:48 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6D55149B99
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:43:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:43 +0200
Message-Id: <1491396106-26376-19-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/21] pci: Use the new pci_can_add_device() to
 enforce devfn_min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This adds a devfn_max field to PCIBus and adds a pci_can_add_device()
function which, if no "addr" (aka devfn) is specified, will tell whether
there is any slot free between devfn_min and devfn_max.

When devfn_max is 0 (default), it will be ignored (no constraints).

This will be used by some PCI root complex implementations that support
only one direct child to avoid having qemu put dumb devices at different
slot numbers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: updated for qemu-2.9 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/pci/pci.c             | 22 ++++++++++++++++++++++
 include/hw/pci/pci_bus.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b1c01a..817ad14ed987 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -143,6 +143,27 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
=20
+static bool pci_can_add_device(BusState *bus, QemuOpts *opts)
+{
+    unsigned int devfn, max;
+    PCIBus *pbus =3D PCI_BUS(bus);
+
+    /* If address is specified, say yes and let it fail if that doesn't =
work */
+    if (qemu_opt_get(opts, "addr") !=3D NULL) {
+        return true;
+    }
+    max =3D ARRAY_SIZE(pbus->devices);
+    if (pbus->devfn_max && pbus->devfn_max < max) {
+        max =3D pbus->devfn_max;
+    }
+    for (devfn =3D pbus->devfn_min ; devfn < max; devfn +=3D PCI_FUNC_MA=
X) {
+        if (!pbus->devices[devfn]) {
+            break;
+        }
+    }
+    return devfn < max;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k =3D BUS_CLASS(klass);
@@ -154,6 +175,7 @@ static void pci_bus_class_init(ObjectClass *klass, vo=
id *data)
     k->realize =3D pci_bus_realize;
     k->unrealize =3D pci_bus_unrealize;
     k->reset =3D pcibus_reset;
+    k->can_add_device =3D pci_can_add_device;
=20
     pbc->is_root =3D pcibus_is_root;
     pbc->bus_num =3D pcibus_num;
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 5484a9b5c573..05c9dd22a8fa 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -23,6 +23,7 @@ struct PCIBus {
     PCIIOMMUFunc iommu_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
+    uint8_t devfn_max;
     pci_set_irq_fn set_irq;
     pci_map_irq_fn map_irq;
     pci_route_irq_fn route_intx_to_irq;
--=20
2.7.4
