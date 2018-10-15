Received: from eggs.gnu.org ([2001:4830:134:3::10]:45683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXD-0004ZD-W8
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXD-0004PN-4t
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:31 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:20 +0800
Message-Id: <1539593186-32183-21-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 20/26] clean up callback when del virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: liujunjie <liujunjie23@huawei.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: liujunjie <liujunjie23@huawei.com>

Before, we did not clear callback like handle_output when delete
the virtqueue which may result be segmentfault.
The scene is as follows:
1. Start a vm with multiqueue vhost-net,
2. then we write VIRTIO_PCI_GUEST_FEATURES in PCI configuration to
triger multiqueue disable in this vm which will delete the virtqueue.
In this step, the tx_bh is deleted but the callback virtio_net_handle_tx_bh
still exist.
3. Finally, we write VIRTIO_PCI_QUEUE_NOTIFY in PCI configuration to
notify the deleted virtqueue. In this way, virtio_net_handle_tx_bh
will be called and qemu will be crashed.

Although the way described above is uncommon, we had better reinforce it.

CC: qemu-stable@nongnu.org
Signed-off-by: liujunjie <liujunjie23@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 94f5c8e..8da00a1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1612,6 +1612,8 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
 
     vdev->vq[n].vring.num = 0;
     vdev->vq[n].vring.num_default = 0;
+    vdev->vq[n].handle_output = NULL;
+    vdev->vq[n].handle_aio_output = NULL;
 }
 
 static void virtio_set_isr(VirtIODevice *vdev, int value)
-- 
2.5.0
