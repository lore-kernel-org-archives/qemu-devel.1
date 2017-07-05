Received: from eggs.gnu.org ([2001:4830:134:3::10]:41616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnta-0004DU-PL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntW-0003Hb-Nv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:22 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:48672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntW-0003Gy-EP
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:18 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6BE24FA9BB
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:26 +0200
Message-Id: <1499274819-15607-14-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 13/26] ppc/xive: introduce a XIVE interrupt
 presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Just like the interrupt source model, we try to reuse the ICP model
because the sPAPR machine is tied to the XICSFabric interface and
should be using a common framework to switch from one controller model
to another: XICS <-> XIVE.

The XIVE interrupt presenter exposes a set of Thread Interrupt
Management Areas, also called rings, one per different level of
privilege (four in all). We only expose the OS ring for the sPAPR
support for the moment. This area is used to handle priority
management and interrupt acknowledgment among other things.

The next patch will introduce the MMIO handlers to interact with the
TIMA, OS only.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive-internal.h | 84 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/intc/xive.c          | 43 +++++++++++++++++++++++++
 include/hw/ppc/xive.h   | 14 +++++++++
 3 files changed, 141 insertions(+)

diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index c06be823aad0..ba5e648a5258 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -24,6 +24,90 @@
 #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
                                  PPC_BIT32(bs))
=20
+/*
+ * Thread Management (aka "TM") registers
+ */
+
+/* TM register offsets */
+#define TM_QW0_USER             0x000 /* All rings */
+#define TM_QW1_OS               0x010 /* Ring 0..2 */
+#define TM_QW2_HV_POOL          0x020 /* Ring 0..1 */
+#define TM_QW3_HV_PHYS          0x030 /* Ring 0..1 */
+
+/* Byte offsets inside a QW             QW0 QW1 QW2 QW3 */
+#define TM_NSR                  0x0  /*  +   +   -   +  */
+#define TM_CPPR                 0x1  /*  -   +   -   +  */
+#define TM_IPB                  0x2  /*  -   +   +   +  */
+#define TM_LSMFB                0x3  /*  -   +   +   +  */
+#define TM_ACK_CNT              0x4  /*  -   +   -   -  */
+#define TM_INC                  0x5  /*  -   +   -   +  */
+#define TM_AGE                  0x6  /*  -   +   -   +  */
+#define TM_PIPR                 0x7  /*  -   +   -   +  */
+
+#define TM_WORD0                0x0
+#define TM_WORD1                0x4
+
+/*
+ * QW word 2 contains the valid bit at the top and other fields
+ * depending on the QW.
+ */
+#define TM_WORD2                0x8
+#define   TM_QW0W2_VU           PPC_BIT32(0)
+#define   TM_QW0W2_LOGIC_SERV   PPC_BITMASK32(1, 31) /* XX 2,31 ? */
+#define   TM_QW1W2_VO           PPC_BIT32(0)
+#define   TM_QW1W2_OS_CAM       PPC_BITMASK32(8, 31)
+#define   TM_QW2W2_VP           PPC_BIT32(0)
+#define   TM_QW2W2_POOL_CAM     PPC_BITMASK32(8, 31)
+#define   TM_QW3W2_VT           PPC_BIT32(0)
+#define   TM_QW3W2_LP           PPC_BIT32(6)
+#define   TM_QW3W2_LE           PPC_BIT32(7)
+#define   TM_QW3W2_T            PPC_BIT32(31)
+
+/*
+ * In addition to normal loads to "peek" and writes (only when invalid)
+ * using 4 and 8 bytes accesses, the above registers support these
+ * "special" byte operations:
+ *
+ *   - Byte load from QW0[NSR] - User level NSR (EBB)
+ *   - Byte store to QW0[NSR] - User level NSR (EBB)
+ *   - Byte load/store to QW1[CPPR] and QW3[CPPR] - CPPR access
+ *   - Byte load from QW3[TM_WORD2] - Read VT||00000||LP||LE on thrd 0
+ *                                    otherwise VT||0000000
+ *   - Byte store to QW3[TM_WORD2] - Set VT bit (and LP/LE if present)
+ *
+ * Then we have all these "special" CI ops at these offset that trigger
+ * all sorts of side effects:
+ */
+#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
+#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg */
+#define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate user co=
ntext */
+#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user
+                                         * context */
+#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit=
 */
+#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate=
 OS
+                                         * context to reg */
+#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate=
 Pool
+                                         * context to reg*/
+#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg */
+#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to =
odd
+                                         * line */
+#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even lin=
e */
+#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to eve=
n
+                                         * line */
+#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even lin=
e */
+/* XXX more... */
+
+/* NSR fields for the various QW ack types */
+#define TM_QW0_NSR_EB           PPC_BIT8(0)
+#define TM_QW1_NSR_EO           PPC_BIT8(0)
+#define TM_QW3_NSR_HE           PPC_BITMASK8(0, 1)
+#define  TM_QW3_NSR_HE_NONE     0
+#define  TM_QW3_NSR_HE_POOL     1
+#define  TM_QW3_NSR_HE_PHYS     2
+#define  TM_QW3_NSR_HE_LSI      3
+#define TM_QW3_NSR_I            PPC_BIT8(2)
+#define TM_QW3_NSR_GRP_LVL      PPC_BIT8(3, 7)
+
 /* IVE/EAS
  *
  * One per interrupt source. Targets that interrupt to a given EQ
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index db808e0cbe3d..c08a4f8efb58 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -26,6 +26,48 @@
=20
 #include "xive-internal.h"
=20
+static void xive_icp_reset(ICPState *icp)
+{
+    XiveICPState *xicp =3D XIVE_ICP(icp);
+
+    memset(xicp->tima, 0, sizeof(xicp->tima));
+}
+
+static void xive_icp_print_info(ICPState *icp, Monitor *mon)
+{
+    XiveICPState *xicp =3D XIVE_ICP(icp);
+
+    monitor_printf(mon, " CPPR=3D%02x IPB=3D%02x PIPR=3D%02x NSR=3D%02x\=
n",
+                   xicp->tima_os[TM_CPPR], xicp->tima_os[TM_IPB],
+                   xicp->tima_os[TM_PIPR], xicp->tima_os[TM_NSR]);
+}
+
+static void xive_icp_init(Object *obj)
+{
+    XiveICPState *xicp =3D XIVE_ICP(obj);
+
+    xicp->tima_os =3D &xicp->tima[TM_QW1_OS];
+}
+
+static void xive_icp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ICPStateClass *icpc =3D ICP_CLASS(klass);
+
+    dc->desc =3D "PowerNV Xive ICP";
+    icpc->reset =3D xive_icp_reset;
+    icpc->print_info =3D xive_icp_print_info;
+}
+
+static const TypeInfo xive_icp_info =3D {
+    .name          =3D TYPE_XIVE_ICP,
+    .parent        =3D TYPE_ICP,
+    .instance_size =3D sizeof(XiveICPState),
+    .instance_init =3D xive_icp_init,
+    .class_init    =3D xive_icp_class_init,
+    .class_size    =3D sizeof(ICPStateClass),
+};
+
 static void xive_icp_irq(XiveICSState *xs, int lisn)
 {
=20
@@ -529,6 +571,7 @@ static void xive_register_types(void)
 {
     type_register_static(&xive_info);
     type_register_static(&xive_ics_info);
+    type_register_static(&xive_icp_info);
 }
=20
 type_init(xive_register_types)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index b06bc861b845..f87df8107dd9 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -23,6 +23,7 @@
=20
 typedef struct XIVE XIVE;
 typedef struct XiveICSState XiveICSState;
+typedef struct XiveICPState XiveICPState;
=20
 #define TYPE_XIVE "xive"
 #define XIVE(obj) OBJECT_CHECK(XIVE, (obj), TYPE_XIVE)
@@ -38,6 +39,9 @@ typedef struct XiveICSState XiveICSState;
 #define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
 #define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
=20
+#define TYPE_XIVE_ICP "xive-icp"
+#define XIVE_ICP(obj) OBJECT_CHECK(XiveICPState, (obj), TYPE_XIVE_ICP)
+
 struct XiveICSState {
     ICSState parent_obj;
=20
@@ -49,4 +53,14 @@ struct XiveICSState {
     XIVE         *xive;
 };
=20
+/* Number of Thread Management Interrupt Areas */
+#define XIVE_TM_RING_COUNT 4
+
+struct XiveICPState {
+    ICPState parent_obj;
+
+    uint8_t tima[XIVE_TM_RING_COUNT * 0x10];
+    uint8_t *tima_os;
+};
+
 #endif /* PPC_XIVE_H */
--=20
2.7.5
