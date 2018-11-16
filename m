Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbp5-0006MS-U6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbp1-0007IK-Ox
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:58:03 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:33520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbp1-0007Bw-Ev
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:57:59 -0500
Received: from player734.ha.ovh.net (unknown [10.109.160.143])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 38E2A106869
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:57:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:56:55 +0100
Message-Id: <20181116105729.23240-3-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 02/36] ppc/xive: add support for the LSI
 interrupt sources
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

The 'sent' status of the LSI interrupt source is modeled with the 'P'
bit of the ESB and the assertion status of the source is maintained in
an array under the main sPAPRXive object. The type of the source is
stored in the same array for practical reasons.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 20 ++++++++++++-
 hw/intc/xive.c        | 68 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 5fec4b08705d..e118acd59f1e 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -32,8 +32,10 @@ typedef struct XiveSource {
     /* IRQs */
     uint32_t        nr_irqs;
     qemu_irq        *qirqs;
+    unsigned long   *lsi_map;
+    int32_t         lsi_map_size; /* for VMSTATE_BITMAP */
=20
-    /* PQ bits */
+    /* PQ bits and LSI assertion bit */
     uint8_t         *status;
=20
     /* ESB memory region */
@@ -89,6 +91,7 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource *x=
src, int srcno)
  * When doing an EOI, the Q bit will indicate if the interrupt
  * needs to be re-triggered.
  */
+#define XIVE_STATUS_ASSERTED  0x4  /* Extra bit for LSI */
 #define XIVE_ESB_VAL_P        0x2
 #define XIVE_ESB_VAL_Q        0x1
=20
@@ -127,4 +130,19 @@ static inline qemu_irq xive_source_qirq(XiveSource *=
xsrc, uint32_t srcno)
     return xsrc->qirqs[srcno];
 }
=20
+static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t src=
no)
+{
+    assert(srcno < xsrc->nr_irqs);
+    return test_bit(srcno, xsrc->lsi_map);
+}
+
+static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t srcno,
+                                       bool lsi)
+{
+    assert(srcno < xsrc->nr_irqs);
+    if (lsi) {
+        bitmap_set(xsrc->lsi_map, srcno, 1);
+    }
+}
+
 #endif /* PPC_XIVE_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f7621f84828c..ac4605fee8b7 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -88,14 +88,40 @@ uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_=
t srcno, uint8_t pq)
     return xive_esb_set(&xsrc->status[srcno], pq);
 }
=20
+/*
+ * Returns whether the event notification should be forwarded.
+ */
+static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t srcno)
+{
+    uint8_t old_pq =3D xive_source_esb_get(xsrc, srcno);
+
+    switch (old_pq) {
+    case XIVE_ESB_RESET:
+        xive_source_esb_set(xsrc, srcno, XIVE_ESB_PENDING);
+        return true;
+    default:
+        return false;
+    }
+}
+
 /*
  * Returns whether the event notification should be forwarded.
  */
 static bool xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcno)
 {
+    bool ret;
+
     assert(srcno < xsrc->nr_irqs);
=20
-    return xive_esb_trigger(&xsrc->status[srcno]);
+    ret =3D xive_esb_trigger(&xsrc->status[srcno]);
+
+    if (xive_source_irq_is_lsi(xsrc, srcno) &&
+        xive_source_esb_get(xsrc, srcno) =3D=3D XIVE_ESB_QUEUED) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: queued an event on LSI IRQ %d\n", srcno);
+    }
+
+    return ret;
 }
=20
 /*
@@ -103,9 +129,22 @@ static bool xive_source_esb_trigger(XiveSource *xsrc=
, uint32_t srcno)
  */
 static bool xive_source_esb_eoi(XiveSource *xsrc, uint32_t srcno)
 {
+    bool ret;
+
     assert(srcno < xsrc->nr_irqs);
=20
-    return xive_esb_eoi(&xsrc->status[srcno]);
+    ret =3D xive_esb_eoi(&xsrc->status[srcno]);
+
+    /* LSI sources do not set the Q bit but they can still be
+     * asserted, in which case we should forward a new event
+     * notification
+     */
+    if (xive_source_irq_is_lsi(xsrc, srcno) &&
+        xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
+        ret =3D xive_source_lsi_trigger(xsrc, srcno);
+    }
+
+    return ret;
 }
=20
 /*
@@ -268,8 +307,17 @@ static void xive_source_set_irq(void *opaque, int sr=
cno, int val)
     XiveSource *xsrc =3D XIVE_SOURCE(opaque);
     bool notify =3D false;
=20
-    if (val) {
-        notify =3D xive_source_esb_trigger(xsrc, srcno);
+    if (xive_source_irq_is_lsi(xsrc, srcno)) {
+        if (val) {
+            xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
+            notify =3D xive_source_lsi_trigger(xsrc, srcno);
+        } else {
+            xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
+        }
+    } else {
+        if (val) {
+            notify =3D xive_source_esb_trigger(xsrc, srcno);
+        }
     }
=20
     /* Forward the source event notification for routing */
@@ -289,9 +337,11 @@ void xive_source_pic_print_info(XiveSource *xsrc, ui=
nt32_t offset, Monitor *mon)
             continue;
         }
=20
-        monitor_printf(mon, "  %08x %c%c\n", i + offset,
+        monitor_printf(mon, "  %08x %s %c%c%c\n", i + offset,
+                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
                        pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
+                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                       xsrc->status[i] & XIVE_STATUS_ASSERTED ? 'A' : ' =
');
     }
 }
=20
@@ -299,6 +349,8 @@ static void xive_source_reset(DeviceState *dev)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
=20
+    /* Do not clear the LSI bitmap */
+
     /* PQs are initialized to 0b01 which corresponds to "ints off" */
     memset(xsrc->status, 0x1, xsrc->nr_irqs);
 }
@@ -325,6 +377,9 @@ static void xive_source_realize(DeviceState *dev, Err=
or **errp)
=20
     xsrc->status =3D g_malloc0(xsrc->nr_irqs);
=20
+    xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
+    xsrc->lsi_map_size =3D xsrc->nr_irqs;
+
     memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
                           &xive_source_esb_ops, xsrc, "xive.esb",
                           (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
@@ -338,6 +393,7 @@ static const VMStateDescription vmstate_xive_source =3D=
 {
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
         VMSTATE_VBUFFER_UINT32(status, XiveSource, 1, NULL, nr_irqs),
+        VMSTATE_BITMAP(lsi_map, XiveSource, 1, lsi_map_size),
         VMSTATE_END_OF_LIST()
     },
 };
--=20
2.17.2
