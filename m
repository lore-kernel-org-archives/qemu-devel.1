Received: from eggs.gnu.org ([2001:4830:134:3::10]:56911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98va-00089T-Oq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vW-0008Eu-Gd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:42 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:59938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98vW-0008DR-6y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:38 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.75])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D8BA51424A
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:05 +0200
Message-Id: <20180419124331.3915-10-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/35] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

After the event was pushed in the Xive EQ, the presenter engine raises
the bit corresponding to the priority of the pending interrupt in the
register IBP (Interrupt Pending Buffer) to indicate there is an event
pending in one of the 8 priority queues. The Pending Interrupt
Priority Register (PIPR) is also updated using the IPB. This register
represent the priority of the most favored pending notification.

The PIPR is then compared to the the Current Processor Priority
Register (CPPR). If it is more favored (numerically less than), the
CPU interrupt line is raised and the EO bit of the Notification Source
Register (NSR) is updated to notify the presence of an exception for
the O/S. The check needs to be done whenever the PIPR or the CPPR are
changed.

The O/S acknowledges the interrupt with a special load in the Thread
Interrupt Management Area. If the EO bit of the NSR is set, the CPPR
takes the value of PIPR. The bit number in the IBP corresponding to
the priority of the pending interrupt is reseted and so is the EO bit
of the NSR.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - introduced the XiveFabric interface

 hw/intc/xive.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 420cc6703b88..8d0e77cac12a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -88,9 +88,63 @@ static void xive_eq_push(XiveEQ *eq, uint32_t data)
  * XIVE Interrupt Presenter
  */
=20
+/* Convert a priority number to an Interrupt Pending Buffer (IPB)
+ * register, which indicates a pending interrupt at the priority
+ * corresponding to the bit number
+ */
+static uint8_t priority_to_ipb(uint8_t priority)
+{
+    return priority > XIVE_PRIORITY_MAX ?
+        0 : 1 << (XIVE_PRIORITY_MAX - priority);
+}
+
+/* Convert an Interrupt Pending Buffer (IPB) register to a Pending
+ * Interrupt Priority Register (PIPR), which contains the priority of
+ * the most favored pending notification.
+ */
+static uint8_t ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
+/* Update the IPB (Interrupt Pending Buffer) with the priority
+ * of the new notification and inform the NVT, which will
+ * decide to raise the exception, or not, depending the CPPR.
+ */
+static void xive_nvt_ipb_update(XiveNVT *nvt, uint8_t priority)
+{
+    nvt->ring_os[TM_IPB] |=3D priority_to_ipb(priority);
+    nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
+}
+
 static uint64_t xive_nvt_accept(XiveNVT *nvt)
 {
-    return 0;
+    uint8_t nsr =3D nvt->ring_os[TM_NSR];
+
+    qemu_irq_lower(nvt->output);
+
+    if (nvt->ring_os[TM_NSR] & TM_QW1_NSR_EO) {
+        uint8_t cppr =3D nvt->ring_os[TM_PIPR];
+
+        nvt->ring_os[TM_CPPR] =3D cppr;
+
+        /* Reset the pending buffer bit */
+        nvt->ring_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
+        nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
+
+        /* Drop Exception bit for OS */
+        nvt->ring_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
+    }
+
+    return (nsr << 8) | nvt->ring_os[TM_CPPR];
+}
+
+static void xive_nvt_notify(XiveNVT *nvt)
+{
+    if (nvt->ring_os[TM_PIPR] < nvt->ring_os[TM_CPPR]) {
+        nvt->ring_os[TM_NSR] |=3D TM_QW1_NSR_EO;
+        qemu_irq_raise(nvt->output);
+    }
 }
=20
 static void xive_nvt_set_cppr(XiveNVT *nvt, uint8_t cppr)
@@ -100,6 +154,10 @@ static void xive_nvt_set_cppr(XiveNVT *nvt, uint8_t =
cppr)
     }
=20
     nvt->ring_os[TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, check if we need to redistribute a pending
+     * exception */
+    xive_nvt_notify(nvt);
 }
=20
 /*
@@ -279,6 +337,12 @@ static void xive_nvt_reset(void *dev)
     int i;
=20
     memset(nvt->regs, 0, sizeof(nvt->regs));
+    /*
+     * Initialize PIPR to 0xFF to avoid phantom interrupts when the
+     * CPPR is first set.
+     */
+    nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
+
     for (i =3D 0; i < ARRAY_SIZE(nvt->eqt); i++) {
         xive_eq_reset(&nvt->eqt[i]);
     }
@@ -407,6 +471,8 @@ static void xive_fabric_route(XiveFabric *xf, int lis=
n)
     XiveEQ *eq;
     uint32_t eq_idx;
     uint8_t priority;
+    XiveNVT *nvt;
+    uint32_t nvt_idx;
=20
     ive =3D xive_fabric_get_ive(xf, lisn);
     if (!ive || !(ive->w & IVE_VALID)) {
@@ -434,6 +500,13 @@ static void xive_fabric_route(XiveFabric *xf, int li=
sn)
         qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
     }
=20
+    nvt_idx =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+    nvt =3D xive_fabric_get_nvt(xf, nvt_idx);
+    if (!nvt) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVT for idx %d\n", nvt_=
idx);
+        return;
+    }
+
     if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
         priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
=20
@@ -441,9 +514,12 @@ static void xive_fabric_route(XiveFabric *xf, int li=
sn)
         if (priority =3D=3D 0xff) {
             g_assert_not_reached();
         }
+        xive_nvt_ipb_update(nvt, priority);
     } else {
         qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
     }
+
+    xive_nvt_notify(nvt);
 }
=20
 static const TypeInfo xive_fabric_info =3D {
--=20
2.13.6
