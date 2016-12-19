Received: from eggs.gnu.org ([2001:4830:134:3::10]:53658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr06-0002yH-8p
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr05-0004ct-B1
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr04-0004Vl-Rl
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:41 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:46 +0800
Message-Id: <1482127152-84732-12-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 11/37] vhost-user/msg:
 VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

The feature, VHOST_USER_PROTOCOL_F_SET_DEVICE_ID, indicates that the
slave side implementation supports different types of devices. The
master tells the slave what type of device to create by sending the
VHOST_USER_SET_DEVICE_ID message. Currently, only the net type is
supported.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c             |  1 +
 hw/virtio/vhost-user.c         | 20 ++++++++++++++++++++
 include/hw/virtio/vhost-user.h |  5 ++++-
 include/hw/virtio/vhost.h      |  1 +
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index f2d49ad..6524503 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -152,6 +152,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->dev.max_queues = 1;
     net->dev.nvqs = 2;
     net->dev.vqs = net->vqs;
+    net->dev.dev_type = VIRTIO_ID_NET;
 
     if (backend_kernel) {
         r = vhost_net_get_fd(options->net_backend);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9e089d4..6391d10 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -452,6 +452,18 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
     return vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features);
 }
 
+static int vhost_user_set_dev_id(struct vhost_dev *dev, uint16_t virtio_id)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_SET_DEVICE_ID,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = virtio_id,
+        .size = sizeof(msg.payload.u64),
+    };
+
+    return vhost_user_write(dev, &msg, NULL, 0);
+}
+
 static int vhost_user_set_owner(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
@@ -509,6 +521,14 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
             return err;
         }
 
+        if (dev->protocol_features &
+            (1ULL << VHOST_USER_PROTOCOL_F_SET_DEVICE_ID)) {
+            err = vhost_user_set_dev_id(dev, dev->dev_type);
+            if (err < 0) {
+                return err;
+            }
+        }
+
         /* query the max queues we support if backend supports Multiple Queue */
         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MQ)) {
             err = vhost_user_get_u64(dev, VHOST_USER_GET_QUEUE_NUM,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index ad5eac9..e79a2ec 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -12,6 +12,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RARP = 2,
     VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
     VHOST_USER_PROTOCOL_F_VHOST_PCI = 4,
+    VHOST_USER_PROTOCOL_F_SET_DEVICE_ID = 5,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -21,7 +22,8 @@ enum VhostUserProtocolFeature {
 #define VHOST_USER_PROTOCOL_FEATURES ((1ULL << VHOST_USER_PROTOCOL_F_MQ) | \
                                (1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD) | \
                                     (1ULL << VHOST_USER_PROTOCOL_F_RARP) | \
-                              (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI))
+                               (1ULL << VHOST_USER_PROTOCOL_F_VHOST_PCI) | \
+                          (1ULL << VHOST_USER_PROTOCOL_F_SET_DEVICE_ID))
 
 typedef enum VhostUserRequest {
     VHOST_USER_NONE = 0,
@@ -44,6 +46,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_QUEUE_NUM = 17,
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
+    VHOST_USER_SET_DEVICE_ID = 20,
     VHOST_USER_MAX
 } VhostUserRequest;
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 1fe5aad..9cf32e2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -43,6 +43,7 @@ struct vhost_dev {
     int n_mem_sections;
     MemoryRegionSection *mem_sections;
     struct vhost_virtqueue *vqs;
+    uint16_t dev_type;
     int nvqs;
     /* the first virtqueue which would be used by this vhost dev */
     int vq_index;
-- 
2.7.4
