Received: from eggs.gnu.org ([2001:4830:134:3::10]:51632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1er87v-0001ox-K5
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1er87r-0008Uj-Bx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:14:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1er87r-0008UG-4k
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:14:55 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 28 Feb 2018 13:14:46 -0700
Message-ID: <20180228201446.25283.82272.stgit@gimli.home>
In-Reply-To: <20180228195504.25283.45666.stgit@gimli.home>
References: <20180228195504.25283.45666.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] vfio/pci: Pull BAR mapping setup from
 read-write path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com, aik@ozlabs.ru

This creates a common helper that we'll use for ioeventfd setup.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c |   39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 357243d76f10..5f2b376dcebd 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -113,6 +113,30 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 	return done;
 }
 
+static int vfio_pci_setup_barmap(struct vfio_pci_device *vdev, int bar)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+	void __iomem *io;
+
+	if (vdev->barmap[bar])
+		return 0;
+
+	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
+	if (ret)
+		return ret;
+
+	io = pci_iomap(pdev, bar, 0);
+	if (!io) {
+		pci_release_selected_regions(pdev, 1 << bar);
+		return -ENOMEM;
+	}
+
+	vdev->barmap[bar] = io;
+
+	return 0;
+}
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -147,22 +171,13 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
 		if (!io)
 			return -ENOMEM;
 		x_end = end;
-	} else if (!vdev->barmap[bar]) {
-		int ret;
-
-		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
+	} else {
+		int ret = vfio_pci_setup_barmap(vdev, bar);
 		if (ret)
 			return ret;
 
-		io = pci_iomap(pdev, bar, 0);
-		if (!io) {
-			pci_release_selected_regions(pdev, 1 << bar);
-			return -ENOMEM;
-		}
-
-		vdev->barmap[bar] = io;
-	} else
 		io = vdev->barmap[bar];
+	}
 
 	if (bar == vdev->msix_bar) {
 		x_start = vdev->msix_offset;
