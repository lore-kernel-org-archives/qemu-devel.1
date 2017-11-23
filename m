Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eHiKz-00078n-4f
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 22:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eHiKu-000218-Je
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 22:38:05 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Nov 2017 11:37:46 +0800
Message-Id: <1511408266-4139-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.11] virtio-net: don't touch virtqueue if
 vm is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

Guest state should not be touched if VM is stopped, unfortunately we
didn't check running state and tried to drain tx queue unconditionally
in virtio_net_set_status(). A crash was then noticed as a migration
destination when user type quit after virtqueue state is loaded but
before region cache is initialized. In this case,
virtio_net_drop_tx_queue_data() tries to access the uninitialized
region cache.

Fix this by only dropping tx queue data when vm is running.

Fixes: 283e2c2adcb80 ("net: virtio-net discards TX data after link down")
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 150fd07..38674b0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -288,7 +288,8 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
                 qemu_bh_cancel(q->tx_bh);
             }
             if ((n->status & VIRTIO_NET_S_LINK_UP) == 0 &&
-                (queue_status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+                (queue_status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+                vdev->vm_running) {
                 /* if tx is waiting we are likely have some packets in tx queue
                  * and disabled notification */
                 q->tx_waiting = 0;
-- 
2.7.4
