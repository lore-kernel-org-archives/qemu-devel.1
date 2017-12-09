Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakX-0001Be-3O
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNakT-00072U-5z
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:45 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:35874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNakS-00071a-Sl
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:41 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6D9741276E5
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:39 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:26 +0100
Message-Id: <20171209084338.29395-8-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/19] spapr: push the XIVE EQ data in OS
 event queue
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

If a triggered event is let through by the XIVE virtualization routing
engine, the Event Queue data defined in the associated IVE is pushed
in the in-memory event queue. The latter is a circular buffer provided
by the OS using the H_INT_SET_QUEUE_CONFIG hcall, one per server and
priority couple. Each Event Queue entry is 4 bytes long, the first bit
being a 'generation' bit and the 31 following bits the EQ Data field.

The EQ Data field provides a way to set an invariant logical event
source number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG
hcall when the EISN flag is used.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:

 - replaced dma_memory_write() by stl_be_dma()
 - improved 'info pic' output

 hw/intc/spapr_xive.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 8e990d58ecf4..629563d01998 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -196,9 +196,87 @@ static sPAPRXiveNVT *spapr_xive_nvt_get(sPAPRXive *x=
ive, int server)
     return cpu ? SPAPR_XIVE_NVT(cpu->intc) : NULL;
 }
=20
+static void spapr_xive_pic_print_info_eq(XiveEQ *eq, Monitor *mon)
+{
+    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
+    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
+    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
+    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
+    uint32_t qentries =3D 1 << (qsize + 10);
+
+    monitor_printf(mon, "eq:@%08" PRIx64"% 6d/%5d ^%d", qaddr_base,
+                   qindex, qentries, qgen);
+}
+
+static void spapr_xive_eq_push(XiveEQ *eq, uint32_t data)
+{
+    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
+    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
+    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
+    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
+
+    uint64_t qaddr =3D qaddr_base + (qindex << 2);
+    uint32_t qdata =3D (qgen << 31) | (data & 0x7fffffff);
+    uint32_t qentries =3D 1 << (qsize + 10);
+
+    if (stl_be_dma(&address_space_memory, qaddr, qdata)) {
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
+    eq =3D spapr_xive_get_eq(xive, XIVE_EQ_INDEX_SERVER(eq_idx),
+                           XIVE_EQ_INDEX_PRIO(eq_idx));
+    if (!eq) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", lisn=
);
+        return;
+    }
+
+    if (eq->w0 & EQ_W0_ENQUEUE) {
+        spapr_xive_eq_push(eq, GETFIELD(IVE_EQ_DATA, ive->w));
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
@@ -480,14 +558,28 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Mon=
itor *mon)
         pq =3D spapr_xive_pq_get(xive, i);
         eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
=20
-        monitor_printf(mon, "  %4x %s %s %c%c server:%d prio:%d %08x\n",=
 i,
+        monitor_printf(mon, "  %4x %s %s %c%c server:%d prio:%d ", i,
                        spapr_xive_irq_is_lsi(xive, i) ? "LSI" : "MSI",
                        ive->w & IVE_MASKED ? "M" : " ",
                        pq & XIVE_ESB_VAL_P ? 'P' : '-',
                        pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
                        XIVE_EQ_INDEX_SERVER(eq_idx),
-                       XIVE_EQ_INDEX_PRIO(eq_idx),
-                       (int) GETFIELD(IVE_EQ_DATA, ive->w));
+                       XIVE_EQ_INDEX_PRIO(eq_idx));
+
+        if (!(ive->w & IVE_MASKED)) {
+            XiveEQ *eq;
+
+            eq =3D spapr_xive_get_eq(xive, XIVE_EQ_INDEX_SERVER(eq_idx),
+                                   XIVE_EQ_INDEX_PRIO(eq_idx));
+            if (eq) {
+                spapr_xive_pic_print_info_eq(eq, mon);
+                monitor_printf(mon, " data:%08x",
+                               (int) GETFIELD(IVE_EQ_DATA, ive->w));
+            } else {
+                monitor_printf(mon, "no eq ?!");
+            }
+        }
+        monitor_printf(mon, "\n");
     }
 }
=20
--=20
2.13.6
