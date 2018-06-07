Received: from eggs.gnu.org ([2001:4830:134:3::10]:48343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQw5v-0003Mc-PY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQw5u-0005KC-PZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:55 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Thu, 7 Jun 2018 17:40:29 +0300
Message-ID: <1528382429-13478-12-git-send-email-ari@tuxera.com>
In-Reply-To: <1528382429-13478-1-git-send-email-ari@tuxera.com>
References: <1528382429-13478-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 10/10] block/blklogwrites: Use the block
 device logical sector size when logging writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:blklogwrites" <qemu-block@nongnu.org>

The guest OS may perform writes which are aligned to the logical
sector size instead of the physical one, so logging at this granularity
records the writes performed on the block device most faithfully.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 8b09e12..52166f2 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -47,6 +47,8 @@ struct log_write_entry {
 
 typedef struct {
     BdrvChild *log_file;
+    uint32_t sectorsize;
+    uint32_t sectorbits;
     uint64_t cur_log_sector;
     uint64_t nr_entries;
 } BDRVBlkLogWritesState;
@@ -67,6 +69,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    s->sectorsize = BDRV_SECTOR_SIZE; /* May be updated later */
+    s->sectorbits = BDRV_SECTOR_BITS;
     s->cur_log_sector = 1;
     s->nr_entries = 0;
 
@@ -168,11 +172,20 @@ static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 }
 
+static inline uint32_t blk_log_writes_log2(uint32_t value)
+{
+    assert(value > 0);
+    return 31 - clz32(value);
+}
+
 static void blk_log_writes_apply_blkconf(BlockDriverState *bs, BlockConf *conf)
 {
-    assert(bs && conf && conf->blk);
+    BDRVBlkLogWritesState *s = bs->opaque;
+    assert(bs && conf && conf->blk && s);
 
-    bs->bl.request_alignment = conf->logical_block_size;
+    s->sectorsize = conf->logical_block_size;
+    s->sectorbits = blk_log_writes_log2(s->sectorsize);
+    bs->bl.request_alignment = s->sectorsize;
     if (conf->discard_granularity != (uint32_t)-1) {
         bs->bl.pdiscard_alignment = conf->discard_granularity;
     }
@@ -215,20 +228,20 @@ typedef struct {
 static void coroutine_fn blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
 {
     BDRVBlkLogWritesState *s = lr->bs->opaque;
-    uint64_t cur_log_offset = s->cur_log_sector << BDRV_SECTOR_BITS;
+    uint64_t cur_log_offset = s->cur_log_sector << s->sectorbits;
 
     s->nr_entries++;
     s->cur_log_sector +=
-            ROUND_UP(lr->qiov->size, BDRV_SECTOR_SIZE) >> BDRV_SECTOR_BITS;
+            ROUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;
 
     lr->log_ret = bdrv_co_pwritev(s->log_file, cur_log_offset, lr->qiov->size,
                                   lr->qiov, 0);
 
     /* Logging for the "write zeroes" operation */
     if (lr->log_ret == 0 && lr->zero_size) {
-        cur_log_offset = s->cur_log_sector << BDRV_SECTOR_BITS;
+        cur_log_offset = s->cur_log_sector << s->sectorbits;
         s->cur_log_sector +=
-                ROUND_UP(lr->zero_size, BDRV_SECTOR_SIZE) >> BDRV_SECTOR_BITS;
+                ROUND_UP(lr->zero_size, s->sectorsize) >> s->sectorbits;
 
         lr->log_ret = bdrv_co_pwrite_zeroes(s->log_file, cur_log_offset,
                                             lr->zero_size, 0);
@@ -240,21 +253,22 @@ static void coroutine_fn blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
             .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
             .version    = cpu_to_le64(WRITE_LOG_VERSION),
             .nr_entries = cpu_to_le64(s->nr_entries),
-            .sectorsize = cpu_to_le32(1 << BDRV_SECTOR_BITS),
+            .sectorsize = cpu_to_le32(s->sectorsize),
         };
-        static const char zeroes[BDRV_SECTOR_SIZE - sizeof(super)] = { '\0' };
+        void *zeroes = g_malloc0(s->sectorsize - sizeof(super));
         QEMUIOVector qiov;
 
         qemu_iovec_init(&qiov, 2);
         qemu_iovec_add(&qiov, &super, sizeof(super));
-        qemu_iovec_add(&qiov, (void *)zeroes, sizeof(zeroes));
+        qemu_iovec_add(&qiov, zeroes, s->sectorsize - sizeof(super));
 
         lr->log_ret =
-            bdrv_co_pwritev(s->log_file, 0, BDRV_SECTOR_SIZE, &qiov, 0);
+            bdrv_co_pwritev(s->log_file, 0, s->sectorsize, &qiov, 0);
         if (lr->log_ret == 0) {
             lr->log_ret = bdrv_co_flush(s->log_file->bs);
         }
         qemu_iovec_destroy(&qiov);
+        g_free(zeroes);
     }
 }
 
@@ -271,6 +285,7 @@ blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 {
     QEMUIOVector log_qiov;
     size_t niov = qiov ? qiov->niov : 0;
+    BDRVBlkLogWritesState *s = bs->opaque;
     BlkLogWritesFileReq fr = {
         .bs     = bs,
         .offset = offset,
@@ -283,22 +298,23 @@ blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         .bs             = bs,
         .qiov           = &log_qiov,
         .entry = {
-            .sector     = cpu_to_le64(offset >> BDRV_SECTOR_BITS),
-            .nr_sectors = cpu_to_le64(bytes >> BDRV_SECTOR_BITS),
+            .sector     = cpu_to_le64(offset >> s->sectorbits),
+            .nr_sectors = cpu_to_le64(bytes >> s->sectorbits),
             .flags      = cpu_to_le64(entry_flags),
             .data_len   = 0,
         },
         .zero_size = is_zero_write ? bytes : 0,
     };
-    static const char zeroes[BDRV_SECTOR_SIZE - sizeof(struct log_write_entry)]
-        = { '\0' };
+    void *zeroes = g_malloc0(s->sectorsize - sizeof(lr.entry));
 
+    assert((1 << s->sectorbits) == s->sectorsize);
+    assert(bs->bl.request_alignment == s->sectorsize);
     assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
     assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
 
     qemu_iovec_init(&log_qiov, niov + 2);
     qemu_iovec_add(&log_qiov, &lr.entry, sizeof(lr.entry));
-    qemu_iovec_add(&log_qiov, (void *)zeroes, sizeof(zeroes));
+    qemu_iovec_add(&log_qiov, zeroes, s->sectorsize - sizeof(lr.entry));
     for (size_t i = 0; i < niov; ++i) {
         qemu_iovec_add(&log_qiov, qiov->iov[i].iov_base, qiov->iov[i].iov_len);
     }
@@ -307,6 +323,7 @@ blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     blk_log_writes_co_do_log(&lr);
 
     qemu_iovec_destroy(&log_qiov);
+    g_free(zeroes);
 
     if (lr.log_ret < 0) {
         return lr.log_ret;
-- 
2.7.4
