Received: from eggs.gnu.org ([2001:4830:134:3::10]:34823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSH4-0000eE-Pa
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSGz-0003tt-TT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:30 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:53584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSGz-0003t0-MJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:13:25 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B9789AB108
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:13:24 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:19 +0200
Message-Id: <20170911171235.29331-6-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 05/21] ppc/xive: allocate IRQ numbers
 for the IPIs
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

The number of IPIs is deduced from the max number of CPUs the guest
supports and the IRQ numbers for the IPIs are allocated from the top
of the IRQ number space to reduce conflict with other IRQ numbers
allocated by the devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 1681affb0848..52c32f588d6d 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -58,6 +58,7 @@ static void spapr_xive_realize(DeviceState *dev, Error =
**errp)
     sPAPRXive *xive =3D SPAPR_XIVE(dev);
     Object *obj;
     Error *err =3D NULL;
+    int i;
=20
     if (!xive->nr_targets) {
         error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
@@ -80,6 +81,11 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
=20
     xive->ics =3D ICS_BASE(obj);
=20
+    /* Allocate the last IRQ numbers for the IPIs */
+    for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i++)=
 {
+        ics_set_irq_type(xive->ics, i, false);
+    }
+
     /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
     xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
     xive->sbe =3D g_malloc0(xive->sbe_size);
--=20
2.13.5
