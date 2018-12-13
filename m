Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICA-0003kj-Lh
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC7-0002D6-0M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:13 +1100
Message-Id: <20181213040126.6768-15-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/27] ppc/xive: add support for the LSI
 interrupt sources
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

The 'sent' status of the LSI interrupt source is modeled with the 'P'
bit of the ESB and the assertion status of the source is maintained
with an extra bit under the main XiveSource object. The type of the
source is stored in the same array for practical reasons.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c        | 66 +++++++++++++++++++++++++++++++++++++++----
 include/hw/ppc/xive.h | 19 ++++++++++++-
 2 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6389bd8323..11c7aac962 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -89,14 +89,42 @@ uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_=
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
+    xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
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
@@ -104,9 +132,22 @@ static bool xive_source_esb_trigger(XiveSource *xsrc=
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
@@ -271,8 +312,16 @@ static void xive_source_set_irq(void *opaque, int sr=
cno, int val)
     XiveSource *xsrc =3D XIVE_SOURCE(opaque);
     bool notify =3D false;
=20
-    if (val) {
-        notify =3D xive_source_esb_trigger(xsrc, srcno);
+    if (xive_source_irq_is_lsi(xsrc, srcno)) {
+        if (val) {
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
@@ -292,9 +341,11 @@ void xive_source_pic_print_info(XiveSource *xsrc, ui=
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
@@ -302,6 +353,8 @@ static void xive_source_reset(void *dev)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
=20
+    /* Do not clear the LSI bitmap */
+
     /* PQs are initialized to 0b01 (Q=3D1) which corresponds to "ints of=
f" */
     memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
 }
@@ -324,6 +377,7 @@ static void xive_source_realize(DeviceState *dev, Err=
or **errp)
     }
=20
     xsrc->status =3D g_malloc0(xsrc->nr_irqs);
+    xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
=20
     memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
                           &xive_source_esb_ops, xsrc, "xive.esb",
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 7aa2e38012..7cebc32eba 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -162,8 +162,9 @@ typedef struct XiveSource {
     /* IRQs */
     uint32_t        nr_irqs;
     qemu_irq        *qirqs;
+    unsigned long   *lsi_map;
=20
-    /* PQ bits */
+    /* PQ bits and LSI assertion bit */
     uint8_t         *status;
=20
     /* ESB memory region */
@@ -219,6 +220,7 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource =
*xsrc, int srcno)
  * When doing an EOI, the Q bit will indicate if the interrupt
  * needs to be re-triggered.
  */
+#define XIVE_STATUS_ASSERTED  0x4  /* Extra bit for LSI */
 #define XIVE_ESB_VAL_P        0x2
 #define XIVE_ESB_VAL_Q        0x1
=20
@@ -257,4 +259,19 @@ static inline qemu_irq xive_source_qirq(XiveSource *=
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
--=20
2.19.2
