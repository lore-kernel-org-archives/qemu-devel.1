Received: from eggs.gnu.org ([2001:4830:134:3::10]:50518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7ln-0006Eg-KI
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7ll-0007rk-Og
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7ll-0007rD-Gp
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:01 -0400
Date: Tue, 20 Mar 2018 05:17:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-3-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/50] virtio-net: use 64-bit values for
 feature flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Baron <jbaron@akamai.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org

From: Jason Baron <jbaron@akamai.com>

In prepartion for using some of the high order feature bits, make sure that
virtio-net uses 64-bit values everywhere.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-net.h |  2 +-
 hw/net/virtio-net.c            | 55 +++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

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
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 188744e..ab06f93 100644
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
-- 
MST
