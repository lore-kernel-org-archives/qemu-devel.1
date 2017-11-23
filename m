Received: from eggs.gnu.org ([2001:4830:134:3::10]:39150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbz-0001oE-1H
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbv-0002Rf-Sl
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:15 -0500
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:40843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrbv-0002Qg-NE
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:11 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 7C2B3175ADD
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:10 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:44 +0100
Message-Id: <20171123132955.1261-15-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS event
 queue
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

If a triggered event is let through, the Event Queue data defined in the
associated IVE is pushed in the in-memory event queue. The latter is a
circular buffer provided by the OS using the H_INT_SET_QUEUE_CONFIG hcall=
,
one per server and priority couple. It is composed of Event Queue entries
which are 4 bytes long, the first bit being a 'generation' bit and the 31
following bits the EQ Data field.

The EQ Data field provides a way to set an invariant logical event source
number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 67 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 983317a6b3f6..df14c5a88275 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -193,9 +193,76 @@ static sPAPRXiveICP *spapr_xive_icp_get(sPAPRXive *x=
ive, int server)
     return cpu ? SPAPR_XIVE_ICP(cpu->intc) : NULL;
 }
=20
+static void spapr_xive_eq_push(XiveEQ *eq, uint32_t data)
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
 static void spapr_xive_irq(sPAPRXive *xive, int lisn)
 {
+    XiveIVE *ive;
+    XiveEQ *eq;
+    uint32_t eq_idx;
+    uint8_t priority;
+
+    ive =3D spapr_xive_get_ive(xive, lisn);
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
+    eq =3D spapr_xive_get_eq(xive, eq_idx);
+    if (!eq) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", lisn=
);
+        return;
+    }
+
+    if (eq->w0 & EQ_W0_ENQUEUE) {
+        spapr_xive_eq_push(eq, GETFIELD(IVE_EQ_DATA, ive->w));
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: !ENQUEUE not implemented\n");
+    }
+
+    if (!(eq->w0 & EQ_W0_UCOND_NOTIFY)) {
+        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
+    }
+
+    if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
+        priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
+
+        /* The EQ is masked. Can this happen ?  */
+        if (priority =3D=3D 0xff) {
+            g_assert_not_reached();
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
+    }
 }
=20
 /*
--=20
2.13.6
