Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7IF-00008C-H9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7IE-0003g8-Ma
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7IE-0003f1-GO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:58 -0400
Date: Mon, 3 Jul 2017 22:45:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-21-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/21] virtio-net: fix tx queue size for
 !vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wei Wang <wei.w.wang@intel.com>, Jason Wang <jasowang@redhat.com>

Current code segfaults when no nic peer is specified.
Fix it up - fall back to default queue size.

Fixes: 9b02e1618cf26a ("virtio-net: enable configurable tx queue size")
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a1fc0db..5630a9e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -498,6 +498,24 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
     }
 }
 
+static int virtio_net_max_tx_queue_size(VirtIONet *n)
+{
+    NetClientState *peer = n->nic_conf.peers.ncs[0];
+
+    /*
+     * Backends other than vhost-user don't support max queue size.
+     */
+    if (!peer) {
+        return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
+    }
+
+    if (peer->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
+        return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
+    }
+
+    return VIRTQUEUE_MAX_SIZE;
+}
+
 static int peer_attach(VirtIONet *n, int index)
 {
     NetClientState *nc = qemu_get_subqueue(n->nic, index);
@@ -1964,14 +1982,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         error_report("Defaulting to \"bh\"");
     }
 
-    /*
-     * Currently, backends other than vhost-user don't support 1024 queue
-     * size.
-     */
-    if (n->net_conf.tx_queue_size == VIRTQUEUE_MAX_SIZE &&
-        n->nic_conf.peers.ncs[0]->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
-        n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
-    }
+    n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
+                                    n->net_conf.tx_queue_size);
 
     for (i = 0; i < n->max_queues; i++) {
         virtio_net_add_queue(n, i);
-- 
MST
