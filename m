Received: from eggs.gnu.org ([2001:4830:134:3::10]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDeh-0001Q3-KT
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDed-0000bd-4X
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:47:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:46:01 +1100
Message-Id: <20181221054606.22007-36-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/40] spapr: extend the sPAPR IRQ backend for
 XICS migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Introduce a new sPAPR IRQ handler to handle resend after migration
when the machine is using a KVM XICS interrupt controller model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 13 +++++--------
 hw/ppc/spapr_irq.c         | 27 +++++++++++++++++++++++++++
 include/hw/ppc/spapr_irq.h |  2 ++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dfb617e580..0b09a88753 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1730,14 +1730,6 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         return err;
     }
=20
-    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
-        CPUState *cs;
-        CPU_FOREACH(cs) {
-            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-            icp_resend(ICP(cpu->intc));
-        }
-    }
-
     /* In earlier versions, there was no separate qdev for the PAPR
      * RTC, so the RTC offset was stored directly in sPAPREnvironment.
      * So when migrating from those versions, poke the incoming offset
@@ -1758,6 +1750,11 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         }
     }
=20
+    err =3D spapr_irq_post_load(spapr, version_id);
+    if (err) {
+        return err;
+    }
+
     return err;
 }
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index fdcc7795e4..292c448a15 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -197,6 +197,18 @@ static Object *spapr_irq_cpu_intc_create_xics(sPAPRM=
achineState *spapr,
     return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
 }
=20
+static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int versio=
n_id)
+{
+    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
+        CPUState *cs;
+        CPU_FOREACH(cs) {
+            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+            icp_resend(ICP(cpu->intc));
+        }
+    }
+    return 0;
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -212,6 +224,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
=20
 /*
@@ -295,6 +308,11 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
     return xive_tctx_create(cpu, XIVE_ROUTER(spapr->xive), errp);
 }
=20
+static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
+{
+    return 0;
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -314,6 +332,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
+    .post_load   =3D spapr_irq_post_load_xive,
 };
=20
 /*
@@ -352,6 +371,13 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int ir=
q)
     return smc->irq->qirq(spapr, irq);
 }
=20
+int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    return smc->irq->post_load(spapr, version_id);
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
@@ -420,4 +446,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 13db0428ab..84a25ffb6c 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -43,6 +43,7 @@ typedef struct sPAPRIrq {
                         void *fdt, uint32_t phandle);
     Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                                Error **errp);
+    int (*post_load)(sPAPRMachineState *spapr, int version_id);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
@@ -53,6 +54,7 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error **e=
rrp);
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
+int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
=20
 /*
  * XICS legacy routines
--=20
2.19.2
