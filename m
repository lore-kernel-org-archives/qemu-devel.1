Received: from eggs.gnu.org ([209.51.188.92]:58341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlQ-0005Zw-B6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlP-00030h-MH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:56 +1100
Message-Id: <20190226045304.25618-43-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 42/50] spapr_pci: add ibm,
 my-drc-index property for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This is needed to denote a boot-time PHB as being hot-pluggable.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059672420.1466090.15147504040270659866.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index a0e1769439..03fc26985a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2203,6 +2203,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t intc_phandle, void *fdt,
     sPAPRTCETable *tcet;
     PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
     sPAPRFDT s_fdt;
+    sPAPRDRConnector *drc;
=20
     /* Start populating the FDT */
     nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2269,6 +2270,14 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint=
32_t intc_phandle, void *fdt,
                  tcet->liobn, tcet->bus_offset,
                  tcet->nb_table << tcet->page_shift);
=20
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, phb->index);
+    if (drc) {
+        uint32_t drc_index =3D cpu_to_be32(spapr_drc_index(drc));
+
+        _FDT(fdt_setprop(fdt, bus_off, "ibm,my-drc-index", &drc_index,
+                         sizeof(drc_index)));
+    }
+
     /* Walk the bridges and program the bus numbers*/
     spapr_phb_pci_enumerate(phb);
     _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
--=20
2.20.1
