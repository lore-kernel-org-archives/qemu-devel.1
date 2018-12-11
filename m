Received: from eggs.gnu.org ([2001:4830:134:3::10]:37091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhA-0007Z9-Ak
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqh6-00007n-SC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:04 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:58282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqh6-0008Vk-CS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:00 -0500
Received: from player688.ha.ovh.net (unknown [10.109.159.152])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 80CB71ECC9C
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:39:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:17 +0100
Message-Id: <20181211223823.13770-7-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 06/12] spapr: add a 'reset' method to the
 sPAPR IRQ backend
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

For the time being, the XIVE reset handler updates the OS CAM line of
the vCPU as it is done under a real hypervisor when a vCPU is
scheduled to run on a HW thread. This will let the XIVE presenter
engine find a match among the NVTs dispatched on the HW threads.

This handler will become even more useful when we introduce the
machine supporting both interrupt modes, XIVE and XICS. In this
machine, the interrupt mode is chosen by the CAS negotiation process
and activated after a reset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v7:

 - removed spapr_irq_reset_xics(). Will be introduce later.
 - replaced spapr_xive_reset_tctx() by spapr_xive_set_tctx_os_cam() to
   also cover hotplugged CPUs. The XiveTCTX and the CPU models lack a
   reset in case of hotplugged.=20
=20
 include/hw/ppc/spapr_irq.h  |  2 ++
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive.c        | 17 +++++++++++++++++
 hw/ppc/spapr.c              |  5 +++++
 hw/ppc/spapr_irq.c          | 30 +++++++++++++++++++++++++++++-
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 84a25ffb6c65..63061a009b4c 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -44,6 +44,7 @@ typedef struct sPAPRIrq {
     Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                                Error **errp);
     int (*post_load)(sPAPRMachineState *spapr, int version_id);
+    void (*reset)(sPAPRMachineState *spapr, Error **errp);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
@@ -55,6 +56,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int irq, =
bool lsi, Error **errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
+void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
=20
 /*
  * XICS legacy routines
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 728a5e8dc163..728735dbcfbe 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -47,5 +47,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
+void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 9e5b2db2439a..aaa5865c4080 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -179,6 +179,23 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
=20
+/*
+ * When a Virtual Processor is scheduled to run on a HW thread, the
+ * hypervisor pushes its identifier in the OS CAM line. Emulate the
+ * same behavior under QEMU.
+ */
+void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
+{
+    uint8_t  nvt_blk;
+    uint32_t nvt_idx;
+    uint32_t nvt_cam;
+
+    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
+
+    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, nvt=
_idx));
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
+}
+
 static void spapr_xive_end_reset(XiveEND *end)
 {
     memset(end, 0, sizeof(*end));
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1f41ea2f3c6c..57c0066edd56 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1619,6 +1619,11 @@ static void spapr_machine_reset(void)
=20
     qemu_devices_reset();
=20
+    /* This is fixing some of the default configuration of the XIVE
+     * devices. To be called after the reset of the machine devices.
+     */
+    spapr_irq_reset(spapr, &error_fatal);
+
     /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
      * if this device is used by another device (eg, a running vhost bac=
kend
      * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 292c448a15fa..f835ea939cbf 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -305,7 +305,13 @@ static void spapr_irq_print_info_xive(sPAPRMachineSt=
ate *spapr,
 static Object *spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
                                               Object *cpu, Error **errp)
 {
-    return xive_tctx_create(cpu, XIVE_ROUTER(spapr->xive), errp);
+    Object *obj =3D xive_tctx_create(cpu, XIVE_ROUTER(spapr->xive), errp=
);
+
+    /* (TCG) Early setting the OS CAM line for hotplugged CPUs as they
+     * don't benificiate from the reset of the XIVE IRQ backend
+     */
+    spapr_xive_set_tctx_os_cam(XIVE_TCTX(obj));
+    return obj;
 }
=20
 static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
@@ -313,6 +319,18 @@ static int spapr_irq_post_load_xive(sPAPRMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
+static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        /* (TCG) Set the OS CAM line of the thread interrupt context. */
+        spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
+    }
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -333,6 +351,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
     .post_load   =3D spapr_irq_post_load_xive,
+    .reset       =3D spapr_irq_reset_xive,
 };
=20
 /*
@@ -378,6 +397,15 @@ int spapr_irq_post_load(sPAPRMachineState *spapr, in=
t version_id)
     return smc->irq->post_load(spapr, version_id);
 }
=20
+void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    if (smc->irq->reset) {
+        smc->irq->reset(spapr, errp);
+    }
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
--=20
2.17.2
