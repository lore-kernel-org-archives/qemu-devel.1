Received: from eggs.gnu.org ([2001:4830:134:3::10]:56745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18X-0005Qs-T9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18W-0001R5-TW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18W-0001OK-KY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:12 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:49 +0200
Message-Id: <20170717081152.17153-7-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/9] virtio-net: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

virtqueue_error includes the queue index in the error output and is preferred
for errors that pertain to a virtqueue rather than to the device as a whole.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/net/virtio-net.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5630a9e..b3d0b85 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -970,7 +970,7 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         }
         if (iov_size(elem->in_sg, elem->in_num) < sizeof(status) ||
             iov_size(elem->out_sg, elem->out_num) < sizeof(ctrl)) {
-            virtio_error(vdev, "virtio-net ctrl missing headers");
+            virtqueue_error(vq, "virtio-net ctrl missing headers");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             break;
@@ -1204,20 +1204,20 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         elem = virtqueue_pop(q->rx_vq, sizeof(VirtQueueElement));
         if (!elem) {
             if (i) {
-                virtio_error(vdev, "virtio-net unexpected empty queue: "
-                             "i %zd mergeable %d offset %zd, size %zd, "
-                             "guest hdr len %zd, host hdr len %zd "
-                             "guest features 0x%" PRIx64,
-                             i, n->mergeable_rx_bufs, offset, size,
-                             n->guest_hdr_len, n->host_hdr_len,
-                             vdev->guest_features);
+                virtqueue_error(q->rx_vq, "virtio-net unexpected empty queue: "
+                                "i %zd mergeable %d offset %zd, size %zd, "
+                                "guest hdr len %zd, host hdr len %zd "
+                                "guest features 0x%" PRIx64,
+                                i, n->mergeable_rx_bufs, offset, size,
+                                n->guest_hdr_len, n->host_hdr_len,
+                                vdev->guest_features);
             }
             return -1;
         }
 
         if (elem->in_num < 1) {
-            virtio_error(vdev,
-                         "virtio-net receive queue contains no in buffers");
+            virtqueue_error(q->rx_vq,
+                            "virtio-net receive queue contains no in buffers");
             virtqueue_detach_element(q->rx_vq, elem, 0);
             g_free(elem);
             return -1;
@@ -1333,7 +1333,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         out_num = elem->out_num;
         out_sg = elem->out_sg;
         if (out_num < 1) {
-            virtio_error(vdev, "virtio-net header not in first element");
+            virtqueue_error(q->tx_vq, "virtio-net header not in first element");
             virtqueue_detach_element(q->tx_vq, elem, 0);
             g_free(elem);
             return -EINVAL;
@@ -1342,7 +1342,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         if (n->has_vnet_hdr) {
             if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
-                virtio_error(vdev, "virtio-net header incorrect");
+                virtqueue_error(q->tx_vq, "virtio-net header incorrect");
                 virtqueue_detach_element(q->tx_vq, elem, 0);
                 g_free(elem);
                 return -EINVAL;
-- 
2.9.3
