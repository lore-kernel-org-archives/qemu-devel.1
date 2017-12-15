Received: from eggs.gnu.org ([2001:4830:134:3::10]:55393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WV-Gt
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVB-0003GK-QA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:43 +0100
Message-Id: <967bbc1a89d1d7afd169350c5e61da19ee0166ec.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 15/32] qcow2: Update l2_load() to support L2
 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

Each entry in the qcow2 L2 cache stores a full L2 table (which uses a
complete cluster in the qcow2 image). A cluster is usually too large
to be used efficiently as the size for a cache entry, so we want to
decouple both values by allowing smaller cache entries. Therefore the
qcow2 L2 cache will no longer return full L2 tables but slices
instead.

This patch updates l2_load() so it can handle L2 slices correctly.
Apart from the offset of the L2 table (which we already had) we also
need the guest offset in order to calculate which one of the slices
we need.

An L2 slice has currently the same size as an L2 table (one cluster),
so for now this function will load exactly the same data as before.

This patch also removes a stale comment about the return value being
a pointer to the L2 table. This function returns an error code since
55c17e9821c474d5fcdebdc82ed2fc096777d611.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 6369a74efe..8d92d623d8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -196,20 +196,26 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
 /*
  * l2_load
  *
- * Loads a L2 table into memory. If the table is in the cache, the cache
- * is used; otherwise the L2 table is loaded from the image file.
+ * @bs: The BlockDriverState
+ * @offset: A guest offset, used to calculate what slice of the L2
+ *          table to load.
+ * @l2_offset: Offset to the L2 table in the image file.
+ * @l2_slice: Location to store the pointer to the L2 slice.
  *
- * Returns a pointer to the L2 table on success, or NULL if the read from
- * the image file failed.
+ * Loads a L2 slice into memory (L2 slices are the parts of L2 tables
+ * that are loaded by the qcow2 cache). If the slice is in the cache,
+ * the cache is used; otherwise the L2 slice is loaded from the image
+ * file.
  */
-
-static int l2_load(BlockDriverState *bs, uint64_t l2_offset,
-    uint64_t **l2_table)
+static int l2_load(BlockDriverState *bs, uint64_t offset,
+                   uint64_t l2_offset, uint64_t **l2_slice)
 {
     BDRVQcow2State *s = bs->opaque;
+    int start_of_slice = sizeof(uint64_t) *
+        (offset_to_l2_index(s, offset) - offset_to_l2_slice_index(s, offset));
 
-    return qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
-                           (void **)l2_table);
+    return qcow2_cache_get(bs, s->l2_table_cache, l2_offset + start_of_slice,
+                           (void **)l2_slice);
 }
 
 /*
@@ -562,7 +568,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     /* load the l2 table in memory */
 
-    ret = l2_load(bs, l2_offset, &l2_table);
+    ret = l2_load(bs, offset, l2_offset, &l2_table);
     if (ret < 0) {
         return ret;
     }
@@ -685,7 +691,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
     if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
         /* load the l2 table in memory */
-        ret = l2_load(bs, l2_offset, &l2_table);
+        ret = l2_load(bs, offset, l2_offset, &l2_table);
         if (ret < 0) {
             return ret;
         }
-- 
2.11.0
