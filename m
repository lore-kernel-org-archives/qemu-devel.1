Received: from eggs.gnu.org ([2001:4830:134:3::10]:39380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbef-00050k-6D
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbed-00068m-88
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbeb-00064X-5o
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:29 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:32 -0400
Message-Id: <1539266915-15216-10-git-send-email-wexu@redhat.com>
In-Reply-To: <1539266915-15216-1-git-send-email-wexu@redhat.com>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [[RFC v3 09/12] virtio-net: fill head desc after done
 all in a chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

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
index 4bdd5b8..186c86cd2 100644
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
