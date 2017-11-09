Received: from eggs.gnu.org ([2001:4830:134:3::10]:40919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmuO-0000ZC-75
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCmuN-0005YX-4t
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:30:16 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:46444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCmuM-0005Y3-Ua
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:30:15 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id CF0F79BDF1
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 14:30:13 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  9 Nov 2017 11:14:35 +0100
Message-Id: <20171109101439.390-9-clg@kaod.org>
In-Reply-To: <20171109101439.390-1-clg@kaod.org>
References: <20171109101439.390-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v2 08/12] spapr: remove the use of
 ics_valid_irq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

ics_valid_irq() can be replaced by a simple check on the 'srcno'
number. It also removes a dependency on the ICSState object of the
sPAPR machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6c3fc12ed8e1..0c6a4c8bffc0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3619,11 +3619,10 @@ static int spapr_irq_alloc_block(XICSFabric *xi, =
int count, int align)
 static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
-    ICSState *ics =3D spapr->ics;
     int srcno =3D irq - spapr->irq_base;
     int i;
=20
-    if (ics_valid_irq(ics, irq)) {
+    if (srcno >=3D 0 && srcno < spapr->nr_irqs) {
         trace_spapr_irq_free(0, irq, num);
         for (i =3D srcno; i < srcno + num; ++i) {
             if (!test_bit(i, spapr->irq_map)) {
--=20
2.13.6
