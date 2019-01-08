Received: from eggs.gnu.org ([209.51.188.92]:58781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09o-00070C-Hb
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09n-0007iS-75
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:57 +1100
Message-Id: <20190108224600.23125-27-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/29] spapr: move the qemu_irq array under the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The qemu_irq array is now allocated at the machine level using a sPAPR
IRQ set_irq handler depending on the chosen interrupt mode. The use of
this handler is slightly inefficient today but it will become necessary
when the 'dual' interrupt mode is introduced.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c             |  2 --
 hw/intc/xics_kvm.c         |  1 -
 hw/intc/xive.c             |  3 ---
 hw/ppc/spapr_irq.c         | 30 +++++++++++++++++++++++++++---
 include/hw/ppc/spapr.h     |  1 +
 include/hw/ppc/spapr_irq.h |  1 +
 include/hw/ppc/xics.h      |  1 -
 include/hw/ppc/xive.h      |  1 -
 8 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 0d65549e3d..16e8ffa2aa 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -571,8 +571,6 @@ static void ics_simple_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
-    ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
-
     qemu_register_reset(ics_simple_reset_handler, ics);
 }
=20
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index c469c85d53..ac94594b19 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -344,7 +344,6 @@ static void ics_kvm_realize(DeviceState *dev, Error *=
*errp)
         error_propagate(errp, local_err);
         return;
     }
-    ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs=
);
=20
     qemu_register_reset(ics_kvm_reset_handler, ics);
 }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c759960895..a3cb0cf0e3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -932,9 +932,6 @@ static void xive_source_realize(DeviceState *dev, Err=
or **errp)
                           &xive_source_esb_ops, xsrc, "xive.esb",
                           (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
=20
-    xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
-                                     xsrc->nr_irqs);
-
     qemu_register_reset(xive_source_reset, dev);
 }
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b875065ef8..d23914887a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -171,7 +171,7 @@ static qemu_irq spapr_qirq_xics(sPAPRMachineState *sp=
apr, int irq)
     uint32_t srcno =3D irq - ics->offset;
=20
     if (ics_valid_irq(ics, irq)) {
-        return ics->qirqs[srcno];
+        return spapr->qirqs[srcno];
     }
=20
     return NULL;
@@ -218,6 +218,18 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
+static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
+{
+    sPAPRMachineState *spapr =3D opaque;
+    MachineState *machine =3D MACHINE(opaque);
+
+    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+        ics_kvm_set_irq(spapr->ics, srcno, val);
+    } else {
+        ics_simple_set_irq(spapr->ics, srcno, val);
+    }
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -235,6 +247,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .set_irq     =3D spapr_irq_set_irq_xics,
 };
=20
 /*
@@ -295,7 +308,6 @@ static void spapr_irq_free_xive(sPAPRMachineState *sp=
apr, int irq, int num)
 static qemu_irq spapr_qirq_xive(sPAPRMachineState *spapr, int irq)
 {
     sPAPRXive *xive =3D spapr->xive;
-    XiveSource *xsrc =3D &xive->source;
=20
     if (irq >=3D xive->nr_irqs) {
         return NULL;
@@ -304,7 +316,7 @@ static qemu_irq spapr_qirq_xive(sPAPRMachineState *sp=
apr, int irq)
     /* The sPAPR machine/device should have claimed the IRQ before */
     assert(xive_eas_is_valid(&xive->eat[irq]));
=20
-    return xsrc->qirqs[irq];
+    return spapr->qirqs[irq];
 }
=20
 static void spapr_irq_print_info_xive(sPAPRMachineState *spapr,
@@ -359,6 +371,13 @@ static void spapr_irq_reset_xive(sPAPRMachineState *=
spapr, Error **errp)
     }
 }
=20
+static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
+{
+    sPAPRMachineState *spapr =3D opaque;
+
+    xive_source_set_irq(&spapr->xive->source, srcno, val);
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -381,6 +400,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
+    .set_irq     =3D spapr_irq_set_irq_xive,
 };
=20
 /*
@@ -394,6 +414,9 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error *=
*errp)
     }
=20
     spapr->irq->init(spapr, errp);
+
+    spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
+                                      spapr->irq->nr_irqs);
 }
=20
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
@@ -493,4 +516,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .set_irq     =3D spapr_irq_set_irq_xics,
 };
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fd24e91bd8..9e01a5a12e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -182,6 +182,7 @@ struct sPAPRMachineState {
     unsigned long *irq_map;
     sPAPRXive  *xive;
     sPAPRIrq *irq;
+    qemu_irq *qirqs;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index d03d4d7ce6..283bb5002c 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -46,6 +46,7 @@ typedef struct sPAPRIrq {
                             Error **errp);
     int (*post_load)(sPAPRMachineState *spapr, int version_id);
     void (*reset)(sPAPRMachineState *spapr, Error **errp);
+    void (*set_irq)(void *opaque, int srcno, int val);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 686db51149..7668c381a8 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -131,7 +131,6 @@ struct ICSState {
     /*< public >*/
     uint32_t nr_irqs;
     uint32_t offset;
-    qemu_irq *qirqs;
     ICSIRQState *irqs;
     XICSFabric *xics;
 };
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index c279dc73b9..ec23253ba4 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -184,7 +184,6 @@ typedef struct XiveSource {
=20
     /* IRQs */
     uint32_t        nr_irqs;
-    qemu_irq        *qirqs;
     unsigned long   *lsi_map;
=20
     /* PQ bits and LSI assertion bit */
--=20
2.20.1
