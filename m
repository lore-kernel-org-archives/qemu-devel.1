Received: from eggs.gnu.org ([209.51.188.92]:46604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1glrUD-0000Fa-7A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1glrUB-0002k5-SI
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:32:45 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1glrUB-0002jg-He
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:32:43 -0500
Received: by mail-pg1-x544.google.com with SMTP id d72so10714932pga.9
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 00:32:43 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 22 Jan 2019 16:31:51 +0800
Message-Id: <20190122083152.10705-6-xieyongji@baidu.com>
In-Reply-To: <20190122083152.10705-1-xieyongji@baidu.com>
References: <20190122083152.10705-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v5 5/6] vhost-user-blk: Add support to
 reconnect backend
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

Since we now support the message VHOST_USER_GET_INFLIGHT_FD
and VHOST_USER_SET_INFLIGHT_FD. The backend is able to restart
safely because it can track inflight I/O in shared memory.
This patch allows qemu to reconnect the backend after
connection closed.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Ni Xun <nixun@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 hw/block/vhost-user-blk.c          | 209 +++++++++++++++++++++++------
 include/hw/virtio/vhost-user-blk.h |   4 +
 2 files changed, 169 insertions(+), 44 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 1f899ac1c0..0fab7b1d2f 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -101,7 +101,7 @@ const VhostDevConfigOps blk_ops = {
     .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
 };
 
-static void vhost_user_blk_start(VirtIODevice *vdev)
+static int vhost_user_blk_start(VirtIODevice *vdev)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
@@ -110,13 +110,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
 
     if (!k->set_guest_notifiers) {
         error_report("binding does not support guest notifiers");
-        return;
+        return -ENOSYS;
     }
 
     ret = vhost_dev_enable_notifiers(&s->dev, vdev);
     if (ret < 0) {
         error_report("Error enabling host notifiers: %d", -ret);
-        return;
+        return ret;
     }
 
     ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
@@ -147,12 +147,13 @@ static void vhost_user_blk_start(VirtIODevice *vdev)
         vhost_virtqueue_mask(&s->dev, vdev, i, false);
     }
 
-    return;
+    return ret;
 
 err_guest_notifiers:
     k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&s->dev, vdev);
+    return ret;
 }
 
 static void vhost_user_blk_stop(VirtIODevice *vdev)
@@ -171,7 +172,6 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
     ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (ret < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
-        return;
     }
 
     vhost_dev_disable_notifiers(&s->dev, vdev);
@@ -181,21 +181,43 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
+    int ret;
 
     if (!vdev->vm_running) {
         should_start = false;
     }
 
-    if (s->dev.started == should_start) {
+    if (s->should_start == should_start) {
+        return;
+    }
+
+    if (!s->connected || s->dev.started == should_start) {
+        s->should_start = should_start;
         return;
     }
 
     if (should_start) {
-        vhost_user_blk_start(vdev);
+        s->should_start = true;
+        /*
+         * make sure vhost_user_blk_handle_output() ignores fake
+         * guest kick by vhost_dev_enable_notifiers()
+         */
+        barrier();
+        ret = vhost_user_blk_start(vdev);
+        if (ret < 0) {
+            error_report("vhost-user-blk: vhost start failed: %s",
+                         strerror(-ret));
+            qemu_chr_fe_disconnect(&s->chardev);
+        }
     } else {
         vhost_user_blk_stop(vdev);
+        /*
+         * make sure vhost_user_blk_handle_output() ignore fake
+         * guest kick by vhost_dev_disable_notifiers()
+         */
+        barrier();
+        s->should_start = false;
     }
-
 }
 
 static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
@@ -225,13 +247,22 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
 static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
-    int i;
+    int i, ret;
 
     if (!(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
         !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))) {
         return;
     }
 
+    if (s->should_start) {
+        return;
+    }
+    s->should_start = true;
+
+    if (!s->connected) {
+        return;
+    }
+
     if (s->dev.started) {
         return;
     }
@@ -239,7 +270,13 @@ static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
      * vhost here instead of waiting for .set_status().
      */
-    vhost_user_blk_start(vdev);
+    ret = vhost_user_blk_start(vdev);
+    if (ret < 0) {
+        error_report("vhost-user-blk: vhost start failed: %s",
+                     strerror(-ret));
+        qemu_chr_fe_disconnect(&s->chardev);
+        return;
+    }
 
     /* Kick right away to begin processing requests already in vring */
     for (i = 0; i < s->dev.nvqs; i++) {
@@ -259,13 +296,106 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
     vhost_dev_reset_inflight(s->inflight);
 }
 
+static int vhost_user_blk_connect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int ret = 0;
+
+    if (s->connected) {
+        return 0;
+    }
+    s->connected = true;
+
+    s->dev.nvqs = s->num_queues;
+    s->dev.vqs = s->vqs;
+    s->dev.vq_index = 0;
+    s->dev.backend_features = 0;
+
+    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
+
+    ret = vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
+    if (ret < 0) {
+        error_report("vhost-user-blk: vhost initialization failed: %s",
+                     strerror(-ret));
+        return ret;
+    }
+
+    /* restore vhost state */
+    if (s->should_start) {
+        ret = vhost_user_blk_start(vdev);
+        if (ret < 0) {
+            error_report("vhost-user-blk: vhost start failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+static void vhost_user_blk_disconnect(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    if (!s->connected) {
+        return;
+    }
+    s->connected = false;
+
+    if (s->dev.started) {
+        vhost_user_blk_stop(vdev);
+    }
+
+    vhost_dev_cleanup(&s->dev);
+}
+
+static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
+                                     void *opaque)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    qemu_chr_fe_disconnect(&s->chardev);
+
+    return true;
+}
+
+static void vhost_user_blk_event(void *opaque, int event)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (vhost_user_blk_connect(dev) < 0) {
+            qemu_chr_fe_disconnect(&s->chardev);
+            return;
+        }
+        s->watch = qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
+                                         vhost_user_blk_watch, dev);
+        break;
+    case CHR_EVENT_CLOSED:
+        vhost_user_blk_disconnect(dev);
+        if (s->watch) {
+            g_source_remove(s->watch);
+            s->watch = 0;
+        }
+        break;
+    }
+}
+
+
 static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     VhostUserState *user;
-    struct vhost_virtqueue *vqs = NULL;
     int i, ret;
+    Error *err = NULL;
 
     if (!s->chardev.chr) {
         error_setg(errp, "vhost-user-blk: chardev is mandatory");
@@ -300,27 +430,28 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     s->inflight = g_new0(struct vhost_inflight, 1);
-
-    s->dev.nvqs = s->num_queues;
-    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
-    s->dev.vq_index = 0;
-    s->dev.backend_features = 0;
-    vqs = s->dev.vqs;
-
-    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
-
-    ret = vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
-    if (ret < 0) {
-        error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
-                   strerror(-ret));
-        goto virtio_err;
-    }
+    s->vqs = g_new(struct vhost_virtqueue, s->num_queues);
+    s->watch = 0;
+    s->should_start = false;
+    s->connected = false;
+
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_event,
+                             NULL, (void *)dev, NULL, true);
+
+reconnect:
+    do {
+        if (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0) {
+            error_report_err(err);
+            err = NULL;
+            sleep(1);
+        }
+    } while (!s->connected);
 
     ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
-                              sizeof(struct virtio_blk_config));
+                               sizeof(struct virtio_blk_config));
     if (ret < 0) {
-        error_setg(errp, "vhost-user-blk: get block config failed");
-        goto vhost_err;
+        error_report("vhost-user-blk: get block config failed");
+        goto reconnect;
     }
 
     if (s->blkcfg.num_queues != s->num_queues) {
@@ -329,34 +460,24 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 
     ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
     if (ret < 0) {
-        error_setg(errp, "vhost-user-blk: get inflight failed");
-        goto vhost_err;
+        error_report("vhost-user-blk: get inflight failed");
+        goto reconnect;
     }
 
     return;
-
-vhost_err:
-    vhost_dev_cleanup(&s->dev);
-virtio_err:
-    g_free(vqs);
-    g_free(s->inflight);
-    virtio_cleanup(vdev);
-
-    vhost_user_cleanup(user);
-    g_free(user);
-    s->vhost_user = NULL;
 }
 
 static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(dev);
-    struct vhost_virtqueue *vqs = s->dev.vqs;
 
     vhost_user_blk_set_status(vdev, 0);
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, NULL,
+                             NULL, NULL, NULL, false);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
-    g_free(vqs);
+    g_free(s->vqs);
     g_free(s->inflight);
     virtio_cleanup(vdev);
 
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 445516604a..4849aa5eb5 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -38,6 +38,10 @@ typedef struct VHostUserBlk {
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState *vhost_user;
+    struct vhost_virtqueue *vqs;
+    guint watch;
+    bool should_start;
+    bool connected;
 } VHostUserBlk;
 
 #endif
-- 
2.17.1
