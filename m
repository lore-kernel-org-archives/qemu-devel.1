Received: from eggs.gnu.org ([2001:4830:134:3::10]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxC7-0002HT-79
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxC2-0003rQ-AK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:23 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxC2-0003qU-03
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:18 -0400
Received: from player169.ha.ovh.net (unknown [10.109.105.80])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5DB09105B97
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:46 +0200
Message-Id: <20180607155003.1580-12-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 11/28] ppc/xive: introduce a simplified XIVE
 presenter
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

The last sub-engine of the XIVE architecture is the Interrupt
Virtualization Presentation Engine (IVPE). On HW, they share elements,
the Power Bus interface (CQ), the routing table descriptors, and they
can be combined in the same HW logic. We do the same in QEMU and
combine both engines in the XiveRouter for simplicity.

When the IVRE has completed its job of matching an event source with a
Virtual Processor (VP) target to notify, it forwards the event
notification to the IVPE handling the Virtual Processor threads. The
IVPE scans the thread interrupt context of the VPs dispatched on the
HW processor threads and if a match is found, it signals the
thread. If not, the IVRE escalates the notification to some other
targets and records the notification in a backlog queue.

The IVPE maintains the thread interrupt context state for each of its
VPs not dispatched on HW processor threads in the Virtual Processor
Descriptor (VPD) table.

The model currently only supports single VP notifications.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |   8 ++
 include/hw/ppc/xive_regs.h |  22 +++++
 hw/intc/xive.c             | 227 +++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 257 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 280bd5a1e6ee..e29b52eeb91f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -197,6 +197,10 @@ typedef struct XiveRouterClass {
                    XiveEQ *eq);
     int (*set_eq)(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx,
                    XiveEQ *eq);
+    int (*get_vp)(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx,
+                   XiveVP *vp);
+    int (*set_vp)(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx,
+                  XiveVP *vp);
 } XiveRouterClass;
=20
 void xive_router_print_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive=
,
@@ -207,6 +211,10 @@ int xive_router_get_eq(XiveRouter *xrtr, uint8_t eq_=
blk, uint32_t eq_idx,
                        XiveEQ *eq);
 int xive_router_set_eq(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx=
,
                        XiveEQ *eq);
+int xive_router_get_vp(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx=
,
+                       XiveVP *vp);
+int xive_router_set_vp(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx=
,
+                       XiveVP *vp);
=20
 /*
  * XIVE EQ ESBs
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index a5473bb2d01b..b438184a88b8 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -157,4 +157,26 @@ typedef struct XiveEQ {
 #define EQ_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
 } XiveEQ;
=20
+/* VP */
+typedef struct XiveVP {
+        uint32_t        w0;
+#define VP_W0_VALID             PPC_BIT32(0)
+        uint32_t        w1;
+        uint32_t        w2;
+        uint32_t        w3;
+        uint32_t        w4;
+        uint32_t        w5;
+        uint32_t        w6;
+        uint32_t        w7;
+        uint32_t        w8;
+#define VP_W8_GRP_VALID         PPC_BIT32(0)
+        uint32_t        w9;
+        uint32_t        wa;
+        uint32_t        wb;
+        uint32_t        wc;
+        uint32_t        wd;
+        uint32_t        we;
+        uint32_t        wf;
+} XiveVP;
+
 #endif /* _PPC_XIVE_REGS_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 77e4f0e1f3f5..6ea9441852e3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -373,6 +373,37 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
     }
 }
=20
+/* The HW CAM (23bits) is hardwired to :
+ *
+ *   0x000||0b1||4Bit chip number||7Bit Thread number.
+ *
+ * and when the block grouping extension is enabled :
+ *
+ *   4Bit chip number||0x001||7Bit Thread number.
+ */
+static uint32_t tctx_hw_cam_line(bool block_group, uint8_t chip_id, uint=
8_t tid)
+{
+    if (block_group) {
+        return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
+    } else {
+        return (chip_id & 0xf) << 11 | 1 << 7 | (tid & 0x7f);
+    }
+}
+
+static uint32_t tctx_cam_line(uint8_t vp_blk, uint32_t vp_idx)
+{
+    return (vp_blk << 19) | vp_idx;
+}
+
+static uint32_t xive_tctx_hw_cam(XiveTCTX *tctx, bool block_group)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(tctx->cs);
+    CPUPPCState *env =3D &cpu->env;
+    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
+
+    return tctx_hw_cam_line(block_group, (pir >> 8) & 0xf, pir & 0x7f);
+}
+
 static void xive_tctx_reset(void *dev)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
@@ -976,6 +1007,194 @@ int xive_router_set_eq(XiveRouter *xrtr, uint8_t e=
q_blk, uint32_t eq_idx,
    return xrc->set_eq(xrtr, eq_blk, eq_idx, eq);
 }
=20
+int xive_router_get_vp(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx=
,
+                       XiveVP *vp)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_vp(xrtr, vp_blk, vp_idx, vp);
+}
+
+int xive_router_set_vp(XiveRouter *xrtr, uint8_t vp_blk, uint32_t vp_idx=
,
+                       XiveVP *vp)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->set_vp(xrtr, vp_blk, vp_idx, vp);
+}
+
+static bool xive_tctx_ring_match(XiveTCTX *tctx, uint8_t ring,
+                                uint8_t vp_blk, uint32_t vp_idx,
+                                bool cam_ignore, uint32_t logic_serv)
+{
+    uint8_t *regs =3D &tctx->regs[ring];
+    uint32_t w2 =3D be32_to_cpu(*((uint32_t *) &regs[TM_WORD2]));
+    uint32_t cam =3D tctx_cam_line(vp_blk, vp_idx);
+    bool block_group =3D false; /* TODO (PowerNV) */
+
+    /* TODO (PowerNV): ignore low order bits of vp id */
+
+    switch (ring) {
+    case TM_QW3_HV_PHYS:
+        return (w2 & TM_QW3W2_VT) && xive_tctx_hw_cam(tctx, block_group)=
 =3D=3D
+            tctx_hw_cam_line(block_group, vp_blk, vp_idx);
+
+    case TM_QW2_HV_POOL:
+        return (w2 & TM_QW2W2_VP) && (cam =3D=3D GETFIELD(TM_QW2W2_POOL_=
CAM, w2));
+
+    case TM_QW1_OS:
+        return (w2 & TM_QW1W2_VO) && (cam =3D=3D GETFIELD(TM_QW1W2_OS_CA=
M, w2));
+
+    case TM_QW0_USER:
+        return ((w2 & TM_QW1W2_VO) && (cam =3D=3D GETFIELD(TM_QW1W2_OS_C=
AM, w2)) &&
+                (w2 & TM_QW0W2_VU) &&
+                (logic_serv =3D=3D GETFIELD(TM_QW0W2_LOGIC_SERV, w2)));
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
+                                     uint8_t vp_blk, uint32_t vp_idx,
+                                     bool cam_ignore, uint32_t logic_ser=
v)
+{
+    if (format =3D=3D 0) {
+        /* F=3D0 & i=3D1: Logical server notification */
+        if (cam_ignore =3D=3D true) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no support for LS "
+                          "notification VP %x/%x\n", vp_blk, vp_idx);
+             return -1;
+        }
+
+        /* F=3D0 & i=3D0: Specific VP notification */
+        if (xive_tctx_ring_match(tctx, TM_QW3_HV_PHYS,
+                                vp_blk, vp_idx, false, 0)) {
+            return TM_QW3_HV_PHYS;
+        }
+        if (xive_tctx_ring_match(tctx, TM_QW2_HV_POOL,
+                                vp_blk, vp_idx, false, 0)) {
+            return TM_QW2_HV_POOL;
+        }
+        if (xive_tctx_ring_match(tctx, TM_QW1_OS,
+                                vp_blk, vp_idx, false, 0)) {
+            return TM_QW1_OS;
+        }
+    } else {
+        /* F=3D1 : User level Event-Based Branch (EBB) notification */
+        if (xive_tctx_ring_match(tctx, TM_QW0_USER,
+                                vp_blk, vp_idx, false, logic_serv)) {
+            return TM_QW0_USER;
+        }
+    }
+    return -1;
+}
+
+typedef struct XiveTCTXMatch {
+    XiveTCTX *tctx;
+    uint8_t ring;
+} XiveTCTXMatch;
+
+static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
+                                 uint8_t vp_blk, uint32_t vp_idx,
+                                 bool cam_ignore, uint8_t priority,
+                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
+{
+    CPUState *cs;
+
+    /* TODO (PowerNV): handle chip_id overwrite of block field for
+     * hardwired CAM compares */
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
+        int ring;
+
+        /*
+         * HW checks that the CPU is enabled in the Physical Thread
+         * Enable Register (PTER).
+         */
+
+        /*
+         * Check the thread context CAM lines and record matches. We
+         * will handle CPU exception delivery later
+         */
+        ring =3D xive_presenter_tctx_match(tctx, format, vp_blk, vp_idx,
+                                         cam_ignore, logic_serv);
+        /*
+         * Save the context and follow on to catch duplicates, that we
+         * don't support yet.
+         */
+        if (ring !=3D -1) {
+            if (match->tctx) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
+                              "context VP %x/%x\n", vp_blk, vp_idx);
+                return false;
+            }
+
+            match->ring =3D ring;
+            match->tctx =3D tctx;
+        }
+    }
+
+    if (!match->tctx) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: VP %x/%x is not dispatched=
\n",
+                      vp_blk, vp_idx);
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * This is our simple Xive Presenter Engine model. It is merged in the
+ * Router as it does not require an extra object.
+ *
+ * It receives notification requests sent by the IVRE to find one VP
+ * (or more) dispatched on the processor threads. In case of single VP
+ * notification, the process is abreviated and the thread is signaled
+ * if a match is found. In case of a logical server notification (bits
+ * ignored at the end of the VP identifier), the IVPE and IVRE select
+ * a winning thread using different filters. This involves 2 or 3
+ * exchanges on the PowerBus that the model does not support.
+ *
+ * The parameters represent what is sent on the PowerBus
+ */
+static void xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
+                                  uint8_t vp_blk, uint32_t vp_idx,
+                                  bool cam_ignore, uint8_t priority,
+                                  uint32_t logic_serv)
+{
+    XiveVP vp;
+    XiveTCTXMatch match =3D { 0 };
+    bool found;
+
+    /* VPD cache lookup */
+    if (xive_router_get_vp(xrtr, vp_blk, vp_idx, &vp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no VP %x/%x\n",
+                      vp_blk, vp_idx);
+        return;
+    }
+
+    if (!(vp.w0 & VP_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: VP %x/%x is invalid\n",
+                      vp_blk, vp_idx);
+        return;
+    }
+
+    found =3D xive_presenter_match(xrtr, format, vp_blk, vp_idx, cam_ign=
ore,
+                                 priority, logic_serv, &match);
+    if (found) {
+        return;
+    }
+
+    /* If no VP dispatched on a HW thread :
+     * - update the VP if backlog is activated
+     * - escalate (ESe PQ bits and IVE in w4-5) if escalation is
+     *   activated
+     */
+}
+
 /*
  * An EQ trigger can come from an event trigger (IPI or HW) or from
  * another chip. We don't model the PowerBus but the EQ trigger
@@ -1043,6 +1262,14 @@ static void xive_router_eq_notify(XiveRouter *xrtr=
, uint8_t eq_blk,
     /*
      * Follows IVPE notification
      */
+    xive_presenter_notify(xrtr, format,
+                          GETFIELD(EQ_W6_NVT_BLOCK, eq.w6),
+                          GETFIELD(EQ_W6_NVT_INDEX, eq.w6),
+                          GETFIELD(EQ_W7_F0_IGNORE, eq.w7),
+                          priority,
+                          GETFIELD(EQ_W7_F1_LOG_SERVER_ID, eq.w7));
+
+    /* TODO: Auto EOI. */
 }
=20
 static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
--=20
2.13.6
