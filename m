Received: from eggs.gnu.org ([2001:4830:134:3::10]:52638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677q-000366-6B
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677o-0001Lt-C9
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 May 2017 22:07:55 -0500
Message-Id: <20170504030755.1001-11-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-1-eblake@redhat.com>
References: <20170504030755.1001-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v12 10/10] qcow2: Discard/zero clusters by byte
 count
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

Passing a byte offset, but sector count, when we ultimately
want to operate on cluster granularity, is madness.  Clean up
the external interfaces to take both offset and count as bytes,
while still keeping the assertion added previously that the
caller must align the values to a cluster.  Then rename things
to make sure backports don't get confused by changed units:
instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
we now have qcow2_cluster_discard() and qcow2_cluster_zeroize().

The internal functions still operate on clusters at a time, and
return an int for number of cleared clusters; but on an image
with 2M clusters, a single L2 table holds 256k entries that each
represent a 2M cluster, totalling well over INT_MAX bytes if we
ever had a request for that many bytes at once.  All our callers
currently limit themselves to 32-bit bytes (and therefore fewer
clusters), but by making this function 64-bit clean, we have one
less place to clean up if we later improve the block layer to
support 64-bit bytes through all operations (with the block layer
auto-fragmenting on behalf of more-limited drivers), rather than
the current state where some interfaces are artificially limited
to INT_MAX at a time.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v12: minor tweaks suggested by Max
v11: reserved for blkdebug half of v10
v10: squash in fixup accounting for unaligned file end
v9: rebase to earlier changes, drop R-b
v7, v8: only earlier half of series submitted for 2.9
v6: rebase due to context
v5: s/count/byte/ to make the units obvious, and rework the math
to ensure no 32-bit integer overflow on large clusters
v4: improve function names, split assertion additions into earlier patch
[no v3 or v2]
v1: https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00339.html
---
 block/qcow2.h          |  9 +++++----
 block/qcow2-cluster.c  | 42 ++++++++++++++++++++++--------------------
 block/qcow2-snapshot.c |  7 +++----
 block/qcow2.c          | 22 +++++++++-------------
 4 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 142f81b..e150e2a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -551,10 +551,11 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
                                          int compressed_size);

 int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
-int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
-    int nb_sectors, enum qcow2_discard_type type, bool full_discard);
-int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
-                        int flags);
+int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
+                          uint64_t bytes, enum qcow2_discard_type type,
+                          bool full_discard);
+int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
+                          uint64_t bytes, int flags);

 int qcow2_expand_zero_clusters(BlockDriverState *bs,
                                BlockDriverAmendStatusCB *status_cb,
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 9aab6dd..a47ac9f 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1547,34 +1547,36 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
     return nb_clusters;
 }

-int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
-    int nb_sectors, enum qcow2_discard_type type, bool full_discard)
+int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
+                          uint64_t bytes, enum qcow2_discard_type type,
+                          bool full_discard)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t end_offset;
+    uint64_t end_offset = offset + bytes;
     uint64_t nb_clusters;
+    int64_t cleared;
     int ret;

-    end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);
-
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
            end_offset == bs->total_sectors << BDRV_SECTOR_BITS);

-    nb_clusters = size_to_clusters(s, end_offset - offset);
+    nb_clusters = size_to_clusters(s, bytes);

     s->cache_discards = true;

     /* Each L2 table is handled by its own loop iteration */
     while (nb_clusters > 0) {
-        ret = discard_single_l2(bs, offset, nb_clusters, type, full_discard);
-        if (ret < 0) {
+        cleared = discard_single_l2(bs, offset, nb_clusters, type,
+                                    full_discard);
+        if (cleared < 0) {
+            ret = cleared;
             goto fail;
         }

-        nb_clusters -= ret;
-        offset += (ret * s->cluster_size);
+        nb_clusters -= cleared;
+        offset += (cleared * s->cluster_size);
     }

     ret = 0;
@@ -1639,16 +1641,15 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
     return nb_clusters;
 }

-int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
-                        int flags)
+int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
+                          uint64_t bytes, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t end_offset;
+    uint64_t end_offset = offset + bytes;
     uint64_t nb_clusters;
+    int64_t cleared;
     int ret;

-    end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);
-
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
@@ -1660,18 +1661,19 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
     }

     /* Each L2 table is handled by its own loop iteration */
-    nb_clusters = size_to_clusters(s, nb_sectors << BDRV_SECTOR_BITS);
+    nb_clusters = size_to_clusters(s, bytes);

     s->cache_discards = true;

     while (nb_clusters > 0) {
-        ret = zero_single_l2(bs, offset, nb_clusters, flags);
-        if (ret < 0) {
+        cleared = zero_single_l2(bs, offset, nb_clusters, flags);
+        if (cleared < 0) {
+            ret = cleared;
             goto fail;
         }

-        nb_clusters -= ret;
-        offset += (ret * s->cluster_size);
+        nb_clusters -= cleared;
+        offset += (cleared * s->cluster_size);
     }

     ret = 0;
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 0324243..44243e0 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -440,10 +440,9 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)

     /* The VM state isn't needed any more in the active L1 table; in fact, it
      * hurts by causing expensive COW for the next snapshot. */
-    qcow2_discard_clusters(bs, qcow2_vm_state_offset(s),
-                           align_offset(sn->vm_state_size, s->cluster_size)
-                                >> BDRV_SECTOR_BITS,
-                           QCOW2_DISCARD_NEVER, false);
+    qcow2_cluster_discard(bs, qcow2_vm_state_offset(s),
+                          align_offset(sn->vm_state_size, s->cluster_size),
+                          QCOW2_DISCARD_NEVER, false);

 #ifdef DEBUG_ALLOC
     {
diff --git a/block/qcow2.c b/block/qcow2.c
index 3478bb6..ce571ea 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2512,7 +2512,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     trace_qcow2_pwrite_zeroes(qemu_coroutine_self(), offset, count);

     /* Whatever is left can use real zero clusters */
-    ret = qcow2_zero_clusters(bs, offset, count >> BDRV_SECTOR_BITS, flags);
+    ret = qcow2_cluster_zeroize(bs, offset, count, flags);
     qemu_co_mutex_unlock(&s->lock);

     return ret;
@@ -2535,8 +2535,8 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     }

     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_discard_clusters(bs, offset, count >> BDRV_SECTOR_BITS,
-                                 QCOW2_DISCARD_REQUEST, false);
+    ret = qcow2_cluster_discard(bs, offset, count, QCOW2_DISCARD_REQUEST,
+                                false);
     qemu_co_mutex_unlock(&s->lock);
     return ret;
 }
@@ -2843,9 +2843,8 @@ fail:
 static int qcow2_make_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t start_sector;
-    int sector_step = (QEMU_ALIGN_DOWN(INT_MAX, s->cluster_size) /
-                       BDRV_SECTOR_SIZE);
+    uint64_t offset, end_offset;
+    int step = QEMU_ALIGN_DOWN(INT_MAX, s->cluster_size);
     int l1_clusters, ret = 0;

     l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(uint64_t));
@@ -2862,18 +2861,15 @@ static int qcow2_make_empty(BlockDriverState *bs)

     /* This fallback code simply discards every active cluster; this is slow,
      * but works in all cases */
-    for (start_sector = 0; start_sector < bs->total_sectors;
-         start_sector += sector_step)
-    {
+    end_offset = bs->total_sectors * BDRV_SECTOR_SIZE;
+    for (offset = 0; offset < end_offset; offset += step) {
         /* As this function is generally used after committing an external
          * snapshot, QCOW2_DISCARD_SNAPSHOT seems appropriate. Also, the
          * default action for this kind of discard is to pass the discard,
          * which will ideally result in an actually smaller image file, as
          * is probably desired. */
-        ret = qcow2_discard_clusters(bs, start_sector * BDRV_SECTOR_SIZE,
-                                     MIN(sector_step,
-                                         bs->total_sectors - start_sector),
-                                     QCOW2_DISCARD_SNAPSHOT, true);
+        ret = qcow2_cluster_discard(bs, offset, MIN(step, end_offset - offset),
+                                    QCOW2_DISCARD_SNAPSHOT, true);
         if (ret < 0) {
             break;
         }
-- 
2.9.3
