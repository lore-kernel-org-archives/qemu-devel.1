Received: from eggs.gnu.org ([2001:4830:134:3::10]:54960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLdq-0004KS-Ed
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLdp-0003tb-NC
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eZLdp-0003rn-FT
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:25 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 10 Jan 2018 12:02:13 -0700
Message-ID: <20180110190212.5389.67764.stgit@gimli.home>
In-Reply-To: <20180110190049.5389.12984.stgit@gimli.home>
References: <20180110190049.5389.12984.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 3/5] vfio/pci: Emulate BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, aik@ozlabs.ru

The kernel provides similar emulation of PCI BAR register access to
QEMU, so up until now we've used that for things like BAR sizing and
storing the BAR address.  However, if we intend to resize BARs or add
BARs that don't exist on the physical device, we need to switch to the
pure QEMU emulation of the BAR.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 46f1e7ed9933..20252ea7aeb7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2773,6 +2773,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     /* QEMU can choose to expose the ROM or not */
     memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
+    /* QEMU can also add or extend BARs */
+    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
 
     /*
      * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
