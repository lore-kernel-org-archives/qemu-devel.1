Received: from eggs.gnu.org ([2001:4830:134:3::10]:33553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpo-00077n-Gy
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpk-0007n0-A3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:48 -0500
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:35899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbpk-0007mI-1Z
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:44 -0500
Received: from player734.ha.ovh.net (unknown [10.109.146.82])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 82A3534C43
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:58:42 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:04 +0100
Message-Id: <20181116105729.23240-12-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 11/36] spapr/xive: use the VCPU id as a NVT
 identifier
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

The IVPE scans the O/S CAM line of the XIVE thread interrupt contexts
to find a matching Notification Virtual Target (NVT) among the NVTs
dispatched on the HW processor threads.

On a real system, the thread interrupt contexts are updated by the
hypervisor when a Virtual Processor is scheduled to run on a HW
thread. Under QEMU, the model emulates the same behavior by hardwiring
the NVT identifier in the thread context registers at reset.

The NVT identifier used by the sPAPRXive model is the VCPU id. The END
identifier is also derived from the VCPU id. A set of helpers doing
the conversion between identifiers are provided for the hcalls
configuring the sources and the ENDs.

The model does not need a NVT table but The XiveRouter NVT operations
are provided to perform some extra checks in the routing algorithm.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  17 +++++
 include/hw/ppc/xive.h       |   3 +
 hw/intc/spapr_xive.c        | 136 ++++++++++++++++++++++++++++++++++++
 hw/intc/xive.c              |   9 +++
 4 files changed, 165 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 06727bd86aa9..3f65b8f485fd 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -43,4 +43,21 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t =
lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
=20
+/*
+ * sPAPR NVT and END indexing helpers
+ */
+uint32_t spapr_xive_nvt_to_target(sPAPRXive *xive, uint8_t nvt_blk,
+                                  uint32_t nvt_idx);
+int spapr_xive_target_to_nvt(sPAPRXive *xive, uint32_t target,
+                            uint8_t *out_nvt_blk, uint32_t *out_nvt_idx)=
;
+int spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
+                          uint8_t *out_nvt_blk, uint32_t *out_nvt_idx);
+
+int spapr_xive_end_to_target(sPAPRXive *xive, uint8_t end_blk, uint32_t =
end_idx,
+                             uint32_t *out_server, uint8_t *out_prio);
+int spapr_xive_target_to_end(sPAPRXive *xive, uint32_t target, uint8_t p=
rio,
+                             uint8_t *out_end_blk, uint32_t *out_end_idx=
);
+int spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8_t prio=
,
+                          uint8_t *out_end_blk, uint32_t *out_end_idx);
+
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index e715a6c6923d..e6931ddaa83f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -187,6 +187,8 @@ typedef struct XiveRouter {
 #define XIVE_ROUTER_GET_CLASS(obj)                              \
     OBJECT_GET_CLASS(XiveRouterClass, (obj), TYPE_XIVE_ROUTER)
=20
+typedef struct XiveTCTX XiveTCTX;
+
 typedef struct XiveRouterClass {
     SysBusDeviceClass parent;
=20
@@ -201,6 +203,7 @@ typedef struct XiveRouterClass {
                    XiveNVT *nvt);
     int (*set_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
                    XiveNVT *nvt);
+    void (*reset_tctx)(XiveRouter *xrtr, XiveTCTX *tctx);
 } XiveRouterClass;
=20
 void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 5d038146c08e..3bf77ace11a2 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -199,6 +199,139 @@ static int spapr_xive_set_end(XiveRouter *xrtr,
     return 0;
 }
=20
+static int spapr_xive_get_nvt(XiveRouter *xrtr,
+                              uint8_t nvt_blk, uint32_t nvt_idx, XiveNVT=
 *nvt)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+    uint32_t vcpu_id =3D spapr_xive_nvt_to_target(xive, nvt_blk, nvt_idx=
);
+    PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
+
+    if (!cpu) {
+        return -1;
+    }
+
+    /*
+     * sPAPR does not maintain a NVT table. Return that the NVT is
+     * valid if we have found a matching CPU
+     */
+    nvt->w0 =3D NVT_W0_VALID;
+    return 0;
+}
+
+static int spapr_xive_set_nvt(XiveRouter *xrtr,
+                              uint8_t nvt_blk, uint32_t nvt_idx, XiveNVT=
 *nvt)
+{
+    /* no NVT table */
+    return 0;
+}
+
+/*
+ * When a Virtual Processor is scheduled to run on a HW thread, the
+ * hypervisor pushes its identifier in the OS CAM line. Under QEMU, we
+ * need to emulate the same behavior.
+ */
+static void spapr_xive_reset_tctx(XiveRouter *xrtr, XiveTCTX *tctx)
+{
+    uint8_t  nvt_blk;
+    uint32_t nvt_idx;
+    uint32_t nvt_cam;
+
+    spapr_xive_cpu_to_nvt(SPAPR_XIVE(xrtr), POWERPC_CPU(tctx->cs),
+                          &nvt_blk, &nvt_idx);
+
+    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_tctx_cam_line(nvt_blk, nv=
t_idx));
+    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
+}
+
+/*
+ * The allocation of VP blocks is a complex operation in OPAL and the
+ * VP identifiers have a relation with the number of HW chips, the
+ * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
+ * controller model does not have the same constraints and can use a
+ * simple mapping scheme of the CPU vcpu_id
+ *
+ * These identifiers are never returned to the OS.
+ */
+
+#define SPAPR_XIVE_VP_BASE 0x400
+
+uint32_t spapr_xive_nvt_to_target(sPAPRXive *xive, uint8_t nvt_blk,
+                                  uint32_t nvt_idx)
+{
+    return nvt_idx - SPAPR_XIVE_VP_BASE;
+}
+
+int spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
+                          uint8_t *out_nvt_blk, uint32_t *out_nvt_idx)
+{
+    XiveRouter *xrtr =3D XIVE_ROUTER(xive);
+
+    if (!cpu) {
+        return -1;
+    }
+
+    if (out_nvt_blk) {
+        /* For testing purpose, we could use 0 for nvt_blk */
+        *out_nvt_blk =3D xrtr->chip_id;
+    }
+
+    if (out_nvt_blk) {
+        *out_nvt_idx =3D SPAPR_XIVE_VP_BASE + cpu->vcpu_id;
+    }
+    return 0;
+}
+
+int spapr_xive_target_to_nvt(sPAPRXive *xive, uint32_t target,
+                             uint8_t *out_nvt_blk, uint32_t *out_nvt_idx=
)
+{
+    return spapr_xive_cpu_to_nvt(xive, spapr_find_cpu(target), out_nvt_b=
lk,
+                                 out_nvt_idx);
+}
+
+/*
+ * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
+ * priorities per CPU
+ */
+int spapr_xive_end_to_target(sPAPRXive *xive, uint8_t end_blk, uint32_t =
end_idx,
+                             uint32_t *out_server, uint8_t *out_prio)
+{
+    if (out_server) {
+        *out_server =3D end_idx >> 3;
+    }
+
+    if (out_prio) {
+        *out_prio =3D end_idx & 0x7;
+    }
+    return 0;
+}
+
+int spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8_t prio=
,
+                          uint8_t *out_end_blk, uint32_t *out_end_idx)
+{
+    XiveRouter *xrtr =3D XIVE_ROUTER(xive);
+
+    if (!cpu) {
+        return -1;
+    }
+
+    if (out_end_blk) {
+        /* For testing purpose, we could use 0 for nvt_blk */
+        *out_end_blk =3D xrtr->chip_id;
+    }
+
+    if (out_end_idx) {
+        *out_end_idx =3D (cpu->vcpu_id << 3) + prio;
+    }
+    return 0;
+}
+
+int spapr_xive_target_to_end(sPAPRXive *xive, uint32_t target, uint8_t p=
rio,
+                             uint8_t *out_end_blk, uint32_t *out_end_idx=
)
+{
+    return spapr_xive_cpu_to_end(xive, spapr_find_cpu(target), prio,
+                                 out_end_blk, out_end_idx);
+}
+
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -263,6 +396,9 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->set_eas =3D spapr_xive_set_eas;
     xrc->get_end =3D spapr_xive_get_end;
     xrc->set_end =3D spapr_xive_set_end;
+    xrc->get_nvt =3D spapr_xive_get_nvt;
+    xrc->set_nvt =3D spapr_xive_set_nvt;
+    xrc->reset_tctx =3D spapr_xive_reset_tctx;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c49932d2b799..fc6ef5895e6d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -481,6 +481,7 @@ static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx,=
 bool block_group)
 static void xive_tctx_reset(void *dev)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
+    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(tctx->xrtr);
=20
     memset(tctx->regs, 0, sizeof(tctx->regs));
=20
@@ -495,6 +496,14 @@ static void xive_tctx_reset(void *dev)
      */
     tctx->regs[TM_QW1_OS + TM_PIPR] =3D
         ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
+
+    /*
+     * QEMU sPAPR XIVE only. To let the controller model reset the OS
+     * CAM line with the VP identifier.
+     */
+    if (xrc->reset_tctx) {
+        xrc->reset_tctx(tctx->xrtr, tctx);
+    }
 }
=20
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
--=20
2.17.2
