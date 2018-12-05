Received: from eggs.gnu.org ([2001:4830:134:3::10]:44486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgXL-0007BV-Ed
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgXH-0003eH-BQ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:59 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:50465)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgXG-0003cR-V1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:55 -0500
Received: from player714.ha.ovh.net (unknown [10.109.143.18])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3C1741E9A05
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:53 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:34 +0100
Message-Id: <20181205232251.10446-21-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 20/37] spapr: extend the sPAPR IRQ backend
 for XICS migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Introduce a new sPAPR IRQ handler to handle resend after migration
when the machine is using a KVM XICS interrupt controller model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  2 ++
 hw/ppc/spapr.c             | 13 +++++--------
 hw/ppc/spapr_irq.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 689176455e51..91ac5784919c 100644
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4dae32049d0a..8911465e32cf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1732,14 +1732,6 @@ static int spapr_post_load(void *opaque, int versi=
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
@@ -1760,6 +1752,11 @@ static int spapr_post_load(void *opaque, int versi=
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
index e16265f29d74..8943e28fc11b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -196,6 +196,18 @@ static Object *spapr_irq_cpu_intc_create_xics(sPAPRM=
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
@@ -211,6 +223,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
=20
 /*
@@ -313,6 +326,11 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
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
@@ -332,6 +350,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
+    .post_load   =3D spapr_irq_post_load_xive,
 };
=20
 /*
@@ -370,6 +389,13 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int ir=
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
@@ -438,4 +464,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
--=20
2.17.2
