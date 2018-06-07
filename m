Received: from eggs.gnu.org ([2001:4830:134:3::10]:39439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDK-0003JI-TG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDG-0004Wz-6x
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:38 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:36154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxDG-0004WH-0g
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:34 -0400
Received: from player169.ha.ovh.net (unknown [10.109.108.82])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CBEF01BDFEA
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:50:00 +0200
Message-Id: <20180607155003.1580-26-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 25/28] spapr: fix XICS migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Extend the sPAPR IRQ backend with a new handler to handle XICS
post_load() specificities.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             |  9 ++-------
 hw/ppc/spapr_irq.c         | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 85829928a9c4..1ca35ffc13cd 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -47,6 +47,7 @@ typedef struct sPAPRIrq {
                         void *fdt, uint32_t phandle);
     Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                                Error **errp);
+    void (*post_load)(sPAPRMachineState *spapr);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_legacy;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2774b53f169e..025d5af84def 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1689,6 +1689,7 @@ static int spapr_pre_load(void *opaque)
 static int spapr_post_load(void *opaque, int version_id)
 {
     sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int err =3D 0;
=20
     err =3D spapr_caps_post_migration(spapr);
@@ -1696,13 +1697,7 @@ static int spapr_post_load(void *opaque, int versi=
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
+    smc->irq->post_load(spapr);
=20
     /* In earlier versions, there was no separate qdev for the PAPR
      * RTC, so the RTC offset was stored directly in sPAPREnvironment.
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a5d89c6ac55f..5f445e17d125 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -254,6 +254,17 @@ static Object *spapr_irq_cpu_intc_create_legacy(sPAP=
RMachineState *spapr,
     return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
 }
=20
+static void spapr_irq_post_load_legacy(sPAPRMachineState *spapr)
+{
+    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
+        CPUState *cs;
+        CPU_FOREACH(cs) {
+            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+            icp_resend(ICP(cpu->intc));
+        }
+    }
+}
+
 sPAPRIrq spapr_irq_legacy =3D {
     .nr_irqs     =3D XICS_IRQS_SPAPR,
     .ov5         =3D 0x0, /* XICS only */
@@ -266,6 +277,7 @@ sPAPRIrq spapr_irq_legacy =3D {
     .print_info  =3D spapr_irq_print_info_legacy,
     .dt_populate =3D spapr_irq_dt_populate_legacy,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_legacy,
+    .post_load   =3D spapr_irq_post_load_legacy,
 };
=20
 /*
@@ -487,6 +499,11 @@ static Object *spapr_irq_cpu_intc_create_xics(sPAPRM=
achineState *spapr,
     return spapr_irq_cpu_intc_create_legacy(spapr, cpu, errp);
 }
=20
+static void spapr_irq_post_load_xics(sPAPRMachineState *spapr)
+{
+    spapr_irq_post_load_legacy(spapr);
+}
+
 /*
  * XICS IRQ number space
  *
@@ -534,6 +551,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_irq_dt_populate_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
+    .post_load   =3D spapr_irq_post_load_xics,
 };
=20
 /*
@@ -716,6 +734,11 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
                             XIVE_ROUTER(spapr->xive), errp);
 }
=20
+static void spapr_irq_post_load_xive(sPAPRMachineState *spapr)
+{
+    ;
+}
+
 /*
  * XIVE IRQ number space
  *
@@ -765,6 +788,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_irq_dt_populate_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
+    .post_load   =3D spapr_irq_post_load_xive,
 };
=20
 /*
--=20
2.13.6
