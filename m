Received: from eggs.gnu.org ([2001:4830:134:3::10]:56686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fJiUa-0004hm-BM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fJiUX-00089u-8W
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:32 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:50481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fJiUX-000896-1v
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:44:29 -0400
Received: from player774.ha.ovh.net (unknown [10.109.120.8])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 57D21B1648
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 18:44:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 18 May 2018 18:44:03 +0200
Message-Id: <20180518164405.11804-3-clg@kaod.org>
In-Reply-To: <20180518164405.11804-1-clg@kaod.org>
References: <20180518164405.11804-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] sparp_pci: simplify how the PCI LSIs are
 allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

PCI LSIs are today allocated one by one using the IRQ alloc_block
routine. Change the code sequence to first allocate a PCI_NUM_PINS
block. It will help us providing a generic IRQ framework to the
machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_pci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39a14980d397..4fd97ffe4c6e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1546,6 +1546,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     sPAPRTCETable *tcet;
     const unsigned windows_supported =3D
         sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
+    uint32_t irq;
+    Error *local_err =3D NULL;
=20
     if (!spapr) {
         error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
@@ -1694,18 +1696,15 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
     QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
=20
     /* Initialize the LSI table */
-    for (i =3D 0; i < PCI_NUM_PINS; i++) {
-        uint32_t irq;
-        Error *local_err =3D NULL;
-
-        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_err)=
;
-        if (local_err) {
-            error_propagate(errp, local_err);
-            error_prepend(errp, "can't allocate LSIs: ");
-            return;
-        }
+    irq =3D spapr_irq_alloc_block(spapr, PCI_NUM_PINS, true, false, &loc=
al_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "can't allocate LSIs: ");
+        return;
+    }
=20
-        sphb->lsi_table[i].irq =3D irq;
+    for (i =3D 0; i < PCI_NUM_PINS; i++) {
+        sphb->lsi_table[i].irq =3D irq + i;
     }
=20
     /* allocate connectors for child PCI devices */
--=20
2.13.6
