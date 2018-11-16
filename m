Received: from eggs.gnu.org ([2001:4830:134:3::10]:34165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbqx-0008Af-7C
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbqo-000098-DK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:59 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:32941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbqh-0008D5-JT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:45 -0500
Received: from player734.ha.ovh.net (unknown [10.109.146.211])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id A4D8D32967
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:59:38 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:14 +0100
Message-Id: <20181116105729.23240-22-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 21/36] spapr: extend the sPAPR IRQ backend
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
---
 include/hw/ppc/spapr_irq.h |  2 ++
 hw/ppc/spapr.c             | 13 +++++--------
 hw/ppc/spapr_irq.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b299dd794bff..4e36c0984e1a 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -45,6 +45,7 @@ typedef struct sPAPRIrq {
                         void *fdt, uint32_t phandle);
     Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                                Error **errp);
+    int (*post_load)(sPAPRMachineState *spapr, int version_id);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
@@ -55,6 +56,7 @@ void spapr_irq_init(sPAPRMachineState *spapr, int nr_se=
rvers, Error **errp);
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
+int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
=20
 /*
  * XICS legacy routines
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8fbb743769db..f9cf2debff5a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1738,14 +1738,6 @@ static int spapr_post_load(void *opaque, int versi=
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
@@ -1766,6 +1758,11 @@ static int spapr_post_load(void *opaque, int versi=
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
index f6e9e44d4cf9..33dd5da7d255 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -203,6 +203,18 @@ static Object *spapr_irq_cpu_intc_create_xics(sPAPRM=
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
@@ -219,6 +231,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_irq_dt_populate_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
=20
  /*
@@ -331,6 +344,11 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
                             XIVE_ROUTER(spapr->xive), errp);
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
@@ -351,6 +369,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_irq_dt_populate_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
+    .post_load   =3D spapr_irq_post_load_xive,
 };
=20
 /*
@@ -389,6 +408,13 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int ir=
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
@@ -458,4 +484,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_irq_dt_populate_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
--=20
2.17.2
