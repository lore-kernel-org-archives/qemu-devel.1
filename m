Received: from eggs.gnu.org ([2001:4830:134:3::10]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunl-0005KO-0I
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcuni-0001jb-A6
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:57 +0200
Message-Id: <20180710154304.18304-18-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/24] block: Use BdrvChild to discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Other I/O functions are already using a BdrvChild pointer in the API, so
make discard do the same. It makes it possible to initiate the same
permission checks before doing I/O, and much easier to share the
helper functions for this, which will be added and used by write,
truncate and copy range paths.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h  |  4 ++--
 block/blkdebug.c       |  2 +-
 block/blklogwrites.c   |  2 +-
 block/blkreplay.c      |  2 +-
 block/block-backend.c  |  2 +-
 block/copy-on-read.c   |  2 +-
 block/io.c             | 18 +++++++++---------
 block/mirror.c         |  2 +-
 block/qcow2-refcount.c |  2 +-
 block/raw-format.c     |  2 +-
 block/throttle.c       |  2 +-
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index a91f37bedf..f85e3a6ed3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -418,8 +418,8 @@ AioWait *bdrv_get_aio_wait(BlockDriverState *bs);
                    bdrv_get_aio_context(bs_),              \
                    cond); })
 
-int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
-int bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
+int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 526af2a808..0457bf5b66 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -625,7 +625,7 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
         return err;
     }
 
-    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
 
 static int coroutine_fn blkdebug_co_block_status(BlockDriverState *bs,
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index efa2c7a66a..ff98cd5533 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -486,7 +486,7 @@ static int coroutine_fn blk_log_writes_co_do_file_flush(BlkLogWritesFileReq *fr)
 static int coroutine_fn
 blk_log_writes_co_do_file_pdiscard(BlkLogWritesFileReq *fr)
 {
-    return bdrv_co_pdiscard(fr->bs->file->bs, fr->offset, fr->bytes);
+    return bdrv_co_pdiscard(fr->bs->file, fr->offset, fr->bytes);
 }
 
 static int coroutine_fn
diff --git a/block/blkreplay.c b/block/blkreplay.c
index b016dbeee7..766150ade6 100755
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -113,7 +113,7 @@ static int coroutine_fn blkreplay_co_pdiscard(BlockDriverState *bs,
                                               int64_t offset, int bytes)
 {
     uint64_t reqid = blkreplay_next_id();
-    int ret = bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+    int ret = bdrv_co_pdiscard(bs->file, offset, bytes);
     block_request_create(reqid, bs, qemu_coroutine_self());
     qemu_coroutine_yield();
 
diff --git a/block/block-backend.c b/block/block-backend.c
index e94e3d5929..f2f75a977d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1560,7 +1560,7 @@ int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
         return ret;
     }
 
-    return bdrv_co_pdiscard(blk_bs(blk), offset, bytes);
+    return bdrv_co_pdiscard(blk->root, offset, bytes);
 }
 
 int blk_co_flush(BlockBackend *blk)
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 1dcdaeed69..a19164f9eb 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -116,7 +116,7 @@ static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
 static int coroutine_fn cor_co_pdiscard(BlockDriverState *bs,
                                         int64_t offset, int bytes)
 {
-    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
 
 
diff --git a/block/io.c b/block/io.c
index 9b2aa04010..fbcd93304b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2633,7 +2633,7 @@ int bdrv_flush(BlockDriverState *bs)
 }
 
 typedef struct DiscardCo {
-    BlockDriverState *bs;
+    BdrvChild *child;
     int64_t offset;
     int bytes;
     int ret;
@@ -2642,17 +2642,17 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
 {
     DiscardCo *rwco = opaque;
 
-    rwco->ret = bdrv_co_pdiscard(rwco->bs, rwco->offset, rwco->bytes);
+    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
 }
 
-int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
-                                  int bytes)
+int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
     int head, tail, align;
+    BlockDriverState *bs = child->bs;
 
-    if (!bs->drv) {
+    if (!bs || !bs->drv) {
         return -ENOMEDIUM;
     }
 
@@ -2763,11 +2763,11 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
 {
     Coroutine *co;
     DiscardCo rwco = {
-        .bs = bs,
+        .child = child,
         .offset = offset,
         .bytes = bytes,
         .ret = NOT_DONE,
@@ -2778,8 +2778,8 @@ int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
         bdrv_pdiscard_co_entry(&rwco);
     } else {
         co = qemu_coroutine_create(bdrv_pdiscard_co_entry, &rwco);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, rwco.ret == NOT_DONE);
+        bdrv_coroutine_enter(child->bs, co);
+        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
     }
 
     return rwco.ret;
diff --git a/block/mirror.c b/block/mirror.c
index 61bd9f3cf1..b48c3f8cf5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1333,7 +1333,7 @@ static int coroutine_fn bdrv_mirror_top_do_write(BlockDriverState *bs,
         break;
 
     case MIRROR_METHOD_DISCARD:
-        ret = bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
+        ret = bdrv_co_pdiscard(bs->backing, offset, bytes);
         break;
 
     default:
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 18c729aa27..4e1589ad7a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -734,7 +734,7 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
 
         /* Discard is optional, ignore the return value */
         if (ret >= 0) {
-            bdrv_pdiscard(bs->file->bs, d->offset, d->bytes);
+            bdrv_pdiscard(bs->file, d->offset, d->bytes);
         }
 
         g_free(d);
diff --git a/block/raw-format.c b/block/raw-format.c
index a3591985f6..dee262875a 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -297,7 +297,7 @@ static int coroutine_fn raw_co_pdiscard(BlockDriverState *bs,
     if (ret) {
         return ret;
     }
-    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
 
 static int64_t raw_getlength(BlockDriverState *bs)
diff --git a/block/throttle.c b/block/throttle.c
index f617f23a12..636c9764aa 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -149,7 +149,7 @@ static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
     ThrottleGroupMember *tgm = bs->opaque;
     throttle_group_co_io_limits_intercept(tgm, bytes, true);
 
-    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+    return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
 
 static int throttle_co_flush(BlockDriverState *bs)
-- 
2.13.6
