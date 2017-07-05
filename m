Received: from eggs.gnu.org ([2001:4830:134:3::10]:42337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnug-0005Co-Rx
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuc-0004Og-Or
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:30 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:34496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnuc-0004NT-GJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:26 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 50A4AFCD9C
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:25 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:37 +0200
Message-Id: <1499274819-15607-25-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 24/26] spapr: include the XIVE interrupt
 source for IPIs
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive_spapr.c  | 10 ++++++++++
 hw/ppc/spapr.c        | 11 ++++++++++-
 include/hw/ppc/xive.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive_spapr.c b/hw/intc/xive_spapr.c
index 64282cb4bfab..eb8a5c081e51 100644
--- a/hw/intc/xive_spapr.c
+++ b/hw/intc/xive_spapr.c
@@ -26,6 +26,16 @@
=20
 #include "xive-internal.h"
=20
+/*
+ * Used by the XICSFabric ics_get handler in sPAPR
+ */
+ICSState *xive_ics_get(XIVE *x, uint32_t lisn)
+{
+    ICSState *ics =3D ICS_BASE(&x->ipi_xs);
+
+    return ics_valid_irq(ics, lisn) ? ics : NULL;
+}
+
 static XiveICSState *xive_ics_find(sPAPRMachineState *spapr, uint32_t li=
sn)
 {
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(spapr);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 45527b4c5eca..816661f4c9ad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3361,7 +3361,16 @@ static ICSState *spapr_ics_get(XICSFabric *dev, in=
t irq)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
=20
-    return ics_valid_irq(spapr->ics, irq) ? spapr->ics : NULL;
+    if (ics_valid_irq(spapr->ics, irq)) {
+        return spapr->ics;
+    }
+
+    /* If needed, check the XIVE IPI source also */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return xive_ics_get(spapr->xive, irq);
+    }
+
+    return NULL;
 }
=20
 static void spapr_ics_resend(XICSFabric *dev)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 3c1cd96ea4d0..dc5309264422 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -74,5 +74,6 @@ uint32_t xive_alloc_hw_irqs(XIVE *x, uint32_t count, ui=
nt32_t align);
 void xive_ics_create(XiveICSState *xs, XIVE *x, uint32_t offset,
                      uint32_t nr_irqs, uint32_t shift, uint32_t flags,
                      Error **errp);
+ICSState *xive_ics_get(XIVE *x, uint32_t lisn);
=20
 #endif /* PPC_XIVE_H */
--=20
2.7.5
