Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHs-0001QQ-Uc
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHo-0004U8-Dx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:20 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:59734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSHo-0004Ti-88
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:16 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 507E3AB262
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:15 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:26 +0200
Message-Id: <20170911171235.29331-13-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 12/21] ppc/xive: notify the CPU when
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Pending Interrupt Priority Register (PIPR) contains the priority
of the most favored pending notification. It is calculated from the
Interrupt Pending Buffer (IPB) which indicates a pending interrupt at
the priority corresponding to the bit number.

If the PIPR is more favored (1) than the Current Processor Priority
Register (CPPR), the CPU interrupt line can be raised and the EO bit
of the Notification Source Register is updated to notify the presence
of an exception for the O/S. The check needs to be done whenever the
PIPR or the CPPR is changed.

(1) numerically less than

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 50 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 4bc61cfda67a..e5d4b723b7e0 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -28,11 +28,39 @@
 #include "xive-internal.h"
=20
=20
+/* Convert a priority number to an Interrupt Pending Buffer (IPB)
+ * register, which indicates a pending interrupt at the priority
+ * corresponding to the bit number
+ */
+static uint8_t priority_to_ipb(uint8_t priority)
+{
+    return priority > XIVE_PRIORITY_MAX ? 0 :  1 << (7 - priority);
+}
+
+/* Convert an Interrupt Pending Buffer (IPB) register to a Pending
+ * Interrupt Priority Register (PIPR), which contains the priority of
+ * the most favored pending notification.
+ *
+ * TODO: PIPR can never be OxFF. Needs a fix.
+ */
+static uint8_t ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
 static uint64_t spapr_xive_icp_accept(ICPState *icp)
 {
     return 0;
 }
=20
+static void spapr_xive_icp_notify(ICPState *icp)
+{
+    if (icp->tima_os[TM_PIPR] < icp->tima_os[TM_CPPR]) {
+        icp->tima_os[TM_NSR] |=3D TM_QW1_NSR_EO;
+        qemu_irq_raise(ICP(icp)->output);
+    }
+}
+
 static void spapr_xive_icp_set_cppr(ICPState *icp, uint8_t cppr)
 {
     if (cppr > XIVE_PRIORITY_MAX) {
@@ -40,6 +68,10 @@ static void spapr_xive_icp_set_cppr(ICPState *icp, uin=
t8_t cppr)
     }
=20
     icp->tima_os[TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, inform the ICP which might raise an
+     * exception */
+    spapr_xive_icp_notify(icp);
 }
=20
 /*
@@ -206,6 +238,8 @@ static void spapr_xive_irq(sPAPRXive *xive, int srcno=
)
     XiveEQ *eq;
     uint32_t eq_idx;
     uint32_t priority;
+    uint32_t target;
+    ICPState *icp;
=20
     ive =3D spapr_xive_get_ive(xive, srcno);
     if (!ive || !(ive->w & IVE_VALID)) {
@@ -235,6 +269,13 @@ static void spapr_xive_irq(sPAPRXive *xive, int srcn=
o)
         qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
     }
=20
+    target =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+    icp =3D xics_icp_get(xive->ics->xics, target);
+    if (!icp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No ICP for target %d\n", t=
arget);
+        return;
+    }
+
     if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
         priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
=20
@@ -242,9 +283,18 @@ static void spapr_xive_irq(sPAPRXive *xive, int srcn=
o)
         if (priority =3D=3D 0xff) {
             return;
         }
+
+        /* Update the IPB (Interrupt Pending Buffer) with the priority
+         * of the new notification and inform the ICP, which will
+         * decide to raise the exception, or not, depending the CPPR.
+         */
+        icp->tima_os[TM_IPB] |=3D priority_to_ipb(priority);
+        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
     } else {
         qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
     }
+
+    spapr_xive_icp_notify(icp);
 }
=20
 /*
--=20
2.13.5
