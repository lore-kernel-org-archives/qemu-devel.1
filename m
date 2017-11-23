Received: from eggs.gnu.org ([2001:4830:134:3::10]:39702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcJ-00026u-Sl
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcG-0002wh-Mp
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:35 -0500
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:34402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcG-0002ux-FH
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:32 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2DEFF16E538
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:31 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:48 +0100
Message-Id: <20171123132955.1261-19-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/25] spapr: allocate IRQ numbers for the XIVE
 interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The IRQ numbers for the IPIs are allocated at the bottom of the IRQ
number space to preserve compatibility with XICS which only uses IRQ
numbers above 4096.

Also make sure that the allocated IRQ numbers are kept in sync between
XICS and XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0e0107c8272c..ca4e72187f60 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2392,6 +2392,11 @@ static void ppc_spapr_init(MachineState *machine)
          * use the range below XICS_IRQ_BASE, which is unused by XICS. *=
/
         spapr->xive =3D spapr_xive_create(spapr, XICS_IRQ_BASE + XICS_IR=
QS_SPAPR,
                                         &error_fatal);
+
+        /* Allocate the first IRQ numbers for the XIVE IPIs */
+        for (i =3D 0; i < xics_max_server_number(); ++i) {
+            spapr_xive_irq_set(spapr->xive, i, false);
+        }
     }
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
@@ -3631,6 +3636,7 @@ static int ics_find_free_block(ICSState *ics, int n=
um, int alignnum)
 static void spapr_irq_set(sPAPRMachineState *spapr, int irq, bool lsi)
 {
     ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
+    spapr_xive_irq_set(spapr->xive, irq, lsi);
 }
=20
 int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
@@ -3721,6 +3727,7 @@ void spapr_irq_free(sPAPRMachineState *spapr, int i=
rq, int num)
             memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
         }
     }
+    spapr_xive_irq_unset(spapr->xive, irq);
 }
=20
 qemu_irq spapr_irq_get_qirq(sPAPRMachineState *spapr, int irq)
--=20
2.13.6
