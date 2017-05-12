Received: from eggs.gnu.org ([2001:4830:134:3::10]:44894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968o-0005fz-Di
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968n-0001uT-3U
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968m-0001je-Q9
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:37 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:39 +0800
Message-Id: <1494578148-102868-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 07/16] vhost-user: send device id to the
 slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Send virtio device id to the slave to indicate the device type.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c        |  1 +
 hw/virtio/vhost-user.c    | 20 ++++++++++++++++++++
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 22874a9..ea9879f 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -155,6 +155,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->dev.max_queues = 1;
     net->dev.nvqs = 2;
     net->dev.vqs = net->vqs;
+    net->dev.dev_type = VIRTIO_ID_NET;
 
     if (backend_kernel) {
         r = vhost_net_get_fd(options->net_backend);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d161884..1eba5e5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -453,6 +453,18 @@ static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
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
@@ -510,6 +522,14 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
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
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a450321..40ba87e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -55,6 +55,7 @@ struct vhost_dev {
     int n_mem_sections;
     MemoryRegionSection *mem_sections;
     struct vhost_virtqueue *vqs;
+    uint16_t dev_type;
     int nvqs;
     /* the first virtqueue which would be used by this vhost dev */
     int vq_index;
-- 
2.7.4
