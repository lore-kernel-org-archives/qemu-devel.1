Received: from eggs.gnu.org ([2001:4830:134:3::10]:60460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQf-0007sX-Bx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQc-00035Q-Vr
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:49 -0500
Date: Mon, 5 Nov 2018 13:16:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-11-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/33] vhost-user-blk: start vhost when guest
 kicks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yongji Xie <elohimes@gmail.com>, Yongji Xie <xieyongji@baidu.com>, Chai Wen <chaiwen@baidu.com>, Ni Xun <nixun@baidu.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Yongji Xie <elohimes@gmail.com>

Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs early")
kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This violates
the virtio spec. But virtio 1.0 transitional devices support this behaviour.
So we should start vhost when guest kicks in this case.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Ni Xun <nixun@baidu.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/vhost-user-blk.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index d755223643..1451940845 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -217,7 +217,32 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
 
 static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int i;
 
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
+
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
MST
