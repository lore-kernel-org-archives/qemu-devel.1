Received: from eggs.gnu.org ([2001:4830:134:3::10]:53081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dHnwN-00024H-LI
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dHnwJ-0004Ng-K0
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:04:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:39896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dHnwJ-0004Ko-8A
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:04:43 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon,  5 Jun 2017 16:57:29 +0800
Message-Id: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1] virtio-net: enable configurable tx queue
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
Cc: jan.scheurich@ericsson.com, Wei Wang <wei.w.wang@intel.com>

This patch enables the virtio-net tx queue size to be configurable
between 256 and 1024 by the user. The queue size specified by the
user should be power of 2. If "tx_queue_size" is not offered by the
user, the default queue size, 1024, will be used.

For the traditional QEMU backend, setting the tx queue size to be 1024
requires the guest virtio driver to support the VIRTIO_F_MAX_CHAIN_SIZE
feature. This feature restricts the guest driver from chaining 1024
vring descriptors, which may cause the device side implementation to
send more than 1024 iov to writev.

VIRTIO_F_MAX_CHAIN_SIZE is a common transport feature added for all
virtio devices. However, each device has the flexibility to set the max
chain size to limit its driver to chain vring descriptors. Currently,
the max chain size of the virtio-net device is set to 1023.

In the case that the tx queue size is set to 1024 and the
VIRTIO_F_MAX_CHAIN_SIZE feature is not supported by the guest driver,
the tx queue size will be reconfigured to be 512.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>

RFC to v1 changes:
1) change VIRTIO_F_MAX_CHAIN_SIZE to be a common virtio feature (was
virtio-net specific);
2) change the default tx queue size to be 1024 (was 256);
3) For the vhost backend case, setting tx queue size to be 1024 dosen't
require the VIRTIO_F_MAX_CHAIN_SIZE feature support.
---
 hw/net/virtio-net.c                            | 69 ++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h                 |  1 +
 include/hw/virtio/virtio.h                     |  2 +
 include/standard-headers/linux/virtio_config.h |  3 ++
 include/standard-headers/linux/virtio_net.h    |  2 +
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..5c82f54 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -33,8 +33,13 @@
 
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
+#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 1024
+
 /* for now, only allow larger queues; with virtio-1, guest can downsize */
 #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
+#define VIRTIO_NET_TX_QUEUE_MIN_SIZE 256
+
+#define VIRTIO_NET_MAX_CHAIN_SIZE 1023
 
 /*
  * Calculate the number of bytes up to and including the given 'field' of
@@ -57,6 +62,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1 << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1 << VIRTIO_F_MAX_CHAIN_SIZE,
+     .end = endof(struct virtio_net_config, max_chain_size)},
     {}
 };
 
@@ -84,6 +91,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     virtio_stw_p(vdev, &netcfg.status, n->status);
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
+    virtio_stw_p(vdev, &netcfg.max_chain_size, VIRTIO_NET_MAX_CHAIN_SIZE);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     memcpy(config, &netcfg, n->config_size);
 }
@@ -635,9 +643,33 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
 }
 
+static bool is_tx(int queue_index)
+{
+    return queue_index % 2 == 1;
+}
+
+static void virtio_net_reconfig_tx_queue_size(VirtIONet *n)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    int i, num_queues = virtio_get_num_queues(vdev);
+
+    /* Return when the queue size is already less than the 1024 */
+    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE) {
+        return;
+    }
+
+    for (i = 0; i < num_queues; i++) {
+        if (is_tx(i)) {
+            n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE / 2;
+            virtio_queue_set_num(vdev, i, n->net_conf.tx_queue_size);
+        }
+    }
+}
+
 static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
+    NetClientState *nc = qemu_get_queue(n->nic);
     int i;
 
     virtio_net_set_multiqueue(n,
@@ -649,6 +681,16 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
                                virtio_has_feature(features,
                                                   VIRTIO_F_VERSION_1));
 
+    /*
+     * When the traditional QEMU backend is used, using 1024 tx queue size
+     * requires the driver to support the VIRTIO_F_MAX_CHAIN_SIZE feature. If
+     * the feature is not supported, reconfigure the tx queue size to 512.
+     */
+    if (!get_vhost_net(nc->peer) &&
+        !virtio_has_feature(features, VIRTIO_F_MAX_CHAIN_SIZE)) {
+        virtio_net_reconfig_tx_queue_size(n);
+    }
+
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
             virtio_net_guest_offloads_by_features(features);
@@ -1297,8 +1339,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
 
         out_num = elem->out_num;
         out_sg = elem->out_sg;
-        if (out_num < 1) {
-            virtio_error(vdev, "virtio-net header not in first element");
+        if (out_num < 1 || out_num > VIRTIO_NET_MAX_CHAIN_SIZE) {
+            virtio_error(vdev, "no packet or too large vring desc chain");
             virtqueue_detach_element(q->tx_vq, elem, 0);
             g_free(elem);
             return -EINVAL;
@@ -1496,13 +1538,15 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
                                            virtio_net_handle_rx);
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
 
@@ -1891,6 +1935,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
     }
 
+    if (virtio_host_has_feature(vdev, VIRTIO_F_MAX_CHAIN_SIZE)) {
+        n->host_features |= (0x1 << VIRTIO_F_MAX_CHAIN_SIZE);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -1910,6 +1958,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -2089,6 +2148,8 @@ static Property virtio_net_properties[] = {
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
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7b6edba..8e85e41 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -260,6 +260,8 @@ typedef struct VirtIORNGConf VirtIORNGConf;
                       VIRTIO_F_NOTIFY_ON_EMPTY, true), \
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
                       VIRTIO_F_ANY_LAYOUT, true), \
+    DEFINE_PROP_BIT64("max_chain_size", _state, _field, \
+                      VIRTIO_F_MAX_CHAIN_SIZE, true), \
     DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
                       VIRTIO_F_IOMMU_PLATFORM, false)
 
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index b777069..b70cbfe 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -60,6 +60,9 @@
 #define VIRTIO_F_ANY_LAYOUT		27
 #endif /* VIRTIO_CONFIG_NO_LEGACY */
 
+/* Guest chains vring descriptors within a limit */
+#define VIRTIO_F_MAX_CHAIN_SIZE		31
+
 /* v1.0 compliant. */
 #define VIRTIO_F_VERSION_1		32
 
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 30ff249..729aaa8 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -76,6 +76,8 @@ struct virtio_net_config {
 	uint16_t max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	uint16_t mtu;
+        /* Maximum number of vring descriptors that can be chained */
+	uint16_t max_chain_size;
 } QEMU_PACKED;
 
 /*
-- 
2.7.4
