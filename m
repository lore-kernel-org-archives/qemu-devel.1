Received: from eggs.gnu.org ([2001:4830:134:3::10]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrc4-0001tl-4a
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrc0-0002Xg-VK
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:20 -0500
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:32969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrc0-0002Vs-MB
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:16 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A98FA175AF9
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:15 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:45 +0100
Message-Id: <20171123132955.1261-16-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/25] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Pending Interrupt Priority Register (PIPR) contains the priority
of the most favored pending notification. It is calculated from the
Interrupt Pending Buffer (IPB) which indicates a pending interrupt at
the priority corresponding to the bit number.

If the PIPR is more favored (1) than the Current Processor Priority
Register (CPPR), the CPU interrupt line is raised and the EO bit of
the Notification Source Register is updated to notify the presence of
an exception for the O/S. The check needs to be done whenever the PIPR
or the CPPR is changed.

Then, the O/S Exception is raised and the O/S acknowledges the
interrupt with a special read in the TIMA. If the EO bit of the
Notification Source Register (NSR) is set (and it should), the Current
Processor Priority Register (CPPR) takes the value of the Pending
Interrupt Priority Register (PIPR). The bit number in the Interrupt
Pending Buffer (IPB) corresponding to the priority of the pending
interrupt is reseted and so is the EO bit of the NSR.

(1) numerically less than

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index df14c5a88275..fead9c7031f3 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -39,9 +39,63 @@ struct sPAPRXiveICP {
     XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
 };
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
+ *
+ * TODO:
+ *
+ *   PIPR is clamped to CPPR. So the value in the PIPR is:
+ *
+ *     v =3D leftmost_bit_of(ipb) (or 0xff);
+ *     pipr =3D v < cppr ? v : cppr;
+ *
+ * Ben says: "which means it's never actually 0xff ... surprise !".
+ * But, the CPPR can be set to 0xFF ... I am confused ...
+ */
+static uint8_t ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
 static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
 {
-    return 0;
+    uint8_t nsr =3D icp->tima_os[TM_NSR];
+
+    qemu_irq_lower(icp->output);
+
+    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
+        uint8_t cppr =3D icp->tima_os[TM_PIPR];
+
+        icp->tima_os[TM_CPPR] =3D cppr;
+
+        /* Reset the pending buffer bit */
+        icp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
+        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
+
+        /* Drop Exception bit for OS */
+        icp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
+    }
+
+    return (nsr << 8) | icp->tima_os[TM_CPPR];
+}
+
+static void spapr_xive_icp_notify(sPAPRXiveICP *icp)
+{
+    if (icp->tima_os[TM_PIPR] < icp->tima_os[TM_CPPR]) {
+        icp->tima_os[TM_NSR] |=3D TM_QW1_NSR_EO;
+        qemu_irq_raise(icp->output);
+    }
 }
=20
 static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp, uint8_t cppr)
@@ -51,6 +105,9 @@ static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp,=
 uint8_t cppr)
     }
=20
     icp->tima_os[TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, inform the ICP which might raise an exception *=
/
+    spapr_xive_icp_notify(icp);
 }
=20
 /*
@@ -224,6 +281,8 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn)
     XiveEQ *eq;
     uint32_t eq_idx;
     uint8_t priority;
+    uint32_t server;
+    sPAPRXiveICP *icp;
=20
     ive =3D spapr_xive_get_ive(xive, lisn);
     if (!ive || !(ive->w & IVE_VALID)) {
@@ -253,6 +312,13 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn=
)
         qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
     }
=20
+    server =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+    icp =3D spapr_xive_icp_get(xive, server);
+    if (!icp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No ICP for server %d\n", s=
erver);
+        return;
+    }
+
     if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
         priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
=20
@@ -260,9 +326,18 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn=
)
         if (priority =3D=3D 0xff) {
             g_assert_not_reached();
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
2.13.6
