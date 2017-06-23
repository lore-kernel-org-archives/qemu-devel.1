Received: from eggs.gnu.org ([2001:4830:134:3::10]:42010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dOEVi-0005ZG-58
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 22:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dOEVe-0008Pu-7U
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 22:39:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:64859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dOEVd-0008At-S8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 22:39:46 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 23 Jun 2017 10:32:33 +0800
Message-Id: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/2] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, stefanha@gmail.com, Wei Wang <wei.w.wang@intel.com>

This patch enables the virtio-net tx queue size to be configurable
between 256 (the default queue size) and 1024 by the user when the
vhost-user backend is used.

Currently, the maximum tx queue size for other backends is 512 due
to the following limitations:
- QEMU backend: the QEMU backend implementation in some cases may
send 1024+1 iovs to writev.
- Vhost_net backend: there are possibilities that the guest sends
a vring_desc of memory which corsses a MemoryRegion thereby
generating more than 1024 iovs after translattion from guest-physical
address in the backend.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/virtio-net.c            | 45 +++++++++++++++++++++++++++++++++---------
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 91eddaf..d13ca60 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -34,8 +34,11 @@
 
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
+#define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
+
 /* for now, only allow larger queues; with virtio-1, guest can downsize */
 #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
+#define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
 
 /*
  * Calculate the number of bytes up to and including the given 'field' of
@@ -1508,15 +1511,18 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
 
     n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
                                            virtio_net_handle_rx);
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
 
@@ -1927,6 +1933,17 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -1947,17 +1964,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -1968,6 +1979,21 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->nic = qemu_new_nic(&net_virtio_info, &n->nic_conf,
                               object_get_typename(OBJECT(dev)), dev->id, n);
     }
+    nc = qemu_get_queue(n->nic);
+
+    /*
+     * Currently, backends other than vhost-user don't support 1024 queue
+     * size.
+     */
+    if (n->net_conf.tx_queue_size == VIRTQUEUE_MAX_SIZE &&
+        nc->peer->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
+        n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
+    }
+
+    for (i = 0; i < n->max_queues; i++) {
+        virtio_net_add_queue(n, i);
+    }
+    n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
 
     peer_test_vnet_hdr(n);
     if (peer_has_vnet_hdr(n)) {
@@ -1990,7 +2016,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->vlans = g_malloc0(MAX_VLAN >> 3);
 
-    nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
 
     n->qdev = dev;
@@ -2106,6 +2131,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_STRING("tx", VirtIONet, net_conf.tx),
     DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_size,
                        VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
+    DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_size,
+                       VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
                      true),
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 602b486..b81b6a4 100644
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
