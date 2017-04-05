Received: from eggs.gnu.org ([2001:4830:134:3::10]:42380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkI4-00014N-6D
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkI0-0001dm-9K
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:44:00 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:38155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkI0-0001dT-3G
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:56 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9CACC49BD6
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:43:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:44 +0200
Message-Id: <1491396106-26376-20-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/21] pci: Don't call pci_irq_handler() for a
 negative intx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Under some circumstances, pci_intx() can return -1 (when the interrupt
pin in the config space is 0 which normally means no interrupt).

I have seen cases of pci_set_irq() being called on such devices, in
turn causing pci_irq_handler() to be called with "-1" as an argument
which doesn't seem like a terribly good idea.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: updated for qemu-2.9 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 817ad14ed987..bfd65461348c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1419,7 +1419,9 @@ qemu_irq pci_allocate_irq(PCIDevice *pci_dev)
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
--=20
2.7.4
