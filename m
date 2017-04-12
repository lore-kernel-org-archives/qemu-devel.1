Received: from eggs.gnu.org ([2001:4830:134:3::10]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyCSK-00050A-6Q
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 03:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyCSG-0005eT-6j
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 03:12:44 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:60360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cyCSG-0005eF-0Q
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 03:12:40 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A249031615
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 09:12:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 12 Apr 2017 09:12:17 +0200
Message-Id: <1491981137-32713-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] pci: Don't call pci_irq_handler() for a
 negative intx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Under some circumstances, pci_intx() can return -1 (when the interrupt
pin in the config space is 0 which normally means no interrupt).

I have seen cases of pci_set_irq() being called on such devices, in
turn causing pci_irq_handler() to be called with "-1" as an argument
which doesn't seem like a terribly good idea.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: updated for qemu-2.9 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci/pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: qemu-powernv-2.9.git/hw/pci/pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-powernv-2.9.git.orig/hw/pci/pci.c
+++ qemu-powernv-2.9.git/hw/pci/pci.c
@@ -1419,7 +1419,9 @@ qemu_irq pci_allocate_irq(PCIDevice *pci
 void pci_set_irq(PCIDevice *pci_dev, int level)
 {
     int intx =3D pci_intx(pci_dev);
-    pci_irq_handler(pci_dev, intx, level);
+    if (intx >=3D 0) {
+        pci_irq_handler(pci_dev, intx, level);
+    }
 }
=20
 /* Special hooks used by device assignment */
