Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edbPF-00087u-7I
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edbPB-0002bD-A3
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edbPB-0002aZ-3o
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:40:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 22 Jan 2018 12:40:32 +0000
Message-Id: <20180122124033.21440-2-stefanha@redhat.com>
In-Reply-To: <20180122124033.21440-1-stefanha@redhat.com>
References: <20180122124033.21440-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] hw/block: Use errp directly rather than
 local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: e77848d3735ba590f23ffbf8094379c646c33d79.1511317952.git.maozy.fnst@cn.fujitsu.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b1532e4e91..58a5def75d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -913,7 +913,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
-    Error *err = NULL;
     unsigned i;
 
     if (!conf->conf.blk) {
@@ -966,9 +965,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < conf->num_queues; i++) {
         virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
-    virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    if (!virtio_blk_data_plane_create(vdev, conf, &s->dataplane, errp)) {
         virtio_cleanup(vdev);
         return;
     }
-- 
2.14.3
