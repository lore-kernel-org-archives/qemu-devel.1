Received: from eggs.gnu.org ([209.51.188.92]:43345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAM-0000AQ-5g
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gvgAI-0006K4-MT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:28:48 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gvgAH-000697-G5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:28:46 -0500
Received: by mail-pf1-x442.google.com with SMTP id c123so8357271pfb.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 02:28:29 -0800 (PST)
From: elohimes@gmail.com
Date: Mon, 18 Feb 2019 18:27:46 +0800
Message-Id: <20190218102748.2242-6-xieyongji@baidu.com>
In-Reply-To: <20190218102748.2242-1-xieyongji@baidu.com>
References: <20190218102748.2242-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v6 5/7] vhost-user-blk: Add support to get/set
 inflight buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch adds support for vhost-user-blk device to get/set
inflight buffer from/to backend.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 hw/block/vhost-user-blk.c          | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 44ac814016..9682df1a7b 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -128,6 +128,21 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
     }
 
     s->dev.acked_features = vdev->guest_features;
+
+    if (!s->inflight->addr) {
+        ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
+        if (ret < 0) {
+            error_report("Error get inflight: %d", -ret);
+            goto err_guest_notifiers;
+        }
+    }
+
+    ret = vhost_dev_set_inflight(&s->dev, s->inflight);
+    if (ret < 0) {
+        error_report("Error set inflight: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     ret = vhost_dev_start(&s->dev, vdev);
     if (ret < 0) {
         error_report("Error starting vhost: %d", -ret);
@@ -249,6 +264,13 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void vhost_user_blk_reset(VirtIODevice *vdev)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    vhost_dev_free_inflight(s->inflight);
+}
+
 static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -289,6 +311,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
                          vhost_user_blk_handle_output);
     }
 
+    s->inflight = g_new0(struct vhost_inflight, 1);
+
     s->dev.nvqs = s->num_queues;
     s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
     s->dev.vq_index = 0;
@@ -321,6 +345,7 @@ vhost_err:
     vhost_dev_cleanup(&s->dev);
 virtio_err:
     g_free(vqs);
+    g_free(s->inflight);
     virtio_cleanup(vdev);
 
     vhost_user_cleanup(user);
@@ -336,7 +361,9 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
 
     vhost_user_blk_set_status(vdev, 0);
     vhost_dev_cleanup(&s->dev);
+    vhost_dev_free_inflight(s->inflight);
     g_free(vqs);
+    g_free(s->inflight);
     virtio_cleanup(vdev);
 
     if (s->vhost_user) {
@@ -386,6 +413,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
     vdc->set_config = vhost_user_blk_set_config;
     vdc->get_features = vhost_user_blk_get_features;
     vdc->set_status = vhost_user_blk_set_status;
+    vdc->reset = vhost_user_blk_reset;
 }
 
 static const TypeInfo vhost_user_blk_info = {
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index d52944aeeb..445516604a 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -36,6 +36,7 @@ typedef struct VHostUserBlk {
     uint32_t queue_size;
     uint32_t config_wce;
     struct vhost_dev dev;
+    struct vhost_inflight *inflight;
     VhostUserState *vhost_user;
 } VHostUserBlk;
 
-- 
2.17.1
