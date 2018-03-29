Received: from eggs.gnu.org ([2001:4830:134:3::10]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1SMp-0008T1-2r
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1SMm-0001Xl-0t
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:53:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1f1SMl-0001Xc-SN
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:52:59 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 29 Mar 2018 09:52:32 +0200
Message-Id: <20180329075233.524-2-maxime.coquelin@redhat.com>
In-Reply-To: <20180329075233.524-1-maxime.coquelin@redhat.com>
References: <20180329075233.524-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] vhost-user-blk: set config ops before
 vhost-user init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, changpeng.liu@intel.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

As soon as vhost-user init is done, the backend may send
VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, so let's set the
notification callback before it.

Also, it will be used to know whether the device supports
the config feature to advertize it or not.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/block/vhost-user-blk.c | 4 ++--
 hw/virtio/vhost.c         | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f840f07dfe..262baca432 100644
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
index 250f886acb..b6c314e350 100644
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
2.14.3
