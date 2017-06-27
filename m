Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw6x-0005wJ-6N
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw6w-0006l7-DQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:43 -0500
Message-Id: <20170627192458.15519-6-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-1-eblake@redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/20] commit: Switch commit_populate() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Start by converting an
internal function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 block/commit.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 4cda7f2..6f67d78 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -47,26 +47,25 @@ typedef struct CommitBlockJob {
 } CommitBlockJob;

 static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
-                                        int64_t sector_num, int nb_sectors,
+                                        int64_t offset, uint64_t bytes,
                                         void *buf)
 {
     int ret = 0;
     QEMUIOVector qiov;
     struct iovec iov = {
         .iov_base = buf,
-        .iov_len = nb_sectors * BDRV_SECTOR_SIZE,
+        .iov_len = bytes,
     };

+    assert(bytes < SIZE_MAX);
     qemu_iovec_init_external(&qiov, &iov, 1);

-    ret = blk_co_preadv(bs, sector_num * BDRV_SECTOR_SIZE,
-                        qiov.size, &qiov, 0);
+    ret = blk_co_preadv(bs, offset, qiov.size, &qiov, 0);
     if (ret < 0) {
         return ret;
     }

-    ret = blk_co_pwritev(base, sector_num * BDRV_SECTOR_SIZE,
-                         qiov.size, &qiov, 0);
+    ret = blk_co_pwritev(base, offset, qiov.size, &qiov, 0);
     if (ret < 0) {
         return ret;
     }
@@ -193,7 +192,9 @@ static void coroutine_fn commit_run(void *opaque)
         trace_commit_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
                                    n * BDRV_SECTOR_SIZE, ret);
         if (copy) {
-            ret = commit_populate(s->top, s->base, sector_num, n, buf);
+            ret = commit_populate(s->top, s->base,
+                                  sector_num * BDRV_SECTOR_SIZE,
+                                  n * BDRV_SECTOR_SIZE, buf);
             bytes_written += n * BDRV_SECTOR_SIZE;
         }
         if (ret < 0) {
-- 
2.9.4
