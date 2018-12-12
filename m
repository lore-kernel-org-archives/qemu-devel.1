Received: from eggs.gnu.org ([2001:4830:134:3::10]:47121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gXAMX-00059b-Nt
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gXAMX-0007RV-00
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gXAMW-0007R0-Px
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:04 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 12 Dec 2018 12:39:56 -0700
Message-ID: <154464359673.9828.13600047795249996191.stgit@gimli.home>
In-Reply-To: <154464279386.9828.10219496338109023342.stgit@gimli.home>
References: <154464279386.9828.10219496338109023342.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 7/8] vfio/pci: Remove PCIe Link Status
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, Eric Auger <eric.auger@redhat.com>

Now that the downstream port will virtually negotiate itself to the
link status of the downstream device, we can remove this emulation.
It's not clear that it was every terribly useful anyway.

Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
