Received: from eggs.gnu.org ([2001:4830:134:3::10]:52292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gK3tQ-0002Bu-ET
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gK3tO-0007zl-MQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:07:52 -0500
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Wed,  7 Nov 2018 00:09:16 +0800
Message-Id: <1541520556-8334-1-git-send-email-dongli.zhang@oracle.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio-blk: rename iov to out_iov in
 virtio_blk_handle_request()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, kwolf@redhat.com, mreitz@redhat.com

In virtio_blk_handle_request(), in_iov is used for input header while iov
is used for output header. Rename iov to out_iov to pair output header's
name with in_iov to avoid confusing people when reading source code.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/block/virtio-blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 83cf5c0..fb0d74d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -482,7 +482,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 {
     uint32_t type;
     struct iovec *in_iov = req->elem.in_sg;
-    struct iovec *iov = req->elem.out_sg;
+    struct iovec *out_iov = req->elem.out_sg;
     unsigned in_num = req->elem.in_num;
     unsigned out_num = req->elem.out_num;
     VirtIOBlock *s = req->dev;
@@ -493,13 +493,13 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         return -1;
     }
 
-    if (unlikely(iov_to_buf(iov, out_num, 0, &req->out,
+    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
                             sizeof(req->out)) != sizeof(req->out))) {
         virtio_error(vdev, "virtio-blk request outhdr too short");
         return -1;
     }
 
-    iov_discard_front(&iov, &out_num, sizeof(req->out));
+    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
 
     if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
         virtio_error(vdev, "virtio-blk request inhdr too short");
@@ -526,7 +526,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                                        &req->out.sector);
 
         if (is_write) {
-            qemu_iovec_init_external(&req->qiov, iov, out_num);
+            qemu_iovec_init_external(&req->qiov, out_iov, out_num);
             trace_virtio_blk_handle_write(vdev, req, req->sector_num,
                                           req->qiov.size / BDRV_SECTOR_SIZE);
         } else {
-- 
2.7.4
