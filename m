Received: from eggs.gnu.org ([2001:4830:134:3::10]:40118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrce-0002PH-7T
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcb-0003Wk-2Y
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:56 -0500
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:33621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrca-0003Vf-TX
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:53 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D4CA7175B10
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:51 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:52 +0100
Message-Id: <20171123132955.1261-23-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/25] spapr: add XIVE support to
 spapr_irq_get_qirq()
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

The XIVE object has its own set of qirqs which is to be used when the
XIVE interrupt mode is activated.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 734706c18cb3..a91ec1c0751a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3746,8 +3746,12 @@ qemu_irq spapr_irq_get_qirq(sPAPRMachineState *spa=
pr, int irq)
 {
     ICSState *ics =3D spapr->ics;
=20
-    if (ics_valid_irq(ics, irq)) {
-        return ics->qirqs[irq - ics->offset];
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return spapr->xive->qirqs[irq];
+    } else {
+        if (ics_valid_irq(ics, irq)) {
+            return ics->qirqs[irq - ics->offset];
+        }
     }
=20
     return NULL;
--=20
2.13.6
