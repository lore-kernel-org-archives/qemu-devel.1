Received: from eggs.gnu.org ([2001:4830:134:3::10]:56639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cngpX-0003Iq-PM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cngpU-0003eY-L7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:25:15 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 15:25:05 +0800
Message-Id: <1489476305-27139-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-pci: reset modern vq meta data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

We don't reset proxy->vqs[].{num|desc[]|avail[]|used[]}. This means if
a driver enable the vq without setting vq address after reset. The old
addresses were leaked. Fixing this by resetting modern vq meta data
during device reset.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b76f3f6..7c36b9c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1857,6 +1857,10 @@ static void virtio_pci_reset(DeviceState *qdev)
 
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         proxy->vqs[i].enabled = 0;
+        proxy->vqs[i].num = 0;
+        proxy->vqs[i].desc[0] = proxy->vqs[i].desc[1] = 0;
+        proxy->vqs[i].avail[0] = proxy->vqs[i].avail[1] = 0;
+        proxy->vqs[i].used[0] = proxy->vqs[i].used[1] = 0;
     }
 }
 
-- 
2.7.4
