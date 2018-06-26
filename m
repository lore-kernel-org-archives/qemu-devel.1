Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXorV-0000Qa-Ml
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXorS-0004xu-JI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:22:29 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:49268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXorS-0004tY-D9
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:22:26 -0400
Received: from player158.ha.ovh.net (unknown [10.109.105.47])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BAB821C835
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:22:24 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 26 Jun 2018 16:22:14 +0200
Message-Id: <20180626142214.27801-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: fix pnv_core_realize() error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit d35aefa9ae15 ("ppc/pnv: introduce a new intc_create() operation
to the chip model") changed the object link in the pnv_core_realize()
routine but a return was forgotten in case of error, which can lead to
more problems afterwards (segv)

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a9f129fc2c5f..9750464bf4a1 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -150,6 +150,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     if (!chip) {
         error_propagate(errp, local_err);
         error_prepend(errp, "required link 'chip' not found: ");
+        return;
     }
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
--=20
2.13.6
