Received: from eggs.gnu.org ([2001:4830:134:3::10]:42430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnum-0005HH-N0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnui-0004US-NE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:36 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnui-0004Td-Gs
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:32 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 77FCEFCDB3
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:31 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:38 +0200
Message-Id: <1499274819-15607-26-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 25/26] spapr: print the XIVE interrupt
 source for IPIs in the monitor
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
 hw/intc/xive_spapr.c  | 5 +++++
 hw/ppc/spapr.c        | 4 ++++
 include/hw/ppc/xive.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/intc/xive_spapr.c b/hw/intc/xive_spapr.c
index eb8a5c081e51..4f689f8b97c0 100644
--- a/hw/intc/xive_spapr.c
+++ b/hw/intc/xive_spapr.c
@@ -36,6 +36,11 @@ ICSState *xive_ics_get(XIVE *x, uint32_t lisn)
     return ics_valid_irq(ics, lisn) ? ics : NULL;
 }
=20
+void xive_ics_pic_print_info(XIVE *x, Monitor *mon)
+{
+    ics_pic_print_info(ICS_BASE(&x->ipi_xs), mon);
+}
+
 static XiveICSState *xive_ics_find(sPAPRMachineState *spapr, uint32_t li=
sn)
 {
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(spapr);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 816661f4c9ad..ca3a6bc2ea16 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3399,6 +3399,10 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
         icp_pic_print_info(ICP(cpu->intc), mon);
     }
=20
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        xive_ics_pic_print_info(spapr->xive, mon);
+    }
+
     ics_pic_print_info(spapr->ics, mon);
 }
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index dc5309264422..ee9b32d8c884 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -75,5 +75,6 @@ void xive_ics_create(XiveICSState *xs, XIVE *x, uint32_=
t offset,
                      uint32_t nr_irqs, uint32_t shift, uint32_t flags,
                      Error **errp);
 ICSState *xive_ics_get(XIVE *x, uint32_t lisn);
+void xive_ics_pic_print_info(XIVE *x, Monitor *mon);
=20
 #endif /* PPC_XIVE_H */
--=20
2.7.5
