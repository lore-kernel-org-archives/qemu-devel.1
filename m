Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fqKGi-00047l-HV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fqKGh-0002p0-91
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:33:00 -0400
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:52985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1fqKGg-0002o6-Rn
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:32:59 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 16 Aug 2018 18:32:43 +0300
Message-Id: <1534433563-30865-4-git-send-email-yury-kotov@yandex-team.ru>
In-Reply-To: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
Subject: [Qemu-devel] [PATCH 3/3] vhost-user: add reconnect support for
 vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Now, vhost device will stop if backend had restarted.
Even if we specify 'reconnect' parameter for chardev and connection will be
restored, vhost device will not be resumed.

To resume device we should sync with backend again after reconnect.

Add vhost_dev_reconnect extern function to vhost and add reconnect handler
to vhost-user which uses vhost_dev_reconnect to retry handshake with
vhost-user backend.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 hw/virtio/vhost-user.c    | 65 +++++++++++++++++++++++++++++++++++++++++++----
 hw/virtio/vhost.c         | 31 ++++++++++++++++++++++
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b041343..5c7e113 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1121,6 +1121,17 @@ out:
     return ret;
 }
 
+static void vhost_close_slave_channel(struct vhost_dev *dev)
+{
+    struct vhost_user *u = dev->opaque;
+
+    if (u->slave_fd >= 0) {
+        qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
+        close(u->slave_fd);
+        u->slave_fd = -1;
+    }
+}
+
 /*
  * Called back from the postcopy fault thread when a fault is received on our
  * ufd.
@@ -1334,6 +1345,41 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
+static void vhost_user_reconnect_handler(void *opaque, int event)
+{
+    struct vhost_user *u = opaque;
+    struct vhost_dev *dev = u->dev;
+    int err;
+
+    if (!dev->started || event != CHR_EVENT_OPENED) {
+        return;
+    }
+
+    if (virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
+        err = vhost_user_set_protocol_features(dev, dev->protocol_features);
+        if (err < 0) {
+            goto fail;
+        }
+    }
+
+    vhost_close_slave_channel(dev);
+    err = vhost_setup_slave_channel(dev);
+    if (err < 0) {
+        goto fail;
+    }
+
+    err = vhost_dev_reconnect(dev);
+    if (err < 0) {
+        goto fail;
+    }
+
+    return;
+
+fail:
+    error_report("Failed to reconnect to backend: %d", err);
+    qemu_chr_fe_disconnect(u->user->chr);
+}
+
 static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
 {
     uint64_t features, protocol_features;
@@ -1348,6 +1394,19 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
     u->dev = dev;
     dev->opaque = u;
 
+    /* We expect the socket is already connected, but Chardev with reconnect
+     * option postpones connect till machine init done event. If this is the
+     * case, then the connect will be forced. */
+    if (!qemu_chr_fe_backend_open(u->user->chr) &&
+        qemu_chr_fe_wait_connected(u->user->chr, NULL) < 0) {
+        return -1;
+    }
+
+    /* Set reconnection handler. */
+    qemu_chr_fe_set_handlers(u->user->chr, NULL, NULL,
+                             vhost_user_reconnect_handler,
+                             NULL, u, NULL, false);
+
     err = vhost_user_get_features(dev, &features);
     if (err < 0) {
         return err;
@@ -1430,11 +1489,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
         postcopy_remove_notifier(&u->postcopy_notifier);
         u->postcopy_notifier.notify = NULL;
     }
-    if (u->slave_fd >= 0) {
-        qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
-        close(u->slave_fd);
-        u->slave_fd = -1;
-    }
+    vhost_close_slave_channel(dev);
     g_free(u->region_rb);
     u->region_rb = NULL;
     g_free(u->region_rb_offset);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6fcfb87..dbd496b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1633,6 +1633,37 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     hdev->vdev = NULL;
 }
 
+int vhost_dev_reconnect(struct vhost_dev *hdev)
+{
+    int i, r;
+
+    assert(hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+    assert(hdev->started);
+    assert(hdev->vhost_ops);
+    assert(hdev->vdev);
+
+    for (i = 0; i < hdev->nvqs; ++i) {
+        /* Sync internal last avail idx to the device used idx. */
+        virtio_queue_restore_last_avail_idx(hdev->vdev, hdev->vq_index + i);
+    }
+
+    r = vhost_dev_sync_backend(hdev);
+    if (r < 0) {
+        goto fail;
+    }
+
+    /* Sync previous mask values */
+    for (i = 0; i < hdev->nvqs; ++i) {
+        unsigned idx = hdev->vq_index + i;
+        vhost_virtqueue_mask(hdev, hdev->vdev, idx, hdev->vqs[idx].masked);
+    }
+
+    return 0;
+
+fail:
+    return r;
+}
+
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file)
 {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a43db26..c3d375a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -91,6 +91,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 void vhost_dev_cleanup(struct vhost_dev *hdev);
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev);
 void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev);
+int vhost_dev_reconnect(struct vhost_dev *hdev);
 int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
 void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
 
-- 
2.7.4
