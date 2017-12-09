Received: from eggs.gnu.org ([2001:4830:134:3::10]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakQ-00016S-Km
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakM-000707-M2
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:38 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:52903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNakM-0006zm-CH
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:34 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 411A01277A1
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:33 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:25 +0100
Message-Id: <20171209084338.29395-7-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/19] spapr: introduce the XIVE Event Queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Event Queue Descriptor (EQD) table, also known as Event
Notification Descriptor (END), is an internal table of the XIVE
virtualization routing engine. It specifies on which Event Queue the
event data should be posted when an exception occurs (later on pulled
by the OS) and which Virtual Processor to notify. The Event Queue is a
much more complex structure but we start with a simple model for the
sPAPR machine.

There is one XiveEQ per priority and the model chooses to store them
under the XIVE virtualization presenter model (sPAPRXiveNVT) to save
an extra table. EQs are simply indexed with :

       (server << 3) | (priority & 0x7)

This is not in the XIVE architecture but as the EQ index is never
exposed to the guest, in the hcalls or in the device tree, we are free
to use what fits best the current model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:

 - removed spapr_xive_eq_for_server() which did the EQ indexing.
 - changed spapr_xive_get_eq() to use a server and a priority parameter
 - introduced a couple of macro for the EQ indexing.=20
 - improved 'info pic' output

 hw/intc/spapr_xive.c    | 48 ++++++++++++++++++++++++++++++++++++++++++-=
-
 hw/intc/xive-internal.h | 53 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 53f0e698e135..8e990d58ecf4 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -15,6 +15,7 @@
 #include "sysemu/dma.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/spapr_xive.h"
+#include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
=20
 #include "xive-internal.h"
@@ -30,6 +31,8 @@ struct sPAPRXiveNVT {
=20
     /* Shortcut to the OS ring */
     uint8_t   *ring_os;
+
+    XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
 };
=20
 static uint64_t spapr_xive_nvt_accept(sPAPRXiveNVT *nvt)
@@ -186,6 +189,13 @@ static const MemoryRegionOps spapr_xive_tm_user_ops =
=3D {
     },
 };
=20
+static sPAPRXiveNVT *spapr_xive_nvt_get(sPAPRXive *xive, int server)
+{
+    PowerPCCPU *cpu =3D spapr_find_cpu(server);
+
+    return cpu ? SPAPR_XIVE_NVT(cpu->intc) : NULL;
+}
+
 static void spapr_xive_irq(sPAPRXive *xive, int lisn)
 {
=20
@@ -461,19 +471,22 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Mon=
itor *mon)
     for (i =3D 0; i < xive->nr_irqs; i++) {
         XiveIVE *ive =3D &xive->ivt[i];
         uint8_t pq;
+        uint32_t eq_idx;
=20
         if (!(ive->w & IVE_VALID)) {
             continue;
         }
=20
         pq =3D spapr_xive_pq_get(xive, i);
+        eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
=20
-        monitor_printf(mon, "  %4x %s %s %c%c %08x %08x\n", i,
+        monitor_printf(mon, "  %4x %s %s %c%c server:%d prio:%d %08x\n",=
 i,
                        spapr_xive_irq_is_lsi(xive, i) ? "LSI" : "MSI",
                        ive->w & IVE_MASKED ? "M" : " ",
                        pq & XIVE_ESB_VAL_P ? 'P' : '-',
                        pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                       (int) GETFIELD(IVE_EQ_INDEX, ive->w),
+                       XIVE_EQ_INDEX_SERVER(eq_idx),
+                       XIVE_EQ_INDEX_PRIO(eq_idx),
                        (int) GETFIELD(IVE_EQ_DATA, ive->w));
     }
 }
@@ -611,6 +624,8 @@ static void spapr_xive_nvt_reset(void *dev)
     sPAPRXiveNVT *nvt =3D SPAPR_XIVE_NVT(dev);
=20
     memset(nvt->regs, 0, sizeof(nvt->regs));
+
+    memset(nvt->eqt, 0, sizeof(nvt->eqt));
 }
=20
 static void spapr_xive_nvt_realize(DeviceState *dev, Error **errp)
@@ -658,6 +673,23 @@ static void spapr_xive_nvt_init(Object *obj)
     nvt->ring_os =3D &nvt->regs[TM_QW1_OS];
 }
=20
+static const VMStateDescription vmstate_spapr_xive_nvt_eq =3D {
+    .name =3D TYPE_SPAPR_XIVE_NVT "/eq",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField []) {
+        VMSTATE_UINT32(w0, XiveEQ),
+        VMSTATE_UINT32(w1, XiveEQ),
+        VMSTATE_UINT32(w2, XiveEQ),
+        VMSTATE_UINT32(w3, XiveEQ),
+        VMSTATE_UINT32(w4, XiveEQ),
+        VMSTATE_UINT32(w5, XiveEQ),
+        VMSTATE_UINT32(w6, XiveEQ),
+        VMSTATE_UINT32(w7, XiveEQ),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool vmstate_spapr_xive_nvt_needed(void *opaque)
 {
     /* TODO check machine XIVE support */
@@ -671,6 +703,8 @@ static const VMStateDescription vmstate_spapr_xive_nv=
t =3D {
     .needed =3D vmstate_spapr_xive_nvt_needed,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(regs, sPAPRXiveNVT),
+        VMSTATE_STRUCT_ARRAY(eqt, sPAPRXiveNVT, (XIVE_PRIORITY_MAX + 1),=
 1,
+                             vmstate_spapr_xive_nvt_eq, XiveEQ),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -731,3 +765,13 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_=
t lisn)
     xive->status[lisn] =3D 0;
     return true;
 }
+
+XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t server, uint8_t prio=
rity)
+{
+    sPAPRXiveNVT *nvt =3D spapr_xive_nvt_get(xive, server);
+
+    if (!nvt || priority > XIVE_PRIORITY_MAX) {
+        return NULL;
+    }
+    return &nvt->eqt[priority];
+}
diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index 49f4b7c5f393..fcd740d276f7 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -136,8 +136,61 @@ typedef struct XiveIVE {
 #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
 } XiveIVE;
=20
+/* EQ */
+typedef struct XiveEQ {
+        uint32_t        w0;
+#define EQ_W0_VALID             PPC_BIT32(0)
+#define EQ_W0_ENQUEUE           PPC_BIT32(1)
+#define EQ_W0_UCOND_NOTIFY      PPC_BIT32(2)
+#define EQ_W0_BACKLOG           PPC_BIT32(3)
+#define EQ_W0_PRECL_ESC_CTL     PPC_BIT32(4)
+#define EQ_W0_ESCALATE_CTL      PPC_BIT32(5)
+#define EQ_W0_END_OF_INTR       PPC_BIT32(6)
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
 #define XIVE_PRIORITY_MAX  7
=20
 XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn);
+XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t server, uint8_t prio=
rity);
+
+#define XIVE_EQ_INDEX(server, prio) (((server) << 3) | ((prio) & 0x7))
+#define XIVE_EQ_INDEX_SERVER(eq_idx) ((eq_idx) >> 3)
+#define XIVE_EQ_INDEX_PRIO(eq_idx) ((eq_idx) & 0x7)
+
=20
 #endif /* _INTC_XIVE_INTERNAL_H */
--=20
2.13.6
