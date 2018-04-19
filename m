Received: from eggs.gnu.org ([2001:4830:134:3::10]:56825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vU-00082K-B5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vQ-00089u-D5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:36 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:40085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98vQ-000897-5B
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:32 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.11])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B0EE413BB6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:30 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:04 +0200
Message-Id: <20180419124331.3915-9-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/35] spapr: push the XIVE EQ data in OS
 event queue
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

When a notification is let through by the routing engine, the Event
Queue data defined in the associated IVE is pushed in the in-memory
event queue. The latter is a circular buffer provided by the OS, one
per server and priority couple. Each Event Queue entry is 4 bytes
long, the first bit being a 'generation' bit and the 31 following bits
the EQ Data field.

The EQ Data field is a way to set an invariant logical event source
number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall
when the EISN flag is used.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - used dma_memory_write() to push EQ data
 - introduced the XiveFabric interface, to generalize the routing algo.

 hw/intc/xive.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2ab37fde80e8..420cc6703b88 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -59,6 +59,31 @@ void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon)
                    priority, server, qaddr_base, qindex, qentries, qgen)=
;
 }
=20
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
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to write EQ data @0=
x%"
+                      HWADDR_PRIx "\n", qaddr);
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
 /*
  * XIVE Interrupt Presenter
  */
@@ -378,7 +403,47 @@ XiveEQ *xive_fabric_get_eq(XiveFabric *xf, uint32_t =
eq_idx)
=20
 static void xive_fabric_route(XiveFabric *xf, int lisn)
 {
+    XiveIVE *ive;
+    XiveEQ *eq;
+    uint32_t eq_idx;
+    uint8_t priority;
=20
+    ive =3D xive_fabric_get_ive(xf, lisn);
+    if (!ive || !(ive->w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
+        return;
+    }
+
+    if (ive->w & IVE_MASKED) {
+        return;
+    }
+
+    /* Find our XiveEQ */
+    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
+    eq =3D xive_fabric_get_eq(xf, eq_idx);
+    if (!eq || !(eq->w0 & EQ_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", lisn=
);
+        return;
+    }
+
+    if (eq->w0 & EQ_W0_ENQUEUE) {
+        xive_eq_push(eq, GETFIELD(IVE_EQ_DATA, ive->w));
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
 static const TypeInfo xive_fabric_info =3D {
--=20
2.13.6
