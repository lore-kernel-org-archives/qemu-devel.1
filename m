Received: from eggs.gnu.org ([2001:4830:134:3::10]:50914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF7-0003LP-B8
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF6-0006yy-NQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:49 -0400
Date: Wed, 15 Mar 2017 20:01:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489600837-11541-8-git-send-email-mst@redhat.com>
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489600837-11541-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] virtio-pci: reset modern vq meta data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

From: Jason Wang <jasowang@redhat.com>

We don't reset proxy->vqs[].{num|desc[]|avail[]|used[]}. This means if
a driver enable the vq without setting vq address after reset. The old
addresses were leaked. Fixing this by resetting modern vq meta data
during device reset.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5ce42af..69cc471 100644
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
MST
