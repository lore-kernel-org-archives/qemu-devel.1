Received: from eggs.gnu.org ([2001:4830:134:3::10]:39064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dD8yK-0006Mm-1y
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dD8yG-0001Wk-Oo
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:31:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dD8yG-0001W7-HE
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C620811AC
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:31:27 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 23 May 2017 14:31:19 +0200
Message-Id: <20170523123119.7414-1-maxime.coquelin@redhat.com>
In-Reply-To: <20170520080658.337-1-maxime.coquelin@redhat.com>
References: <20170520080658.337-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2] virtio_net: Bypass backends for MTU feature
 negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, aconole@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

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
---

Tests performed:
- Vhost-net kernel backendi, host_mtu=2000:
 * default machine type: guest MTU = 2000
 * pc-q35-2.9 machine type: Guest MTU = 1500

- Vhost-net user backend, host_mtu=2000:
 * DPDK v17.05 (MTU feature supported on backend side)
  - default machine type: guest MTU = 2000
  - pc-q35-2.9 machine type: guest MTU = 2000)
 * DPDK v16.11 (MTU feature not supported on backend side)
  - default machine type: guest MTU = 2000
  - pc-q35-2.9 machine type: guest MTU = 1500)

 hw/net/virtio-net.c            | 17 ++++++++++++++++-
 include/hw/compat.h            |  4 ++++
 include/hw/virtio/virtio-net.h |  1 +
 include/hw/virtio/virtio.h     |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7d091c9..39c336e 100644
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
 
@@ -2090,6 +2103,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT16("rx_queue_size", VirtIONet, net_conf.rx_queue_size,
                        VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE),
     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
+    DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
+                     true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 55b1765..181f450 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -6,6 +6,10 @@
         .driver   = "pci-bridge",\
         .property = "shpc",\
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
-- 
2.9.4
