Received: from eggs.gnu.org ([2001:4830:134:3::10]:35414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhHN-0001AV-Nh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhHK-0008OS-KY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:54:01 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 14 Mar 2017 15:52:32 +0800
Message-ID: <1489477952-6901-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] hw/net/virtio-net.c: Follow CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, QEMU Trivial <qemu-trivial@nongnu.org>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 hw/net/virtio-net.c | 53 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c321680..ede618e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -273,7 +273,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
         if (queue_started) {
             if (q->tx_timer) {
                 timer_mod(q->tx_timer,
-                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                         qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
             } else {
                 qemu_bh_schedule(q->tx_bh);
             }
@@ -301,13 +301,15 @@ static void virtio_net_set_link_status(NetClientState *nc)
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     uint16_t old_status = n->status;
 
-    if (nc->link_down)
+    if (nc->link_down) {
         n->status &= ~VIRTIO_NET_S_LINK_UP;
-    else
+    } else {
         n->status |= VIRTIO_NET_S_LINK_UP;
+    }
 
-    if (n->status != old_status)
+    if (n->status != old_status) {
         virtio_notify_config(vdev);
+    }
 
     virtio_net_set_status(vdev, vdev->status);
 }
@@ -319,7 +321,8 @@ static void rxfilter_notify(NetClientState *nc)
     if (nc->rxfilter_notify_enabled) {
         gchar *path = object_get_canonical_path(OBJECT(n->qdev));
         qapi_event_send_nic_rx_filter_changed(!!n->netclient_name,
-                                              n->netclient_name, path, &error_abort);
+                                              n->netclient_name,
+                                              path, &error_abort);
         g_free(path);
 
         /* disable event notification to avoid events flooding */
@@ -459,8 +462,9 @@ static int peer_has_vnet_hdr(VirtIONet *n)
 
 static int peer_has_ufo(VirtIONet *n)
 {
-    if (!peer_has_vnet_hdr(n))
+    if (!peer_has_vnet_hdr(n)) {
         return 0;
+    }
 
     n->has_ufo = qemu_has_ufo(qemu_get_queue(n->nic)->peer);
 
@@ -847,15 +851,17 @@ static int virtio_net_handle_vlan_table(VirtIONet *n, uint8_t cmd,
         return VIRTIO_NET_ERR;
     }
 
-    if (vid >= MAX_VLAN)
+    if (vid >= MAX_VLAN) {
         return VIRTIO_NET_ERR;
+    }
 
-    if (cmd == VIRTIO_NET_CTRL_VLAN_ADD)
+    if (cmd == VIRTIO_NET_CTRL_VLAN_ADD) {
         n->vlans[vid >> 5] |= (1U << (vid & 0x1f));
-    else if (cmd == VIRTIO_NET_CTRL_VLAN_DEL)
+    } else if (cmd == VIRTIO_NET_CTRL_VLAN_DEL) {
         n->vlans[vid >> 5] &= ~(1U << (vid & 0x1f));
-    else
+    } else {
         return VIRTIO_NET_ERR;
+    }
 
     rxfilter_notify(nc);
 
@@ -938,7 +944,8 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         iov_cnt = elem->out_num;
-        iov2 = iov = g_memdup(elem->out_sg, sizeof(struct iovec) * elem->out_num);
+        iov2 = iov = g_memdup(elem->out_sg,
+                              sizeof(struct iovec) * elem->out_num);
         s = iov_to_buf(iov, iov_cnt, 0, &ctrl, sizeof(ctrl));
         iov_discard_front(&iov, &iov_cnt, sizeof(ctrl));
         if (s != sizeof(ctrl)) {
@@ -1086,18 +1093,21 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     uint8_t *ptr = (uint8_t *)buf;
     int i;
 
-    if (n->promisc)
+    if (n->promisc) {
         return 1;
+    }
 
     ptr += n->host_hdr_len;
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
         int vid = lduw_be_p(ptr + 14) & 0xfff;
-        if (!(n->vlans[vid >> 5] & (1U << (vid & 0x1f))))
+        if (!(n->vlans[vid >> 5] & (1U << (vid & 0x1f)))) {
             return 0;
+        }
     }
 
-    if (ptr[0] & 1) { // multicast
+    if (ptr[0] & 1) {
+        /* multicast */
         if (!memcmp(ptr, bcast, sizeof(bcast))) {
             return !n->nobcast;
         } else if (n->nomulti) {
@@ -1111,7 +1121,8 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
                 return 1;
             }
         }
-    } else { // unicast
+    } else {
+        /* unicast */
         if (n->nouni) {
             return 0;
         } else if (n->alluni || n->mac_table.uni_overflow) {
@@ -1150,8 +1161,9 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return 0;
     }
 
-    if (!receive_filter(n, buf, size))
+    if (!receive_filter(n, buf, size)) {
         return size;
+    }
 
     offset = i = 0;
 
@@ -1283,7 +1295,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
     for (;;) {
         ssize_t ret;
         unsigned int out_num;
-        struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
+        struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1],
+               *out_sg;
         struct virtio_net_hdr_mrg_rxbuf mhdr;
 
         elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
@@ -1317,10 +1330,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                                    n->guest_hdr_len, -1);
                 if (out_num == VIRTQUEUE_MAX_SIZE) {
                     goto drop;
-		}
+                }
                 out_num += 1;
                 out_sg = sg2;
-	    }
+            }
         }
         /*
          * If host wants to see the guest header as is, we can
@@ -1384,7 +1397,7 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
         }
     } else {
         timer_mod(q->tx_timer,
-                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
         q->tx_waiting = 1;
         virtio_queue_set_notification(vq, 0);
     }
-- 
2.7.4
