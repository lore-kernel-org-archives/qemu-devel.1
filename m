Received: from eggs.gnu.org ([2001:4830:134:3::10]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgXQ-0007Ez-FA
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgXM-0003jD-4M
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:04 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:36441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgXL-0003hq-Jx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:59 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.239])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 74968D5DEF
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:35 +0100
Message-Id: <20181205232251.10446-22-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 21/37] spapr: add a 'reset' method to the
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
scheduled to run on a HW thread.

This method will become even more useful when the machine supporting
both interrupt modes, XIVE and XICS, is introduced. In this machine,
the interrupt mode is chosen by the CAS negotiation process and
activated after a reset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h  |  2 ++
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive.c        | 24 ++++++++++++++++++++++++
 hw/ppc/spapr.c              |  5 +++++
 hw/ppc/spapr_irq.c          | 25 +++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 91ac5784919c..bdb1c66125c9 100644
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
index 728a5e8dc163..7244a6231ce6 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -47,5 +47,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
+void spapr_xive_reset_tctx(sPAPRXive *xive);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index fd02dc6b91e4..3cddc9332acb 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -181,6 +181,30 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
=20
+/*
+ * When a Virtual Processor is scheduled to run on a HW thread, the
+ * hypervisor pushes its identifier in the OS CAM line. Emulate the
+ * same behavior under QEMU.
+ */
+void spapr_xive_reset_tctx(sPAPRXive *xive)
+{
+    CPUState *cs;
+    uint8_t  nvt_blk;
+    uint32_t nvt_idx;
+    uint32_t nvt_cam;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
+
+        spapr_xive_cpu_to_nvt(xive, cpu, &nvt_blk, &nvt_idx);
+
+        nvt_cam =3D cpu_to_be32(TM_QW1W2_VO |
+                              xive_nvt_cam_line(nvt_blk, nvt_idx));
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
+    }
+}
+
 static void spapr_xive_end_reset(XiveEND *end)
 {
     memset(end, 0, sizeof(*end));
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8911465e32cf..530aee8d143d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1621,6 +1621,11 @@ static void spapr_machine_reset(void)
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
index 8943e28fc11b..58ce124c1501 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/xics.h"
 #include "sysemu/kvm.h"
=20
@@ -208,6 +209,10 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
+static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
+{
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -224,6 +229,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .dt_populate =3D spapr_dt_xics,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
+    .reset       =3D spapr_irq_reset_xics,
 };
=20
 /*
@@ -331,6 +337,15 @@ static int spapr_irq_post_load_xive(sPAPRMachineStat=
e *spapr, int version_id)
     return 0;
 }
=20
+static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
+{
+    /*
+     * Set the OS CAM line of the cpu interrupt thread context. Needs
+     * to come after the XiveTCTX reset handlers.
+     */
+    spapr_xive_reset_tctx(spapr->xive);
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -351,6 +366,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .dt_populate =3D spapr_dt_xive,
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
     .post_load   =3D spapr_irq_post_load_xive,
+    .reset       =3D spapr_irq_reset_xive,
 };
=20
 /*
@@ -396,6 +412,15 @@ int spapr_irq_post_load(sPAPRMachineState *spapr, in=
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
