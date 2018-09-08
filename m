Received: from eggs.gnu.org ([2001:4830:134:3::10]:55123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fycvo-00080Z-Q3
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 09:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fycvj-0003uG-Tu
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 09:05:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60372 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fycvj-0003cD-Dc
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 09:05:39 -0400
From: liujunjie <liujunjie23@huawei.com>
Date: Sat, 8 Sep 2018 21:04:48 +0800
Message-ID: <20180908130448.24516-1-liujunjie23@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] clean up callback when del virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com
Cc: wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org, liujunjie <liujunjie23@huawei.com>

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

Signed-off-by: liujunjie <liujunjie23@huawei.com>
---
 hw/net/virtio-net.c | 4 +++-
 hw/virtio/virtio.c  | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f154756..9bb20e3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1467,7 +1467,9 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
     virtio_queue_set_notification(vq, 0);
-    qemu_bh_schedule(q->tx_bh);
+    if (q->tx_bh) {
+        qemu_bh_schedule(q->tx_bh);
+    }
 }
 
 static void virtio_net_tx_timer(void *opaque)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98..7577518 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1604,6 +1604,9 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
 
     vdev->vq[n].vring.num = 0;
     vdev->vq[n].vring.num_default = 0;
+    vdev->vq[n].vring.align = 0;
+    vdev->vq[n].handle_output = NULL;
+    vdev->vq[n].handle_aio_output = NULL;
 }
 
 static void virtio_set_isr(VirtIODevice *vdev, int value)
-- 
1.8.3.1
