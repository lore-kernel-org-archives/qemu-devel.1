Received: from eggs.gnu.org ([2001:4830:134:3::10]:55087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30K-0006zO-0n
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30I-000874-HH
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:11 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:36 -0500
Message-Id: <20170703151051.31327-3-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-1-eblake@redhat.com>
References: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 02/17] hbitmap: Rename
 serialization_granularity to serialization_align
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

The only client of hbitmap_serialization_granularity() is dirty-bitmap's
bdrv_dirty_bitmap_serialization_align().  Keeping the two names consistent
is worthwhile, and the shorter name is more representative of what the
function returns (the required alignment to be used for start/count of
other serialization functions, where violating the alignment causes
assertion failures).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 include/qemu/hbitmap.h |  8 ++++----
 block/dirty-bitmap.c   |  2 +-
 tests/test-hbitmap.c   | 10 +++++-----
 util/hbitmap.c         |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index d3a74a2..81e7804 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -159,16 +159,16 @@ bool hbitmap_get(const HBitmap *hb, uint64_t item);
 bool hbitmap_is_serializable(const HBitmap *hb);

 /**
- * hbitmap_serialization_granularity:
+ * hbitmap_serialization_align:
  * @hb: HBitmap to operate on.
  *
- * Granularity of serialization chunks, used by other serialization functions.
- * For every chunk:
+ * Required alignment of serialization chunks, used by other serialization
+ * functions. For every chunk:
  * 1. Chunk start should be aligned to this granularity.
  * 2. Chunk size should be aligned too, except for last chunk (for which
  *      start + count == hb->size)
  */
-uint64_t hbitmap_serialization_granularity(const HBitmap *hb);
+uint64_t hbitmap_serialization_align(const HBitmap *hb);

 /**
  * hbitmap_serialization_size:
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 30462d4..0490ca3 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -617,7 +617,7 @@ uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,

 uint64_t bdrv_dirty_bitmap_serialization_align(const BdrvDirtyBitmap *bitmap)
 {
-    return hbitmap_serialization_granularity(bitmap->bitmap);
+    return hbitmap_serialization_align(bitmap->bitmap);
 }

 void bdrv_dirty_bitmap_serialize_part(const BdrvDirtyBitmap *bitmap,
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 1acb353..af41642 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -738,15 +738,15 @@ static void test_hbitmap_meta_one(TestHBitmapData *data, const void *unused)
     }
 }

-static void test_hbitmap_serialize_granularity(TestHBitmapData *data,
-                                               const void *unused)
+static void test_hbitmap_serialize_align(TestHBitmapData *data,
+                                         const void *unused)
 {
     int r;

     hbitmap_test_init(data, L3 * 2, 3);
     g_assert(hbitmap_is_serializable(data->hb));

-    r = hbitmap_serialization_granularity(data->hb);
+    r = hbitmap_serialization_align(data->hb);
     g_assert_cmpint(r, ==, 64 << 3);
 }

@@ -974,8 +974,8 @@ int main(int argc, char **argv)
     hbitmap_test_add("/hbitmap/meta/word", test_hbitmap_meta_word);
     hbitmap_test_add("/hbitmap/meta/sector", test_hbitmap_meta_sector);

-    hbitmap_test_add("/hbitmap/serialize/granularity",
-                     test_hbitmap_serialize_granularity);
+    hbitmap_test_add("/hbitmap/serialize/align",
+                     test_hbitmap_serialize_align);
     hbitmap_test_add("/hbitmap/serialize/basic",
                      test_hbitmap_serialize_basic);
     hbitmap_test_add("/hbitmap/serialize/part",
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 21535cc..2f9d0fd 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -413,14 +413,14 @@ bool hbitmap_is_serializable(const HBitmap *hb)
 {
     /* Every serialized chunk must be aligned to 64 bits so that endianness
      * requirements can be fulfilled on both 64 bit and 32 bit hosts.
-     * We have hbitmap_serialization_granularity() which converts this
+     * We have hbitmap_serialization_align() which converts this
      * alignment requirement from bitmap bits to items covered (e.g. sectors).
      * That value is:
      *    64 << hb->granularity
      * Since this value must not exceed UINT64_MAX, hb->granularity must be
      * less than 58 (== 64 - 6, where 6 is ld(64), i.e. 1 << 6 == 64).
      *
-     * In order for hbitmap_serialization_granularity() to always return a
+     * In order for hbitmap_serialization_align() to always return a
      * meaningful value, bitmaps that are to be serialized must have a
      * granularity of less than 58. */

@@ -437,7 +437,7 @@ bool hbitmap_get(const HBitmap *hb, uint64_t item)
     return (hb->levels[HBITMAP_LEVELS - 1][pos >> BITS_PER_LEVEL] & bit) != 0;
 }

-uint64_t hbitmap_serialization_granularity(const HBitmap *hb)
+uint64_t hbitmap_serialization_align(const HBitmap *hb)
 {
     assert(hbitmap_is_serializable(hb));

@@ -454,7 +454,7 @@ static void serialization_chunk(const HBitmap *hb,
                                 unsigned long **first_el, uint64_t *el_count)
 {
     uint64_t last = start + count - 1;
-    uint64_t gran = hbitmap_serialization_granularity(hb);
+    uint64_t gran = hbitmap_serialization_align(hb);

     assert((start & (gran - 1)) == 0);
     assert((last >> hb->granularity) < hb->size);
-- 
2.9.4
