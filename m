Received: from eggs.gnu.org ([2001:4830:134:3::10]:39216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dUe51-0004RA-CA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dUe4y-0001rx-7n
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dUe4x-0001rl-Ts
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:10:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDBD64E4CA
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 19:10:42 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 10 Jul 2017 13:10:42 -0600
Message-ID: <20170710191038.32728.34984.stgit@gimli.home>
In-Reply-To: <20170710190904.32728.74078.stgit@gimli.home>
References: <20170710190904.32728.74078.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/2] vfio/pci: Fixup v0 PCIe capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Intel 82599 VFs report a PCIe capability version of 0, which is
invalid.  The earliest version of the PCIe spec used version 1.  This
causes Windows to fail startup on the device and it will be disabled
with error code 10.  Our choices are either to drop the PCIe cap on
such devices, which has the side effect of likely preventing the guest
from discovering any extended capabilities, or performing a fixup to
update the capability to the earliest valid version.  This implements
the latter.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ccdb6e1d632a..d4051cb9513d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1743,6 +1743,18 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
     }
 
+    /*
+     * Intel 82599 SR-IOV VFs report an invalid PCIe capability version 0
+     * (Niantic errate #35) causing Windows to error with a Code 10 for the
+     * device on Q35.  Fixup any such devices to report version 1.  If we
+     * were to remove the capability entirely the guest would lose extended
+     * config space.
+     */
+    if ((flags & PCI_EXP_FLAGS_VERS) == 0) {
+        vfio_add_emulated_word(vdev, pos + PCI_CAP_FLAGS,
+                               1, PCI_EXP_FLAGS_VERS);
+    }
+
     pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
                              errp);
     if (pos < 0) {
