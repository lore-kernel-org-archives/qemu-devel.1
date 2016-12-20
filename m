Received: from eggs.gnu.org ([2001:4830:134:3::10]:57594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJPsr-0007vB-U5
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cJPsq-0007Lr-97
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:15:33 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 20 Dec 2016 13:15:18 -0600
Message-Id: <20161220191523.5779-3-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-1-eblake@redhat.com>
References: <20161220191523.5779-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/7] qcow2: Discard/zero clusters by byte
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

Passing a byte offset, but sector count, when we ultimately
want to operate on cluster granularity, is madness.  Clean up
the interfaces to take both offset and count as bytes, while
still keeping the assertion added previously that the caller
must align the values to a cluster.  Then rename things to
make sure backports don't get confused by changed units:
instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
we now have qcow2_cluster_discard and qcow2_cluster_zeroize().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: improve function names, split assertion additions into earlier patch
[no v3 or v2]
v1: https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00339.html
---
 block/qcow2.h          |  9 +++++----
 block/qcow2-cluster.c  | 17 ++++++++---------
 block/qcow2-snapshot.c |  7 +++----
 block/qcow2.c          | 21 +++++++++------------
 4 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 1823414..a131b72 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -543,10 +543,11 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
                                          int compressed_size);

 int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
-int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
-    int nb_sectors, enum qcow2_discard_type type, bool full_discard);
-int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
-                        int flags);
+int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
+                          uint64_t count, enum qcow2_discard_type type,
+                          bool full_discard);
+int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
+                          uint64_t count, int flags);

 int qcow2_expand_zero_clusters(BlockDriverState *bs,
                                BlockDriverAmendStatusCB *status_cb,
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3304a15..aad5183 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1511,16 +1511,15 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
     return nb_clusters;
 }

-int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
-    int nb_sectors, enum qcow2_discard_type type, bool full_discard)
+int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
+                          uint64_t count, enum qcow2_discard_type type,
+                          bool full_discard)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t end_offset;
+    uint64_t end_offset = offset + count;
     uint64_t nb_clusters;
     int ret;

-    end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);
-
     /* Caller must pass aligned values */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size));
@@ -1591,8 +1590,8 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
     return nb_clusters;
 }

-int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
-                        int flags)
+int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
+                          uint64_t count, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t nb_clusters;
@@ -1600,7 +1599,7 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,

     /* Caller must pass aligned values */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(nb_sectors, s->cluster_size >> BDRV_SECTOR_BITS));
+    assert(QEMU_IS_ALIGNED(count, s->cluster_size));

     /* The zero flag is only supported by version 3 and newer */
     if (s->qcow_version < 3) {
@@ -1608,7 +1607,7 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
     }

     /* Each L2 table is handled by its own loop iteration */
-    nb_clusters = size_to_clusters(s, nb_sectors << BDRV_SECTOR_BITS);
+    nb_clusters = size_to_clusters(s, count);

     s->cache_discards = true;

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
index 96fb8a8..324e474 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2487,7 +2487,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     trace_qcow2_pwrite_zeroes(qemu_coroutine_self(), offset, count);

     /* Whatever is left can use real zero clusters */
-    ret = qcow2_zero_clusters(bs, offset, count >> BDRV_SECTOR_BITS, flags);
+    ret = qcow2_cluster_zeroize(bs, offset, count, flags);
     qemu_co_mutex_unlock(&s->lock);

     return ret;
@@ -2505,8 +2505,8 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     }

     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_discard_clusters(bs, offset, count >> BDRV_SECTOR_BITS,
-                                 QCOW2_DISCARD_REQUEST, false);
+    ret = qcow2_cluster_discard(bs, offset, count, QCOW2_DISCARD_REQUEST,
+                                false);
     qemu_co_mutex_unlock(&s->lock);
     return ret;
 }
@@ -2807,9 +2807,8 @@ fail:
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
@@ -2826,18 +2825,16 @@ static int qcow2_make_empty(BlockDriverState *bs)

     /* This fallback code simply discards every active cluster; this is slow,
      * but works in all cases */
-    for (start_sector = 0; start_sector < bs->total_sectors;
-         start_sector += sector_step)
+    end_offset = bs->total_sectors * BDRV_SECTOR_SIZE;
+    for (offset = 0; offset < end_offset; offset += step)
     {
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
