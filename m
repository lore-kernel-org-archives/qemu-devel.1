Received: from eggs.gnu.org ([2001:4830:134:3::10]:60219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fQYRp-0005rf-PS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1fQYRm-0005hN-LC
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:25:57 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1fQYRm-0005go-El
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:25:54 -0400
Received: by mail-pf0-x241.google.com with SMTP id c22-v6so2728140pfi.2
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 06:25:54 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
Date: Wed,  6 Jun 2018 21:24:48 +0800
Message-Id: <1528291488-2586-1-git-send-email-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v2] vhost-user-blk: start vhost when guest kicks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, stefanha@redhat.com, changpeng.liu@intel.com
Cc: qemu-devel@nongnu.org, chaiwen@baidu.com, nixun@baidu.com, elohimes@gmail.com

Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs early")
kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This violates
the virtio spec. But virtio 1.0 transitional devices support this behaviour.
So we should start vhost when guest kicks in this case.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Ni Xun <nixun@baidu.com>
---
 hw/block/vhost-user-blk.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index d755223..1451940 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -217,7 +217,32 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
 
 static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int i;
+
+    if (!(virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+        !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))) {
+        return;
+    }
+
+    if (s->dev.started) {
+        return;
+    }
+
+    /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
+     * vhost here instead of waiting for .set_status().
+     */
+    vhost_user_blk_start(vdev);
 
+    /* Kick right away to begin processing requests already in vring */
+    for (i = 0; i < s->dev.nvqs; i++) {
+        VirtQueue *kick_vq = virtio_get_queue(vdev, i);
+
+        if (!virtio_queue_get_desc_addr(vdev, i)) {
+            continue;
+        }
+        event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
+    }
 }
 
 static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
-- 
1.7.9.5
