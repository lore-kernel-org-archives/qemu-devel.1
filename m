Received: from eggs.gnu.org ([2001:4830:134:3::10]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgz-0007RD-RV
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgw-0008KL-9b
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:53 -0500
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:40330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqgv-0008Gj-Sm
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:50 -0500
Received: from player688.ha.ovh.net (unknown [10.109.146.5])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id F385537391
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:39:47 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:15 +0100
Message-Id: <20181211223823.13770-5-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 04/12] spapr: allocate the interrupt thread
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xive.h      |  1 +
 hw/intc/xive.c             | 22 ++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c    |  5 ++---
 hw/ppc/spapr_irq.c         | 15 +++++++++++++++
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index e51e9f052f63..13db0428ab51 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -41,6 +41,8 @@ typedef struct sPAPRIrq {
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
     void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
+    Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
+                               Error **errp);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 19309d1d65d1..18cd114eb244 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -419,6 +419,7 @@ typedef struct XiveTCTX {
 extern const MemoryRegionOps xive_tm_ops;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
+Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ea5385ff7784..53d2f191e8a3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -526,6 +526,28 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
+Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(TYPE_XIVE_TCTX);
+    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    return obj;
+
+error:
+    object_unparent(obj);
+    error_propagate(errp, local_err);
+    return NULL;
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
index 975954dc2712..fdcc7795e446 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -191,6 +191,12 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
ate *spapr, Monitor *mon)
     ics_pic_print_info(spapr->ics, mon);
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
@@ -205,6 +211,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
=20
 /*
@@ -282,6 +289,12 @@ static void spapr_irq_print_info_xive(sPAPRMachineSt=
ate *spapr,
     spapr_xive_pic_print_info(spapr->xive, mon);
 }
=20
+static Object *spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
+                                              Object *cpu, Error **errp)
+{
+    return xive_tctx_create(cpu, XIVE_ROUTER(spapr->xive), errp);
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -300,6 +313,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
 };
=20
 /*
@@ -405,4 +419,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
--=20
2.17.2
