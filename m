Received: from eggs.gnu.org ([2001:4830:134:3::10]:38066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbE-0000w0-ET
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbB-0000f7-9Y
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:28 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:38006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrbB-0000dd-3v
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:25 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id EF36D171BED
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:31:23 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:35 +0100
Message-Id: <20171123132955.1261-6-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/25] spapr: introduce a spapr_irq_set() helper
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

It will make synchronisation easier with the XIVE interrupt mode when
available. The 'irq' parameter refers to the global IRQ number space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7ae84d40bdb4..79f38a9ff4e1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3594,6 +3594,11 @@ static int ics_find_free_block(ICSState *ics, int =
num, int alignnum)
     return -1;
 }
=20
+static void spapr_irq_set(sPAPRMachineState *spapr, int irq, bool lsi)
+{
+    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
+}
+
 int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
                     Error **errp)
 {
@@ -3618,7 +3623,7 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int i=
rq_hint, bool lsi,
         irq +=3D ics->offset;
     }
=20
-    ics_set_irq_type(ics, irq - ics->offset, lsi);
+    spapr_irq_set(spapr, irq, lsi);
     trace_spapr_irq_alloc(irq);
=20
     return irq;
@@ -3657,10 +3662,10 @@ int spapr_irq_alloc_block(sPAPRMachineState *spap=
r, int num, bool lsi,
         return -1;
     }
=20
+    first +=3D ics->offset;
     for (i =3D first; i < first + num; ++i) {
-        ics_set_irq_type(ics, i, lsi);
+        spapr_irq_set(spapr, i, lsi);
     }
-    first +=3D ics->offset;
=20
     trace_spapr_irq_alloc_block(first, num, lsi, align);
=20
--=20
2.13.6
