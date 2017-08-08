Received: from eggs.gnu.org ([2001:4830:134:3::10]:42514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52R-0000Lc-04
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52L-0002B2-9e
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:30 +0200
Message-Id: <20170808135838.11525-11-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/18] block: respect error code from
 bdrv_getlength in handle_aiocb_write_zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: "Denis V. Lunev" <den@openvz.org>

Original idea beyond the code in question was the following: we have failed
to write zeroes with fallocate(FALLOC_FL_ZERO_RANGE) as the simplest
approach and via fallocate(FALLOC_FL_PUNCH_HOLE)/fallocate(0). We have the
only chance now: if the request comes beyond end of the file. Thus we
should calculate file length and respect the error code from that op.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cfbb236f6f..f4de022ae0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1339,6 +1339,9 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
 #if defined(CONFIG_FALLOCATE) || defined(CONFIG_XFS)
     BDRVRawState *s = aiocb->bs->opaque;
 #endif
+#ifdef CONFIG_FALLOCATE
+    int64_t len;
+#endif
 
     if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
         return handle_aiocb_write_zeroes_block(aiocb);
@@ -1381,7 +1384,10 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
 #endif
 
 #ifdef CONFIG_FALLOCATE
-    if (s->has_fallocate && aiocb->aio_offset >= bdrv_getlength(aiocb->bs)) {
+    /* Last resort: we are trying to extend the file with zeroed data. This
+     * can be done via fallocate(fd, 0) */
+    len = bdrv_getlength(aiocb->bs);
+    if (s->has_fallocate && len >= 0 && aiocb->aio_offset >= len) {
         int ret = do_fallocate(s->fd, 0, aiocb->aio_offset, aiocb->aio_nbytes);
         if (ret == 0 || ret != -ENOTSUP) {
             return ret;
-- 
2.13.4
