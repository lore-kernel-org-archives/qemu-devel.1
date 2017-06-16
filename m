Received: from eggs.gnu.org ([2001:4830:134:3::10]:44270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dLouv-0005kP-1E
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dLour-0000Ic-4p
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:55:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:42052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dLouq-0000Hn-Qf
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:55:49 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 16 Jun 2017 18:48:38 +0800
Message-Id: <1497610119-45041-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/2] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, marcandre.lureau@gmail.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, pbonzini@redhat.com, armbru@redhat.com, jan.scheurich@ericsson.com, Wei Wang <wei.w.wang@intel.com>

This patch enables the virtio-net tx queue size to be configurable
between 256 (the default queue size) and 1024 by the user when the
vhost-user backend is used.

Currently, the maximum tx queue size for other backends is 512 due
to the following limitations:
- QEMU backend: the QEMU backend implementation in some cases may
send 1024+1 iovs to writev.
- Vhost_net backend: there are possibilities that the guest sends
a vring_desc of memory which corsses a MemoryRegion thereby
generating more than 1024 iovs in total after translattion from
guest-physical address in the backend.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/virtio-net.c            | 46 ++++++++++++++++++++++++++++++++++--------
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..e1a08fd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -33,8 +33,11 @@
 
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
+#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
+
 /* for now, only allow larger queues; with virtio-1, guest can downsize */
 #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
+#define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
 
 /*
  * Calculate the number of bytes up to and including the given 'field' of
@@ -1491,18 +1494,33 @@ static void virtio_net_tx_bh(void *opaque)
 static void virtio_net_add_queue(VirtIONet *n, int index)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    NetClientState *nc = qemu_get_queue(n->nic);
 
     n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
                                            virtio_net_handle_rx);
+
+    /*
+     * Currently, backends other than vhost-user don't support 1024 queue
+     * size.
+     */
+    if (n->net_conf.tx_queue_size == VIRTQUEUE_MAX_SIZE &&
+        nc->peer->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
+        fprintf(stderr, "warning: %s: queue size %d not supported\n",
+                __func__, n->net_conf.tx_queue_size);
+        n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
+    }
+
     if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
         n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, 256, virtio_net_handle_tx_timer);
+            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
+                             virtio_net_handle_tx_timer);
         n->vqs[index].tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                               virtio_net_tx_timer,
                                               &n->vqs[index]);
     } else {
         n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, 256, virtio_net_handle_tx_bh);
+            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
+                             virtio_net_handle_tx_bh);
         n->vqs[index].tx_bh = qemu_bh_new(virtio_net_tx_bh, &n->vqs[index]);
     }
 
@@ -1910,6 +1928,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
+        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
+        !is_power_of_2(n->net_conf.tx_queue_size)) {
+        error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
+                   "must be a power of 2 between %d and %d",
+                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
+                   VIRTQUEUE_MAX_SIZE);
+        virtio_cleanup(vdev);
+        return;
+    }
+
     n->max_queues = MAX(n->nic_conf.peers.queues, 1);
     if (n->max_queues * 2 + 1 > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
@@ -1930,17 +1959,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         error_report("Defaulting to \"bh\"");
     }
 
-    for (i = 0; i < n->max_queues; i++) {
-        virtio_net_add_queue(n, i);
-    }
-
-    n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
     memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
     n->status = VIRTIO_NET_S_LINK_UP;
     n->announce_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                      virtio_net_announce_timer, n);
-
     if (n->netclient_type) {
         /*
          * Happen when virtio_net_set_netclient_name has been called.
@@ -1952,6 +1975,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
                               object_get_typename(OBJECT(dev)), dev->id, n);
     }
 
+    for (i = 0; i < n->max_queues; i++) {
+        virtio_net_add_queue(n, i);
+    }
+    n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
+
     peer_test_vnet_hdr(n);
     if (peer_has_vnet_hdr(n)) {
         for (i = 0; i < n->max_queues; i++) {
@@ -2089,6 +2117,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_STRING("tx", VirtIONet, net_conf.tx),
     DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_size,
                        VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
+    DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
+                       VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 1eec9a2..fd944ba 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -36,6 +36,7 @@ typedef struct virtio_net_conf
     int32_t txburst;
     char *tx;
     uint16_t rx_queue_size;
+    uint16_t tx_queue_size;
     uint16_t mtu;
 } virtio_net_conf;
 
-- 
2.7.4
