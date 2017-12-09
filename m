Received: from eggs.gnu.org ([2001:4830:134:3::10]:45460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakc-0001HY-UM
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakY-000786-Vm
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:50 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:34636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNakY-00077Q-Mq
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:46 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9A8AD1277C6
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:45 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:27 +0100
Message-Id: <20171209084338.29395-9-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/19] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
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

Once an event has been routed, the XIVE virtualization presenter
engine raises the bit corresponding to the priority of the pending
interrupt in the register IBP (Interrupt Pending Buffer). The Pending
Interrupt Priority Register (PIPR) is also updated using the IPB. It
contains the priority of the most favored pending notification.

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

 Changes since v1:

 - set initial TM_PIPR to 0xFF

 hw/intc/spapr_xive.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 629563d01998..a8acfee740d9 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -35,9 +35,68 @@ struct sPAPRXiveNVT {
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
+ */
+static uint8_t ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
+/*
+ * TODO:
+ *
+ * Ben says: "
+ *
+ * PIPR is clamped to CPPR. So the value in the PIPR is:
+ *
+ *     v =3D leftmost_bit_of(ipb) (or 0xff);
+ *     pipr =3D v < cppr ? v : cppr;
+ *
+ * which means it's never actually 0xff ... surprise !".
+ *
+ * But, the CPPR is set to 0xFF by the OS and so the PIPR will always
+ * be more favored ... I am confused ...
+ */
 static uint64_t spapr_xive_nvt_accept(sPAPRXiveNVT *nvt)
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
+static void spapr_xive_nvt_notify(sPAPRXiveNVT *nvt)
+{
+    if (nvt->ring_os[TM_PIPR] < nvt->ring_os[TM_CPPR]) {
+        nvt->ring_os[TM_NSR] |=3D TM_QW1_NSR_EO;
+        qemu_irq_raise(nvt->output);
+    }
 }
=20
 static void spapr_xive_nvt_set_cppr(sPAPRXiveNVT *nvt, uint8_t cppr)
@@ -47,6 +106,10 @@ static void spapr_xive_nvt_set_cppr(sPAPRXiveNVT *nvt=
, uint8_t cppr)
     }
=20
     nvt->ring_os[TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, check if we need to redistribute a pending
+     * exception */
+    spapr_xive_nvt_notify(nvt);
 }
=20
 /*
@@ -239,6 +302,8 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn)
     XiveEQ *eq;
     uint32_t eq_idx;
     uint8_t priority;
+    uint32_t server;
+    sPAPRXiveNVT *nvt;
=20
     ive =3D spapr_xive_get_ive(xive, lisn);
     if (!ive || !(ive->w & IVE_VALID)) {
@@ -267,6 +332,13 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn=
)
         qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
     }
=20
+    server =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+    nvt =3D spapr_xive_nvt_get(xive, server);
+    if (!nvt) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVT for server %d\n", s=
erver);
+        return;
+    }
+
     if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
         priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
=20
@@ -274,9 +346,18 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn=
)
         if (priority =3D=3D 0xff) {
             g_assert_not_reached();
         }
+
+        /* Update the IPB (Interrupt Pending Buffer) with the priority
+         * of the new notification and inform the NVT, which will
+         * decide to raise the exception, or not, depending the CPPR.
+         */
+        nvt->ring_os[TM_IPB] |=3D priority_to_ipb(priority);
+        nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
     } else {
         qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
     }
+
+    spapr_xive_nvt_notify(nvt);
 }
=20
 /*
@@ -717,6 +798,12 @@ static void spapr_xive_nvt_reset(void *dev)
=20
     memset(nvt->regs, 0, sizeof(nvt->regs));
=20
+    /*
+     * Initialize PIPR to 0xFF to avoid phantom interrupts when the
+     * CPPR is first set.
+     */
+    nvt->ring_os[TM_PIPR] =3D ipb_to_pipr(nvt->ring_os[TM_IPB]);
+
     memset(nvt->eqt, 0, sizeof(nvt->eqt));
 }
=20
--=20
2.13.6
