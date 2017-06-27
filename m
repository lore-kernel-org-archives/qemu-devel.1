Received: from eggs.gnu.org ([2001:4830:134:3::10]:42564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw78-000671-Co
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw77-0006pM-53
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:49 -0500
Message-Id: <20170627192458.15519-12-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-1-eblake@redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/20] mirror: Switch mirror_do_read() to
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
easier to reason about than sector-based.  Convert another internal
function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: rebase to earlier changes
---
 block/mirror.c | 75 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1a4602a..81ff784 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -196,7 +196,7 @@ static inline int mirror_clip_sectors(MirrorBlockJob *s,
 /* Round offset and/or bytes to target cluster if COW is needed, and
  * return the offset of the adjusted tail against original. */
 static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
-                            unsigned int *bytes)
+                            uint64_t *bytes)
 {
     bool need_cow;
     int ret = 0;
@@ -204,6 +204,7 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     unsigned int align_bytes = *bytes;
     int max_bytes = s->granularity * s->max_iov;

+    assert(*bytes < INT_MAX);
     need_cow = !test_bit(*offset / s->granularity, s->cow_bitmap);
     need_cow |= !test_bit((*offset + *bytes - 1) / s->granularity,
                           s->cow_bitmap);
@@ -239,59 +240,50 @@ static inline void mirror_wait_for_io(MirrorBlockJob *s)
 }

 /* Submit async read while handling COW.
- * Returns: The number of sectors copied after and including sector_num,
- *          excluding any sectors copied prior to sector_num due to alignment.
- *          This will be nb_sectors if no alignment is necessary, or
- *          (new_end - sector_num) if tail is rounded up or down due to
+ * Returns: The number of bytes copied after and including offset,
+ *          excluding any bytes copied prior to offset due to alignment.
+ *          This will be @bytes if no alignment is necessary, or
+ *          (new_end - offset) if tail is rounded up or down due to
  *          alignment or buffer limit.
  */
-static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
-                          int nb_sectors)
+static uint64_t mirror_do_read(MirrorBlockJob *s, int64_t offset,
+                               uint64_t bytes)
 {
     BlockBackend *source = s->common.blk;
-    int sectors_per_chunk, nb_chunks;
-    int ret;
+    int nb_chunks;
+    uint64_t ret;
     MirrorOp *op;
-    int max_sectors;
+    uint64_t max_bytes;

-    sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
-    max_sectors = sectors_per_chunk * s->max_iov;
+    max_bytes = s->granularity * s->max_iov;

     /* We can only handle as much as buf_size at a time. */
-    nb_sectors = MIN(s->buf_size >> BDRV_SECTOR_BITS, nb_sectors);
-    nb_sectors = MIN(max_sectors, nb_sectors);
-    assert(nb_sectors);
-    assert(nb_sectors < BDRV_REQUEST_MAX_SECTORS);
-    ret = nb_sectors;
+    bytes = MIN(s->buf_size, MIN(max_bytes, bytes));
+    assert(bytes);
+    assert(bytes < BDRV_REQUEST_MAX_BYTES);
+    ret = bytes;

     if (s->cow_bitmap) {
-        int64_t offset = sector_num * BDRV_SECTOR_SIZE;
-        unsigned int bytes = nb_sectors * BDRV_SECTOR_SIZE;
-        int gap;
-
-        gap = mirror_cow_align(s, &offset, &bytes);
-        sector_num = offset / BDRV_SECTOR_SIZE;
-        nb_sectors = bytes / BDRV_SECTOR_SIZE;
-        ret += gap / BDRV_SECTOR_SIZE;
+        ret += mirror_cow_align(s, &offset, &bytes);
     }
-    assert(nb_sectors << BDRV_SECTOR_BITS <= s->buf_size);
-    /* The sector range must meet granularity because:
+    assert(bytes <= s->buf_size);
+    /* The range will be sector-aligned because:
      * 1) Caller passes in aligned values;
-     * 2) mirror_cow_align is used only when target cluster is larger. */
-    assert(!(sector_num % sectors_per_chunk));
-    nb_chunks = DIV_ROUND_UP(nb_sectors, sectors_per_chunk);
+     * 2) mirror_cow_align is used only when target cluster is larger.
+     * But it might not be cluster-aligned at end-of-file. */
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+    nb_chunks = DIV_ROUND_UP(bytes, s->granularity);

     while (s->buf_free_count < nb_chunks) {
-        trace_mirror_yield_in_flight(s, sector_num * BDRV_SECTOR_SIZE,
-                                     s->in_flight);
+        trace_mirror_yield_in_flight(s, offset, s->in_flight);
         mirror_wait_for_io(s);
     }

     /* Allocate a MirrorOp that is used as an AIO callback.  */
     op = g_new(MirrorOp, 1);
     op->s = s;
-    op->offset = sector_num * BDRV_SECTOR_SIZE;
-    op->bytes = nb_sectors * BDRV_SECTOR_SIZE;
+    op->offset = offset;
+    op->bytes = bytes;

     /* Now make a QEMUIOVector taking enough granularity-sized chunks
      * from s->buf_free.
@@ -299,7 +291,7 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
     qemu_iovec_init(&op->qiov, nb_chunks);
     while (nb_chunks-- > 0) {
         MirrorBuffer *buf = QSIMPLEQ_FIRST(&s->buf_free);
-        size_t remaining = nb_sectors * BDRV_SECTOR_SIZE - op->qiov.size;
+        size_t remaining = bytes - op->qiov.size;

         QSIMPLEQ_REMOVE_HEAD(&s->buf_free, next);
         s->buf_free_count--;
@@ -308,12 +300,10 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,

     /* Copy the dirty cluster.  */
     s->in_flight++;
-    s->bytes_in_flight += nb_sectors * BDRV_SECTOR_SIZE;
-    trace_mirror_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
-                               nb_sectors * BDRV_SECTOR_SIZE);
+    s->bytes_in_flight += bytes;
+    trace_mirror_one_iteration(s, offset, bytes);

-    blk_aio_preadv(source, sector_num * BDRV_SECTOR_SIZE, &op->qiov, 0,
-                   mirror_read_complete, op);
+    blk_aio_preadv(source, offset, &op->qiov, 0, mirror_read_complete, op);
     return ret;
 }

@@ -461,8 +451,9 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         io_sectors = mirror_clip_sectors(s, sector_num, io_sectors);
         switch (mirror_method) {
         case MIRROR_METHOD_COPY:
-            io_sectors = mirror_do_read(s, sector_num, io_sectors);
-            io_bytes_acct = io_sectors * BDRV_SECTOR_SIZE;
+            io_bytes_acct = mirror_do_read(s, sector_num * BDRV_SECTOR_SIZE,
+                                           io_sectors * BDRV_SECTOR_SIZE);
+            io_sectors = io_bytes_acct / BDRV_SECTOR_SIZE;
             break;
         case MIRROR_METHOD_ZERO:
         case MIRROR_METHOD_DISCARD:
-- 
2.9.4
