Received: from eggs.gnu.org ([2001:4830:134:3::10]:50730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eWxuB-00083t-SJ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 00:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eWxuA-0000C0-Om
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 00:17:27 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:50340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1eWxuA-0000AX-Ej
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 00:17:26 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  4 Jan 2018 00:16:45 -0500
Message-Id: <045deae35c270264b14550fd41bd14f5b75e76e9.1515042044.git.jbaron@akamai.com>
In-Reply-To: <cover.1515041373.git.jbaron@akamai.com>
References: <cover.1515041373.git.jbaron@akamai.com>
References: <cover.1515041373.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v3 3/3] qemu: add linkspeed and duplex settings
 to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, davem@davemloft.net
Cc: jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

Although linkspeed and duplex can be set in a linux guest via 'ethtool -s',
this requires custom ethtool commands for virtio-net by default.

Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
the hypervisor to export a linkspeed and duplex setting. The user can
subsequently overwrite it later if desired via: 'ethtool -s'.

Linkspeed and duplex settings can be set as:
'-device virtio-net,speed=10000,duplex=full'

where speed is [-1...INT_MAX], and duplex is ["half"|"full"].

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 hw/net/virtio-net.c                         | 35 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h              |  3 +++
 include/standard-headers/linux/virtio_net.h | 13 +++++++++++
 3 files changed, 51 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index adc20df..eec8422 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -40,6 +40,12 @@
 #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
 #define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
 
+/* duplex and speed */
+#define DUPLEX_UNKNOWN          0xff
+#define DUPLEX_HALF             0x00
+#define DUPLEX_FULL             0x01
+#define SPEED_UNKNOWN           -1
+
 /*
  * Calculate the number of bytes up to and including the given 'field' of
  * 'container'.
@@ -61,6 +67,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
+     .end = endof(struct virtio_net_config, duplex)},
     {}
 };
 
@@ -89,6 +97,14 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
+    if (n->status & VIRTIO_NET_S_LINK_UP) {
+        virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
+        netcfg.duplex = n->net_conf.duplex;
+    } else {
+        virtio_stl_p(vdev, &netcfg.speed, SPEED_UNKNOWN);
+        netcfg.duplex = DUPLEX_UNKNOWN;
+    }
+
     memcpy(config, &netcfg, n->config_size);
 }
 
@@ -1941,6 +1957,23 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+    if (n->net_conf.duplex_str) {
+        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_HALF;
+        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_FULL;
+        } else {
+            error_setg(errp, "'duplex' must be 'half' or 'full'");
+        }
+    } else {
+        n->net_conf.duplex = DUPLEX_UNKNOWN;
+    }
+    if (n->net_conf.speed < SPEED_UNKNOWN) {
+            error_setg(errp, "'speed' must be between -1 (SPEED_UNKOWN) and "
+                       "INT_MAX");
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -2160,6 +2193,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
     DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
                      true),
+    DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
+    DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index e7634c9..02484dc 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -38,6 +38,9 @@ typedef struct virtio_net_conf
     uint16_t rx_queue_size;
     uint16_t tx_queue_size;
     uint16_t mtu;
+    int32_t speed;
+    char *duplex_str;
+    uint8_t duplex;
 } virtio_net_conf;
 
 /* Maximum packet size we can receive from tap device: header + 64k */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 30ff249..17c8531 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,8 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
+
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
 #endif /* VIRTIO_NET_NO_LEGACY */
@@ -76,6 +78,17 @@ struct virtio_net_config {
 	uint16_t max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	uint16_t mtu;
+	/*
+	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
+	 * Any other value stands for unknown.
+	 */
+	uint32_t speed;
+	/*
+	 * 0x00 - half duplex
+	 * 0x01 - full duplex
+	 * Any other value stands for unknown.
+	 */
+	uint8_t duplex;
 } QEMU_PACKED;
 
 /*
