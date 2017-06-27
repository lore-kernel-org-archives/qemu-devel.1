Received: from eggs.gnu.org ([2001:4830:134:3::10]:42562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw78-00066n-9l
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw77-0006pR-6o
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:48 -0500
Message-Id: <20170627192458.15519-11-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-1-eblake@redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/20] mirror: Switch mirror_cow_align() to
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
function (no semantic change), and add mirror_clip_bytes() as a
counterpart to mirror_clip_sectors().  Some of the conversion is
a bit tricky, requiring temporaries to convert between units; it
will be cleared up in a following patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: tweak mirror_clip_bytes() signature to match previous patch
---
 block/mirror.c | 64 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1a43304..1a4602a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -176,6 +176,15 @@ static void mirror_read_complete(void *opaque, int ret)
     aio_context_release(blk_get_aio_context(s->common.blk));
 }

+/* Clip bytes relative to offset to not exceed end-of-file */
+static inline int64_t mirror_clip_bytes(MirrorBlockJob *s,
+                                        int64_t offset,
+                                        int64_t bytes)
+{
+    return MIN(bytes, s->bdev_length - offset);
+}
+
+/* Clip nb_sectors relative to sector_num to not exceed end-of-file */
 static inline int mirror_clip_sectors(MirrorBlockJob *s,
                                       int64_t sector_num,
                                       int nb_sectors)
@@ -184,44 +193,39 @@ static inline int mirror_clip_sectors(MirrorBlockJob *s,
                s->bdev_length / BDRV_SECTOR_SIZE - sector_num);
 }

-/* Round sector_num and/or nb_sectors to target cluster if COW is needed, and
- * return the offset of the adjusted tail sector against original. */
-static int mirror_cow_align(MirrorBlockJob *s,
-                            int64_t *sector_num,
-                            int *nb_sectors)
+/* Round offset and/or bytes to target cluster if COW is needed, and
+ * return the offset of the adjusted tail against original. */
+static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
+                            unsigned int *bytes)
 {
     bool need_cow;
     int ret = 0;
-    int chunk_sectors = s->granularity >> BDRV_SECTOR_BITS;
-    int64_t align_sector_num = *sector_num;
-    int align_nb_sectors = *nb_sectors;
-    int max_sectors = chunk_sectors * s->max_iov;
+    int64_t align_offset = *offset;
+    unsigned int align_bytes = *bytes;
+    int max_bytes = s->granularity * s->max_iov;

-    need_cow = !test_bit(*sector_num / chunk_sectors, s->cow_bitmap);
-    need_cow |= !test_bit((*sector_num + *nb_sectors - 1) / chunk_sectors,
+    need_cow = !test_bit(*offset / s->granularity, s->cow_bitmap);
+    need_cow |= !test_bit((*offset + *bytes - 1) / s->granularity,
                           s->cow_bitmap);
     if (need_cow) {
-        bdrv_round_sectors_to_clusters(blk_bs(s->target), *sector_num,
-                                       *nb_sectors, &align_sector_num,
-                                       &align_nb_sectors);
+        bdrv_round_to_clusters(blk_bs(s->target), *offset, *bytes,
+                               &align_offset, &align_bytes);
     }

-    if (align_nb_sectors > max_sectors) {
-        align_nb_sectors = max_sectors;
+    if (align_bytes > max_bytes) {
+        align_bytes = max_bytes;
         if (need_cow) {
-            align_nb_sectors = QEMU_ALIGN_DOWN(align_nb_sectors,
-                                               s->target_cluster_size >>
-                                               BDRV_SECTOR_BITS);
+            align_bytes = QEMU_ALIGN_DOWN(align_bytes,
+                                          s->target_cluster_size);
         }
     }
-    /* Clipping may result in align_nb_sectors unaligned to chunk boundary, but
+    /* Clipping may result in align_bytes unaligned to chunk boundary, but
      * that doesn't matter because it's already the end of source image. */
-    align_nb_sectors = mirror_clip_sectors(s, align_sector_num,
-                                           align_nb_sectors);
+    align_bytes = mirror_clip_bytes(s, align_offset, align_bytes);

-    ret = align_sector_num + align_nb_sectors - (*sector_num + *nb_sectors);
-    *sector_num = align_sector_num;
-    *nb_sectors = align_nb_sectors;
+    ret = align_offset + align_bytes - (*offset + *bytes);
+    *offset = align_offset;
+    *bytes = align_bytes;
     assert(ret >= 0);
     return ret;
 }
@@ -257,10 +261,18 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
     nb_sectors = MIN(s->buf_size >> BDRV_SECTOR_BITS, nb_sectors);
     nb_sectors = MIN(max_sectors, nb_sectors);
     assert(nb_sectors);
+    assert(nb_sectors < BDRV_REQUEST_MAX_SECTORS);
     ret = nb_sectors;

     if (s->cow_bitmap) {
-        ret += mirror_cow_align(s, &sector_num, &nb_sectors);
+        int64_t offset = sector_num * BDRV_SECTOR_SIZE;
+        unsigned int bytes = nb_sectors * BDRV_SECTOR_SIZE;
+        int gap;
+
+        gap = mirror_cow_align(s, &offset, &bytes);
+        sector_num = offset / BDRV_SECTOR_SIZE;
+        nb_sectors = bytes / BDRV_SECTOR_SIZE;
+        ret += gap / BDRV_SECTOR_SIZE;
     }
     assert(nb_sectors << BDRV_SECTOR_BITS <= s->buf_size);
     /* The sector range must meet granularity because:
-- 
2.9.4
