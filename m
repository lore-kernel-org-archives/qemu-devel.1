Received: from eggs.gnu.org ([2001:4830:134:3::10]:53244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBf-0007m7-IY
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBS-0001o8-Im
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:01:10 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZCBQ-0001mJ-Ip
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:01:02 -0500
Received: by mail-pg1-x541.google.com with SMTP id v28so7576878pgk.10
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:00:58 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 18 Dec 2018 18:00:00 +0800
Message-Id: <20181218100002.11219-6-xieyongji@baidu.com>
In-Reply-To: <20181218100002.11219-1-xieyongji@baidu.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v2 for-4.0 5/7] vhost-user-blk: Add support to
 provide shared memory to backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, yury-kotov@yandex-team.ru, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patch add supports for vhost-user-blk device to provide
shared memory to backend.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 hw/block/vhost-user-blk.c          | 26 ++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 1451940845..27028cf996 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -126,6 +126,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
     }
 
     s->dev.acked_features = vdev->guest_features;
+
+    ret = vhost_dev_set_shm(&s->dev, s->shm);
+    if (ret < 0) {
+        error_report("Error set shared memory: %d", -ret);
+        goto err_guest_notifiers;
+    }
+
     ret = vhost_dev_start(&s->dev, vdev);
     if (ret < 0) {
         error_report("Error starting vhost: %d", -ret);
@@ -245,6 +252,13 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void vhost_user_blk_reset(VirtIODevice *vdev)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    vhost_dev_reset_shm(s->shm);
+}
+
 static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -284,6 +298,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
                          vhost_user_blk_handle_output);
     }
 
+    s->shm = g_new0(struct vhost_shm, 1);
+
     s->dev.nvqs = s->num_queues;
     s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
     s->dev.vq_index = 0;
@@ -309,12 +325,19 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         s->blkcfg.num_queues = s->num_queues;
     }
 
+    ret = vhost_dev_init_shm(&s->dev, s->shm);
+    if (ret < 0) {
+        error_setg(errp, "vhost-user-blk: init shared memory failed");
+        goto vhost_err;
+    }
+
     return;
 
 vhost_err:
     vhost_dev_cleanup(&s->dev);
 virtio_err:
     g_free(s->dev.vqs);
+    g_free(s->shm);
     virtio_cleanup(vdev);
 
     vhost_user_cleanup(user);
@@ -329,7 +352,9 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
 
     vhost_user_blk_set_status(vdev, 0);
     vhost_dev_cleanup(&s->dev);
+    vhost_dev_free_shm(s->shm);
     g_free(s->dev.vqs);
+    g_free(s->shm);
     virtio_cleanup(vdev);
 
     if (s->vhost_user) {
@@ -379,6 +404,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
     vdc->set_config = vhost_user_blk_set_config;
     vdc->get_features = vhost_user_blk_get_features;
     vdc->set_status = vhost_user_blk_set_status;
+    vdc->reset = vhost_user_blk_reset;
 }
 
 static const TypeInfo vhost_user_blk_info = {
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index d52944aeeb..bb706d70b3 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -36,6 +36,7 @@ typedef struct VHostUserBlk {
     uint32_t queue_size;
     uint32_t config_wce;
     struct vhost_dev dev;
+    struct vhost_shm *shm;
     VhostUserState *vhost_user;
 } VHostUserBlk;
 
-- 
2.17.1
