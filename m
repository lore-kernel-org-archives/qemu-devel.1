Received: from eggs.gnu.org ([2001:4830:134:3::10]:45305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakE-0000xV-M1
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakA-0006v1-Nw
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:26 -0500
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:54886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNakA-0006uK-Ek
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:22 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E03EC1277A1
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:20 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:23 +0100
Message-Id: <20171209084338.29395-5-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/19] spapr: add support for the LSI
 interrupt sources
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

The 'sent' status of the LSI interrupt source is modeled with the 'P'
bit of the ESB and the assertion status of the source is maintained in
an array under the main sPAPRXive object. The type of the source is
stored in the same array for practical reasons.

The OS will use the H_INT_GET_SOURCE_INFO hcall to determine the type
of an interrupt source.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 54 +++++++++++++++++++++++++++++++++++++++=
++----
 include/hw/ppc/spapr_xive.h | 10 ++++++++-
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 43df6814619d..c772c726667f 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -144,6 +144,21 @@ static bool spapr_xive_pq_trigger(sPAPRXive *xive, u=
int32_t lisn)
 }
=20
 /*
+ * LSI interrupt sources use the P bit and a custom assertion flag
+ */
+static bool spapr_xive_lsi_trigger(sPAPRXive *xive, uint32_t lisn)
+{
+    uint8_t old_pq =3D spapr_xive_pq_get(xive, lisn);
+
+    if  (old_pq =3D=3D XIVE_ESB_RESET &&
+         xive->status[lisn] & XIVE_STATUS_ASSERTED) {
+        spapr_xive_pq_set(xive, lisn, XIVE_ESB_PENDING);
+        return true;
+    }
+    return false;
+}
+
+/*
  * XIVE Interrupt Source MMIOs
  */
=20
@@ -165,6 +180,14 @@ static uint64_t spapr_xive_esb_read(void *opaque, hw=
addr addr, unsigned size)
          * XIVE_ESB_STORE_EOI support for the interrupt sources
          */
         ret =3D spapr_xive_pq_eoi(xive, lisn);
+
+        /* If the LSI source is still asserted, forward a new source
+         * event notification */
+        if (spapr_xive_irq_is_lsi(xive, lisn)) {
+            if (spapr_xive_lsi_trigger(xive, lisn)) {
+                spapr_xive_irq(xive, lisn);
+            }
+        }
         break;
=20
     case XIVE_ESB_GET:
@@ -201,6 +224,14 @@ static void spapr_xive_esb_write(void *opaque, hwadd=
r addr,
          * notification
          */
         notify =3D spapr_xive_pq_eoi(xive, lisn);
+
+        /* LSI sources do not set the Q bit but they can still be
+         * asserted, in which case we should forward a new source
+         * event notification
+         */
+        if (spapr_xive_irq_is_lsi(xive, lisn)) {
+            notify =3D spapr_xive_lsi_trigger(xive, lisn);
+        }
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr %d\=
n",
@@ -233,8 +264,17 @@ static void spapr_xive_source_set_irq(void *opaque, =
int lisn, int val)
     sPAPRXive *xive =3D SPAPR_XIVE(opaque);
     bool notify =3D false;
=20
-    if (val) {
-        notify =3D spapr_xive_pq_trigger(xive, lisn);
+    if (spapr_xive_irq_is_lsi(xive, lisn)) {
+        if (val) {
+            xive->status[lisn] |=3D XIVE_STATUS_ASSERTED;
+        } else {
+            xive->status[lisn] &=3D ~XIVE_STATUS_ASSERTED;
+        }
+        notify =3D spapr_xive_lsi_trigger(xive, lisn);
+    } else {
+        if (val) {
+            notify =3D spapr_xive_pq_trigger(xive, lisn);
+        }
     }
=20
     /* Forward the source event notification for routing */
@@ -260,7 +300,8 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monit=
or *mon)
=20
         pq =3D spapr_xive_pq_get(xive, i);
=20
-        monitor_printf(mon, "  %4x %s %c%c %08x %08x\n", i,
+        monitor_printf(mon, "  %4x %s %s %c%c %08x %08x\n", i,
+                       spapr_xive_irq_is_lsi(xive, i) ? "LSI" : "MSI",
                        ive->w & IVE_MASKED ? "M" : " ",
                        pq & XIVE_ESB_VAL_P ? 'P' : '-',
                        pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
@@ -274,6 +315,8 @@ static void spapr_xive_reset(DeviceState *dev)
     sPAPRXive *xive =3D SPAPR_XIVE(dev);
     int i;
=20
+    /* Do not clear IRQ's status */
+
     /* Mask all valid IVEs in the IRQ number space. */
     for (i =3D 0; i < xive->nr_irqs; i++) {
         XiveIVE *ive =3D &xive->ivt[i];
@@ -301,6 +344,7 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
     /* QEMU IRQs */
     xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xive,
                                      xive->nr_irqs);
+    xive->status =3D g_malloc0(xive->nr_irqs);
=20
     /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
     xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
@@ -381,7 +425,7 @@ XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t=
 lisn)
     return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
 }
=20
-bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn)
+bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)
 {
     XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
=20
@@ -390,6 +434,7 @@ bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t =
lisn)
     }
=20
     ive->w |=3D IVE_VALID;
+    xive->status[lisn] |=3D lsi ? XIVE_STATUS_LSI : 0;
     return true;
 }
=20
@@ -402,5 +447,6 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t=
 lisn)
     }
=20
     ive->w &=3D ~IVE_VALID;
+    xive->status[lisn] =3D 0;
     return true;
 }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index ecc15d889b74..a7e59fd601d7 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -23,6 +23,9 @@ struct sPAPRXive {
=20
     /* Properties */
     uint32_t     nr_irqs;
+#define XIVE_STATUS_LSI                0x1
+#define XIVE_STATUS_ASSERTED           0x2
+    uint8_t      *status;
=20
     /* IRQ */
     qemu_irq     *qirqs;
@@ -37,7 +40,12 @@ struct sPAPRXive {
     MemoryRegion esb_iomem;
 };
=20
-bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn);
+static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xive, int lisn)
+{
+    return xive->status[lisn] & XIVE_STATUS_LSI;
+}
+
+bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
=20
--=20
2.13.6
