Received: from eggs.gnu.org ([2001:4830:134:3::10]:35050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFjcE-0000aA-Te
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFjcB-0007Qa-Ot
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:31:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cFjcB-0007QO-Gd
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:31:07 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Sat, 10 Dec 2016 16:30:38 +0100
Message-Id: <20161210153038.9184-4-maxime.coquelin@redhat.com>
In-Reply-To: <20161210153038.9184-1-maxime.coquelin@redhat.com>
References: <20161210153038.9184-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/3] virtio-net: Add MTU feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, aconole@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, yuanhan.liu@linux.intel.com
Cc: fbl@redhat.com, berrange@redhat.com, mlureau@redhat.com, ktraynor@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

This patch allows advising guest with host MTU's by setting
host_mtu parameter.

If VIRTIO_NET_F_MTU has been successfully negotiated, MTU
value is passed to the backend.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Aaron Conole <aconole@redhat.com
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/net/virtio-net.c            | 19 +++++++++++++++++++
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5009533..b6da529 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -55,6 +55,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, status)},
     {.flags = 1 << VIRTIO_NET_F_MQ,
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
+    {.flags = 1 << VIRTIO_NET_F_MTU,
+     .end = endof(struct virtio_net_config, mtu)},
     {}
 };
 
@@ -81,6 +83,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 
     virtio_stw_p(vdev, &netcfg.status, n->status);
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
+    virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     memcpy(config, &netcfg, n->config_size);
 }
@@ -152,6 +155,16 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
             qemu_net_queue_purge(qnc->incoming_queue, qnc->peer);
         }
 
+        if (virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MTU)) {
+            r = vhost_net_set_mtu(get_vhost_net(nc->peer), n->net_conf.mtu);
+            if (r < 0) {
+                error_report("%uBytes MTU not supported by the backend",
+                             n->net_conf.mtu);
+
+                return;
+            }
+        }
+
         n->vhost_started = 1;
         r = vhost_net_start(vdev, n->nic->ncs, queues);
         if (r < 0) {
@@ -1695,6 +1708,7 @@ static void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features)
 {
     int i, config_size = 0;
     virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
+
     for (i = 0; feature_sizes[i].flags != 0; i++) {
         if (host_features & feature_sizes[i].flags) {
             config_size = MAX(feature_sizes[i].end, config_size);
@@ -1724,6 +1738,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     NetClientState *nc;
     int i;
 
+    if (n->net_conf.mtu) {
+        n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -1922,6 +1940,7 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_STRING("tx", VirtIONet, net_conf.tx),
     DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_size,
                        VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
+    DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 0ced975..8ea56a8 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -36,6 +36,7 @@ typedef struct virtio_net_conf
     int32_t txburst;
     char *tx;
     uint16_t rx_queue_size;
+    uint16_t mtu;
 } virtio_net_conf;
 
 /* Maximum packet size we can receive from tap device: header + 64k */
-- 
2.9.3
