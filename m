Received: from eggs.gnu.org ([2001:4830:134:3::10]:36517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW53A-00025p-24
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW535-0006QG-AQ
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:35 -0500
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:54962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gW533-0005zA-Ln
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:47:30 -0500
Received: from player695.ha.ovh.net (unknown [10.109.159.69])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 92BCF206910
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 20:47:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun,  9 Dec 2018 20:46:02 +0100
Message-Id: <20181209194610.29727-12-clg@kaod.org>
In-Reply-To: <20181209194610.29727-1-clg@kaod.org>
References: <20181209194610.29727-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 11/19] spapr: extend the sPAPR IRQ backend
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
---
 include/hw/ppc/spapr_irq.h |  2 ++
 hw/ppc/spapr.c             | 13 +++++--------
 hw/ppc/spapr_irq.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 13db0428ab51..84a25ffb6c65 100644
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
index 8ff22cdb79d8..8cea4cad1732 100644
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
index 5efe33826967..35a067cad3f8 100644
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
@@ -315,6 +328,11 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
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
@@ -334,6 +352,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
+    .post_load   =3D spapr_irq_post_load_xive,
 };
=20
 /*
@@ -372,6 +391,13 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int ir=
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
@@ -440,4 +466,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
--=20
2.17.2
