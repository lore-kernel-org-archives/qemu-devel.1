Received: from eggs.gnu.org ([2001:4830:134:3::10]:37836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBK-0003DS-Ti
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBJ-0008Qt-3H
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:54 +0200
Message-Id: <1494513181-7900-52-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 51/58] qcow2: Make distinction between zero
 cluster types obvious
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Treat plain zero clusters differently from allocated ones, so that
we can simplify the logic of checking whether an offset is present.
Do this by splitting QCOW2_CLUSTER_ZERO into two new enums,
QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC.

I tried to arrange the enum so that we could use
'ret <= QCOW2_CLUSTER_ZERO_PLAIN' for all unallocated types, and
'ret >= QCOW2_CLUSTER_ZERO_ALLOC' for allocated types, although
I didn't actually end up taking advantage of the layout.

In many cases, this leads to simpler code, by properly combining
cases (sometimes, both zero types pair together, other times,
plain zero is more like unallocated while allocated zero is more
like normal).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170507000552.20847-7-eblake@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c      | 79 ++++++++++++++++++----------------------------
 block/qcow2-refcount.c     | 44 +++++++++++---------------
 block/qcow2.c              |  9 ++++--
 block/qcow2.h              |  8 +++--
 tests/qemu-iotests/060.out |  6 ++--
 5 files changed, 63 insertions(+), 83 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 26f9e0e..558c239 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -321,8 +321,7 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
     /* must be allocated */
     first_cluster_type = qcow2_get_cluster_type(first_entry);
     assert(first_cluster_type == QCOW2_CLUSTER_NORMAL ||
-           (first_cluster_type == QCOW2_CLUSTER_ZERO &&
-            (first_entry & L2E_OFFSET_MASK) != 0));
+           first_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
 
     for (i = 0; i < nb_clusters; i++) {
         uint64_t l2_entry = be64_to_cpu(l2_table[i]) & mask;
@@ -344,13 +343,13 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
 {
     int i;
 
-    assert(wanted_type == QCOW2_CLUSTER_ZERO ||
+    assert(wanted_type == QCOW2_CLUSTER_ZERO_PLAIN ||
            wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
         uint64_t entry = be64_to_cpu(l2_table[i]);
         QCow2ClusterType type = qcow2_get_cluster_type(entry);
 
-        if (type != wanted_type || entry & L2E_OFFSET_MASK) {
+        if (type != wanted_type) {
             break;
         }
     }
@@ -559,55 +558,36 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     assert(nb_clusters <= INT_MAX);
 
     type = qcow2_get_cluster_type(*cluster_offset);
+    if (s->qcow_version < 3 && (type == QCOW2_CLUSTER_ZERO_PLAIN ||
+                                type == QCOW2_CLUSTER_ZERO_ALLOC)) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
+                                " in pre-v3 image (L2 offset: %#" PRIx64
+                                ", L2 index: %#x)", l2_offset, l2_index);
+        ret = -EIO;
+        goto fail;
+    }
     switch (type) {
     case QCOW2_CLUSTER_COMPRESSED:
         /* Compressed clusters can only be processed one by one */
         c = 1;
         *cluster_offset &= L2E_COMPRESSED_OFFSET_SIZE_MASK;
         break;
-    case QCOW2_CLUSTER_ZERO:
-        if (s->qcow_version < 3) {
-            qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
-                                    " in pre-v3 image (L2 offset: %#" PRIx64
-                                    ", L2 index: %#x)", l2_offset, l2_index);
-            ret = -EIO;
-            goto fail;
-        }
-        /* Distinguish between pure zero clusters and pre-allocated ones */
-        if (*cluster_offset & L2E_OFFSET_MASK) {
-            c = count_contiguous_clusters(nb_clusters, s->cluster_size,
-                                          &l2_table[l2_index], QCOW_OFLAG_ZERO);
-            *cluster_offset &= L2E_OFFSET_MASK;
-            if (offset_into_cluster(s, *cluster_offset)) {
-                qcow2_signal_corruption(bs, true, -1, -1,
-                                        "Preallocated zero cluster offset %#"
-                                        PRIx64 " unaligned (L2 offset: %#"
-                                        PRIx64 ", L2 index: %#x)",
-                                        *cluster_offset, l2_offset, l2_index);
-                ret = -EIO;
-                goto fail;
-            }
-        } else {
-            c = count_contiguous_clusters_unallocated(nb_clusters,
-                                                      &l2_table[l2_index],
-                                                      QCOW2_CLUSTER_ZERO);
-            *cluster_offset = 0;
-        }
-        break;
+    case QCOW2_CLUSTER_ZERO_PLAIN:
     case QCOW2_CLUSTER_UNALLOCATED:
         /* how many empty clusters ? */
         c = count_contiguous_clusters_unallocated(nb_clusters,
-                                                  &l2_table[l2_index],
-                                                  QCOW2_CLUSTER_UNALLOCATED);
+                                                  &l2_table[l2_index], type);
         *cluster_offset = 0;
         break;
+    case QCOW2_CLUSTER_ZERO_ALLOC:
     case QCOW2_CLUSTER_NORMAL:
         /* how many allocated clusters ? */
         c = count_contiguous_clusters(nb_clusters, s->cluster_size,
-                &l2_table[l2_index], QCOW_OFLAG_ZERO);
+                                      &l2_table[l2_index], QCOW_OFLAG_ZERO);
         *cluster_offset &= L2E_OFFSET_MASK;
         if (offset_into_cluster(s, *cluster_offset)) {
-            qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offset %#"
+            qcow2_signal_corruption(bs, true, -1, -1,
+                                    "Cluster allocation offset %#"
                                     PRIx64 " unaligned (L2 offset: %#" PRIx64
                                     ", L2 index: %#x)", *cluster_offset,
                                     l2_offset, l2_index);
@@ -902,7 +882,8 @@ static int count_cow_clusters(BDRVQcow2State *s, int nb_clusters,
             break;
         case QCOW2_CLUSTER_UNALLOCATED:
         case QCOW2_CLUSTER_COMPRESSED:
-        case QCOW2_CLUSTER_ZERO:
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
             break;
         default:
             abort();
@@ -1203,8 +1184,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
      * wrong with our code. */
     assert(nb_clusters > 0);
 
-    if (qcow2_get_cluster_type(entry) == QCOW2_CLUSTER_ZERO &&
-        (entry & L2E_OFFSET_MASK) != 0 && (entry & QCOW_OFLAG_COPIED) &&
+    if (qcow2_get_cluster_type(entry) == QCOW2_CLUSTER_ZERO_ALLOC &&
+        (entry & QCOW_OFLAG_COPIED) &&
         (!*host_offset ||
          start_of_cluster(s, *host_offset) == (entry & L2E_OFFSET_MASK)))
     {
@@ -1536,13 +1517,13 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
             }
             break;
 
-        case QCOW2_CLUSTER_ZERO:
-            /* Preallocated zero clusters should be discarded in any case */
-            if (!full_discard && (old_l2_entry & L2E_OFFSET_MASK) == 0) {
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+            if (!full_discard) {
                 continue;
             }
             break;
 
+        case QCOW2_CLUSTER_ZERO_ALLOC:
         case QCOW2_CLUSTER_NORMAL:
         case QCOW2_CLUSTER_COMPRESSED:
             break;
@@ -1759,13 +1740,13 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             uint64_t l2_entry = be64_to_cpu(l2_table[j]);
             int64_t offset = l2_entry & L2E_OFFSET_MASK;
             QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
-            bool preallocated = offset != 0;
 
-            if (cluster_type != QCOW2_CLUSTER_ZERO) {
+            if (cluster_type != QCOW2_CLUSTER_ZERO_PLAIN &&
+                cluster_type != QCOW2_CLUSTER_ZERO_ALLOC) {
                 continue;
             }
 
-            if (!preallocated) {
+            if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                 if (!bs->backing) {
                     /* not backed; therefore we can simply deallocate the
                      * cluster */
@@ -1800,7 +1781,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                                         "%#" PRIx64 " unaligned (L2 offset: %#"
                                         PRIx64 ", L2 index: %#x)", offset,
                                         l2_offset, j);
-                if (!preallocated) {
+                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     qcow2_free_clusters(bs, offset, s->cluster_size,
                                         QCOW2_DISCARD_ALWAYS);
                 }
@@ -1810,7 +1791,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 
             ret = qcow2_pre_write_overlap_check(bs, 0, offset, s->cluster_size);
             if (ret < 0) {
-                if (!preallocated) {
+                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     qcow2_free_clusters(bs, offset, s->cluster_size,
                                         QCOW2_DISCARD_ALWAYS);
                 }
@@ -1819,7 +1800,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 
             ret = bdrv_pwrite_zeroes(bs->file, offset, s->cluster_size, 0);
             if (ret < 0) {
-                if (!preallocated) {
+                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     qcow2_free_clusters(bs, offset, s->cluster_size,
                                         QCOW2_DISCARD_ALWAYS);
                 }
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e639b34..7c06061 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1028,18 +1028,17 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
         }
         break;
     case QCOW2_CLUSTER_NORMAL:
-    case QCOW2_CLUSTER_ZERO:
-        if (l2_entry & L2E_OFFSET_MASK) {
-            if (offset_into_cluster(s, l2_entry & L2E_OFFSET_MASK)) {
-                qcow2_signal_corruption(bs, false, -1, -1,
-                                        "Cannot free unaligned cluster %#llx",
-                                        l2_entry & L2E_OFFSET_MASK);
-            } else {
-                qcow2_free_clusters(bs, l2_entry & L2E_OFFSET_MASK,
-                                    nb_clusters << s->cluster_bits, type);
-            }
+    case QCOW2_CLUSTER_ZERO_ALLOC:
+        if (offset_into_cluster(s, l2_entry & L2E_OFFSET_MASK)) {
+            qcow2_signal_corruption(bs, false, -1, -1,
+                                    "Cannot free unaligned cluster %#llx",
+                                    l2_entry & L2E_OFFSET_MASK);
+        } else {
+            qcow2_free_clusters(bs, l2_entry & L2E_OFFSET_MASK,
+                                nb_clusters << s->cluster_bits, type);
         }
         break;
+    case QCOW2_CLUSTER_ZERO_PLAIN:
     case QCOW2_CLUSTER_UNALLOCATED:
         break;
     default:
@@ -1145,10 +1144,10 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     break;
 
                 case QCOW2_CLUSTER_NORMAL:
-                case QCOW2_CLUSTER_ZERO:
+                case QCOW2_CLUSTER_ZERO_ALLOC:
                     if (offset_into_cluster(s, offset)) {
-                        qcow2_signal_corruption(bs, true, -1, -1, "Data "
-                                                "cluster offset %#" PRIx64
+                        qcow2_signal_corruption(bs, true, -1, -1, "Cluster "
+                                                "allocation offset %#" PRIx64
                                                 " unaligned (L2 offset: %#"
                                                 PRIx64 ", L2 index: %#x)",
                                                 offset, l2_offset, j);
@@ -1157,11 +1156,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     }
 
                     cluster_index = offset >> s->cluster_bits;
-                    if (!cluster_index) {
-                        /* unallocated */
-                        refcount = 0;
-                        break;
-                    }
+                    assert(cluster_index);
                     if (addend != 0) {
                         ret = qcow2_update_cluster_refcount(bs,
                                     cluster_index, abs(addend), addend < 0,
@@ -1177,6 +1172,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     }
                     break;
 
+                case QCOW2_CLUSTER_ZERO_PLAIN:
                 case QCOW2_CLUSTER_UNALLOCATED:
                     refcount = 0;
                     break;
@@ -1443,12 +1439,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             }
             break;
 
-        case QCOW2_CLUSTER_ZERO:
-            if ((l2_entry & L2E_OFFSET_MASK) == 0) {
-                break;
-            }
-            /* fall through */
-
+        case QCOW2_CLUSTER_ZERO_ALLOC:
         case QCOW2_CLUSTER_NORMAL:
         {
             uint64_t offset = l2_entry & L2E_OFFSET_MASK;
@@ -1478,6 +1469,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             break;
         }
 
+        case QCOW2_CLUSTER_ZERO_PLAIN:
         case QCOW2_CLUSTER_UNALLOCATED:
             break;
 
@@ -1642,8 +1634,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             uint64_t data_offset = l2_entry & L2E_OFFSET_MASK;
             QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
 
-            if ((cluster_type == QCOW2_CLUSTER_NORMAL) ||
-                ((cluster_type == QCOW2_CLUSTER_ZERO) && (data_offset != 0))) {
+            if (cluster_type == QCOW2_CLUSTER_NORMAL ||
+                cluster_type == QCOW2_CLUSTER_ZERO_ALLOC) {
                 ret = qcow2_get_refcount(bs,
                                          data_offset >> s->cluster_bits,
                                          &refcount);
diff --git a/block/qcow2.c b/block/qcow2.c
index 8caf800..3fa62b0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1385,7 +1385,7 @@ static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
         *file = bs->file->bs;
         status |= BDRV_BLOCK_OFFSET_VALID | cluster_offset;
     }
-    if (ret == QCOW2_CLUSTER_ZERO) {
+    if (ret == QCOW2_CLUSTER_ZERO_PLAIN || ret == QCOW2_CLUSTER_ZERO_ALLOC) {
         status |= BDRV_BLOCK_ZERO;
     } else if (ret != QCOW2_CLUSTER_UNALLOCATED) {
         status |= BDRV_BLOCK_DATA;
@@ -1482,7 +1482,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             }
             break;
 
-        case QCOW2_CLUSTER_ZERO:
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
             qemu_iovec_memset(&hd_qiov, 0, 0, cur_bytes);
             break;
 
@@ -2491,7 +2492,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         count = s->cluster_size;
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
-        if (ret != QCOW2_CLUSTER_UNALLOCATED && ret != QCOW2_CLUSTER_ZERO) {
+        if (ret != QCOW2_CLUSTER_UNALLOCATED &&
+            ret != QCOW2_CLUSTER_ZERO_PLAIN &&
+            ret != QCOW2_CLUSTER_ZERO_ALLOC) {
             qemu_co_mutex_unlock(&s->lock);
             return -ENOTSUP;
         }
diff --git a/block/qcow2.h b/block/qcow2.h
index c148bbc..810ceb8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -351,9 +351,10 @@ typedef struct QCowL2Meta
 
 typedef enum QCow2ClusterType {
     QCOW2_CLUSTER_UNALLOCATED,
+    QCOW2_CLUSTER_ZERO_PLAIN,
+    QCOW2_CLUSTER_ZERO_ALLOC,
     QCOW2_CLUSTER_NORMAL,
     QCOW2_CLUSTER_COMPRESSED,
-    QCOW2_CLUSTER_ZERO
 } QCow2ClusterType;
 
 typedef enum QCow2MetadataOverlap {
@@ -448,7 +449,10 @@ static inline QCow2ClusterType qcow2_get_cluster_type(uint64_t l2_entry)
     if (l2_entry & QCOW_OFLAG_COMPRESSED) {
         return QCOW2_CLUSTER_COMPRESSED;
     } else if (l2_entry & QCOW_OFLAG_ZERO) {
-        return QCOW2_CLUSTER_ZERO;
+        if (l2_entry & L2E_OFFSET_MASK) {
+            return QCOW2_CLUSTER_ZERO_ALLOC;
+        }
+        return QCOW2_CLUSTER_ZERO_PLAIN;
     } else if (!(l2_entry & L2E_OFFSET_MASK)) {
         return QCOW2_CLUSTER_UNALLOCATED;
     } else {
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 5d40206..9e8f5b9 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -135,7 +135,7 @@ qemu-img: Error while amending options: Input/output error
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qcow2: Marking image as corrupt: Data cluster offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
 read failed: Input/output error
 
 === Testing unaligned pre-allocated zero cluster ===
@@ -166,7 +166,7 @@ discard 65536/65536 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qcow2: Image is corrupt: Data cluster offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further non-fatal corruption events will be suppressed
+qcow2: Image is corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further non-fatal corruption events will be suppressed
 read failed: Input/output error
 read failed: Input/output error
 
@@ -176,7 +176,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Image is corrupt: Cannot free unaligned cluster 0x52a00; further non-fatal corruption events will be suppressed
-qcow2: Marking image as corrupt: Data cluster offset 0x62a00 unaligned (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Cluster allocation offset 0x62a00 unaligned (L2 offset: 0x40000, L2 index: 0x1); further corruption events will be suppressed
 discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read failed: Input/output error
-- 
1.8.3.1
