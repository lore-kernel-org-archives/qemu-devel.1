Received: from eggs.gnu.org ([2001:4830:134:3::10]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpk-00073k-24
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbpg-0007kV-0t
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:44 -0500
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:50978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbpa-0007gx-VC
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:38 -0500
Received: from player734.ha.ovh.net (unknown [10.109.160.76])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BE7D02054D3
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:58:25 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:01 +0100
Message-Id: <20181116105729.23240-9-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 08/36] ppc/xive: introduce a simplified XIVE
 presenter
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

The last sub-engine of the XIVE architecture is the Interrupt
Virtualization Presentation Engine (IVPE). On HW, they share elements,
the Power Bus interface (CQ), the routing table descriptors, and they
can be combined in the same HW logic. We do the same in QEMU and
combine both engines in the XiveRouter for simplicity.

When the IVRE has completed its job of matching an event source with a
Notification Virtual Target (NVT) to notify, it forwards the event
notification to the IVPE sub-engine. The IVPE scans the thread
interrupt contexts of the Notification Virtual Targets (NVT)
dispatched on the HW processor threads and if a match is found, it
signals the thread. If not, the IVPE escalates the notification to
some other targets and records the notification in a backlog queue.

The IVPE maintains the thread interrupt context state for each of its
NVTs not dispatched on HW processor threads in the Notification
Virtual Target table (NVTT).

The model currently only supports single NVT notifications.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |  13 +++
 include/hw/ppc/xive_regs.h |  22 ++++
 hw/intc/xive.c             | 223 +++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 5987f26ddb98..e715a6c6923d 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -197,6 +197,10 @@ typedef struct XiveRouterClass {
                    XiveEND *end);
     int (*set_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
                    XiveEND *end);
+    int (*get_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
+                   XiveNVT *nvt);
+    int (*set_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
+                   XiveNVT *nvt);
 } XiveRouterClass;
=20
 void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
@@ -207,6 +211,10 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t en=
d_blk, uint32_t end_idx,
                         XiveEND *end);
 int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_=
idx,
                         XiveEND *end);
+int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_=
idx,
+                        XiveNVT *nvt);
+int xive_router_set_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_=
idx,
+                        XiveNVT *nvt);
=20
 /*
  * XIVE END ESBs
@@ -274,4 +282,9 @@ extern const MemoryRegionOps xive_tm_ops;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
=20
+static inline uint32_t xive_tctx_cam_line(uint8_t nvt_blk, uint32_t nvt_=
idx)
+{
+    return (nvt_blk << 19) | nvt_idx;
+}
+
 #endif /* PPC_XIVE_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 2e3d6cb507da..05cb992d2815 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -158,4 +158,26 @@ typedef struct XiveEND {
 #define END_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
 } XiveEND;
=20
+/* Notification Virtual Target (NVT) */
+typedef struct XiveNVT {
+        uint32_t        w0;
+#define NVT_W0_VALID             PPC_BIT32(0)
+        uint32_t        w1;
+        uint32_t        w2;
+        uint32_t        w3;
+        uint32_t        w4;
+        uint32_t        w5;
+        uint32_t        w6;
+        uint32_t        w7;
+        uint32_t        w8;
+#define NVT_W8_GRP_VALID         PPC_BIT32(0)
+        uint32_t        w9;
+        uint32_t        wa;
+        uint32_t        wb;
+        uint32_t        wc;
+        uint32_t        wd;
+        uint32_t        we;
+        uint32_t        wf;
+} XiveNVT;
+
 #endif /* PPC_XIVE_REGS_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4c6cb5d52975..5ba3b06e6e25 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -373,6 +373,32 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
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
+static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx, bool block_group)
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
@@ -1013,6 +1039,195 @@ int xive_router_set_end(XiveRouter *xrtr, uint8_t=
 end_blk, uint32_t end_idx,
    return xrc->set_end(xrtr, end_blk, end_idx, end);
 }
=20
+int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_=
idx,
+                        XiveNVT *nvt)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_nvt(xrtr, nvt_blk, nvt_idx, nvt);
+}
+
+int xive_router_set_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_=
idx,
+                        XiveNVT *nvt)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->set_nvt(xrtr, nvt_blk, nvt_idx, nvt);
+}
+
+static bool xive_tctx_ring_match(XiveTCTX *tctx, uint8_t ring,
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                 bool cam_ignore, uint32_t logic_serv)
+{
+    uint8_t *regs =3D &tctx->regs[ring];
+    uint32_t w2 =3D be32_to_cpu(*((uint32_t *) &regs[TM_WORD2]));
+    uint32_t cam =3D xive_tctx_cam_line(nvt_blk, nvt_idx);
+    bool block_group =3D false; /* TODO (PowerNV) */
+
+    /* TODO (PowerNV): ignore low order bits of nvt id */
+
+    switch (ring) {
+    case TM_QW3_HV_PHYS:
+        return (w2 & TM_QW3W2_VT) && xive_tctx_hw_cam_line(tctx, block_g=
roup) =3D=3D
+            tctx_hw_cam_line(block_group, nvt_blk, nvt_idx);
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
+                                     uint8_t nvt_blk, uint32_t nvt_idx,
+                                     bool cam_ignore, uint32_t logic_ser=
v)
+{
+    if (format =3D=3D 0) {
+        /* F=3D0 & i=3D1: Logical server notification */
+        if (cam_ignore =3D=3D true) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no support for LS "
+                          "NVT %x/%x\n", nvt_blk, nvt_idx);
+             return -1;
+        }
+
+        /* F=3D0 & i=3D0: Specific NVT notification */
+        if (xive_tctx_ring_match(tctx, TM_QW3_HV_PHYS,
+                                nvt_blk, nvt_idx, false, 0)) {
+            return TM_QW3_HV_PHYS;
+        }
+        if (xive_tctx_ring_match(tctx, TM_QW2_HV_POOL,
+                                nvt_blk, nvt_idx, false, 0)) {
+            return TM_QW2_HV_POOL;
+        }
+        if (xive_tctx_ring_match(tctx, TM_QW1_OS,
+                                nvt_blk, nvt_idx, false, 0)) {
+            return TM_QW1_OS;
+        }
+    } else {
+        /* F=3D1 : User level Event-Based Branch (EBB) notification */
+        if (xive_tctx_ring_match(tctx, TM_QW0_USER,
+                                nvt_blk, nvt_idx, false, logic_serv)) {
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
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
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
+        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
+                                         cam_ignore, logic_serv);
+        /*
+         * Save the context and follow on to catch duplicates, that we
+         * don't support yet.
+         */
+        if (ring !=3D -1) {
+            if (match->tctx) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
+                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
+                return false;
+            }
+
+            match->ring =3D ring;
+            match->tctx =3D tctx;
+        }
+    }
+
+    if (!match->tctx) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatche=
d\n",
+                      nvt_blk, nvt_idx);
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
+ * It receives notification requests sent by the IVRE to find one
+ * matching NVT (or more) dispatched on the processor threads. In case
+ * of a single NVT notification, the process is abreviated and the
+ * thread is signaled if a match is found. In case of a logical server
+ * notification (bits ignored at the end of the NVT identifier), the
+ * IVPE and IVRE select a winning thread using different filters. This
+ * involves 2 or 3 exchanges on the PowerBus that the model does not
+ * support.
+ *
+ * The parameters represent what is sent on the PowerBus
+ */
+static void xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
+                                  uint8_t nvt_blk, uint32_t nvt_idx,
+                                  bool cam_ignore, uint8_t priority,
+                                  uint32_t logic_serv)
+{
+    XiveNVT nvt;
+    XiveTCTXMatch match =3D { 0 };
+    bool found;
+
+    /* NVT cache lookup */
+    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
+                      nvt_blk, nvt_idx);
+        return;
+    }
+
+    if (!(nvt.w0 & NVT_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is invalid\n",
+                      nvt_blk, nvt_idx);
+        return;
+    }
+
+    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
+                                 priority, logic_serv, &match);
+    if (found) {
+        return;
+    }
+
+    /* If no matching NVT is dispatched on a HW thread :
+     * - update the NVT structure if backlog is activated
+     * - escalate (ESe PQ bits and EAS in w4-5) if escalation is
+     *   activated
+     */
+}
+
 /*
  * An END trigger can come from an event trigger (IPI or HW) or from
  * another chip. We don't model the PowerBus but the END trigger
@@ -1081,6 +1296,14 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
     /*
      * Follows IVPE notification
      */
+    xive_presenter_notify(xrtr, format,
+                          GETFIELD(END_W6_NVT_BLOCK, end.w6),
+                          GETFIELD(END_W6_NVT_INDEX, end.w6),
+                          GETFIELD(END_W7_F0_IGNORE, end.w7),
+                          priority,
+                          GETFIELD(END_W7_F1_LOG_SERVER_ID, end.w7));
+
+    /* TODO: Auto EOI. */
 }
=20
 static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
--=20
2.17.2
