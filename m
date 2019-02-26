Received: from eggs.gnu.org ([209.51.188.92]:58644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmI-0006PH-US
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmD-0003l9-8E
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:55 +1100
Message-Id: <20190226045304.25618-42-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 41/50] spapr_pci: provide node start offset via
 spapr_populate_pci_dt()
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

PHB hotplug re-uses PHB device tree generation code and passes
it to a guest via RTAS. Doing this requires knowledge of where
exactly in the device tree the node describing the PHB begins.

Provide this via a new optional pointer that can be used to
store the PHB node's start offset.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059671912.1466090.10891589403973703473.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 2 +-
 hw/ppc/spapr_pci.c          | 5 ++++-
 include/hw/pci-host/spapr.h | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fcda177090..76b3c15d59 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1312,7 +1312,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr)
=20
     QLIST_FOREACH(phb, &spapr->phbs, list) {
         ret =3D spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
-                                    spapr->irq->nr_msis);
+                                    spapr->irq->nr_msis, NULL);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
             exit(1);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ede928b0bf..a0e1769439 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2153,7 +2153,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
 }
=20
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
-                          uint32_t nr_msis)
+                          uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
     gchar *nodename;
@@ -2208,6 +2208,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t intc_phandle, void *fdt,
     nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
     _FDT(bus_off =3D fdt_add_subnode(fdt, 0, nodename));
     g_free(nodename);
+    if (node_offset) {
+        *node_offset =3D bus_off;
+    }
=20
     /* Write PHB properties */
     _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 4b0443f4cf..ab0e3a0a6f 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -113,7 +113,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
 }
=20
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
-                          uint32_t nr_msis);
+                          uint32_t nr_msis, int *node_offset);
=20
 void spapr_pci_rtas_init(void);
=20
--=20
2.20.1
