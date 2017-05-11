Received: from eggs.gnu.org ([2001:4830:134:3::10]:37975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBP-0003Kt-ID
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBL-0008TJ-Dn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:55 +0200
Message-Id: <1494513181-7900-53-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 52/58] qcow2: Optimize zero_single_l2() to
 minimize L2 churn
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
Message-id: 20170507000552.20847-8-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 558c239..e2c5759 100644
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
1.8.3.1
