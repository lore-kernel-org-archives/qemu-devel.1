Received: from eggs.gnu.org ([2001:4830:134:3::10]:38444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsKK-0006lD-FE
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsKJ-0001ph-78
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:22:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:21:05 +0200
Message-Id: <20170613202107.10125-15-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 14/16] block/qcow2: falloc/full
 preallocating growth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Implement the preallocation modes falloc and full for growing qcow2
images.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |   5 +++
 block/qcow2-refcount.c |  12 ++----
 block/qcow2.c          | 100 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index c216bf4..cf33e4e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -509,6 +509,11 @@ int qcow2_update_cluster_refcount(BlockDriverState *bs, int64_t cluster_index,
                                   uint64_t addend, bool decrease,
                                   enum qcow2_discard_type type);
 
+int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t offset,
+                            uint64_t additional_clusters, bool exact_size,
+                            int new_refblock_index,
+                            uint64_t new_refblock_offset);
+
 int64_t qcow2_alloc_clusters(BlockDriverState *bs, uint64_t size);
 int64_t qcow2_alloc_clusters_at(BlockDriverState *bs, uint64_t offset,
                                 int64_t nb_clusters);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 9d109e9..fcaa7ac 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -34,10 +34,6 @@ static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                             int64_t offset, int64_t length, uint64_t addend,
                             bool decrease, enum qcow2_discard_type type);
-static int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t offset,
-                                   uint64_t additional_clusters,
-                                   bool exact_size, int new_refblock_index,
-                                   uint64_t new_refblock_offset);
 
 static uint64_t get_refcount_ro0(const void *refcount_array, uint64_t index);
 static uint64_t get_refcount_ro1(const void *refcount_array, uint64_t index);
@@ -517,10 +513,10 @@ fail:
  * Returns: The offset after the new refcount structures (i.e. where the
  *          @additional_clusters may be placed) on success, -errno on error.
  */
-static int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
-                                   uint64_t additional_clusters,
-                                   bool exact_size, int new_refblock_index,
-                                   uint64_t new_refblock_offset)
+int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
+                            uint64_t additional_clusters, bool exact_size,
+                            int new_refblock_index,
+                            uint64_t new_refblock_offset)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t total_refblock_count_u64, additional_refblock_count;
diff --git a/block/qcow2.c b/block/qcow2.c
index 058f32e..daa71a4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2632,7 +2632,9 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
     int64_t new_l1_size;
     int ret;
 
-    if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_METADATA) {
+    if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_METADATA &&
+        prealloc != PREALLOC_MODE_FALLOC && prealloc != PREALLOC_MODE_FULL)
+    {
         error_setg(errp, "Unsupported preallocation mode '%s'",
                    PreallocMode_lookup[prealloc]);
         return -ENOTSUP;
@@ -2676,6 +2678,102 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         }
         break;
 
+    case PREALLOC_MODE_FALLOC:
+    case PREALLOC_MODE_FULL:
+    {
+        int64_t allocation_start, host_offset, guest_offset;
+        int64_t clusters_allocated;
+        int64_t old_file_size, new_file_size;
+        uint64_t nb_new_data_clusters, nb_new_l2_tables;
+
+        old_file_size = bdrv_getlength(bs->file->bs);
+        if (old_file_size < 0) {
+            error_setg_errno(errp, -old_file_size,
+                             "Failed to inquire current file length");
+            return ret;
+        }
+
+        nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
+                                            s->cluster_size);
+
+        /* This is an overestimation; we will not actually allocate space for
+         * these in the file but just make sure the new refcount structures are
+         * able to cover them so we will not have to allocate new refblocks
+         * while entering the data blocks in the potentially new L2 tables.
+         * (We do not actually care where the L2 tables are placed. Maybe they
+         *  are already allocated or they can be placed somewhere before
+         *  @old_file_size. It does not matter because they will be fully
+         *  allocated automatically, so they do not need to be covered by the
+         *  preallocation. All that matters is that we will not have to allocate
+         *  new refcount structures for them.) */
+        nb_new_l2_tables = DIV_ROUND_UP(nb_new_data_clusters,
+                                        s->cluster_size / sizeof(uint64_t));
+        /* The cluster range may not be aligned to L2 boundaries, so add one L2
+         * table for a potential head/tail */
+        nb_new_l2_tables++;
+
+        allocation_start = qcow2_refcount_area(bs, old_file_size,
+                                               nb_new_data_clusters +
+                                               nb_new_l2_tables,
+                                               true, 0, 0);
+        if (allocation_start < 0) {
+            error_setg_errno(errp, -allocation_start,
+                             "Failed to resize refcount structures");
+            return -allocation_start;
+        }
+
+        clusters_allocated = qcow2_alloc_clusters_at(bs, allocation_start,
+                                                     nb_new_data_clusters);
+        if (clusters_allocated < 0) {
+            error_setg_errno(errp, -clusters_allocated,
+                             "Failed to allocate data clusters");
+            return -clusters_allocated;
+        }
+
+        assert(clusters_allocated == nb_new_data_clusters);
+
+        /* Allocate the data area */
+        new_file_size = allocation_start +
+                        nb_new_data_clusters * s->cluster_size;
+        ret = bdrv_truncate(bs->file, new_file_size, prealloc, errp);
+        if (ret < 0) {
+            error_prepend(errp, "Failed to resize underlying file: ");
+            qcow2_free_clusters(bs, allocation_start,
+                                nb_new_data_clusters * s->cluster_size,
+                                QCOW2_DISCARD_OTHER);
+            return ret;
+        }
+
+        /* Create the necessary L2 entries */
+        host_offset = allocation_start;
+        guest_offset = old_length;
+        while (nb_new_data_clusters) {
+            int64_t guest_cluster = guest_offset >> s->cluster_bits;
+            int64_t nb_clusters = MIN(nb_new_data_clusters,
+                                      s->l2_size - guest_cluster % s->l2_size);
+            QCowL2Meta allocation = {
+                .offset       = guest_offset,
+                .alloc_offset = host_offset,
+                .nb_clusters  = nb_clusters,
+            };
+            qemu_co_queue_init(&allocation.dependent_requests);
+
+            ret = qcow2_alloc_cluster_link_l2(bs, &allocation);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to update L2 tables");
+                qcow2_free_clusters(bs, host_offset,
+                                    nb_new_data_clusters * s->cluster_size,
+                                    QCOW2_DISCARD_OTHER);
+                return ret;
+            }
+
+            guest_offset += nb_clusters * s->cluster_size;
+            host_offset += nb_clusters * s->cluster_size;
+            nb_new_data_clusters -= nb_clusters;
+        }
+        break;
+    }
+
     default:
         g_assert_not_reached();
     }
-- 
2.9.4
