Received: from eggs.gnu.org ([209.51.188.92]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEuEu-0007gC-EX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEuEq-0001HO-ST
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:20:58 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Apr 2019 21:20:44 +1000
Message-Id: <20190412112044.15361-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190412112044.15361-1-david@gibson.dropbear.id.au>
References: <20190412112044.15361-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] spapr_pci: Fix broken naming of PCI bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, mst@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, clg@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Recent commit 5cf0d326a0fe fixed a regression which was preventing the
guest to access the extended config space of a PCIe device. This was
done by introducing a new PCI bus subtype for PAPR. The original fix
was causing PCI busses to be named "spapr-pci-host-bridge-root-bus.N"
instead of "pci.N", which was making upper layers unhappy of course.
This got worked around by hardcoding the PCI bus name to "pci.0", but
this only works for the default PHB. And we're now hitting:

# qemu-system-ppc64 \
             -device spapr-pci-host-bridge,index=3D1 \
             -device e1000e,bus=3Dpci.0 \
             -device e1000e,bus=3Dpci.1
qemu-system-ppc64: -device e1000e,bus=3Dpci.1: Bus 'pci.1' not found

David already posted some patches [1] to control PCI extended config
space accesses with a new flag in the base PCI bus class instead of
subtyping. These patches are a bit more intrusive though, and
are targetted for 4.1.

When no name is passed to pci_register_bus(), the core device code
generates a lowercase name based on the QOM typename. The typename
for the base PCI bus class is "PCI", hence the "pci.0", "pci.1"
bus names. Rename the type of the PAPR PCI bus to "pci", so that
the QOM code can generate proper names. This is a hack but it is
enough to fix the regression. And all this will be reworked properly
in 4.1.

[1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D100486

Fixes: 5cf0d326a0fe
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155500034416.646888.1307366522340665522.stgit@bahia.lab.toul=
ouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f0b6b23afc..f62e6833b8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1652,7 +1652,7 @@ static void spapr_phb_root_bus_class_init(ObjectCla=
ss *klass, void *data)
     pbc->allows_extended_config_space =3D spapr_phb_allows_extended_conf=
ig_space;
 }
=20
-#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
=20
 static const TypeInfo spapr_phb_root_bus_info =3D {
     .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
@@ -1761,7 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
=20
-    bus =3D pci_register_root_bus(dev, "pci.0",
+    bus =3D pci_register_root_bus(dev, NULL,
                                 pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
--=20
2.20.1
