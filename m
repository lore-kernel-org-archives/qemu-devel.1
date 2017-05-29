Received: from eggs.gnu.org ([2001:4830:134:3::10]:59381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Oj-0000GS-LG
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8Oi-0006Jg-7X
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8Oh-0006IL-UL
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:19:00 -0400
Date: Mon, 29 May 2017 03:18:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-11-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/13] virtio_net: Bypass backends for MTU
 feature negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Aaron Conole <aconole@redhat.com>, Vlad Yasevich <vyasevic@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch adds a new internal "x-mtu-bypass-backend" property
to bypass backends for MTU feature negotiation.

When this property is set, the MTU feature is negotiated as soon
as supported by the guest and a MTU value is set via the host_mtu
parameter. In case the backend advertises the feature (e.g. DPDK's
vhost-user backend), the feature negotiation is propagated down to
the backend.

When this property is not set, the backend has to support the MTU
feature for its negotiation to succeed.

For compatibility purpose, this property is disabled for machine
types v2.9 and older.

Cc: Aaron Conole <aconole@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Vlad Yasevich <vyasevic@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/compat.h            |  4 ++++
 include/hw/virtio/virtio-net.h |  1 +
 include/hw/virtio/virtio.h     |  1 +
 hw/net/virtio-net.c            | 17 ++++++++++++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 4c53d60..400c64b 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -10,6 +10,10 @@
         .driver   = "intel-iommu",\
         .property = "pt",\
         .value    = "off",\
+    },{\
+        .driver   = "virtio-net-device",\
+        .property = "x-mtu-bypass-backend",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_8 \
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 1eec9a2..602b486 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -97,6 +97,7 @@ typedef struct VirtIONet {
     QEMUTimer *announce_timer;
     int announce_counter;
     bool needs_vnet_hdr_swap;
+    bool mtu_bypass_backend;
 } VirtIONet;
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7b6edba..80c45c3 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -79,6 +79,7 @@ struct VirtIODevice
     uint16_t queue_sel;
     uint64_t guest_features;
     uint64_t host_features;
+    uint64_t backend_features;
     size_t config_len;
     void *config;
     uint16_t config_vector;
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 98bd683..9a3d769 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -589,7 +589,15 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     if (!get_vhost_net(nc->peer)) {
         return features;
     }
-    return vhost_net_get_features(get_vhost_net(nc->peer), features);
+    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
+    vdev->backend_features = features;
+
+    if (n->mtu_bypass_backend &&
+            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
+        features |= (1ULL << VIRTIO_NET_F_MTU);
+    }
+
+    return features;
 }
 
 static uint64_t virtio_net_bad_features(VirtIODevice *vdev)
@@ -640,6 +648,11 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     VirtIONet *n = VIRTIO_NET(vdev);
     int i;
 
+    if (n->mtu_bypass_backend &&
+            !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
+        features &= ~(1ULL << VIRTIO_NET_F_MTU);
+    }
+
     virtio_net_set_multiqueue(n,
                               virtio_has_feature(features, VIRTIO_NET_F_MQ));
 
@@ -2093,6 +2106,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_size,
                        VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
+    DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
+                     true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST
