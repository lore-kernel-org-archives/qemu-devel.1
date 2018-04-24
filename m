Received: from eggs.gnu.org ([2001:4830:134:3::10]:58527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d2-00029E-Vn
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB3d1-00061A-SR
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:29:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 24 Apr 2018 14:25:03 -0500
Message-Id: <20180424192506.149089-4-eblake@redhat.com>
In-Reply-To: <20180424192506.149089-1-eblake@redhat.com>
References: <20180424192506.149089-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] null: Switch to byte-based read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based callbacks
in the null-co and null-aio drivers.

Note that since the null driver does nothing on writes, it trivially
supports the BDRV_REQ_FUA flag (all writes have already landed to
the same bit-bucket without needing an extra flush call).  Also, since
the null driver does just as well with byte-based requests, we can
now avoid cycles wasted on read-modify-write by taking advantage of
the block layer now defaulting the alignment to 1 instead of 512.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rely on new block layer default alignment [Kevin]
---
 block/null.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/block/null.c b/block/null.c
index 806a8631e4d..8fbbda52ea1 100644
--- a/block/null.c
+++ b/block/null.c
@@ -93,6 +93,7 @@ static int null_file_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->read_zeroes = qemu_opt_get_bool(opts, NULL_OPT_ZEROES, false);
     qemu_opts_del(opts);
+    bs->supported_write_flags = BDRV_REQ_FUA;
     return ret;
 }

@@ -116,22 +117,22 @@ static coroutine_fn int null_co_common(BlockDriverState *bs)
     return 0;
 }

-static coroutine_fn int null_co_readv(BlockDriverState *bs,
-                                      int64_t sector_num, int nb_sectors,
-                                      QEMUIOVector *qiov)
+static coroutine_fn int null_co_preadv(BlockDriverState *bs,
+                                       uint64_t offset, uint64_t bytes,
+                                       QEMUIOVector *qiov, int flags)
 {
     BDRVNullState *s = bs->opaque;

     if (s->read_zeroes) {
-        qemu_iovec_memset(qiov, 0, 0, nb_sectors * BDRV_SECTOR_SIZE);
+        qemu_iovec_memset(qiov, 0, 0, bytes);
     }

     return null_co_common(bs);
 }

-static coroutine_fn int null_co_writev(BlockDriverState *bs,
-                                       int64_t sector_num, int nb_sectors,
-                                       QEMUIOVector *qiov)
+static coroutine_fn int null_co_pwritev(BlockDriverState *bs,
+                                        uint64_t offset, uint64_t bytes,
+                                        QEMUIOVector *qiov, int flags)
 {
     return null_co_common(bs);
 }
@@ -186,26 +187,26 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
     return &acb->common;
 }

-static BlockAIOCB *null_aio_readv(BlockDriverState *bs,
-                                  int64_t sector_num, QEMUIOVector *qiov,
-                                  int nb_sectors,
-                                  BlockCompletionFunc *cb,
-                                  void *opaque)
-{
-    BDRVNullState *s = bs->opaque;
-
-    if (s->read_zeroes) {
-        qemu_iovec_memset(qiov, 0, 0, nb_sectors * BDRV_SECTOR_SIZE);
-    }
-
-    return null_aio_common(bs, cb, opaque);
-}
-
-static BlockAIOCB *null_aio_writev(BlockDriverState *bs,
-                                   int64_t sector_num, QEMUIOVector *qiov,
-                                   int nb_sectors,
+static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
+                                   uint64_t offset, uint64_t bytes,
+                                   QEMUIOVector *qiov, int flags,
                                    BlockCompletionFunc *cb,
                                    void *opaque)
+{
+    BDRVNullState *s = bs->opaque;
+
+    if (s->read_zeroes) {
+        qemu_iovec_memset(qiov, 0, 0, bytes);
+    }
+
+    return null_aio_common(bs, cb, opaque);
+}
+
+static BlockAIOCB *null_aio_pwritev(BlockDriverState *bs,
+                                    uint64_t offset, uint64_t bytes,
+                                    QEMUIOVector *qiov, int flags,
+                                    BlockCompletionFunc *cb,
+                                    void *opaque)
 {
     return null_aio_common(bs, cb, opaque);
 }
@@ -266,8 +267,8 @@ static BlockDriver bdrv_null_co = {
     .bdrv_close             = null_close,
     .bdrv_getlength         = null_getlength,

-    .bdrv_co_readv          = null_co_readv,
-    .bdrv_co_writev         = null_co_writev,
+    .bdrv_co_preadv         = null_co_preadv,
+    .bdrv_co_pwritev        = null_co_pwritev,
     .bdrv_co_flush_to_disk  = null_co_flush,
     .bdrv_reopen_prepare    = null_reopen_prepare,

@@ -286,8 +287,8 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_close             = null_close,
     .bdrv_getlength         = null_getlength,

-    .bdrv_aio_readv         = null_aio_readv,
-    .bdrv_aio_writev        = null_aio_writev,
+    .bdrv_aio_preadv        = null_aio_preadv,
+    .bdrv_aio_pwritev       = null_aio_pwritev,
     .bdrv_aio_flush         = null_aio_flush,
     .bdrv_reopen_prepare    = null_reopen_prepare,

-- 
2.14.3
