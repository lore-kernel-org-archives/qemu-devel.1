Received: from eggs.gnu.org ([2001:4830:134:3::10]:39246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCq-0002t2-AQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCk-0004Ef-1w
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:08 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:52975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCj-0004E0-OC
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:01 -0400
Received: from player169.ha.ovh.net (unknown [10.109.108.82])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0F636C4D80
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:00 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:54 +0200
Message-Id: <20180607155003.1580-20-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 19/28] spapr: allocate the interrupt thread
 context under the CPU core
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

Each interrupt mode has its own specific interrupt presenter object,
that we store under the CPU object, one for XICS and one for XIVE.

Extend the sPAPR IRQ backend with a new handler to support them both.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |  1 +
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xive.h      |  2 ++
 hw/intc/xive.c             | 21 +++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c    |  4 ++--
 hw/ppc/spapr_irq.c         | 23 +++++++++++++++++++++++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3c7bae874f91..223837882496 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -169,6 +169,7 @@ struct sPAPRMachineState {
     unsigned long *irq_map;
     const char *icp_type;
     sPAPRXive  *xive;
+    const char *xive_tctx_type;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b070276c9abb..8046cbd83d61 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -44,6 +44,8 @@ typedef struct sPAPRIrq {
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
     void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
+    Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
+                               Error **errp);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_legacy;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index e29b52eeb91f..378bd61c6d18 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -281,5 +281,7 @@ typedef struct XiveTCTX {
 extern const MemoryRegionOps xive_tm_ops;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
+Object *xive_tctx_create(Object *cpu, const char *type, XiveRouter *xrtr=
,
+                         Error **errp);
=20
 #endif /* PPC_XIVE_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 671ea1c6c36b..8d86f739522d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -587,6 +587,27 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
+Object *xive_tctx_create(Object *cpu, const char *type, XiveRouter *xrtr=
,
+                         Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(type);
+    object_property_add_child(cpu, type, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_add_const_link(obj, "xive", OBJECT(xrtr), &error_abo=
rt);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        object_unparent(obj);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return obj;
+}
+
 /*
  * XIVE ESB helpers
  */
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index f3e9b879b251..fe9bcfdf01c8 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -148,6 +148,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -159,8 +160,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
         goto error;
     }
=20
-    cpu->intc =3D icp_create(child, spapr->icp_type, XICS_FABRIC(spapr),
-                           &local_err);
+    cpu->intc =3D smc->irq->cpu_intc_create(spapr, child, &local_err);
     if (local_err) {
         goto error;
     }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index be71998777c2..266f7db3be7b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -248,6 +248,12 @@ static void spapr_irq_dt_populate_legacy(sPAPRMachin=
eState *spapr,
     spapr_dt_xics(nr_servers, fdt, phandle);
 }
=20
+static Object *spapr_irq_cpu_intc_create_legacy(sPAPRMachineState *spapr=
,
+                                              Object *cpu, Error **errp)
+{
+    return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
+}
+
 sPAPRIrq spapr_irq_legacy =3D {
     .nr_irqs     =3D XICS_IRQS_SPAPR,
     .init        =3D spapr_irq_init_legacy,
@@ -258,6 +264,7 @@ sPAPRIrq spapr_irq_legacy =3D {
     .qirq        =3D spapr_qirq_legacy,
     .print_info  =3D spapr_irq_print_info_legacy,
     .dt_populate =3D spapr_irq_dt_populate_legacy,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_legacy,
 };
=20
 /*
@@ -473,6 +480,12 @@ static void spapr_irq_dt_populate_xics(sPAPRMachineS=
tate *spapr,
     spapr_irq_dt_populate_legacy(spapr, nr_servers, fdt, phandle);
 }
=20
+static Object *spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
+                                              Object *cpu, Error **errp)
+{
+    return spapr_irq_cpu_intc_create_legacy(spapr, cpu, errp);
+}
+
 /*
  * XICS IRQ number space
  *
@@ -518,6 +531,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_irq_dt_populate_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
=20
 /*
@@ -582,6 +596,7 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, uint32_t nr_servers,
         spapr_irq_alloc(spapr, SPAPR_IRQ_IPI, i, errp);
     }
=20
+    spapr->xive_tctx_type =3D TYPE_XIVE_TCTX;
     spapr_xive_hcall_init(spapr);
 }
=20
@@ -683,6 +698,13 @@ static void spapr_irq_dt_populate_xive(sPAPRMachineS=
tate *spapr,
     spapr_dt_xive(spapr->xive, nr_servers, fdt, phandle);
 }
=20
+static Object *spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
+                                                   Object *cpu, Error **=
errp)
+{
+    return xive_tctx_create(cpu, spapr->xive_tctx_type,
+                            XIVE_ROUTER(spapr->xive), errp);
+}
+
 /*
  * XIVE IRQ number space
  *
@@ -730,6 +752,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_irq_dt_populate_xive,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
 };
=20
 /*
--=20
2.13.6
