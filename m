Received: from eggs.gnu.org ([2001:4830:134:3::10]:39038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCN-0002TK-BH
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCI-00041Y-Kx
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:39 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:60262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCI-00040H-AZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:34 -0400
Received: from player169.ha.ovh.net (unknown [10.109.108.58])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id B8BAC1BC4EA
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:49 +0200
Message-Id: <20180607155003.1580-15-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/28] spapr/xive: use the VCPU id as a VP
 identifier in the OS CAM.
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

For the IVPE to find a matching VP among the VPs dispatched on the
physical processor threads, the model needs to update the OS CAM line
of the XIVE thread interrupt context with the VP identifier.

The model uses the VCPU id as the VP identifier for the sPAPR and
provide a set of helpers to do the conversion between identifiers.
EQ ids are also derived from the VCPU id.

sPAPRXive does not provision storage for a VPD table but the
XiveRouter handlers provide some extra checks to the routing
algorithm.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h | 15 +++++++++
 hw/intc/spapr_xive.c        | 80 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive.c              | 12 +++++++
 3 files changed, 107 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 32733270f734..be1163a8f272 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -43,4 +43,19 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t =
lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
=20
+/*
+ * sPAPR VP and EQ indexing helpers
+ */
+static inline uint32_t spapr_xive_vp_to_target(sPAPRXive *xive, uint8_t =
vp_blk,
+                                               uint32_t vp_idx)
+{
+    return vp_idx;
+}
+int spapr_xive_target_to_vp(XiveRouter *xrtr, uint32_t target,
+                            uint8_t *out_vp_blk, uint32_t *out_vp_idx);
+int spapr_xive_target_to_eq(XiveRouter *xrtr, uint32_t target, uint8_t p=
rio,
+                            uint8_t *out_eq_blk, uint32_t *out_eq_idx);
+int spapr_xive_cpu_to_eq(XiveRouter *xrtr, PowerPCCPU *cpu, uint8_t prio=
,
+                         uint8_t *out_eq_blk, uint32_t *out_eq_idx);
+
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e006c199ed11..222c1266a547 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -184,6 +184,84 @@ static int spapr_xive_set_eq(XiveRouter *xrtr,
     return 0;
 }
=20
+static int spapr_xive_get_vp(XiveRouter *xrtr,
+                             uint8_t vp_blk, uint32_t vp_idx, XiveVP *vp=
)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+    uint32_t vcpu_id =3D spapr_xive_vp_to_target(xive, vp_blk, vp_idx);
+    PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
+
+    if (!cpu) {
+        return -1;
+    }
+
+    /*
+     * sPAPR does not maintain a VPD table. Return that the VP is
+     * valid if we have found a matching CPU
+     */
+    vp->w0 =3D VP_W0_VALID;
+    return 0;
+}
+
+static int spapr_xive_set_vp(XiveRouter *xrtr,
+                             uint8_t vp_blk, uint32_t vp_idx, XiveVP *vp=
)
+{
+    /* no VPD table */
+    return 0;
+}
+
+/*
+ * sPAPR VP indexing uses a simple mapping of the CPU vcpu_id
+ */
+int spapr_xive_target_to_vp(XiveRouter *xrtr, uint32_t target,
+                            uint8_t *out_vp_blk, uint32_t *out_vp_idx)
+{
+    PowerPCCPU *cpu =3D spapr_find_cpu(target);
+
+    if (!cpu) {
+        return -1;
+    }
+
+    if (out_vp_blk) {
+        *out_vp_blk =3D xrtr->chip_id;
+    }
+
+    if (out_vp_blk) {
+        *out_vp_idx =3D cpu->vcpu_id;
+    }
+    return 0;
+}
+
+/*
+ * sPAPR EQ indexing uses a simple mapping of the CPU vcpu_id, 8
+ * priorities per CPU
+ */
+int spapr_xive_cpu_to_eq(XiveRouter *xrtr, PowerPCCPU *cpu, uint8_t prio=
,
+                         uint8_t *out_eq_blk, uint32_t *out_eq_idx)
+{
+    if (!cpu) {
+        return -1;
+    }
+
+    if (out_eq_blk) {
+        *out_eq_blk =3D xrtr->chip_id;
+    }
+
+    if (out_eq_idx) {
+        *out_eq_idx =3D (cpu->vcpu_id << 3) + prio;
+    }
+    return 0;
+}
+
+int spapr_xive_target_to_eq(XiveRouter *xrtr, uint32_t target, uint8_t p=
rio,
+                            uint8_t *out_eq_blk, uint32_t *out_eq_idx)
+{
+    PowerPCCPU *cpu =3D spapr_find_cpu(target);
+
+    return spapr_xive_cpu_to_eq(xrtr, cpu, prio, out_eq_blk, out_eq_idx)=
;
+}
+
+
 static const VMStateDescription vmstate_spapr_xive_eq =3D {
     .name =3D TYPE_SPAPR_XIVE "/eq",
     .version_id =3D 1,
@@ -248,6 +326,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->set_ive =3D spapr_xive_set_ive;
     xrc->get_eq  =3D spapr_xive_get_eq;
     xrc->set_eq  =3D spapr_xive_set_eq;
+    xrc->get_vp  =3D spapr_xive_get_vp;
+    xrc->set_vp  =3D spapr_xive_set_vp;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f249ffc8943e..671ea1c6c36b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -486,6 +486,8 @@ static uint32_t xive_tctx_hw_cam(XiveTCTX *tctx, bool=
 block_group)
 static void xive_tctx_reset(void *dev)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
+    PowerPCCPU *cpu =3D POWERPC_CPU(tctx->cs);
+    CPUPPCState *env =3D &cpu->env;
=20
     memset(tctx->regs, 0, sizeof(tctx->regs));
=20
@@ -500,6 +502,16 @@ static void xive_tctx_reset(void *dev)
      */
     tctx->regs[TM_QW1_OS + TM_PIPR] =3D
         ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
+
+    /* The OS CAM is pushed by the hypervisor when the VP is scheduled
+     * to run on a HW thread. On QEMU, when running a pseries machine,
+     * hardwire the VCPU id as this is our VP identifier.
+     */
+    if (!msr_hv) {
+        uint32_t os_cam =3D cpu_to_be32(
+            TM_QW1W2_VO | tctx_cam_line(tctx->xrtr->chip_id, cpu->vcpu_i=
d));
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &os_cam, 4);
+    }
 }
=20
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
--=20
2.13.6
