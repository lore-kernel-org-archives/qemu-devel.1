Received: from eggs.gnu.org ([2001:4830:134:3::10]:57496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzJyD-00026T-Oa
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzJy6-0001JI-UF
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:03:04 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:33935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzJy4-0001Eo-LX
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:02:58 -0400
Received: from player691.ha.ovh.net (unknown [10.109.159.7])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 531E315A2B5
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 13:02:53 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Sep 2018 13:02:22 +0200
Message-Id: <20180910110222.8162-4-clg@kaod.org>
In-Reply-To: <20180910110222.8162-1-clg@kaod.org>
References: <20180910110222.8162-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] spapr_pci: fix "ibm,pe-total-#msi" value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The "ibm,pe-total-#msi" property of the sPAPR PHB defines the number
of allocatable MSI interrupts. This is currently set to XICS_IRQS_SPAPR
which covers the full IRQ number space of the machine. This is wrong.

Fix the definition by using the 'nr_msis' attribute of the sPAPRIrq
class and remove XICS_IRQS_SPAPR which is now unused.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xics.h | 2 --
 hw/ppc/spapr_irq.c    | 2 +-
 hw/ppc/spapr_pci.c    | 5 +++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 9c2916c9b23a..9958443d1984 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -181,8 +181,6 @@ typedef struct XICSFabricClass {
     ICPState *(*icp_get)(XICSFabric *xi, int server);
 } XICSFabricClass;
=20
-#define XICS_IRQS_SPAPR               1024
-
 void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
=20
 ICPState *xics_icp_get(XICSFabric *xi, int server);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b14d7bce00ea..e77b94cc685e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -290,7 +290,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
 bool align, Error **errp)
     return first + ics->offset;
 }
=20
-#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     XICS_IRQS_SPAPR
+#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
=20
 sPAPRIrq spapr_irq_xics_legacy =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 6bcb4f419b6b..bb736177e76c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2121,6 +2121,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     sPAPRTCETable *tcet;
     PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
     sPAPRFDT s_fdt;
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machine(=
));
=20
     /* Start populating the FDT */
     nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2138,8 +2139,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
     _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
-    /* TODO: fine tune the total count of allocatable MSIs per PHB */
-    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_S=
PAPR));
+    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
+                          smc->irq->nr_msis));
=20
     /* Dynamic DMA window */
     if (phb->ddw_enabled) {
--=20
2.17.1
