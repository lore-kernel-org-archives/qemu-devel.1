Received: from eggs.gnu.org ([209.51.188.92]:34116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxW-0006g1-3a
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxQ-0002gA-Fi
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:10 -0500
Date: Tue, 15 Jan 2019 15:04:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-5-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/49] qemu: avoid memory leak while remove
 disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jian Wang <wangjian161@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org

From: Jian Wang <wangjian161@huawei.com>

Memset vhost_dev to zero in the vhost_dev_cleanup function.
This causes dev.vqs to be NULL, so that
vqs does not free up space when calling the g_free function.
This will result in a memory leak. But you can't release vqs
directly in the vhost_dev_cleanup function, because vhost_net
will also call this function, and vhost_net's vqs is assigned by array.
In order to solve this problem, we first save the pointer of vqs,
and release the space of vqs after vhost_dev_cleanup is called.

Signed-off-by: Jian Wang <wangjian161@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 7 +++++--
 hw/scsi/vhost-scsi.c      | 3 ++-
 hw/scsi/vhost-user-scsi.c | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 1451940845..c3af28fad4 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -250,6 +250,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     VhostUserState *user;
+    struct vhost_virtqueue *vqs = NULL;
     int i, ret;
 
     if (!s->chardev.chr) {
@@ -288,6 +289,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
     s->dev.vq_index = 0;
     s->dev.backend_features = 0;
+    vqs = s->dev.vqs;
 
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
@@ -314,7 +316,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 vhost_err:
     vhost_dev_cleanup(&s->dev);
 virtio_err:
-    g_free(s->dev.vqs);
+    g_free(vqs);
     virtio_cleanup(vdev);
 
     vhost_user_cleanup(user);
@@ -326,10 +328,11 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(dev);
+    struct vhost_virtqueue *vqs = s->dev.vqs;
 
     vhost_user_blk_set_status(vdev, 0);
     vhost_dev_cleanup(&s->dev);
-    g_free(s->dev.vqs);
+    g_free(vqs);
     virtio_cleanup(vdev);
 
     if (s->vhost_user) {
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 7f21b4f9d6..61e2e57da9 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -215,6 +215,7 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
+    struct vhost_virtqueue *vqs = vsc->dev.vqs;
 
     migrate_del_blocker(vsc->migration_blocker);
     error_free(vsc->migration_blocker);
@@ -223,7 +224,7 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
     vhost_scsi_set_status(vdev, 0);
 
     vhost_dev_cleanup(&vsc->dev);
-    g_free(vsc->dev.vqs);
+    g_free(vqs);
 
     virtio_scsi_common_unrealize(dev, errp);
 }
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 2e1ba4a87b..6728878a52 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -121,12 +121,13 @@ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
+    struct vhost_virtqueue *vqs = vsc->dev.vqs;
 
     /* This will stop the vhost backend. */
     vhost_user_scsi_set_status(vdev, 0);
 
     vhost_dev_cleanup(&vsc->dev);
-    g_free(vsc->dev.vqs);
+    g_free(vqs);
 
     virtio_scsi_common_unrealize(dev, errp);
 
-- 
MST
