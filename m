Received: from eggs.gnu.org ([2001:4830:134:3::10]:48950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etmBp-0007ws-4m
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etmBl-0002zv-OF
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:25:57 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1]:49876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1etmBl-0002zf-CC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:25:53 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Wed,  7 Mar 2018 22:25:41 -0500
Message-Id: <d4920d0c06c64330777f65b91056a4203b95ee1d.1520450515.git.jbaron@akamai.com>
In-Reply-To: <cover.1520450515.git.jbaron@akamai.com>
References: <cover.1520450515.git.jbaron@akamai.com>
In-Reply-To: <cover.1520450515.git.jbaron@akamai.com>
References: <cover.1520450515.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v2 3/3] virtio-net: add linkspeed and duplex
 settings to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org

Although linkspeed and duplex can be set in a linux guest via 'ethtool -s',
this requires custom ethtool commands for virtio-net by default.

Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
the hypervisor to export a linkspeed and duplex setting. The user can
subsequently overwrite it later if desired via: 'ethtool -s'.

Linkspeed and duplex settings can be set as:
'-device virtio-net,speed=10000,duplex=full'

where speed is [0...INT_MAX], and duplex is ["half"|"full"].

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 hw/net/virtio-net.c            | 26 ++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4feaa49..c3ce7d2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,6 +26,7 @@
 #include "qapi-event.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "standard-headers/linux/ethtool.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -61,6 +62,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
     {.flags = 1ULL << VIRTIO_NET_F_MTU,
      .end = endof(struct virtio_net_config, mtu)},
+    {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
+     .end = endof(struct virtio_net_config, duplex)},
     {}
 };
 
@@ -89,6 +92,8 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
+    virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
+    netcfg.duplex = n->net_conf.duplex;
     memcpy(config, &netcfg, n->config_size);
 }
 
@@ -1941,6 +1946,25 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (n->net_conf.duplex_str) {
+        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_HALF;
+        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
+            n->net_conf.duplex = DUPLEX_FULL;
+        } else {
+            error_setg(errp, "'duplex' must be 'half' or 'full'");
+        }
+        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+    } else {
+        n->net_conf.duplex = DUPLEX_UNKNOWN;
+    }
+
+    if (n->net_conf.speed < SPEED_UNKNOWN) {
+        error_setg(errp, "'speed' must be between 0 and INT_MAX");
+    } else if (n->net_conf.speed >= 0) {
+        n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -2161,6 +2185,8 @@ static Property virtio_net_properties[] = {
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
-- 
2.7.4
