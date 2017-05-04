Received: from eggs.gnu.org ([2001:4830:134:3::10]:52544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677k-0002xf-5B
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677i-0001Hl-DI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 May 2017 22:07:49 -0500
Message-Id: <20170504030755.1001-5-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-1-eblake@redhat.com>
References: <20170504030755.1001-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v12 04/10] qcow2: Make distinction between zero
 cluster types obvious
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

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

---
v12: new patch
---
 block/qcow2.h          |  8 +++++--
 block/qcow2-cluster.c  | 65 ++++++++++++++++++--------------------------------
 block/qcow2-refcount.c | 40 +++++++++++++------------------
 block/qcow2.c          |  9 ++++---
 4 files changed, 51 insertions(+), 71 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8731f24..142f81b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -351,9 +351,10 @@ typedef struct QCowL2Meta

 enum {
     QCOW2_CLUSTER_UNALLOCATED,
+    QCOW2_CLUSTER_ZERO_PLAIN,
+    QCOW2_CLUSTER_ZERO_ALLOC,
     QCOW2_CLUSTER_NORMAL,
     QCOW2_CLUSTER_COMPRESSED,
-    QCOW2_CLUSTER_ZERO
 };

 typedef enum QCow2MetadataOverlap {
@@ -448,7 +449,10 @@ static inline int qcow2_get_cluster_type(uint64_t l2_entry)
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
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f3bfce6..14e2086 100644
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
@@ -344,7 +343,7 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
 {
     int i;

-    assert(wanted_type == QCOW2_CLUSTER_ZERO ||
+    assert(wanted_type == QCOW2_CLUSTER_ZERO_PLAIN ||
            wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
         uint64_t entry = be64_to_cpu(l2_table[i]);
@@ -558,52 +557,32 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     assert(nb_clusters <= INT_MAX);

     ret = qcow2_get_cluster_type(*cluster_offset);
+    if (s->qcow_version < 3 && (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
+                                ret == QCOW2_CLUSTER_ZERO_ALLOC)) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry found"
+                                " in pre-v3 image (L2 offset: %#" PRIx64
+                                ", L2 index: %#x)", l2_offset, l2_index);
+        ret = -EIO;
+        goto fail;
+    }
     switch (ret) {
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
+                                                  &l2_table[l2_index], ret);
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
             qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offset %#"
@@ -901,7 +880,8 @@ static int count_cow_clusters(BDRVQcow2State *s, int nb_clusters,
             break;
         case QCOW2_CLUSTER_UNALLOCATED:
         case QCOW2_CLUSTER_COMPRESSED:
-        case QCOW2_CLUSTER_ZERO:
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
             break;
         default:
             abort();
@@ -1202,8 +1182,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
      * wrong with our code. */
     assert(nb_clusters > 0);

-    if (qcow2_get_cluster_type(entry) == QCOW2_CLUSTER_ZERO &&
-        (entry & L2E_OFFSET_MASK) != 0 && (entry & QCOW_OFLAG_COPIED) &&
+    if (qcow2_get_cluster_type(entry) == QCOW2_CLUSTER_ZERO_ALLOC &&
+        (entry & QCOW_OFLAG_COPIED) &&
         (!*host_offset ||
          start_of_cluster(s, *host_offset) == (entry & L2E_OFFSET_MASK)))
     {
@@ -1535,13 +1515,13 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
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
@@ -1760,7 +1740,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             int cluster_type = qcow2_get_cluster_type(l2_entry);
             bool preallocated = offset != 0;

-            if (cluster_type != QCOW2_CLUSTER_ZERO) {
+            if (cluster_type != QCOW2_CLUSTER_ZERO_PLAIN &&
+                cluster_type != QCOW2_CLUSTER_ZERO_ALLOC) {
                 continue;
             }

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index a5a0076..fa2ea05 100644
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
@@ -1144,7 +1143,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     break;

                 case QCOW2_CLUSTER_NORMAL:
-                case QCOW2_CLUSTER_ZERO:
+                case QCOW2_CLUSTER_ZERO_ALLOC:
                     if (offset_into_cluster(s, offset_masked)) {
                         qcow2_signal_corruption(bs, true, -1, -1, "Data "
                                                 "cluster offset %#" PRIx64
@@ -1157,11 +1156,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     }

                     cluster_index = offset_masked >> s->cluster_bits;
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
             int cluster_type = qcow2_get_cluster_type(l2_entry);

-            if ((cluster_type == QCOW2_CLUSTER_NORMAL) ||
-                ((cluster_type == QCOW2_CLUSTER_ZERO) && (data_offset != 0))) {
+            if (cluster_type == QCOW2_CLUSTER_NORMAL ||
+                cluster_type == QCOW2_CLUSTER_ZERO_ALLOC) {
                 ret = qcow2_get_refcount(bs,
                                          data_offset >> s->cluster_bits,
                                          &refcount);
diff --git a/block/qcow2.c b/block/qcow2.c
index f5a72a4..dded5a0 100644
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
-- 
2.9.3
