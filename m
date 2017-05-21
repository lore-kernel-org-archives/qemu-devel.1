Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dCRk3-0007EJ-VA
	for qemu-devel@nongnu.org; Sun, 21 May 2017 10:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dCRk0-0005pE-PS
	for qemu-devel@nongnu.org; Sun, 21 May 2017 10:21:55 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Sun, 21 May 2017 17:21:46 +0300
Message-Id: <1495376506-13227-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] qcow2: handle cluster leak happening with
 a guest TRIM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

  qemu-img create -f qcow2 1.img 64G
  qemu-io -c "write -P 0x32 0 64k" 1.img
results in
  324 -rw-r--r-- 1 den den 393216 May 21 16:48 1.img
Subsequent
  qemu-io -c "write -z 0 64k" 1.img
  qemu-io -c "write -P 0x32 0 64k" 1.img
results in
  388 -rw-r--r-- 1 den den 458752 May 21 16:50 1.img
which looks like we have 1 cluster leaked.

Indeed, qcow2_co_pwrite_zeroes calls qcow2_zero_clusters/zero_single_l2,
which does not update refcount for the host cluster and keep the offset
as used. Later on handle_copied() does not take into account
QCOW2_CLUSTER_ZERO type of the cluster.

For now we comes into a very bad situation after qcow2_zero_cluster.
We have a hole in the host file and we have the offset allocated for
that guest cluster. Now there are 2 options:
1) allocate new offset once the write will come into this guest
   cluster (actually happens, but original cluster offset is leaked)
2) re-use host offset, i.e. fix handle_copied() to allow to reuse
   offset not only for QCOW2_CLUSTER_NORMAL but for QCOW2_CLUSTER_ZERO
   too
Option 2) seems worse to me as in this case we can easily have host
fragmentation in that cluster if writes will come in small pieces.

This is not a very big deal if we have filesystem with PUCH_HOLE support,
but without this feature the cluster is actually leaked forever.

The patch replaces zero_single_l2 with discard_single_l2 and removes
now unused zero_single_l2 to fix the situation.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 46 ++--------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 100398c..1e53a7c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1548,49 +1548,6 @@ fail:
     return ret;
 }
 
-/*
- * This zeroes as many clusters of nb_clusters as possible at once (i.e.
- * all clusters in the same L2 table) and returns the number of zeroed
- * clusters.
- */
-static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
-                          uint64_t nb_clusters, int flags)
-{
-    BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_table;
-    int l2_index;
-    int ret;
-    int i;
-
-    ret = get_cluster_table(bs, offset, &l2_table, &l2_index);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /* Limit nb_clusters to one L2 table */
-    nb_clusters = MIN(nb_clusters, s->l2_size - l2_index);
-    assert(nb_clusters <= INT_MAX);
-
-    for (i = 0; i < nb_clusters; i++) {
-        uint64_t old_offset;
-
-        old_offset = be64_to_cpu(l2_table[l2_index + i]);
-
-        /* Update L2 entries */
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
-        if (old_offset & QCOW_OFLAG_COMPRESSED || flags & BDRV_REQ_MAY_UNMAP) {
-            l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
-            qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
-        } else {
-            l2_table[l2_index + i] |= cpu_to_be64(QCOW_OFLAG_ZERO);
-        }
-    }
-
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
-
-    return nb_clusters;
-}
-
 int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
                         int flags)
 {
@@ -1609,7 +1566,8 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
     s->cache_discards = true;
 
     while (nb_clusters > 0) {
-        ret = zero_single_l2(bs, offset, nb_clusters, flags);
+        ret = discard_single_l2(bs, offset, nb_clusters,
+                                QCOW2_DISCARD_REQUEST, false);
         if (ret < 0) {
             goto fail;
         }
-- 
2.7.4
