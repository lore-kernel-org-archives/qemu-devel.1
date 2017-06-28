Received: from eggs.gnu.org ([2001:4830:134:3::10]:38859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dQI8n-0002EQ-VE
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dQI8j-0005Vz-5C
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:56:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dQI8i-0005Vf-Vs
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:56:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC0E8C057EC9
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:56:35 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 28 Jun 2017 12:56:32 -0600
Message-ID: <20170628185546.4469.87645.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Fixup v0 PCIe capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org

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
index 32aca7770177..3346f89f98c2 100644
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
     pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size);
     if (pos >= 0) {
         vdev->pdev.exp.exp_cap = pos;
