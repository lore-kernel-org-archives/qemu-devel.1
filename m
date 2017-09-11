Received: from eggs.gnu.org ([2001:4830:134:3::10]:34922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHD-0000mk-Ah
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSH7-0003z8-M0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:39 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:40795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSH7-0003yW-DC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:33 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2337AAB138
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:13:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:20 +0200
Message-Id: <20170911171235.29331-7-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 06/21] ppc/xive: introduce handlers for
 interrupt sources
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

These are very similar to the XICS handlers in a simpler form. They
make use of the ICSIRQState array of the XICS interrupt source to
differentiate the MSI from the LSI interrupts. The spapr_xive_irq()
routine in charge of triggering the CPU interrupt line will be filled
later on.

The next patch will introduce the MMIO handlers to interact with XIVE
interrupt sources.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 46 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr_xive.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 52c32f588d6d..1ed7b6a286e9 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -27,6 +27,50 @@
=20
 #include "xive-internal.h"
=20
+static void spapr_xive_irq(sPAPRXive *xive, int srcno)
+{
+
+}
+
+/*
+ * XIVE Interrupt Source
+ */
+static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int srcno, in=
t val)
+{
+    if (val) {
+        spapr_xive_irq(xive, srcno);
+    }
+}
+
+static void spapr_xive_source_set_irq_lsi(sPAPRXive *xive, int srcno, in=
t val)
+{
+    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
+
+    if (val) {
+        irq->status |=3D XICS_STATUS_ASSERTED;
+    } else {
+        irq->status &=3D ~XICS_STATUS_ASSERTED;
+    }
+
+    if (irq->status & XICS_STATUS_ASSERTED
+        && !(irq->status & XICS_STATUS_SENT)) {
+        irq->status |=3D XICS_STATUS_SENT;
+        spapr_xive_irq(xive, srcno);
+    }
+}
+
+static void spapr_xive_source_set_irq(void *opaque, int srcno, int val)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
+    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
+
+    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
+        spapr_xive_source_set_irq_lsi(xive, srcno, val);
+    } else {
+        spapr_xive_source_set_irq_msi(xive, srcno, val);
+    }
+}
+
 /*
  * Main XIVE object
  */
@@ -80,6 +124,8 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
     }
=20
     xive->ics =3D ICS_BASE(obj);
+    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xive,
+                                     xive->nr_irqs);
=20
     /* Allocate the last IRQ numbers for the IPIs */
     for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i++)=
 {
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 29112589b37f..eab92c4c1bb8 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -38,6 +38,7 @@ struct sPAPRXive {
=20
     /* IRQ */
     ICSState     *ics;  /* XICS source inherited from the SPAPR machine =
*/
+    qemu_irq     *qirqs;
=20
     /* XIVE internal tables */
     uint8_t      *sbe;
--=20
2.13.5
