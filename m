Received: from eggs.gnu.org ([2001:4830:134:3::10]:41751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntm-0004Os-Vx
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnti-0003So-VG
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:34 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:52678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnti-0003QS-Pb
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:30 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id BFBD5FCC5C
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:28 +0200
Message-Id: <1499274819-15607-16-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 15/26] ppc/xive: push EQ data in OS event
 queues
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

If a triggered event is let through, the event queue data defined in
the associated IVE is pushed in the in-memory event queue of the
OS. The latter is a memory ring buffer defined by the OS with
H_INT_SET_QUEUE_CONFIG hcall.

Then, an interrupt presenter is located and notified. See next patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 94 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 82b2f0dcda0b..c3c1e9c9db2d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -242,9 +242,103 @@ static const TypeInfo xive_icp_info =3D {
     .class_size    =3D sizeof(ICPStateClass),
 };
=20
+static XiveICPState *xive_icp_get(XICSFabric *xi, int server)
+{
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
+    ICPState *icp =3D xic->icp_get(xi, server);
+
+    return XIVE_ICP(icp);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write EQ data @0x%=
"
+                      HWADDR_PRIx "\n", __func__, qaddr);
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
 static void xive_icp_irq(XiveICSState *xs, int lisn)
 {
+    XIVE *x =3D xs->xive;
+    XiveICPState *xicp;
+    XiveIVE *ive;
+    XiveEQ *eq;
+    uint32_t eq_idx;
+    uint32_t priority;
+    uint32_t target;
+
+    ive =3D xive_get_ive(x, lisn);
+    if (!ive || !(ive->w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
+        return;
+    }
=20
+    if (ive->w & IVE_MASKED) {
+        return;
+    }
+
+    /* Find our XiveEQ */
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+    eq =3D xive_get_eq(x, eq_idx);
+    if (!eq) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", lisn=
);
+        return;
+    }
+
+    if (eq->w0 & EQ_W0_ENQUEUE) {
+        xive_eq_push(eq, GETFIELD(IVE_EQ_DATA, ive->w));
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: !ENQUEUE not implemented\n");
+    }
+
+    if (!(eq->w0 & EQ_W0_UCOND_NOTIFY)) {
+        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
+    }
+
+    target =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
+
+    /* use the XICSFabric (machine) to get the ICP */
+    xicp =3D xive_icp_get(ICS_BASE(xs)->xics, target);
+    if (!xicp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No ICP for target %d\n", t=
arget);
+        return;
+    }
+
+    if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
+        priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
+
+        /* The EQ is masked. Can this happen ?  */
+        if (priority =3D=3D 0xff) {
+            return;
+        }
+
+        /* Update the IPB (Interrupt Pending Buffer) with the priority
+         * of the new notification and inform the ICP, which will
+         * decide to raise the exception, or not, depending on its
+         * current CPPR value.
+         */
+        xicp->tima_os[TM_IPB] |=3D priority_to_ipb(priority);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
+    }
 }
=20
 /*
--=20
2.7.5
