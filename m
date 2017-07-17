Received: from eggs.gnu.org ([2001:4830:134:3::10]:56730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18V-0005P5-Jw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18U-0001Ms-Li
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18U-0001Ma-Fv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:10 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:48 +0200
Message-Id: <20170717081152.17153-6-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/9] virtio-blk: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

virtqueue_error includes the queue index in the error output and is preferred
for errors that pertain to a virtqueue rather than to the device as a whole.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b750bd8..359d8bd 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -490,20 +490,20 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
     if (req->elem.out_num < 1 || req->elem.in_num < 1) {
-        virtio_error(vdev, "virtio-blk missing headers");
+        virtqueue_error(req->vq, "virtio-blk missing headers");
         return -1;
     }
 
     if (unlikely(iov_to_buf(iov, out_num, 0, &req->out,
                             sizeof(req->out)) != sizeof(req->out))) {
-        virtio_error(vdev, "virtio-blk request outhdr too short");
+        virtqueue_error(req->vq, "virtio-blk request outhdr too short");
         return -1;
     }
 
     iov_discard_front(&iov, &out_num, sizeof(req->out));
 
     if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
-        virtio_error(vdev, "virtio-blk request inhdr too short");
+        virtqueue_error(req->vq, "virtio-blk request inhdr too short");
         return -1;
     }
 
-- 
2.9.3
