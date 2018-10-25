Received: from eggs.gnu.org ([2001:4830:134:3::10]:43603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1gFgHd-0007pq-Md
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1gFgHb-0007dv-S8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:06:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1gFgHb-0007dj-KN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:06:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id w5-v6so9485517wrt.2
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 07:06:43 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 25 Oct 2018 17:06:31 +0300
Message-Id: <20181025140631.634922-3-sameeh@daynix.com>
In-Reply-To: <20181025140631.634922-1-sameeh@daynix.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 2/2] virtio-net: Implement VIRTIO_NET_F_STANDBY
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 hw/net/virtio-net.c            | 25 +++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f154756e85..f478445cbd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -686,6 +686,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     int i;
+    Error *err;
 
     if (n->mtu_bypass_backend &&
             !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
@@ -721,6 +722,10 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
+
+    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+        qdev_unhide(n->net_conf.primary_id_str, n->primary_parent_bus, &err);
+    }
 }
 
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -1946,6 +1951,20 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
     n->netclient_type = g_strdup(type);
 }
 
+static void virtio_net_primary_should_be_hidden(DeviceListener *listener,const char *dev_id, BusState *bus, bool *res)
+{
+   VirtIONet *n = container_of(listener, VirtIONet, primary_listener);
+    if (!strcmp(n->net_conf.primary_id_str ,dev_id) && bus)
+    {
+        printf("net_confnet_confnet_confnet_confnet_conf\n");
+        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
+        n->primary_parent_bus = bus;
+        *res = true;
+        return;
+    }
+    *res = false;
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1976,6 +1995,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }
 
+    if (n->net_conf.primary_id_str) {
+        n->primary_listener.should_be_hidden = virtio_net_primary_should_be_hidden;
+        device_listener_register(&n->primary_listener);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -2198,6 +2222,7 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_STRING("primary", VirtIONet, net_conf.primary_id_str),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 4d7f3c82ca..6aca93e461 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -42,6 +42,7 @@ typedef struct virtio_net_conf
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
+    char *primary_id_str;
 } virtio_net_conf;
 
 /* Maximum packet size we can receive from tap device: header + 64k */
@@ -103,9 +104,13 @@ typedef struct VirtIONet {
     int announce_counter;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    BusState *primary_parent_bus;
+    DeviceListener primary_listener;
 } VirtIONet;
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+void virtio_net_register_primary_device(DeviceState *vdev, DeviceState *pdev);
+
 
 #endif
-- 
2.17.0
