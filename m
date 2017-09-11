Received: from eggs.gnu.org ([2001:4830:134:3::10]:35469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSI0-0001X4-Br
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSHv-0004ZV-RH
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:28 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:39178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSHv-0004Xq-LX
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:14:23 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 79984AB24B
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:27 +0200
Message-Id: <20170911171235.29331-14-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 13/21] ppc/xive: handle interrupt
 acknowledgment by the O/S
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

When an O/S Exception is raised, the O/S acknowledges the interrupt
with a special read in the TIMA. If the EO bit of the Notification
Source Register (NSR) is set (and it should), the Current Processor
Priority Register (CPPR) takes the value of the Pending Interrupt
Priority Register (PIPR), which contains the priority of the most
favored pending notification. The bit number corresponding to the
priority of the pending interrupt is reseted in the Interrupt Pending
Buffer (IPB) and so is the EO bit of the NSR.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e5d4b723b7e0..ad3ff91b13ea 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -50,7 +50,24 @@ static uint8_t ipb_to_pipr(uint8_t ibp)
=20
 static uint64_t spapr_xive_icp_accept(ICPState *icp)
 {
-    return 0;
+    uint8_t nsr =3D icp->tima_os[TM_NSR];
+
+    qemu_irq_lower(icp->output);
+
+    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
+        uint8_t cppr =3D icp->tima_os[TM_PIPR];
+
+        icp->tima_os[TM_CPPR] =3D cppr;
+
+        /* Reset the pending buffer bit */
+        icp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
+        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
+
+        /* Drop Exception bit for OS */
+        icp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
+    }
+
+    return (nsr << 8) | icp->tima_os[TM_CPPR];
 }
=20
 static void spapr_xive_icp_notify(ICPState *icp)
--=20
2.13.5
