Received: from eggs.gnu.org ([209.51.188.92]:47204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzT-0003Zv-Rn
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzR-0007qr-2k
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzJ-0007ku-QK
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:31 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:15 -0500
Message-Id: <1547663480-547-11-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/15] virtio-net: fill head desc after done
 all in a chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

With the support of marking a descriptor used/unused in 'flags'
field for 1.1, the current way of filling a chained descriptors
does not work since driver side may get the wrong 'num_buffer'
information in case of the head descriptor has been filled in
while the subsequent ones are still in processing in device side.

This patch fills the head one after done all the others one.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/net/virtio-net.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e37fc34..39336b9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1198,6 +1198,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     struct virtio_net_hdr_mrg_rxbuf mhdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset;
+    VirtQueueElement head;
+    int head_len = 0;
 
     if (!virtio_net_can_receive(nc)) {
         return -1;
@@ -1275,7 +1277,13 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         }
 
         /* signal other side */
-        virtqueue_fill(q->rx_vq, elem, total, i++);
+        if (i == 0) {
+            head_len = total;
+            head = *elem;
+        } else {
+            virtqueue_fill(q->rx_vq, elem, len, i);
+        }
+        i++;
         g_free(elem);
     }
 
@@ -1286,6 +1294,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                      &mhdr.num_buffers, sizeof mhdr.num_buffers);
     }
 
+    virtqueue_fill(q->rx_vq, &head, head_len, 0);
     virtqueue_flush(q->rx_vq, i);
     virtio_notify(vdev, q->rx_vq);
 
-- 
1.8.3.1
