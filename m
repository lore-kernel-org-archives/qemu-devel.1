Received: from eggs.gnu.org ([2001:4830:134:3::10]:41830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntt-0004T2-Aa
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntp-0003gA-73
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:41 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:48795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSntp-0003dl-04
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:37 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id E7572FCD11
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:29 +0200
Message-Id: <1499274819-15607-17-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 16/26] ppc/xive: notify CPU when interrupt
 priority is more privileged
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
 hw/intc/xive.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c3c1e9c9db2d..cda1fa18e44d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -53,6 +53,21 @@ static uint64_t xive_icp_accept(XiveICPState *xicp)
     return (nsr << 8) | xicp->tima_os[TM_CPPR];
 }
=20
+static uint8_t ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
+static void xive_icp_notify(XiveICPState *xicp)
+{
+    xicp->tima_os[TM_PIPR] =3D ipb_to_pipr(xicp->tima_os[TM_IPB]);
+
+    if (xicp->tima_os[TM_PIPR] < xicp->tima_os[TM_CPPR]) {
+        xicp->tima_os[TM_NSR] |=3D TM_QW1_NSR_EO;
+        qemu_irq_raise(ICP(xicp)->output);
+    }
+}
+
 static void xive_icp_set_cppr(XiveICPState *xicp, uint8_t cppr)
 {
     if (cppr > XIVE_PRIORITY_MAX) {
@@ -60,6 +75,10 @@ static void xive_icp_set_cppr(XiveICPState *xicp, uint=
8_t cppr)
     }
=20
     xicp->tima_os[TM_CPPR] =3D cppr;
+
+    /* CPPR has changed, inform the ICP which might raise an
+     * exception */
+    xive_icp_notify(xicp);
 }
=20
 /*
@@ -339,6 +358,8 @@ static void xive_icp_irq(XiveICSState *xs, int lisn)
     } else {
         qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
     }
+
+    xive_icp_notify(xicp);
 }
=20
 /*
--=20
2.7.5
