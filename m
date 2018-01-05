Received: from eggs.gnu.org ([2001:4830:134:3::10]:42315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eXajp-00050a-Vf
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eXajl-0005bk-Vn
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:45:22 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:60673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1eXajl-0005a0-2o
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:45:17 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Fri,  5 Jan 2018 17:44:53 -0500
Message-Id: <50e16b79a79d81f1890f6d836b7c1a656ff3d2a9.1515190612.git.jbaron@akamai.com>
In-Reply-To: <cover.1515190238.git.jbaron@akamai.com>
References: <cover.1515190238.git.jbaron@akamai.com>
References: <cover.1515190238.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v4 2/3] qemu: virtio-net: use 64-bit values for
 feature flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: davem@davemloft.net, jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

In prepartion for using some of the high order feature bits, make sure that
virtio-net uses 64-bit values everywhere.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 hw/net/virtio-net.c            | 55 +++++++++++++++++++++---------------------
 include/hw/virtio/virtio-net.h |  2 +-
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b0..54823af 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -48,18 +48,18 @@
     (offsetof(container, field) + sizeof(((container *)0)->field))
 
 typedef struct VirtIOFeature {
-    uint32_t flags;
+    uint64_t flags;
     size_t end;
 } VirtIOFeature;
 
 static VirtIOFeature feature_sizes[] = {
-    {.flags = 1 << VIRTIO_NET_F_MAC,
+    {.flags = 1ULL << VIRTIO_NET_F_MAC,
      .end = endof(struct virtio_net_config, mac)},
-    {.flags = 1 << VIRTIO_NET_F_STATUS,
+    {.flags = 1ULL << VIRTIO_NET_F_STATUS,
      .end = endof(struct virtio_net_config, status)},
-    {.flags = 1 << VIRTIO_NET_F_MQ,
+    {.flags = 1ULL << VIRTIO_NET_F_MQ,
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
-    {.flags = 1 << VIRTIO_NET_F_MTU,
+    {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
     {}
 };
@@ -1938,7 +1938,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     int i;
 
     if (n->net_conf.mtu) {
-        n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
+        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
     virtio_net_set_config_size(n, n->host_features);
@@ -2109,45 +2109,46 @@ static const VMStateDescription vmstate_virtio_net = {
 };
 
 static Property virtio_net_properties[] = {
-    DEFINE_PROP_BIT("csum", VirtIONet, host_features, VIRTIO_NET_F_CSUM, true),
-    DEFINE_PROP_BIT("guest_csum", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
+                    VIRTIO_NET_F_CSUM, true),
+    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_CSUM, true),
-    DEFINE_PROP_BIT("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, true),
-    DEFINE_PROP_BIT("guest_tso4", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO, true),
+    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_TSO4, true),
-    DEFINE_PROP_BIT("guest_tso6", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_TSO6, true),
-    DEFINE_PROP_BIT("guest_ecn", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_ECN, true),
-    DEFINE_PROP_BIT("guest_ufo", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_UFO, true),
-    DEFINE_PROP_BIT("guest_announce", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
                     VIRTIO_NET_F_GUEST_ANNOUNCE, true),
-    DEFINE_PROP_BIT("host_tso4", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_TSO4, true),
-    DEFINE_PROP_BIT("host_tso6", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_TSO6, true),
-    DEFINE_PROP_BIT("host_ecn", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_ECN, true),
-    DEFINE_PROP_BIT("host_ufo", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
                     VIRTIO_NET_F_HOST_UFO, true),
-    DEFINE_PROP_BIT("mrg_rxbuf", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
                     VIRTIO_NET_F_MRG_RXBUF, true),
-    DEFINE_PROP_BIT("status", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
                     VIRTIO_NET_F_STATUS, true),
-    DEFINE_PROP_BIT("ctrl_vq", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_VQ, true),
-    DEFINE_PROP_BIT("ctrl_rx", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_RX, true),
-    DEFINE_PROP_BIT("ctrl_vlan", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_VLAN, true),
-    DEFINE_PROP_BIT("ctrl_rx_extra", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_RX_EXTRA, true),
-    DEFINE_PROP_BIT("ctrl_mac_addr", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_MAC_ADDR, true),
-    DEFINE_PROP_BIT("ctrl_guest_offloads", VirtIONet, host_features,
+    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
-    DEFINE_PROP_BIT("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
+    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
     DEFINE_NIC_PROPERTIES(VirtIONet, nic_conf),
     DEFINE_PROP_UINT32("x-txtimer", VirtIONet, net_conf.txtimer,
                        TX_TIMER_INTERVAL),
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b81b6a4..e7634c9 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -67,7 +67,7 @@ typedef struct VirtIONet {
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
     size_t guest_hdr_len;
-    uint32_t host_features;
+    uint64_t host_features;
     uint8_t has_ufo;
     uint32_t mergeable_rx_bufs;
     uint8_t promisc;
-- 
2.6.1
