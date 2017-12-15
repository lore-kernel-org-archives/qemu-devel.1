Received: from eggs.gnu.org ([2001:4830:134:3::10]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVJ-0000YH-8i
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVF-0003N2-15
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:17 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:47 +0100
Message-Id: <c209a6903edc99329e9f8693851a180e33a80c75.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 19/32] qcow2: Update
 qcow2_alloc_cluster_link_l2() to support L2 slices
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

There's a loop in this function that iterates over the L2 entries in a
table, so now we need to assert that it remains within the limits of
an L2 slice.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f167bb6336..f8c22ca2be 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -931,7 +931,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
 {
     BDRVQcow2State *s = bs->opaque;
     int i, j = 0, l2_index, ret;
-    uint64_t *old_cluster, *l2_table;
+    uint64_t *old_cluster, *l2_slice;
     uint64_t cluster_offset = m->alloc_offset;
 
     trace_qcow2_cluster_link_l2(qemu_coroutine_self(), m->nb_clusters);
@@ -958,13 +958,13 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
                                    s->refcount_block_cache);
     }
 
-    ret = get_cluster_table(bs, m->offset, &l2_table, &l2_index);
+    ret = get_cluster_table(bs, m->offset, &l2_slice, &l2_index);
     if (ret < 0) {
         goto err;
     }
-    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
 
-    assert(l2_index + m->nb_clusters <= s->l2_size);
+    assert(l2_index + m->nb_clusters <= s->l2_slice_size);
     for (i = 0; i < m->nb_clusters; i++) {
         /* if two concurrent writes happen to the same unallocated cluster
          * each write allocates separate cluster and writes data concurrently.
@@ -972,16 +972,16 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
          * cluster the second one has to do RMW (which is done above by
          * perform_cow()), update l2 table with its cluster pointer and free
          * old cluster. This is what this loop does */
-        if (l2_table[l2_index + i] != 0) {
-            old_cluster[j++] = l2_table[l2_index + i];
+        if (l2_slice[l2_index + i] != 0) {
+            old_cluster[j++] = l2_slice[l2_index + i];
         }
 
-        l2_table[l2_index + i] = cpu_to_be64((cluster_offset +
+        l2_slice[l2_index + i] = cpu_to_be64((cluster_offset +
                     (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
      }
 
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     /*
      * If this was a COW, we need to decrease the refcount of the old cluster.
-- 
2.11.0
