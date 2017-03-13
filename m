Received: from eggs.gnu.org ([2001:4830:134:3::10]:42996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4f-0000jU-PF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4e-0002Xa-Tx
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:29 -0500
Message-Id: <20170313195547.21466-13-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/30] trace: Fix parameter types in hw/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; in this patch, switching from
'/ BDRV_SECTOR_SIZE' (which changes types to unsigned long long) to
'>> BDRV_SECTOR_BITS' (which preserves the type at size_t) is sufficient
to match the existing trace definition.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/block/virtio-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 98c16a7..b609202 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -529,11 +529,11 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         if (is_write) {
             qemu_iovec_init_external(&req->qiov, iov, out_num);
             trace_virtio_blk_handle_write(req, req->sector_num,
-                                          req->qiov.size / BDRV_SECTOR_SIZE);
+                                          req->qiov.size >> BDRV_SECTOR_BITS);
         } else {
             qemu_iovec_init_external(&req->qiov, in_iov, in_num);
             trace_virtio_blk_handle_read(req, req->sector_num,
-                                         req->qiov.size / BDRV_SECTOR_SIZE);
+                                         req->qiov.size >> BDRV_SECTOR_BITS);
         }

         if (!virtio_blk_sect_range_ok(req->dev, req->sector_num,
-- 
2.9.3
