Received: from eggs.gnu.org ([209.51.188.92]:58520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09J-0006SI-Qf
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09I-00078t-Pl
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:50 +1100
Message-Id: <20190108224600.23125-20-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/29] spapr/xive: simplify the sPAPR IRQ qirq
 method for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The qirq routines of the XiveSource and the sPAPRXive model are only
used under the sPAPR IRQ backend. Simplify the overall call stack and
gather all the code under spapr_qirq_xive(). It will ease future
changes.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 14 --------------
 hw/ppc/spapr_irq.c          | 12 +++++++++++-
 include/hw/ppc/spapr_xive.h |  1 -
 include/hw/ppc/xive.h       |  6 ------
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 0e39c90cbd..eea28337e8 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -488,20 +488,6 @@ bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t l=
isn)
     return true;
 }
=20
-qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn)
-{
-    XiveSource *xsrc =3D &xive->source;
-
-    if (lisn >=3D xive->nr_irqs) {
-        return NULL;
-    }
-
-    /* The sPAPR machine/device should have claimed the IRQ before */
-    assert(xive_eas_is_valid(&xive->eat[lisn]));
-
-    return xive_source_qirq(xsrc, lisn);
-}
-
 /*
  * XIVE hcalls
  *
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 7b3b5afec2..be5fe531a8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -284,7 +284,17 @@ static void spapr_irq_free_xive(sPAPRMachineState *s=
papr, int irq, int num)
=20
 static qemu_irq spapr_qirq_xive(sPAPRMachineState *spapr, int irq)
 {
-    return spapr_xive_qirq(spapr->xive, irq);
+    sPAPRXive *xive =3D spapr->xive;
+    XiveSource *xsrc =3D &xive->source;
+
+    if (irq >=3D xive->nr_irqs) {
+        return NULL;
+    }
+
+    /* The sPAPR machine/device should have claimed the IRQ before */
+    assert(xive_eas_is_valid(&xive->eat[irq]));
+
+    return xsrc->qirqs[irq];
 }
=20
 static void spapr_irq_print_info_xive(sPAPRMachineState *spapr,
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 728735dbcf..9ee524fdb2 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -40,7 +40,6 @@ typedef struct sPAPRXive {
 bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
-qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 18cd114eb2..b05fe88b5b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -278,12 +278,6 @@ uint8_t xive_source_esb_set(XiveSource *xsrc, uint32=
_t srcno, uint8_t pq);
 void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset,
                                 Monitor *mon);
=20
-static inline qemu_irq xive_source_qirq(XiveSource *xsrc, uint32_t srcno=
)
-{
-    assert(srcno < xsrc->nr_irqs);
-    return xsrc->qirqs[srcno];
-}
-
 static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t src=
no)
 {
     assert(srcno < xsrc->nr_irqs);
--=20
2.20.1
