Received: from eggs.gnu.org ([2001:4830:134:3::10]:35618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIF-0001lv-2B
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIA-0004h8-6a
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:43 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:50765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSIA-0004gm-0r
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:38 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D808DAB1FE
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:29 +0200
Message-Id: <20170911171235.29331-16-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 15/21] spapr: modify
 spapr_populate_pci_dt() to use a 'nr_irqs' argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This adds some flexibility in the definition of the number of
available IRQS used in a sPAPR machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c              | 2 +-
 hw/ppc/spapr_pci.c          | 4 ++--
 include/hw/pci-host/spapr.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3e3ff1fbc988..5d69df928434 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1093,7 +1093,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     }
=20
     QLIST_FOREACH(phb, &spapr->phbs, list) {
-        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt);
+        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, XICS_IRQS_=
SPAPR);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d84abf1070a0..05b0a067458e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2073,7 +2073,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
=20
 int spapr_populate_pci_dt(sPAPRPHBState *phb,
                           uint32_t xics_phandle,
-                          void *fdt)
+                          void *fdt, int nr_irqs)
 {
     int bus_off, i, j, ret;
     char nodename[FDT_NAME_MAX];
@@ -2142,7 +2142,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
     _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1=
));
-    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_S=
PAPR));
+    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_irqs));
=20
     /* Dynamic DMA window */
     if (phb->ddw_enabled) {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 38470b2f0e5c..40146f72c103 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -115,7 +115,7 @@ PCIHostState *spapr_create_phb(sPAPRMachineState *spa=
pr, int index);
=20
 int spapr_populate_pci_dt(sPAPRPHBState *phb,
                           uint32_t xics_phandle,
-                          void *fdt);
+                          void *fdt, int nr_irqs);
=20
 void spapr_pci_rtas_init(void);
=20
--=20
2.13.5
