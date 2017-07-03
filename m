Received: from eggs.gnu.org ([2001:4830:134:3::10]:55822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cp-0007Wb-Ev
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9co-0004UO-Cb
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:45 -0500
Message-Id: <20170703221456.30817-5-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/15] block: Make bdrv_round_to_clusters()
 signature more useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

In the process of converting sector-based interfaces to bytes,
I'm finding it easier to represent a byte count as a 64-bit
integer at the block layer (even if we are internally capped
by SIZE_MAX or even INT_MAX for individual transactions, it's
still nicer to not have to worry about truncation/overflow
issues on as many variables).  Update the signature of
bdrv_round_to_clusters() to uniformly use int64_t, matching
the signature already chosen for bdrv_is_allocated and the
fact that off_t is also a signed type, then adjust clients
according to the required fallout.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: fix commit message [John], rebase to earlier changes, including
mirror_clip_bytes() signature update
---
 include/block/block.h | 4 ++--
 block/io.c            | 7 ++++---
 block/mirror.c        | 7 +++----
 block/trace-events    | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index f0fdbe8..cc82a0d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -473,9 +473,9 @@ int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
 void bdrv_round_to_clusters(BlockDriverState *bs,
-                            int64_t offset, unsigned int bytes,
+                            int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
-                            unsigned int *cluster_bytes);
+                            int64_t *cluster_bytes);

 const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
diff --git a/block/io.c b/block/io.c
index 719a6b0..2377f3a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -422,9 +422,9 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
  * Round a region to cluster boundaries
  */
 void bdrv_round_to_clusters(BlockDriverState *bs,
-                            int64_t offset, unsigned int bytes,
+                            int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
-                            unsigned int *cluster_bytes)
+                            int64_t *cluster_bytes)
 {
     BlockDriverInfo bdi;

@@ -922,7 +922,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     struct iovec iov;
     QEMUIOVector bounce_qiov;
     int64_t cluster_offset;
-    unsigned int cluster_bytes;
+    int64_t cluster_bytes;
     size_t skip_bytes;
     int ret;

@@ -943,6 +943,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
                                    cluster_offset, cluster_bytes);

+    assert(cluster_bytes < SIZE_MAX);
     iov.iov_len = cluster_bytes;
     iov.iov_base = bounce_buffer = qemu_try_blockalign(bs, iov.iov_len);
     if (bounce_buffer == NULL) {
diff --git a/block/mirror.c b/block/mirror.c
index 21758a8..08c0c27 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -190,10 +190,9 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     bool need_cow;
     int ret = 0;
     int64_t align_offset = *offset;
-    unsigned int align_bytes = *bytes;
+    int64_t align_bytes = *bytes;
     int max_bytes = s->granularity * s->max_iov;

-    assert(*bytes < INT_MAX);
     need_cow = !test_bit(*offset / s->granularity, s->cow_bitmap);
     need_cow |= !test_bit((*offset + *bytes - 1) / s->granularity,
                           s->cow_bitmap);
@@ -389,7 +388,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     while (nb_chunks > 0 && offset < s->bdev_length) {
         int64_t ret;
         int io_sectors;
-        unsigned int io_bytes;
+        int64_t io_bytes;
         int64_t io_bytes_acct;
         enum MirrorMethod {
             MIRROR_METHOD_COPY,
@@ -414,7 +413,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
             io_bytes = s->granularity;
         } else if (ret >= 0 && !(ret & BDRV_BLOCK_DATA)) {
             int64_t target_offset;
-            unsigned int target_bytes;
+            int64_t target_bytes;
             bdrv_round_to_clusters(blk_bs(s->target), offset, io_bytes,
                                    &target_offset, &target_bytes);
             if (target_offset == offset &&
diff --git a/block/trace-events b/block/trace-events
index 4a4df25..13a5a87 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -12,7 +12,7 @@ blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flag
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags %#x"
-bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
+bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %"PRId64" cluster_offset %"PRId64" cluster_bytes %u"

 # block/stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
-- 
2.9.4
