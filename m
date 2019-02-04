Received: from eggs.gnu.org ([209.51.188.92]:38145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8O-0000OB-I4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8L-0007B1-Us
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:01:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:01 +1100
Message-Id: <20190204090124.26191-15-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/37] spapr/pci: Fix primary bus number for PCI
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: David Hildenbrand <david@redhat.com>

While looking at the s390x implementation, looks like spapr has a
similar BUG when building the topology.

The primary bus number corresponds always to the bus number of the
bus the bridge is attached to.

Right now, if we have two bridges attached to the same bus (e.g. root
bus) this is however not the case. The first bridge will have primary
bus 0, the second bridge primary bus 1, which is wrong. Fix the assignmen=
t.

While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
Setting it temporarily to that value (as discussed e.g. in [1]), is
only relevant for a running system that probes the buses. The value is
effectively unused for us just doing a DFS.

[1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b74f2632ec..5cdc98513d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2030,8 +2030,6 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *=
bus, PCIDevice *pdev,
                                            void *opaque)
 {
     unsigned int *bus_no =3D opaque;
-    unsigned int primary =3D *bus_no;
-    unsigned int subordinate =3D 0xff;
     PCIBus *sec_bus =3D NULL;
=20
     if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
@@ -2040,7 +2038,7 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *=
bus, PCIDevice *pdev,
     }
=20
     (*bus_no)++;
-    pci_default_write_config(pdev, PCI_PRIMARY_BUS, primary, 1);
+    pci_default_write_config(pdev, PCI_PRIMARY_BUS, pci_dev_bus_num(pdev=
), 1);
     pci_default_write_config(pdev, PCI_SECONDARY_BUS, *bus_no, 1);
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
=20
@@ -2049,7 +2047,6 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *=
bus, PCIDevice *pdev,
         return;
     }
=20
-    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, subordinate, 1);
     pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
                         spapr_phb_pci_enumerate_bridge, bus_no);
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
--=20
2.20.1
