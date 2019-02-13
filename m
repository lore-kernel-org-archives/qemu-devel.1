Received: from eggs.gnu.org ([209.51.188.92]:46295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gu1lK-0003C3-0P
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gu1lI-0003F2-Ne
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:08:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gu1lI-0003EV-H5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 16:08:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DL03ot059158
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 16:08:07 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmsv7apj6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 16:08:07 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 13 Feb 2019 21:08:05 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 13 Feb 2019 22:07:56 +0100
In-Reply-To: <20190213210756.27032-1-clg@kaod.org>
References: <20190213210756.27032-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190213210756.27032-3-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] spapr/irq: remove the XICS offset
 adjustment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Now that we have changed the XICS and the XIVE interrupt backend to
have different size for their IRQ number space, we do not need to
align their source numbers anymore. Remove the offset adjustment and
wire the dual 'qirq' handler to the 'qirq' handler of the current
interrupt mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 99c3f6ba251a..6a6571e043b3 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -453,17 +453,6 @@ static void spapr_irq_init_dual(sPAPRMachineState *s=
papr, int nr_irqs,
         return;
     }
=20
-    /*
-     * Align the XICS and the XIVE IRQ number space under QEMU.
-     *
-     * However, the XICS KVM device still considers that the IRQ
-     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
-     * should introduce a KVM device ioctl to set the offset or ignore
-     * the lower 4K numbers when using the get/set ioctl of the XICS
-     * KVM device. The second option seems the least intrusive.
-     */
-    spapr->ics->offset =3D 0;
-
     spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -500,21 +489,7 @@ static void spapr_irq_free_dual(sPAPRMachineState *s=
papr, int irq, int num)
=20
 static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
 {
-    sPAPRXive *xive =3D spapr->xive;
-    ICSState *ics =3D spapr->ics;
-
-    if (irq >=3D spapr->irq->nr_irqs) {
-        return NULL;
-    }
-
-    /*
-     * The IRQ number should have been claimed under both interrupt
-     * controllers.
-     */
-    assert(!ICS_IRQ_FREE(ics, irq - ics->offset));
-    assert(xive_eas_is_valid(&xive->eat[irq]));
-
-    return spapr->qirqs[irq];
+    return spapr_irq_current(spapr)->qirq(spapr, irq);
 }
=20
 static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor =
*mon)
--=20
2.20.1
