Received: from eggs.gnu.org ([2001:4830:134:3::10]:35308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHl-0001JE-CQ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHh-0004Qk-8d
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:13 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:43955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSHh-0004QQ-2A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:09 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1C75BAB215
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:25 +0200
Message-Id: <20170911171235.29331-12-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 11/21] ppc/xive: push the EQ data in OS
 event queue
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

If a triggered event is let through, the Event Queue data defined in
the associated IVE is pushed in the in-memory event queue. The latter
is a circular buffer provided by the OS using the H_INT_SET_QUEUE_CONFIG
hcall, one per target and priority couple. It is composed of Event
Queue entries which are 4 bytes long, the first bit being a
'generation' bit and the 31 following bits the EQ Data field.

The EQ Data field provides a way to set an invariant logical event
source number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG
hcall.

Notification of the CPU will be done in the following patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 67 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 557a7e2535b5..4bc61cfda67a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -175,9 +175,76 @@ static const MemoryRegionOps spapr_xive_tm_ops =3D {
     },
 };
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
 static void spapr_xive_irq(sPAPRXive *xive, int srcno)
 {
+    XiveIVE *ive;
+    XiveEQ *eq;
+    uint32_t eq_idx;
+    uint32_t priority;
+
+    ive =3D spapr_xive_get_ive(xive, srcno);
+    if (!ive || !(ive->w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", srcno)=
;
+        return;
+    }
+
+    if (ive->w & IVE_MASKED) {
+        return;
+    }
+
+    /* Find our XiveEQ */
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+    eq =3D spapr_xive_get_eq(xive, eq_idx);
+    if (!eq) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", srcn=
o);
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
=20
+        /* The EQ is masked. Can this happen ?  */
+        if (priority =3D=3D 0xff) {
+            return;
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
+    }
 }
=20
 /*
--=20
2.13.5
