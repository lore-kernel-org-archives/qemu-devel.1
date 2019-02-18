Received: from eggs.gnu.org ([209.51.188.92]:38642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjws-0005XD-6J
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwk-0002aM-Q9
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:08 +1100
Message-Id: <20190218143049.17142-3-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/43] spapr: Rename xics to intc in interrupt
 controller agnostic code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

All this code is used with both the XICS and XIVE interrupt controllers.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              | 6 +++---
 hw/ppc/spapr_events.c       | 2 +-
 hw/ppc/spapr_pci.c          | 6 +++---
 hw/ppc/spapr_vio.c          | 2 +-
 include/hw/pci-host/spapr.h | 2 +-
 include/hw/ppc/spapr.h      | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 332cba89d4..850cfe28c4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,7 +96,7 @@
=20
 #define MIN_RMA_SLOF            128UL
=20
-#define PHANDLE_XICP            0x00001111
+#define PHANDLE_INTC            0x00001111
=20
 /* These two functions implement the VCPU id numbering: one to compute t=
hem
  * all and one to identify thread 0 of a VCORE. Any change to the first =
one
@@ -1274,7 +1274,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr)
=20
     /* /interrupt controller */
     spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
-                          PHANDLE_XICP);
+                          PHANDLE_INTC);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -1294,7 +1294,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr)
     }
=20
     QLIST_FOREACH(phb, &spapr->phbs, list) {
-        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
+        ret =3D spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
                                     spapr->irq->nr_msis);
         if (ret < 0) {
             error_report("couldn't setup PCI devices in fdt");
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 32719a1b72..b9c7ecb9e9 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -282,7 +282,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
             continue;
         }
=20
-        spapr_dt_xics_irq(interrupts, source->irq, false);
+        spapr_dt_irq(interrupts, source->irq, false);
=20
         _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, source_=
name));
         _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c99721cde8..41d81f4a85 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2063,7 +2063,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
=20
 }
=20
-int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
+int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
                           uint32_t nr_msis)
 {
     int bus_off, i, j, ret;
@@ -2161,8 +2161,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t xics_phandle, void *fdt,
             irqmap[1] =3D 0;
             irqmap[2] =3D 0;
             irqmap[3] =3D cpu_to_be32(j+1);
-            irqmap[4] =3D cpu_to_be32(xics_phandle);
-            spapr_dt_xics_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, t=
rue);
+            irqmap[4] =3D cpu_to_be32(intc_phandle);
+            spapr_dt_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, true);
         }
     }
     /* Write interrupt map */
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 414673d313..2b7e7ecac5 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -126,7 +126,7 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
     if (dev->irq) {
         uint32_t ints_prop[2];
=20
-        spapr_dt_xics_irq(ints_prop, dev->irq, false);
+        spapr_dt_irq(ints_prop, dev->irq, false);
         ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
                           sizeof(ints_prop));
         if (ret < 0) {
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index a5a7bf4837..51d81c4b7c 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -112,7 +112,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
     return spapr_qirq(spapr, phb->lsi_table[pin].irq);
 }
=20
-int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
+int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
                           uint32_t nr_msis);
=20
 void spapr_pci_rtas_init(void);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a947a0a0dc..cbd276ed2b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -683,7 +683,7 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *=
fdt, hwaddr addr);
  * "interrupt-controller" node has its "#interrupt-cells" property set t=
o 2 (ie,
  * VIO devices, RTAS event sources and PHBs).
  */
-static inline void spapr_dt_xics_irq(uint32_t *intspec, int irq, bool is=
_lsi)
+static inline void spapr_dt_irq(uint32_t *intspec, int irq, bool is_lsi)
 {
     intspec[0] =3D cpu_to_be32(irq);
     intspec[1] =3D is_lsi ? cpu_to_be32(1) : 0;
--=20
2.20.1
