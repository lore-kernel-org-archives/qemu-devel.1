Received: from eggs.gnu.org ([209.51.188.92]:58010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08v-000638-6J
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08s-0006kE-OA
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:40 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:47 +1100
Message-Id: <20190108224600.23125-17-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/29] spapr: move spapr_create_phb() to core
 machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This function is only used when creating the default PHB. Let's rename
it and move it to the core machine code for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 13 ++++++++++++-
 hw/ppc/spapr_pci.c          | 11 -----------
 include/hw/pci-host/spapr.h |  2 --
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7e61f1e5ff..f621032d40 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2552,6 +2552,17 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
     }
 }
=20
+static PCIHostState *spapr_create_default_phb(void)
+{
+    DeviceState *dev;
+
+    dev =3D qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
+    qdev_prop_set_uint32(dev, "index", 0);
+    qdev_init_nofail(dev);
+
+    return PCI_HOST_BRIDGE(dev);
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
@@ -2784,7 +2795,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     /* Set up PCI */
     spapr_pci_rtas_init();
=20
-    phb =3D spapr_create_phb(spapr, 0);
+    phb =3D spapr_create_default_phb();
=20
     for (i =3D 0; i < nb_nics; i++) {
         NICInfo *nd =3D &nd_table[i];
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bfb02ee96b..b74f2632ec 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1988,17 +1988,6 @@ static const TypeInfo spapr_phb_info =3D {
     }
 };
=20
-PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index)
-{
-    DeviceState *dev;
-
-    dev =3D qdev_create(NULL, TYPE_SPAPR_PCI_HOST_BRIDGE);
-    qdev_prop_set_uint32(dev, "index", index);
-    qdev_init_nofail(dev);
-
-    return PCI_HOST_BRIDGE(dev);
-}
-
 typedef struct sPAPRFDT {
     void *fdt;
     int node_off;
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 7c66c3872f..a65cfef169 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -111,8 +111,6 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
     return spapr_qirq(spapr, phb->lsi_table[pin].irq);
 }
=20
-PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
-
 int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
                           uint32_t nr_msis);
=20
--=20
2.20.1
