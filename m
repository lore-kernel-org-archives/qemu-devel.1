Received: from eggs.gnu.org ([2001:4830:134:3::10]:48087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpr-0001OD-RL
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKnpl-0002Hh-1E
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:43 -0500
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:54103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKnpk-0002Fo-QP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:36 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8E9B4177DAB
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 17:06:35 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  1 Dec 2017 17:06:03 +0100
Message-Id: <20171201160604.15265-5-clg@kaod.org>
In-Reply-To: <20171201160604.15265-1-clg@kaod.org>
References: <20171201160604.15265-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] spapr: introduce a spapr_irq_set_lsi()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It will make synchronisation easier with the XIVE interrupt mode when
available. The 'irq' parameter refers to the global IRQ number space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since initial XIVE patchset:
=20
 - s/spapr_irq_set/spapr_irq_set_lsi/

 hw/ppc/spapr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f6e72f686c34..5e4192aee8fe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3579,6 +3579,14 @@ static int ics_find_free_block(ICSState *ics, int =
num, int alignnum)
     return -1;
 }
=20
+/*
+ * Allocate the IRQ number and set the IRQ type, LSI or MSI
+ */
+static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
+{
+    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
+}
+
 int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
                     Error **errp)
 {
@@ -3603,7 +3611,7 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int i=
rq_hint, bool lsi,
         irq +=3D ics->offset;
     }
=20
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
+    spapr_irq_set_lsi(spapr, irq, lsi);
     trace_spapr_irq_alloc(irq);
=20
     return irq;
@@ -3642,10 +3650,10 @@ int spapr_irq_alloc_block(sPAPRMachineState *spap=
r, int num, bool lsi,
         return -1;
     }
=20
+    first +=3D ics->offset;
     for (i =3D first; i < first + num; ++i) {
-        ics_set_irq_type(ics, i, lsi);
+        spapr_irq_set_lsi(spapr, i, lsi);
     }
-    first +=3D ics->offset;
=20
     trace_spapr_irq_alloc_block(first, num, lsi, align);
=20
--=20
2.13.6
