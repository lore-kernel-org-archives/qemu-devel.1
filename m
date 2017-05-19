Received: from eggs.gnu.org ([2001:4830:134:3::10]:49557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dBXpD-0006UU-Tx
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dBXpA-0005fE-QD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:39:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:11523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dBXpA-0005ev-Ec
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:39:28 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 19 May 2017 10:32:19 +0800
Message-Id: <1495161139-28757-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH RFC] virtio-net: enable configurable tx queue
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

This patch enables the virtio-net tx queue size to be configurable
between 256 (the default queue size) and 1024 by the user. The queue
size specified by the user should be power of 2.

Setting the tx queue size to be 1024 requires the guest driver to
support the VIRTIO_NET_F_MAX_CHAIN_SIZE feature. This feature restricts
the guest driver from chaining 1024 vring descriptors, which may cause
the device side implementation to send more than 1024 iov to writev.
Currently, the max chain size allowed for the guest driver is set to
1023.

In the case that the tx queue size is set to 1024 and the
VIRTIO_NET_F_MAX_CHAIN_SIZE feature is not supported by the guest driver,
the default tx queue size (256) will be used.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/virtio-net.c                         | 71 +++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h              |  1 +
 include/standard-headers/linux/virtio_net.h |  3 ++
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..ef38cb1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -33,8 +33,12 @@
 
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
+#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
 /* for now, only allow larger queues; with virtio-1, guest can downsize */
 #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
+#define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
+
+#define VIRTIO_NET_MAX_CHAIN_SIZE 1023
 
 /*
  * Calculate the number of bytes up to and including the given 'field' of
@@ -57,6 +61,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1 << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1 << VIRTIO_NET_F_MAX_CHAIN_SIZE,
+     .end = endof(struct virtio_net_config, max_chain_size)},
     {}
 };
 
@@ -84,6 +90,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     virtio_stw_p(vdev, &netcfg.status, n->status);
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
+    virtio_stw_p(vdev, &netcfg.max_chain_size, VIRTIO_NET_MAX_CHAIN_SIZE);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     memcpy(config, &netcfg, n->config_size);
 }
@@ -568,6 +575,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     features |= n->host_features;
 
     virtio_add_feature(&features, VIRTIO_NET_F_MAC);
+    virtio_add_feature(&features, VIRTIO_NET_F_MAX_CHAIN_SIZE);
 
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
@@ -603,6 +611,7 @@ static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
     virtio_add_feature(&features, VIRTIO_NET_F_HOST_TSO4);
     virtio_add_feature(&features, VIRTIO_NET_F_HOST_TSO6);
     virtio_add_feature(&features, VIRTIO_NET_F_HOST_ECN);
+    virtio_add_feature(&features, VIRTIO_NET_F_MAX_CHAIN_SIZE);
 
     return features;
 }
@@ -635,6 +644,27 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
 }
 
+static bool is_tx(int queue_index)
+{
+    return queue_index % 2 == 1;
+}
+
+static void virtio_net_change_tx_queue_size(VirtIONet *n)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    int i, num_queues = virtio_get_num_queues(vdev);
+
+    if (n->net_conf.tx_queue_size == VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE) {
+        return;
+    }
+
+    for (i = 0; i < num_queues; i++) {
+        if (is_tx(i)) {
+            virtio_queue_set_num(vdev, i, n->net_conf.tx_queue_size);
+        }
+    }
+}
+
 static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -649,6 +679,16 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
                                virtio_has_feature(features,
                                                   VIRTIO_F_VERSION_1));
 
+    /*
+     * Change the tx queue size if the guest supports
+     * VIRTIO_NET_F_MAX_CHAIN_SIZE. This will restrict the guest from sending
+     * a very large chain of vring descriptors (e.g. 1024), which may cause
+     * 1025 iov to be written to writev.
+     */
+    if (virtio_has_feature(features, VIRTIO_NET_F_MAX_CHAIN_SIZE)) {
+        virtio_net_change_tx_queue_size(n);
+    }
+
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
             virtio_net_guest_offloads_by_features(features);
@@ -1297,8 +1337,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
 
         out_num = elem->out_num;
         out_sg = elem->out_sg;
-        if (out_num < 1) {
-            virtio_error(vdev, "virtio-net header not in first element");
+        if (out_num < 1 || out_num > VIRTIO_NET_F_MAX_CHAIN_SIZE) {
+            virtio_error(vdev, "no packet or too large vring desc chain");
             virtqueue_detach_element(q->tx_vq, elem, 0);
             g_free(elem);
             return -EINVAL;
@@ -1491,18 +1531,27 @@ static void virtio_net_tx_bh(void *opaque)
 static void virtio_net_add_queue(VirtIONet *n, int index)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    /*
+     * If the user specified tx queue size is less than IOV_MAX (e.g. 512),
+     * it is safe to use the specified queue size here. Otherwise, use the
+     * default queue size here, and change it when the guest confirms that
+     * it supports the VIRTIO_NET_F_MAX_CHAIN_SIZE feature.
+     */
+    uint16_t tx_queue_size = n->net_conf.tx_queue_size < IOV_MAX ?
+                                       n->net_conf.tx_queue_size :
+                                 VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
 
     n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
                                            virtio_net_handle_rx);
     if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
         n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, 256, virtio_net_handle_tx_timer);
+            virtio_add_queue(vdev, tx_queue_size, virtio_net_handle_tx_timer);
         n->vqs[index].tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                               virtio_net_tx_timer,
                                               &n->vqs[index]);
     } else {
         n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, 256, virtio_net_handle_tx_bh);
+            virtio_add_queue(vdev, tx_queue_size, virtio_net_handle_tx_bh);
         n->vqs[index].tx_bh = qemu_bh_new(virtio_net_tx_bh, &n->vqs[index]);
     }
 
@@ -1857,6 +1906,7 @@ static void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features)
 {
     int i, config_size = 0;
     virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
+    virtio_add_feature(&host_features, VIRTIO_NET_F_MAX_CHAIN_SIZE);
 
     for (i = 0; feature_sizes[i].flags != 0; i++) {
         if (host_features & feature_sizes[i].flags) {
@@ -1910,6 +1960,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
+        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
+        (n->net_conf.tx_queue_size & (n->net_conf.tx_queue_size - 1))) {
+        error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
+                   "must be a power of 2 between %d and %d.",
+                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
+                   VIRTQUEUE_MAX_SIZE);
+        virtio_cleanup(vdev);
+        return;
+    }
+
     n->max_queues = MAX(n->nic_conf.peers.queues, 1);
     if (n->max_queues * 2 + 1 > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
@@ -2089,6 +2150,8 @@ static Property virtio_net_properties[] = {
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
 
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 30ff249..0bc1c52 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_MAX_CHAIN_SIZE 25	/* Guest chains desc within a limit */
 
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
@@ -76,6 +77,8 @@ struct virtio_net_config {
 	uint16_t max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	uint16_t mtu;
+        /* Maximum number of vring descriptors that can be chained */
+	uint16_t max_chain_size;
 } QEMU_PACKED;
 
 /*
-- 
2.7.4
