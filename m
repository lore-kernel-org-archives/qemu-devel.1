Received: from eggs.gnu.org ([2001:4830:134:3::10]:51281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICe-0004E5-PA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICa-0002qU-Hl
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:02:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:23 +1100
Message-Id: <20181213040126.6768-25-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/27] ppc/xive: introduce a simplified XIVE
 presenter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The last sub-engine of the XIVE architecture is the Interrupt
Virtualization Presentation Engine (IVPE). On HW, the IVRE and the
IVPE share elements, the Power Bus interface (CQ), the routing table
descriptors, and they can be combined in the same HW logic. We do the
same in QEMU and combine both engines in the XiveRouter for
simplicity.

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c             | 185 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/xive.h      |  14 +++
 include/hw/ppc/xive_regs.h |  24 +++++
 3 files changed, 223 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2615d16b74..3eecffe99b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -983,6 +983,183 @@ int xive_router_write_end(XiveRouter *xrtr, uint8_t=
 end_blk, uint32_t end_idx,
    return xrc->write_end(xrtr, end_blk, end_idx, end, word_number);
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
+int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
+                        XiveNVT *nvt, uint8_t word_number)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
+}
+
+/*
+ * The thread context register words are in big-endian format.
+ */
+static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
+                                     uint8_t nvt_blk, uint32_t nvt_idx,
+                                     bool cam_ignore, uint32_t logic_ser=
v)
+{
+    uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
+    uint32_t qw2w2 =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
+    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
+    uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
+
+    /* TODO (PowerNV): ignore mode. The low order bits of the NVT
+     * identifier are ignored in the "CAM" match.
+     */
+
+    if (format =3D=3D 0) {
+        if (cam_ignore =3D=3D true) {
+            /* F=3D0 & i=3D1: Logical server notification (bits ignored =
at
+             * the end of the NVT identifier)
+             */
+            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\=
n",
+                          nvt_blk, nvt_idx);
+             return -1;
+        }
+
+        /* F=3D0 & i=3D0: Specific NVT notification */
+
+        /* TODO (PowerNV) : PHYS ring */
+
+        /* HV POOL ring */
+        if ((be32_to_cpu(qw2w2) & TM_QW2W2_VP) &&
+            cam =3D=3D GETFIELD_BE32(TM_QW2W2_POOL_CAM, qw2w2)) {
+            return TM_QW2_HV_POOL;
+        }
+
+        /* OS ring */
+        if ((be32_to_cpu(qw1w2) & TM_QW1W2_VO) &&
+            cam =3D=3D GETFIELD_BE32(TM_QW1W2_OS_CAM, qw1w2)) {
+            return TM_QW1_OS;
+        }
+    } else {
+        /* F=3D1 : User level Event-Based Branch (EBB) notification */
+
+        /* USER ring */
+        if  ((be32_to_cpu(qw1w2) & TM_QW1W2_VO) &&
+             (cam =3D=3D GETFIELD_BE32(TM_QW1W2_OS_CAM, qw1w2)) &&
+             (be32_to_cpu(qw0w2) & TM_QW0W2_VU) &&
+             (logic_serv =3D=3D GETFIELD_BE32(TM_QW0W2_LOGIC_SERV, qw0w2=
))) {
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
+        qemu_log_mask(LOG_UNIMP, "XIVE: NVT %x/%x is not dispatched\n",
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
+    XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
+    bool found;
+
+    /* NVT cache lookup */
+    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
+                      nvt_blk, nvt_idx);
+        return;
+    }
+
+    if (!xive_nvt_is_valid(&nvt)) {
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
@@ -1052,6 +1229,14 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
     /*
      * Follows IVPE notification
      */
+    xive_presenter_notify(xrtr, format,
+                          GETFIELD_BE32(END_W6_NVT_BLOCK, end.w6),
+                          GETFIELD_BE32(END_W6_NVT_INDEX, end.w6),
+                          GETFIELD_BE32(END_W7_F0_IGNORE, end.w7),
+                          priority,
+                          GETFIELD_BE32(END_W7_F1_LOG_SERVER_ID, end.w7)=
);
+
+    /* TODO: Auto EOI. */
 }
=20
 static void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 1e823a4c64..19309d1d65 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -325,6 +325,10 @@ typedef struct XiveRouterClass {
                    XiveEND *end);
     int (*write_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx=
,
                      XiveEND *end, uint8_t word_number);
+    int (*get_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
+                   XiveNVT *nvt);
+    int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
+                     XiveNVT *nvt, uint8_t word_number);
 } XiveRouterClass;
=20
 void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
@@ -335,6 +339,11 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t en=
d_blk, uint32_t end_idx,
                         XiveEND *end);
 int xive_router_write_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t en=
d_idx,
                           XiveEND *end, uint8_t word_number);
+int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_=
idx,
+                        XiveNVT *nvt);
+int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
+                          XiveNVT *nvt, uint8_t word_number);
+
=20
 /*
  * XIVE END ESBs
@@ -411,4 +420,9 @@ extern const MemoryRegionOps xive_tm_ops;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
=20
+static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
+{
+    return (nvt_blk << 19) | nvt_idx;
+}
+
 #endif /* PPC_XIVE_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index ede3d04c5e..85557e730c 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -186,4 +186,28 @@ typedef struct XiveEND {
 #define GETFIELD_BE32(m, v)       GETFIELD(m, be32_to_cpu(v))
 #define SETFIELD_BE32(m, v, val)  cpu_to_be32(SETFIELD(m, be32_to_cpu(v)=
, val))
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
+#define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID=
)
+
 #endif /* PPC_XIVE_REGS_H */
--=20
2.19.2
