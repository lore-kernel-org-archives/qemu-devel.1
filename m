Received: from eggs.gnu.org ([2001:4830:134:3::10]:45839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79iG-0002i0-6w
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79iD-0007ke-Rs
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat,  6 May 2017 19:05:47 -0500
Message-Id: <20170507000552.20847-8-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-1-eblake@redhat.com>
References: <20170507000552.20847-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v13 07/12] qcow2: Optimize zero_single_l2() to
 minimize L2 churn
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

Similar to discard_single_l2(), we should try to avoid dirtying
the L2 cache when the cluster we are changing already has the
right characteristics.

Note that by the time we get to zero_single_l2(), BDRV_REQ_MAY_UNMAP
is a requirement to unallocate a cluster (this is because the block
layer clears that flag if discard.* flags during open requested that
we never punch holes - see the conversation around commit 170f4b2e,
https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg07306.html).
Therefore, this patch can only reuse a zero cluster as-is if either
unmapping is not requested, or if the zero cluster was not associated
with an allocation.

Technically, there are some cases where an unallocated cluster
already reads as all zeroes (namely, when there is no backing file
[easy: check bs->backing], or when the backing file also reads as
zeroes [harder: we can't check bdrv_get_block_status since we are
already holding the lock]), where the guest would not immediately see
a difference if we left that cluster unallocated.  But if the user
did not request unmapping, leaving an unallocated cluster is wrong;
and even if the user DID request unmapping, keeping a cluster
unallocated risks a subtle semantic change of guest-visible contents
if a backing file is later added, and it is not worth auditing
whether all internal uses such as mirror properly avoid an unmap
request.  Thus, this patch is intentionally limited to just clusters
that are already marked as zero.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v13: use enum name
v12: store cluster type in temporary
v11: reserved for blkdebug half of v10
v10: new patch, replacing earlier attempt to use unallocated clusters,
and ditching any optimization of v2 files
---
 block/qcow2-cluster.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a4a3229..6c59708 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1601,6 +1601,7 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
     int l2_index;
     int ret;
     int i;
+    bool unmap = !!(flags & BDRV_REQ_MAY_UNMAP);

     ret = get_cluster_table(bs, offset, &l2_table, &l2_index);
     if (ret < 0) {
@@ -1613,12 +1614,22 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,

     for (i = 0; i < nb_clusters; i++) {
         uint64_t old_offset;
+        QCow2ClusterType cluster_type;

         old_offset = be64_to_cpu(l2_table[l2_index + i]);

-        /* Update L2 entries */
+        /*
+         * Minimize L2 changes if the cluster already reads back as
+         * zeroes with correct allocation.
+         */
+        cluster_type = qcow2_get_cluster_type(old_offset);
+        if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN ||
+            (cluster_type == QCOW2_CLUSTER_ZERO_ALLOC && !unmap)) {
+            continue;
+        }
+
         qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
-        if (old_offset & QCOW_OFLAG_COMPRESSED || flags & BDRV_REQ_MAY_UNMAP) {
+        if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
         } else {
-- 
2.9.3
