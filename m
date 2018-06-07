Received: from eggs.gnu.org ([2001:4830:134:3::10]:38814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBq-00023v-Dq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBl-0003hy-Kh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:06 -0400
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:52400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBl-0003h1-B3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:01 -0400
Received: from player169.ha.ovh.net (unknown [10.109.122.116])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id DD9B1B08C1
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:50:59 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:43 +0200
Message-Id: <20180607155003.1580-9-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 08/28] ppc/xive: introduce the XIVE Event
 Queues
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

The Event Queue Descriptor (EQD) table is an internal table of the
XIVE routing sub-engine, the IVRE. It specifies on which Event Queue
the Event Queue data should be posted when an exception occurs (and
later on pulled by the OS) and which Virtual Processor to notify.

The routing algorithm of the XiveRouter is extended to push in the
system memory event queue the Event Queue data defined in the
associated IVE. The event queue is a circular buffer in RAM provided
by the OS, one per server and priority couple, containing Event Queue
entries. These are 4 bytes long, the first bit being a 'generation'
bit and the 31 following bits the EQ Data field.

The EQ Data field is a way to set an invariant logical event source
number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall
when the EISN flag is used.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |  17 +++++
 include/hw/ppc/xive_regs.h |  48 +++++++++++++
 hw/intc/xive.c             | 163 +++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 13c414bf7d55..fc2ed7319f0f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -193,11 +193,28 @@ typedef struct XiveRouterClass {
     /* XIVE table accessors */
     int (*get_ive)(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
     int (*set_ive)(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
+    int (*get_eq)(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx,
+                   XiveEQ *eq);
+    int (*set_eq)(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx,
+                   XiveEQ *eq);
 } XiveRouterClass;
=20
 void xive_router_print_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive=
,
                            Monitor *mon);
 int xive_router_get_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
 int xive_router_set_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive);
+int xive_router_get_eq(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx=
,
+                       XiveEQ *eq);
+int xive_router_set_eq(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx=
,
+                       XiveEQ *eq);
+
+/*
+ * For legacy compatibility, the exceptions define up to 256 different
+ * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
+ * and the least favored level 0xFF.
+ */
+#define XIVE_PRIORITY_MAX  7
+
+void xive_eq_reset(XiveEQ *eq);
=20
 #endif /* PPC_XIVE_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 74420030111a..50d96d028002 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -27,4 +27,52 @@ typedef struct XiveIVE {
 #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
 } XiveIVE;
=20
+/* EQ */
+typedef struct XiveEQ {
+        uint32_t        w0;
+#define EQ_W0_VALID             PPC_BIT32(0) /* "v" bit */
+#define EQ_W0_ENQUEUE           PPC_BIT32(1) /* "q" bit */
+#define EQ_W0_UCOND_NOTIFY      PPC_BIT32(2) /* "n" bit */
+#define EQ_W0_BACKLOG           PPC_BIT32(3) /* "b" bit */
+#define EQ_W0_PRECL_ESC_CTL     PPC_BIT32(4) /* "p" bit */
+#define EQ_W0_ESCALATE_CTL      PPC_BIT32(5) /* "e" bit */
+#define EQ_W0_UNCOND_ESCALATE   PPC_BIT32(6) /* "u" bit - DD2.0 */
+#define EQ_W0_SILENT_ESCALATE   PPC_BIT32(7) /* "s" bit - DD2.0 */
+#define EQ_W0_QSIZE             PPC_BITMASK32(12, 15)
+#define EQ_W0_SW0               PPC_BIT32(16)
+#define EQ_W0_FIRMWARE          EQ_W0_SW0 /* Owned by FW */
+#define EQ_QSIZE_4K             0
+#define EQ_QSIZE_64K            4
+#define EQ_W0_HWDEP             PPC_BITMASK32(24, 31)
+        uint32_t        w1;
+#define EQ_W1_ESn               PPC_BITMASK32(0, 1)
+#define EQ_W1_ESn_P             PPC_BIT32(0)
+#define EQ_W1_ESn_Q             PPC_BIT32(1)
+#define EQ_W1_ESe               PPC_BITMASK32(2, 3)
+#define EQ_W1_ESe_P             PPC_BIT32(2)
+#define EQ_W1_ESe_Q             PPC_BIT32(3)
+#define EQ_W1_GENERATION        PPC_BIT32(9)
+#define EQ_W1_PAGE_OFF          PPC_BITMASK32(10, 31)
+        uint32_t        w2;
+#define EQ_W2_MIGRATION_REG     PPC_BITMASK32(0, 3)
+#define EQ_W2_OP_DESC_HI        PPC_BITMASK32(4, 31)
+        uint32_t        w3;
+#define EQ_W3_OP_DESC_LO        PPC_BITMASK32(0, 31)
+        uint32_t        w4;
+#define EQ_W4_ESC_EQ_BLOCK      PPC_BITMASK32(4, 7)
+#define EQ_W4_ESC_EQ_INDEX      PPC_BITMASK32(8, 31)
+        uint32_t        w5;
+#define EQ_W5_ESC_EQ_DATA       PPC_BITMASK32(1, 31)
+        uint32_t        w6;
+#define EQ_W6_FORMAT_BIT        PPC_BIT32(8)
+#define EQ_W6_NVT_BLOCK         PPC_BITMASK32(9, 12)
+#define EQ_W6_NVT_INDEX         PPC_BITMASK32(13, 31)
+        uint32_t        w7;
+#define EQ_W7_F0_IGNORE         PPC_BIT32(0)
+#define EQ_W7_F0_BLK_GROUPING   PPC_BIT32(1)
+#define EQ_W7_F0_PRIORITY       PPC_BITMASK32(8, 15)
+#define EQ_W7_F1_WAKEZ          PPC_BIT32(0)
+#define EQ_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
+} XiveEQ;
+
 #endif /* _PPC_XIVE_REGS_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7f007d5a3ec0..ae5c7f545d30 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -443,6 +443,64 @@ static const TypeInfo xive_source_info =3D {
 };
=20
 /*
+ * XiveEQ helpers
+ */
+
+void xive_eq_reset(XiveEQ *eq)
+{
+    memset(eq, 0, sizeof(*eq));
+
+    /* switch off the escalation and notification ESBs */
+    eq->w1 =3D EQ_W1_ESe_Q | EQ_W1_ESn_Q;
+}
+
+static void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon)
+{
+    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
+    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
+    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
+    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
+    uint32_t qentries =3D 1 << (qsize + 10);
+
+    uint32_t server =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+    uint8_t priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
+
+    monitor_printf(mon, "%c%c%c%c%c prio:%d server:%03d eq:@%08"PRIx64
+                   "% 6d/%5d ^%d",
+                   eq->w0 & EQ_W0_VALID ? 'v' : '-',
+                   eq->w0 & EQ_W0_ENQUEUE ? 'q' : '-',
+                   eq->w0 & EQ_W0_UCOND_NOTIFY ? 'n' : '-',
+                   eq->w0 & EQ_W0_BACKLOG ? 'b' : '-',
+                   eq->w0 & EQ_W0_ESCALATE_CTL ? 'e' : '-',
+                   priority, server, qaddr_base, qindex, qentries, qgen)=
;
+}
+
+static void xive_eq_push(XiveEQ *eq, uint32_t data)
+{
+    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
+    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
+    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
+    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
+
+    uint64_t qaddr =3D qaddr_base + (qindex << 2);
+    uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
+    uint32_t qentries =3D 1 << (qsize + 10);
+
+    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qd=
ata))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to write EQ data @0=
x%"
+                      HWADDR_PRIx "\n", qaddr);
+        return;
+    }
+
+    qindex =3D (qindex + 1) % qentries;
+    if (qindex =3D=3D 0) {
+        qgen ^=3D 1;
+        eq->w1 =3D SETFIELD(EQ_W1_GENERATION, eq->w1, qgen);
+    }
+    eq->w1 =3D SETFIELD(EQ_W1_PAGE_OFF, eq->w1, qindex);
+}
+
+/*
  * XIVE Router (aka. Virtualization Controller or IVRE)
  */
=20
@@ -460,6 +518,81 @@ int xive_router_set_ive(XiveRouter *xrtr, uint32_t l=
isn, XiveIVE *ive)
     return xrc->set_ive(xrtr, lisn, ive);
 }
=20
+int xive_router_get_eq(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx=
,
+                       XiveEQ *eq)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_eq(xrtr, eq_blk, eq_idx, eq);
+}
+
+int xive_router_set_eq(XiveRouter *xrtr, uint8_t eq_blk, uint32_t eq_idx=
,
+                       XiveEQ *eq)
+{
+   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->set_eq(xrtr, eq_blk, eq_idx, eq);
+}
+
+/*
+ * An EQ trigger can come from an event trigger (IPI or HW) or from
+ * another chip. We don't model the PowerBus but the EQ trigger
+ * message has the same parameters than in the function below.
+ */
+static void xive_router_eq_notify(XiveRouter *xrtr, uint8_t eq_blk,
+                                  uint32_t eq_idx, uint32_t eq_data)
+{
+    XiveEQ eq;
+    uint8_t priority;
+    uint8_t format;
+
+    /* EQD cache lookup */
+    if (xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ %x/%x\n", eq_blk, eq=
_idx);
+        return;
+    }
+
+    if (!(eq.w0 & EQ_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: EQ %x/%x is invalid\n",
+                      eq_blk, eq_idx);
+        return;
+    }
+
+    if (eq.w0 & EQ_W0_ENQUEUE) {
+        xive_eq_push(&eq, eq_data);
+        xive_router_set_eq(xrtr, eq_blk, eq_idx, &eq);
+    }
+
+    /*
+     * The W7 format depends on the F bit in W6. It defines the type
+     * of the notification :
+     *
+     *   F=3D0 : single or multiple VP notification
+     *   F=3D1 : User level Event-Based Branch (EBB) notification, no
+     *         priority
+     */
+    format =3D GETFIELD(EQ_W6_FORMAT_BIT, eq.w6);
+    priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq.w7);
+
+    /* The EQ is masked */
+    if (format =3D=3D 0 && priority =3D=3D 0xff) {
+        return;
+    }
+
+    /*
+     * Check the EQ ESn (Event State Buffer for notification) for
+     * futher even coalescing in the Router
+     */
+    if (!(eq.w0 & EQ_W0_UCOND_NOTIFY)) {
+        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
+        return;
+    }
+
+    /*
+     * Follows IVPE notification
+     */
+}
+
 static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xf);
@@ -486,6 +619,14 @@ static void xive_router_notify(XiveFabric *xf, uint3=
2_t lisn)
         /* Notification completed */
         return;
     }
+
+    /*
+     * The event trigger becomes an EQ trigger
+     */
+    xive_router_eq_notify(xrtr,
+                          GETFIELD(IVE_EQ_BLOCK, ive.w),
+                          GETFIELD(IVE_EQ_INDEX, ive.w),
+                          GETFIELD(IVE_EQ_DATA,  ive.w));
 }
=20
 static Property xive_router_properties[] =3D {
@@ -518,11 +659,31 @@ static const TypeInfo xive_router_info =3D {
 void xive_router_print_ive(XiveRouter *xrtr, uint32_t lisn, XiveIVE *ive=
,
                            Monitor *mon)
 {
+    uint8_t eq_blk;
+    uint32_t eq_idx;
+
     if (!(ive->w & IVE_VALID)) {
         return;
     }
=20
-    monitor_printf(mon, "  %8x %s\n", lisn, ive->w & IVE_MASKED ? "M" : =
" ");
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+    eq_blk =3D GETFIELD(IVE_EQ_BLOCK, ive->w);
+
+    monitor_printf(mon, "  %8x %s eqidx:%04x eqblk:%02x ", lisn,
+                   ive->w & IVE_MASKED ? "M" : " ", eq_idx, eq_blk);
+
+    if (!(ive->w & IVE_MASKED)) {
+        XiveEQ eq;
+
+        if (!xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq)) {
+            xive_eq_pic_print_info(&eq, mon);
+            monitor_printf(mon, " data:%08x",
+                           (int) GETFIELD(IVE_EQ_DATA, ive->w));
+        } else {
+            monitor_printf(mon, "no eq ?!");
+        }
+    }
+    monitor_printf(mon, "\n");
 }
=20
 /*
--=20
2.13.6
