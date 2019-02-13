Received: from eggs.gnu.org ([209.51.188.92]:43645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gtvst-0003MO-2r
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gtvsq-0007h8-Ug
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:51:34 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gtvso-0007Yu-U5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:51:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id t200so2734029wmt.0
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:51:24 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 13 Feb 2019 16:51:16 +0200
Message-Id: <20190213145116.20654-1-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH] virtio-net: do not start queues that are not
 enabled by the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, yan@daynix.com

https://bugzilla.redhat.com/show_bug.cgi?id=1608226
On startup/link-up in multiqueue configuration the virtio-net
tries to starts all the queues, including those that the guest
will not enable by VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.
If the guest driver does not allocate queues that it will not
use (for example, Windows driver does not) and number of actually
used queues is less that maximal number supported by the device,
this causes vhost_net_start to fail and actually disables vhost
for all the queues, reducing the performance.
Current commit fixes this: initially only first queue is started,
upon VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET started all the queues
requested by the guest.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3f319ef723..d3b1ac6d3a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -174,7 +174,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     NetClientState *nc = qemu_get_queue(n->nic);
-    int queues = n->multiqueue ? n->max_queues : 1;
+    int queues = n->multiqueue ? n->curr_queues : 1;
 
     if (!get_vhost_net(nc->peer)) {
         return;
@@ -1016,9 +1016,12 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
         return VIRTIO_NET_ERR;
     }
 
-    n->curr_queues = queues;
     /* stop the backend before changing the number of queues to avoid handling a
      * disabled queue */
+    virtio_net_set_status(vdev, 0);
+
+    n->curr_queues = queues;
+
     virtio_net_set_status(vdev, vdev->status);
     virtio_net_set_queues(n);
 
-- 
2.17.1
