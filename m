Received: from eggs.gnu.org ([2001:4830:134:3::10]:43006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dL4cP-0002gB-Fb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dL4cO-0006d3-FW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:29:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Jun 2017 10:29:30 +0100
Message-Id: <20170614092930.11234-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: trace vdev so devices can be
 distinguished
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

It is hard to analyze trace logs with multiple virtio-blk devices
because none of the trace events include the VirtIODevice *vdev.

This patch adds vdev so it's clear which device a request is associated
with.

I considered using VirtIOBlock *s instead but VirtIODevice *vdev is more
general and may be correlated with generic virtio trace events like
virtio_set_status.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 12 +++++++-----
 hw/block/trace-events | 10 +++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 604d37d..c0bd247 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -50,7 +50,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     VirtIOBlock *s = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    trace_virtio_blk_req_complete(req, status);
+    trace_virtio_blk_req_complete(vdev, req, status);
 
     stb_p(&req->in->status, status);
     virtqueue_push(req->vq, &req->elem, req->in_len);
@@ -88,12 +88,13 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
 {
     VirtIOBlockReq *next = opaque;
     VirtIOBlock *s = next->dev;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
     aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
     while (next) {
         VirtIOBlockReq *req = next;
         next = req->mr_next;
-        trace_virtio_blk_rw_complete(req, ret);
+        trace_virtio_blk_rw_complete(vdev, req, ret);
 
         if (req->qiov.nalloc != -1) {
             /* If nalloc is != 1 req->qiov is a local copy of the original
@@ -355,7 +356,8 @@ static inline void submit_requests(BlockBackend *blk, MultiReqBuffer *mrb,
             mrb->reqs[i - 1]->mr_next = mrb->reqs[i];
         }
 
-        trace_virtio_blk_submit_multireq(mrb, start, num_reqs,
+        trace_virtio_blk_submit_multireq(VIRTIO_DEVICE(mrb->reqs[start]->dev),
+                                         mrb, start, num_reqs,
                                          sector_num << BDRV_SECTOR_BITS,
                                          qiov->size, is_write);
         block_acct_merge_done(blk_get_stats(blk),
@@ -526,11 +528,11 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 
         if (is_write) {
             qemu_iovec_init_external(&req->qiov, iov, out_num);
-            trace_virtio_blk_handle_write(req, req->sector_num,
+            trace_virtio_blk_handle_write(vdev, req, req->sector_num,
                                           req->qiov.size / BDRV_SECTOR_SIZE);
         } else {
             qemu_iovec_init_external(&req->qiov, in_iov, in_num);
-            trace_virtio_blk_handle_read(req, req->sector_num,
+            trace_virtio_blk_handle_read(vdev, req, req->sector_num,
                                          req->qiov.size / BDRV_SECTOR_SIZE);
         }
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 65e83dc..c332c01 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -1,11 +1,11 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/block/virtio-blk.c
-virtio_blk_req_complete(void *req, int status) "req %p status %d"
-virtio_blk_rw_complete(void *req, int ret) "req %p ret %d"
-virtio_blk_handle_write(void *req, uint64_t sector, size_t nsectors) "req %p sector %"PRIu64" nsectors %zu"
-virtio_blk_handle_read(void *req, uint64_t sector, size_t nsectors) "req %p sector %"PRIu64" nsectors %zu"
-virtio_blk_submit_multireq(void *mrb, int start, int num_reqs, uint64_t offset, size_t size, bool is_write) "mrb %p start %d num_reqs %d offset %"PRIu64" size %zu is_write %d"
+virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req %p status %d"
+virtio_blk_rw_complete(void *vdev, void *req, int ret) "vdev %p req %p ret %d"
+virtio_blk_handle_write(void *vdev, void *req, uint64_t sector, size_t nsectors) "vdev %p req %p sector %"PRIu64" nsectors %zu"
+virtio_blk_handle_read(void *vdev, void *req, uint64_t sector, size_t nsectors) "vdev %p req %p sector %"PRIu64" nsectors %zu"
+virtio_blk_submit_multireq(void *vdev, void *mrb, int start, int num_reqs, uint64_t offset, size_t size, bool is_write) "vdev %p mrb %p start %d num_reqs %d offset %"PRIu64" size %zu is_write %d"
 
 # hw/block/hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
-- 
2.9.4
