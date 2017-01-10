Received: from eggs.gnu.org ([2001:4830:134:3::10]:33848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAi-00087N-T7
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAh-0005s0-JB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:36 -0500
Received: from mail.kernel.org ([198.145.29.136]:48372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAh-0005rb-2H
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:35 -0500
Date: Tue, 10 Jan 2017 07:40:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-29-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 28/41] net: virtio-net discards TX data after
 link down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=1295637
Upon set_link monitor command or upon netdev deletion
virtio-net sends link down indication to the guest
and stops vhost if one is used.
Guest driver can still submit data for TX until it
recognizes link loss. If these packets not returned by
the host, the Windows guest will never be able to finish
disable/removal/shutdown.
Now each packet sent by guest after NIC indicated link
down will be completed immediately.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5009533..6f98eab 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -218,6 +218,14 @@ static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
     }
 }
 
+static void virtio_net_drop_tx_queue_data(VirtIODevice *vdev, VirtQueue *vq)
+{
+    unsigned int dropped = virtqueue_drop_all(vq);
+    if (dropped) {
+        virtio_notify(vdev, vq);
+    }
+}
+
 static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -262,6 +270,14 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
             } else {
                 qemu_bh_cancel(q->tx_bh);
             }
+            if ((n->status & VIRTIO_NET_S_LINK_UP) == 0 &&
+                (queue_status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+                /* if tx is waiting we are likely have some packets in tx queue
+                 * and disabled notification */
+                q->tx_waiting = 0;
+                virtio_queue_set_notification(q->tx_vq, 1);
+                virtio_net_drop_tx_queue_data(vdev, q->tx_vq);
+            }
         }
     }
 }
@@ -1323,6 +1339,11 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIONet *n = VIRTIO_NET(vdev);
     VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
 
+    if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
+        virtio_net_drop_tx_queue_data(vdev, vq);
+        return;
+    }
+
     /* This happens when device was stopped but VCPU wasn't. */
     if (!vdev->vm_running) {
         q->tx_waiting = 1;
@@ -1349,6 +1370,11 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
     VirtIONet *n = VIRTIO_NET(vdev);
     VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
 
+    if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
+        virtio_net_drop_tx_queue_data(vdev, vq);
+        return;
+    }
+
     if (unlikely(q->tx_waiting)) {
         return;
     }
-- 
MST
