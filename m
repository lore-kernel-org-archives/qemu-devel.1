Received: from eggs.gnu.org ([2001:4830:134:3::10]:60759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMf-00021W-GD
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMd-0008Fv-LE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:52 +0200
Message-Id: <1498234919-27316-55-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 54/61] qed: Use bdrv_co_* for coroutine_fns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

All functions that are marked coroutine_fn can directly call the
bdrv_co_* version of functions instead of going through the wrapper.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index 48f2b0e..c073baa 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -116,7 +116,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState *s)
     };
     qemu_iovec_init_external(&qiov, &iov, 1);
 
-    ret = bdrv_preadv(s->bs->file, 0, &qiov);
+    ret = bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
     if (ret < 0) {
         goto out;
     }
@@ -124,7 +124,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState *s)
     /* Update header */
     qed_header_cpu_to_le(&s->header, (QEDHeader *) buf);
 
-    ret = bdrv_pwritev(s->bs->file, 0, &qiov);
+    ret = bdrv_co_pwritev(s->bs->file, 0, qiov.size,  &qiov, 0);
     if (ret < 0) {
         goto out;
     }
@@ -796,7 +796,7 @@ static int coroutine_fn qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
     qemu_iovec_concat(*backing_qiov, qiov, 0, size);
 
     BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
-    ret = bdrv_preadv(s->bs->backing, pos, *backing_qiov);
+    ret = bdrv_co_preadv(s->bs->backing, pos, size, *backing_qiov, 0);
     if (ret < 0) {
         return ret;
     }
@@ -844,7 +844,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
     }
 
     BLKDBG_EVENT(s->bs->file, BLKDBG_COW_WRITE);
-    ret = bdrv_pwritev(s->bs->file, offset, &qiov);
+    ret = bdrv_co_pwritev(s->bs->file, offset, qiov.size, &qiov, 0);
     if (ret < 0) {
         goto out;
     }
@@ -987,7 +987,8 @@ static int coroutine_fn qed_aio_write_main(QEDAIOCB *acb)
     trace_qed_aio_write_main(s, acb, 0, offset, acb->cur_qiov.size);
 
     BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
-    ret = bdrv_pwritev(s->bs->file, offset, &acb->cur_qiov);
+    ret = bdrv_co_pwritev(s->bs->file, offset, acb->cur_qiov.size,
+                          &acb->cur_qiov, 0);
     if (ret < 0) {
         return ret;
     }
@@ -1004,7 +1005,7 @@ static int coroutine_fn qed_aio_write_main(QEDAIOCB *acb)
              * region.  The solution is to flush after writing a new data
              * cluster and before updating the L2 table.
              */
-            ret = bdrv_flush(s->bs->file->bs);
+            ret = bdrv_co_flush(s->bs->file->bs);
             if (ret < 0) {
                 return ret;
             }
@@ -1221,7 +1222,8 @@ static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-    ret = bdrv_preadv(bs->file, offset, &acb->cur_qiov);
+    ret = bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
+                         &acb->cur_qiov, 0);
     if (ret < 0) {
         return ret;
     }
-- 
1.8.3.1
