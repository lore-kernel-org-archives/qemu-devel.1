Received: from eggs.gnu.org ([2001:4830:134:3::10]:33417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvOAP-000534-Be
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvNur-0003dp-Fg
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fvNur-0003co-4P
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:21 -0400
Received: by mail-wm0-x243.google.com with SMTP id y139-v6so2197903wmc.2
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 07:27:20 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 30 Aug 2018 17:27:06 +0300
Message-Id: <20180830142708.14311-5-sameeh@daynix.com>
In-Reply-To: <20180830142708.14311-1-sameeh@daynix.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 4/6] virtio-net: implement steering mode feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 hw/net/virtio-net.c                         | 65 +++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h              |  3 ++
 include/standard-headers/linux/virtio_net.h | 55 ++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 90502fca7c..e7c4ce6f66 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -972,13 +972,53 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
     return VIRTIO_NET_OK;
 }
 
+static int virtio_net_ctrl_steering_mode(VirtIONet *n, uint8_t cmd,
+                                struct iovec *iov, unsigned int iov_cnt,
+                                struct iovec *iov_in, unsigned int iov_cnt_in,
+        size_t *size_in)
+{
+    size_t s;
+    struct virtio_net_steering_mode sm;
+
+    switch (cmd) {
+    case VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES:
+        if (!size_in) {
+            return VIRTIO_NET_ERR;
+        }
+                  s = iov_from_buf(iov_in, iov_cnt_in, 0,
+          &n->supported_modes, sizeof(n->supported_modes));
+        if (s != sizeof(n->supported_modes) ||
+          !size_in) {
+            return VIRTIO_NET_ERR;
+        }
+                  *size_in = s;
+      break;
+    case VIRTIO_NET_CTRL_SM_CONTROL:
+        s = iov_to_buf(iov, iov_cnt, 0, &sm, sizeof(sm) -
+                sizeof(union command_data));
+        if (s != sizeof(sm) - sizeof(union command_data)) {
+            return VIRTIO_NET_ERR;
+        }
+        /* switch (cmd)
+             {
+                dafault:
+                return VIRTIO_NET_ERR;
+         } */
+      break;
+    default:
+                return VIRTIO_NET_ERR;
+    }
+
+    return VIRTIO_NET_OK;
+}
+
 static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_ctrl_hdr ctrl;
     virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
     VirtQueueElement *elem;
-    size_t s;
+    size_t s, elem_in_size = 0;
     struct iovec *iov, *iov2;
     unsigned int iov_cnt;
 
@@ -996,7 +1036,8 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         iov_cnt = elem->out_num;
-        iov2 = iov = g_memdup(elem->out_sg, sizeof(struct iovec) * elem->out_num);
+        iov2 = iov = g_memdup(elem->out_sg, sizeof(struct iovec) *
+                elem->out_num);
         s = iov_to_buf(iov, iov_cnt, 0, &ctrl, sizeof(ctrl));
         iov_discard_front(&iov, &iov_cnt, sizeof(ctrl));
         if (s != sizeof(ctrl)) {
@@ -1013,12 +1054,20 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             status = virtio_net_handle_mq(n, ctrl.cmd, iov, iov_cnt);
         } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
             status = virtio_net_handle_offloads(n, ctrl.cmd, iov, iov_cnt);
+        } else if (ctrl.class == VIRTIO_NET_CTRL_STEERING_MODE) {
+            size_t size_in = 0;
+            status = virtio_net_ctrl_steering_mode(n, ctrl.cmd, iov, iov_cnt,
+                   elem->in_sg, elem->in_num, &size_in);
+            if (status == VIRTIO_NET_OK  && size_in > 0) {
+                elem_in_size += size_in;
+        }
         }
 
-        s = iov_from_buf(elem->in_sg, elem->in_num, 0, &status, sizeof(status));
+        s = iov_from_buf(elem->in_sg, elem->in_num, elem_in_size, &status,
+                sizeof(status));
         assert(s == sizeof(status));
-
-        virtqueue_push(vq, elem, sizeof(status));
+        elem_in_size += s;
+        virtqueue_push(vq, elem, elem_in_size);
         virtio_notify(vdev, vq);
         g_free(iov2);
         g_free(elem);
@@ -1375,10 +1424,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                                    n->guest_hdr_len, -1);
                 if (out_num == VIRTQUEUE_MAX_SIZE) {
                     goto drop;
-		}
+    }
                 out_num += 1;
                 out_sg = sg2;
-	    }
+      }
         }
         /*
          * If host wants to see the guest header as is, we can
@@ -1957,6 +2006,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+        n->host_features |= (1ULL << VIRTIO_NET_F_CTRL_STEERING_MODE);
+
     if (n->net_conf.duplex_str) {
         if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
             n->net_conf.duplex = DUPLEX_HALF;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index a7b53edc96..809e85481c 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -102,6 +102,9 @@ typedef struct VirtIONet {
     int announce_counter;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    struct virtio_net_steering_modes supported_modes;
+    struct virtio_net_steering_modes current_mode;
+    struct virtio_net_rss_conf *rss_conf;
 } VirtIONet;
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index e9f255ea3f..fa399b97ab 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -258,4 +258,59 @@ struct virtio_net_ctrl_mq {
 #define VIRTIO_NET_CTRL_GUEST_OFFLOADS   5
 #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET        0
 
+
+#define RSS_HASH_FUNCTION_TOEPLITZ       0x1
+#define RSS_HASH_FUNCTION_SYMMETRIC      0x2
+
+// Hash function fields
+#define RSS_HASH_FIELDS_IPV4             0x00000100
+#define RSS_HASH_FIELDS_TCP_IPV4         0x00000200
+#define RSS_HASH_FIELDS_IPV6             0x00000400
+#define RSS_HASH_FIELDS_IPV6_EX          0x00000800
+#define RSS_HASH_FIELDS_TCP_IPV6         0x00001000
+#define RSS_HASH_FIELDS_TCP_IPV6_EX      0x00002000
+
+struct virtio_net_rss_supported_hash{
+uint32_t hash_function;
+};
+
+struct virtio_net_rss_conf_ptrs {
+    uint8_t *hash_key;
+    uint32_t  *indirection_table;
+};
+
+struct virtio_net_rss_conf {
+    uint32_t hash_function;
+    uint32_t hash_function_flags;
+    uint32_t hash_key_length;
+    uint32_t indirection_table_length;
+    struct virtio_net_rss_conf_ptrs ptrs;
+};
+
+#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
+#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
+
+
+struct virtio_net_steering_modes {
+    uint32_t steering_modes;
+};
+
+union command_data {
+    struct virtio_net_rss_conf rss;
+};
+
+struct virtio_net_steering_mode {
+    uint32_t steering_mode;
+    uint32_t command;
+};
+
+#define VIRTIO_NET_F_CTRL_STEERING_MODE  60
+
+#define VIRTIO_NET_CTRL_STEERING_MODE             7
+#define VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES    0
+#define VIRTIO_NET_CTRL_SM_CONTROL                1
+
+#define STEERING_MODE_AUTO          0x1
+#define STEERING_MODE_RSS           0x2
+
 #endif /* _LINUX_VIRTIO_NET_H */
-- 
2.13.6
