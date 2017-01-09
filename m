Received: from eggs.gnu.org ([2001:4830:134:3::10]:33540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaG0-000727-V0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFy-00035D-KJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:34 +0100
Message-Id: <1483969476-7172-13-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/14] blkverify: Implement
 bdrv_co_preadv/pwritev/flush
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

This enables byte granularity requests for blkverify, and at the same
time gets us rid of another user of the BDS-level AIO emulation.

The reference output of a test case must be changed because the
verification failure message reports byte offsets instead of sectors
now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/blkverify.c          | 201 ++++++++++++++++++++++-----------------------
 tests/qemu-iotests/071.out |   8 +-
 2 files changed, 100 insertions(+), 109 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index 28f9af6..43a940c 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -19,38 +19,36 @@ typedef struct {
     BdrvChild *test_file;
 } BDRVBlkverifyState;
 
-typedef struct BlkverifyAIOCB BlkverifyAIOCB;
-struct BlkverifyAIOCB {
-    BlockAIOCB common;
+typedef struct BlkverifyRequest {
+    Coroutine *co;
+    BlockDriverState *bs;
 
     /* Request metadata */
     bool is_write;
-    int64_t sector_num;
-    int nb_sectors;
+    uint64_t offset;
+    uint64_t bytes;
+    int flags;
 
-    int ret;                    /* first completed request's result */
-    unsigned int done;          /* completion counter */
+    int (*request_fn)(BdrvChild *, int64_t, unsigned int, QEMUIOVector *,
+                      BdrvRequestFlags);
 
-    QEMUIOVector *qiov;         /* user I/O vector */
-    QEMUIOVector raw_qiov;      /* cloned I/O vector for raw file */
-    void *buf;                  /* buffer for raw file I/O */
+    int ret;                    /* test image result */
+    int raw_ret;                /* raw image result */
 
-    void (*verify)(BlkverifyAIOCB *acb);
-};
+    unsigned int done;          /* completion counter */
 
-static const AIOCBInfo blkverify_aiocb_info = {
-    .aiocb_size         = sizeof(BlkverifyAIOCB),
-};
+    QEMUIOVector *qiov;         /* user I/O vector */
+    QEMUIOVector *raw_qiov;     /* cloned I/O vector for raw file */
+} BlkverifyRequest;
 
-static void GCC_FMT_ATTR(2, 3) blkverify_err(BlkverifyAIOCB *acb,
+static void GCC_FMT_ATTR(2, 3) blkverify_err(BlkverifyRequest *r,
                                              const char *fmt, ...)
 {
     va_list ap;
 
     va_start(ap, fmt);
-    fprintf(stderr, "blkverify: %s sector_num=%" PRId64 " nb_sectors=%d ",
-            acb->is_write ? "write" : "read", acb->sector_num,
-            acb->nb_sectors);
+    fprintf(stderr, "blkverify: %s offset=%" PRId64 " bytes=%" PRId64 " ",
+            r->is_write ? "write" : "read", r->offset, r->bytes);
     vfprintf(stderr, fmt, ap);
     fprintf(stderr, "\n");
     va_end(ap);
@@ -166,113 +164,106 @@ static int64_t blkverify_getlength(BlockDriverState *bs)
     return bdrv_getlength(s->test_file->bs);
 }
 
-static BlkverifyAIOCB *blkverify_aio_get(BlockDriverState *bs, bool is_write,
-                                         int64_t sector_num, QEMUIOVector *qiov,
-                                         int nb_sectors,
-                                         BlockCompletionFunc *cb,
-                                         void *opaque)
+static void coroutine_fn blkverify_do_test_req(void *opaque)
 {
-    BlkverifyAIOCB *acb = qemu_aio_get(&blkverify_aiocb_info, bs, cb, opaque);
-
-    acb->is_write = is_write;
-    acb->sector_num = sector_num;
-    acb->nb_sectors = nb_sectors;
-    acb->ret = -EINPROGRESS;
-    acb->done = 0;
-    acb->qiov = qiov;
-    acb->buf = NULL;
-    acb->verify = NULL;
-    return acb;
+    BlkverifyRequest *r = opaque;
+    BDRVBlkverifyState *s = r->bs->opaque;
+
+    r->ret = r->request_fn(s->test_file, r->offset, r->bytes, r->qiov,
+                           r->flags);
+    r->done++;
+    qemu_coroutine_enter_if_inactive(r->co);
 }
 
-static void blkverify_aio_bh(void *opaque)
+static void coroutine_fn blkverify_do_raw_req(void *opaque)
 {
-    BlkverifyAIOCB *acb = opaque;
+    BlkverifyRequest *r = opaque;
 
-    if (acb->buf) {
-        qemu_iovec_destroy(&acb->raw_qiov);
-        qemu_vfree(acb->buf);
-    }
-    acb->common.cb(acb->common.opaque, acb->ret);
-    qemu_aio_unref(acb);
+    r->raw_ret = r->request_fn(r->bs->file, r->offset, r->bytes, r->raw_qiov,
+                               r->flags);
+    r->done++;
+    qemu_coroutine_enter_if_inactive(r->co);
 }
 
-static void blkverify_aio_cb(void *opaque, int ret)
+static int coroutine_fn
+blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
+                  uint64_t bytes, QEMUIOVector *qiov, QEMUIOVector *raw_qiov,
+                  int flags, bool is_write)
 {
-    BlkverifyAIOCB *acb = opaque;
-
-    switch (++acb->done) {
-    case 1:
-        acb->ret = ret;
-        break;
-
-    case 2:
-        if (acb->ret != ret) {
-            blkverify_err(acb, "return value mismatch %d != %d", acb->ret, ret);
-        }
-
-        if (acb->verify) {
-            acb->verify(acb);
-        }
+    Coroutine *co_a, *co_b;
+
+    *r = (BlkverifyRequest) {
+        .co         = qemu_coroutine_self(),
+        .bs         = bs,
+        .offset     = offset,
+        .bytes      = bytes,
+        .qiov       = qiov,
+        .raw_qiov   = raw_qiov,
+        .flags      = flags,
+        .is_write   = is_write,
+        .request_fn = is_write ? bdrv_co_pwritev : bdrv_co_preadv,
+    };
+
+    co_a = qemu_coroutine_create(blkverify_do_test_req, r);
+    co_b = qemu_coroutine_create(blkverify_do_raw_req, r);
+
+    qemu_coroutine_enter(co_a);
+    qemu_coroutine_enter(co_b);
+
+    while (r->done < 2) {
+        qemu_coroutine_yield();
+    }
 
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
-                                blkverify_aio_bh, acb);
-        break;
+    if (r->ret != r->raw_ret) {
+        blkverify_err(r, "return value mismatch %d != %d", r->ret, r->raw_ret);
     }
+
+    return r->ret;
 }
 
-static void blkverify_verify_readv(BlkverifyAIOCB *acb)
+static int coroutine_fn
+blkverify_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                    QEMUIOVector *qiov, int flags)
 {
-    ssize_t offset = qemu_iovec_compare(acb->qiov, &acb->raw_qiov);
-    if (offset != -1) {
-        blkverify_err(acb, "contents mismatch in sector %" PRId64,
-                      acb->sector_num + (int64_t)(offset / BDRV_SECTOR_SIZE));
+    BlkverifyRequest r;
+    QEMUIOVector raw_qiov;
+    void *buf;
+    ssize_t cmp_offset;
+    int ret;
+
+    buf = qemu_blockalign(bs->file->bs, qiov->size);
+    qemu_iovec_init(&raw_qiov, qiov->niov);
+    qemu_iovec_clone(&raw_qiov, qiov, buf);
+
+    ret = blkverify_co_prwv(bs, &r, offset, bytes, qiov, &raw_qiov, flags,
+                            false);
+
+    cmp_offset = qemu_iovec_compare(qiov, &raw_qiov);
+    if (cmp_offset != -1) {
+        blkverify_err(&r, "contents mismatch at offset %" PRId64,
+                      offset + cmp_offset);
     }
-}
 
-static BlockAIOCB *blkverify_aio_readv(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque)
-{
-    BDRVBlkverifyState *s = bs->opaque;
-    BlkverifyAIOCB *acb = blkverify_aio_get(bs, false, sector_num, qiov,
-                                            nb_sectors, cb, opaque);
-
-    acb->verify = blkverify_verify_readv;
-    acb->buf = qemu_blockalign(bs->file->bs, qiov->size);
-    qemu_iovec_init(&acb->raw_qiov, acb->qiov->niov);
-    qemu_iovec_clone(&acb->raw_qiov, qiov, acb->buf);
-
-    bdrv_aio_readv(s->test_file, sector_num, qiov, nb_sectors,
-                   blkverify_aio_cb, acb);
-    bdrv_aio_readv(bs->file, sector_num, &acb->raw_qiov, nb_sectors,
-                   blkverify_aio_cb, acb);
-    return &acb->common;
+    qemu_iovec_destroy(&raw_qiov);
+    qemu_vfree(buf);
+
+    return ret;
 }
 
-static BlockAIOCB *blkverify_aio_writev(BlockDriverState *bs,
-        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-        BlockCompletionFunc *cb, void *opaque)
+static int coroutine_fn
+blkverify_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                     QEMUIOVector *qiov, int flags)
 {
-    BDRVBlkverifyState *s = bs->opaque;
-    BlkverifyAIOCB *acb = blkverify_aio_get(bs, true, sector_num, qiov,
-                                            nb_sectors, cb, opaque);
-
-    bdrv_aio_writev(s->test_file, sector_num, qiov, nb_sectors,
-                    blkverify_aio_cb, acb);
-    bdrv_aio_writev(bs->file, sector_num, qiov, nb_sectors,
-                    blkverify_aio_cb, acb);
-    return &acb->common;
+    BlkverifyRequest r;
+    return blkverify_co_prwv(bs, &r, offset, bytes, qiov, qiov, flags, true);
 }
 
-static BlockAIOCB *blkverify_aio_flush(BlockDriverState *bs,
-                                       BlockCompletionFunc *cb,
-                                       void *opaque)
+static int blkverify_co_flush(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
     /* Only flush test file, the raw file is not important */
-    return bdrv_aio_flush(s->test_file->bs, cb, opaque);
+    return bdrv_co_flush(s->test_file->bs);
 }
 
 static bool blkverify_recurse_is_first_non_filter(BlockDriverState *bs,
@@ -332,9 +323,9 @@ static BlockDriver bdrv_blkverify = {
     .bdrv_getlength                   = blkverify_getlength,
     .bdrv_refresh_filename            = blkverify_refresh_filename,
 
-    .bdrv_aio_readv                   = blkverify_aio_readv,
-    .bdrv_aio_writev                  = blkverify_aio_writev,
-    .bdrv_aio_flush                   = blkverify_aio_flush,
+    .bdrv_co_preadv                   = blkverify_co_preadv,
+    .bdrv_co_pwritev                  = blkverify_co_pwritev,
+    .bdrv_co_flush                    = blkverify_co_flush,
 
     .is_filter                        = true,
     .bdrv_recurse_is_first_non_filter = blkverify_recurse_is_first_non_filter,
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index 8ff423f..dd879f1 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -12,7 +12,7 @@ read 512/512 bytes at offset 229376
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkverify: read sector_num=0 nb_sectors=1 contents mismatch in sector 0
+blkverify: read offset=0 bytes=512 contents mismatch at offset 0
 
 === Testing blkverify through file blockref ===
 
@@ -26,7 +26,7 @@ read 512/512 bytes at offset 229376
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-blkverify: read sector_num=0 nb_sectors=1 contents mismatch in sector 0
+blkverify: read offset=0 bytes=512 contents mismatch at offset 0
 
 === Testing blkdebug through filename ===
 
@@ -56,7 +56,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-blkverify: read sector_num=0 nb_sectors=1 contents mismatch in sector 0
+blkverify: read offset=0 bytes=512 contents mismatch at offset 0
 
 
 === Testing blkverify on existing raw block device ===
@@ -66,7 +66,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-blkverify: read sector_num=0 nb_sectors=1 contents mismatch in sector 0
+blkverify: read offset=0 bytes=512 contents mismatch at offset 0
 
 
 === Testing blkdebug's set-state through QMP ===
-- 
1.8.3.1
