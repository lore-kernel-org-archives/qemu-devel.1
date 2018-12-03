Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gTr5E-0005XK-K7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gTr5D-00037c-Vm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gTr5D-00037D-Q4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:28:31 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 03 Dec 2018 09:28:30 -0700
Message-ID: <154385451043.17724.16271001117325356391.stgit@gimli.home>
In-Reply-To: <154385426086.17724.4390242199797858265.stgit@gimli.home>
References: <154385426086.17724.4390242199797858265.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-4.0 PATCH v2 7/9] vfio/pci: Remove PCIe Link
 Status emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>

Now that the downstream port will virtually negotiate itself to the
link status of the downstream devie, we can remove this emulation.
It's not clear that it was every terribly useful anyway.

Tested-by: Geoffrey McRae <geoff@hostfission.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 74f9a46b4be0..c0cb1ec28908 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1901,12 +1901,6 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                            QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
             vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
-
-        /* Mark the Link Status bits as emulated to allow virtual negotiation */
-        vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKSTA,
-                               pci_get_word(vdev->pdev.config + pos +
-                                            PCI_EXP_LNKSTA),
-                               PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
     }
 
     /*
