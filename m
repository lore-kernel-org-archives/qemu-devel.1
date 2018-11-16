Received: from eggs.gnu.org ([2001:4830:134:3::10]:34035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbqY-0007ow-OS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbqS-000898-JY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:34 -0500
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:60615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbqQ-000864-I6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:27 -0500
Received: from player734.ha.ovh.net (unknown [10.109.143.146])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3232ED42D2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:59:22 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:11 +0100
Message-Id: <20181116105729.23240-19-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 18/36] spapr: allocate the interrupt thread
 context under the CPU core
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

Each interrupt mode has its own specific interrupt presenter object,
that we store under the CPU object, one for XICS and one for XIVE.

Extend the sPAPR IRQ backend with a new handler to support them both.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h     |  1 +
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xive.h      |  2 ++
 hw/intc/xive.c             | 21 +++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c    |  5 ++---
 hw/ppc/spapr_irq.c         | 17 +++++++++++++++++
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 8415faea7b82..f43ef69d61bc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -177,6 +177,7 @@ struct sPAPRMachineState {
     int32_t irq_map_nr;
     unsigned long *irq_map;
     sPAPRXive  *xive;
+    const char *xive_tctx_type;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index cfdc1f86e713..c3b4c38145eb 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -42,6 +42,8 @@ typedef struct sPAPRIrq {
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
     void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
+    Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
+                               Error **errp);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index e6931ddaa83f..b74eb326dcd1 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -284,6 +284,8 @@ typedef struct XiveTCTX {
 extern const MemoryRegionOps xive_tm_ops;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
+Object *xive_tctx_create(Object *cpu, const char *type, XiveRouter *xrtr=
,
+                         Error **errp);
=20
 static inline uint32_t xive_tctx_cam_line(uint8_t nvt_blk, uint32_t nvt_=
idx)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index fc6ef5895e6d..7d921023e2ee 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -579,6 +579,27 @@ static const TypeInfo xive_tctx_info =3D {
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
index 2398ce62c0e7..1811cd48db90 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -11,7 +11,6 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
-#include "hw/ppc/xics.h" /* for icp_create() - to be removed */
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
@@ -215,6 +214,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev=
, Error **errp)
 static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
                                sPAPRCPUCore *sc, Error **errp)
 {
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     CPUPPCState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
     Error *local_err =3D NULL;
@@ -233,8 +233,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
=20
-    cpu->intc =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(s=
papr),
-                           &local_err);
+    cpu->intc =3D smc->irq->cpu_intc_create(spapr, OBJECT(cpu), &local_e=
rr);
     if (local_err) {
         goto error_unregister;
     }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d88a029d8c5c..253abc10e780 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -197,6 +197,12 @@ static void spapr_irq_dt_populate_xics(sPAPRMachineS=
tate *spapr,
     spapr_dt_xics(nr_servers, fdt, phandle);
 }
=20
+static Object *spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
+                                              Object *cpu, Error **errp)
+{
+    return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -211,6 +217,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_irq_dt_populate_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
=20
  /*
@@ -267,6 +274,7 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, int nr_irqs,
         return;
     }
=20
+    spapr->xive_tctx_type =3D TYPE_XIVE_TCTX;
     spapr_xive_hcall_init(spapr);
 }
=20
@@ -315,6 +323,13 @@ static void spapr_irq_dt_populate_xive(sPAPRMachineS=
tate *spapr,
     spapr_dt_xive(spapr->xive, nr_servers, fdt, phandle);
 }
=20
+static Object *spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
+                                              Object *cpu, Error **errp)
+{
+    return xive_tctx_create(cpu, spapr->xive_tctx_type,
+                            XIVE_ROUTER(spapr->xive), errp);
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -333,6 +348,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_irq_dt_populate_xive,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
 };
=20
 /*
@@ -438,4 +454,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_irq_dt_populate_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
--=20
2.17.2
