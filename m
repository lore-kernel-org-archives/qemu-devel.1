Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gN28b-0004uF-6R
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gN28a-0005JO-Fw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gN28a-0005Fk-98
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:48 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 14 Nov 2018 13:51:35 -0700
Message-ID: <154222869511.9288.17334254288748635551.stgit@gimli.home>
In-Reply-To: <154222737752.9288.484557356059052047.stgit@gimli.home>
References: <154222737752.9288.484557356059052047.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC for-3.2 PATCH 7/7] vfio/pci: Remove PCIe Link
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
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, geoff@hostfission.com

Now that the downstream port will virtually negotiate itself to the
link status of the downstream devie, we can remove this emulation.
It's not clear that it was every terribly useful anyway.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 08aab328b442..0d1dd4666fd1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1899,12 +1899,6 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
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
