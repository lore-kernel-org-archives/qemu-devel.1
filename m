Received: from eggs.gnu.org ([2001:4830:134:3::10]:44389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgXI-00078i-Cg
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgXD-0003Zv-FM
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:56 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:36945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgXD-0003Wc-3N
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:51 -0500
Received: from player714.ha.ovh.net (unknown [10.109.159.20])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id E55C210C8B7
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:47 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:33 +0100
Message-Id: <20181205232251.10446-20-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 19/37] spapr: allocate the interrupt thread
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
The XIVE model hardwires the NVT identifier in the thread context
model to emulate the push/pull of hypervisor when a vCPU is dispatched
on a HW thread.

The sPAPR IRQ backend is extended with a new handler to support them
both.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v5:

 - hardwires the NVT identifier in the thread context
=20
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xive.h      |  1 +
 hw/intc/xive.c             | 31 +++++++++++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c    |  5 ++---
 hw/ppc/spapr_irq.c         | 15 +++++++++++++++
 5 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 457239826b8f..689176455e51 100644
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
index e9b06e75fc1c..60c335ce0e1e 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -421,6 +421,7 @@ typedef struct XiveTCTX {
 extern const MemoryRegionOps xive_tm_ops;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
+Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0db77107ab15..7638592da20f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -552,6 +552,37 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
+Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
+{
+
+    CPUPPCState *env =3D &POWERPC_CPU(cpu)->env;
+    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
+    uint32_t hw_cam =3D hw_cam_line((pir >> 8) & 0xf, pir & 0x7f);
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(TYPE_XIVE_TCTX);
+    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
+    object_unref(obj);
+    object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_add_const_link(obj, "xive", OBJECT(xrtr), &error_abo=
rt);
+    object_property_set_int(obj, hw_cam, "hw-cam", &local_err);
+    if (local_err) {
+        goto error;
+    }
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
index 8401c75fdbe4..e16265f29d74 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -190,6 +190,12 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
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
@@ -204,6 +210,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
=20
 /*
@@ -300,6 +307,12 @@ static void spapr_irq_print_info_xive(sPAPRMachineSt=
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
@@ -318,6 +331,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
     .dt_populate =3D spapr_dt_xive,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
 };
=20
 /*
@@ -423,4 +437,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
     .dt_populate =3D spapr_dt_xics,
+    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
 };
--=20
2.17.2
