Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzx-00068G-H5
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzw-00089a-Jw
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:21 -0400
Date: Mon, 9 Apr 2018 17:42:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523284856-251254-2-git-send-email-mst@redhat.com>
References: <1523284856-251254-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284856-251254-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] vhost-user-blk: set config ops before
 vhost-user init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Maxime Coquelin <maxime.coquelin@redhat.com>

As soon as vhost-user init is done, the backend may send
VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, so let's set the
notification callback before it.

Also, it will be used to know whether the device supports
the config feature to advertize it or not.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Changpeng Liu <changpeng.liu@intel.com>
---
 hw/block/vhost-user-blk.c | 4 ++--
 hw/virtio/vhost.c         | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f840f07..262baca 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -259,6 +259,8 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     s->dev.vq_index = 0;
     s->dev.backend_features = 0;
 
+    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
+
     ret = vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER, 0);
     if (ret < 0) {
         error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
@@ -277,8 +279,6 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         s->blkcfg.num_queues = s->num_queues;
     }
 
-    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
-
     return;
 
 vhost_err:
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 250f886..b6c314e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1451,7 +1451,6 @@ int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *data,
 void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
                                    const VhostDevConfigOps *ops)
 {
-    assert(hdev->vhost_ops);
     hdev->config_ops = ops;
 }
 
-- 
MST
