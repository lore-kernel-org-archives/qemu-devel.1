Received: from eggs.gnu.org ([209.51.188.92]:41498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gu8dH-0001MZ-E9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gu8dF-00059z-1K
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gu8dE-0004gU-Nu
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:16 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 23:26:40 -0500
Message-Id: <1550118402-4057-10-git-send-email-wexu@redhat.com>
In-Reply-To: <1550118402-4057-1-git-send-email-wexu@redhat.com>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/11] virtio-net: update the head
 descriptor in a chain lastly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

This is a helper for packed ring.

To support packed ring, the head descriptor in a chain should be updated
lastly since no 'avail_idx' like in packed ring to explicitly tell the
driver side that all payload is ready after having done the chain, so
the head is always visible immediately.

This patch fills the header after done all the other ones.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/net/virtio-net.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3f319ef..330abea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1251,6 +1251,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     struct virtio_net_hdr_mrg_rxbuf mhdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset;
+    VirtQueueElement head;
+    int head_len = 0;
 
     if (!virtio_net_can_receive(nc)) {
         return -1;
@@ -1328,7 +1330,13 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
 
@@ -1339,6 +1347,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                      &mhdr.num_buffers, sizeof mhdr.num_buffers);
     }
 
+    virtqueue_fill(q->rx_vq, &head, head_len, 0);
     virtqueue_flush(q->rx_vq, i);
     virtio_notify(vdev, q->rx_vq);
 
-- 
1.8.3.1
