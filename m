Received: from eggs.gnu.org ([2001:4830:134:3::10]:52138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDk-0001m5-HP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDh-000404-B5
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:56 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1cGiDh-0003vD-50
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:53 -0500
Received: by mail-wj0-f194.google.com with SMTP id j10so15104164wjb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:13:30 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 13 Dec 2016 10:12:08 +0200
Message-Id: <1481616728-148412-5-git-send-email-yuri.benditovich@daynix.com>
In-Reply-To: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
References: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v3 4/4] net: virtio-net discards TX data after
 link down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

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
1.9.1
