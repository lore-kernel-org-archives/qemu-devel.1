Received: from eggs.gnu.org ([2001:4830:134:3::10]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wK-0000au-V8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wG-0000Na-SP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:29 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:43822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wG-0000MB-Dm
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:24 -0400
Received: from player792.ha.ovh.net (unknown [10.109.120.21])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id AD278B949D
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:13 +0200
Message-Id: <20180419124331.3915-18-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/35] spapr: add XIVE support to
 spapr_qirq()
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

The XIVE object has its own set of qirqs which is to be used when the
XIVE exploitation interrupt mode is activated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 13 +++++++++++++
 hw/ppc/spapr.c              |  4 ++++
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xive.h       |  6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 7aba6e571a93..98e067bfc90c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -263,3 +263,16 @@ void spapr_xive_mmio_unmap(sPAPRXive *xive)
     sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 0);
     sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 1);
 }
+
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn)
+{
+    XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
+    XiveSource *xsrc =3D &xive->source;
+
+    if (!ive || !(ive->w & IVE_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
+        return NULL;
+    }
+
+    return xive_source_qirq(xsrc, lisn - xsrc->offset);
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a9770f8f0a6e..4fcc942ccfa3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3941,6 +3941,10 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int =
irq)
 {
     ICSState *ics =3D spapr->ics;
=20
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return spapr_xive_qirq(spapr->xive, irq);
+    }
+
     if (ics_valid_irq(ics, irq)) {
         return ics->qirqs[irq - ics->offset];
     }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 0373b1c995bc..df87e68b3d05 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -37,6 +37,7 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t l=
isn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 void spapr_xive_mmio_map(sPAPRXive *xive);
 void spapr_xive_mmio_unmap(sPAPRXive *xive);
+qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn);
=20
 /*
  * sPAPR encoding of EQ indexes
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 6cc02638c677..328b093eb9c3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -155,6 +155,12 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
     xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
 }
=20
+static inline qemu_irq xive_source_qirq(XiveSource *xsrc, uint32_t srcno=
)
+{
+    assert(srcno < xsrc->nr_irqs);
+    return xsrc->qirqs[srcno];
+}
+
 /*
  * XIVE Interrupt Presenter
  */
--=20
2.13.6
