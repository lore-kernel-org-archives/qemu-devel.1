Received: from eggs.gnu.org ([2001:4830:134:3::10]:46412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR6-0005H9-2t
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR4-0005q2-FS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Apr 2017 20:17:06 -0500
Message-Id: <20170411011718.9152-2-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-1-eblake@redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 01/13] qcow2: Unallocate unmapped zero
 clusters if no backing file
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

'qemu-img map' already coalesces information about unallocated
clusters (those with status 0) and pure zero clusters (those
with status BDRV_BLOCK_ZERO and no offset).  Furthermore, all
qcow2 images with no backing file already report all unallocated
clusters (in the preallocation sense of clusters with no offset)
as BDRV_BLOCK_ZERO, regardless of whether the QCOW_OFLAG_ZERO was
set in that L2 entry (QCOW_OFLAG_ZERO also implies a return of
BDRV_BLOCK_ALLOCATED, but we intentionally do not expose that bit
to external users), thanks to generic block layer code in
bdrv_co_get_block_status().

So, for an image with no backing file, having bdrv_pwrite_zeroes
mark clusters as unallocated (defer to backing file) rather than
reads-as-zero (regardless of backing file) makes no difference
to normal behavior, but may potentially allow for fewer writes to
the L2 table of a freshly-created image where the L2 table is
initially written to all-zeroes (although I don't actually know
if we skip an L2 update and flush when re-writing the same
contents as already present).

Furthermore, this matches the behavior of discard_single_l2(), in
favoring an unallocated cluster over a zero cluster when full
discard is requested.

Meanwhile, version 2 qcow2 files (compat=0.10) lack support for an
explicit zero cluster.  This minor tweak therefore allows us to turn
write zeroes with unmap into an actual unallocation on those files,
where they used to return -ENOTSUP and cause an allocation due to
the fallback to explicitly written zeroes.

Note that technically, we _could_ write a cluster as unallocated
rather than zero if a backing file exists but the backing file
also reads as zero, but that's more expensive to determine, so
this optimization is limited to qcow2 without a backing file.

Also note that this patch unmaps a compressed cluster when there
is no backing file, even when BDRV_REQ_MAY_UNMAP was not set, but
it is unlikely to have compressed clusters in a fully preallocated
image (the point of compression is to reduce space requirements),
so the side effect of unmapping a cluster in that case is not
deemed to be a problem.

Finally, note that this change can create a subtle difference if a
backing file is later added with 'qemu-img rebase -u'; pre-patch,
a v3 file (compat=1.1) will have a cluster that still reads as 0
(the cluster is not allocated in the sense of preallocation, but
is provided from the layer), while post-patch the cluster will
now defer to the backing file - but it's already an unsupported
action if you are modifying guest-visible data by messing with
backing chains ;)

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v9: new patch
---
 block/qcow2-cluster.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 100398c..12f44b2 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1579,7 +1579,8 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
         /* Update L2 entries */
         qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
         if (old_offset & QCOW_OFLAG_COMPRESSED || flags & BDRV_REQ_MAY_UNMAP) {
-            l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
+            l2_table[l2_index + i] = bs->backing
+                ? cpu_to_be64(QCOW_OFLAG_ZERO) : 0;
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
         } else {
             l2_table[l2_index + i] |= cpu_to_be64(QCOW_OFLAG_ZERO);
@@ -1598,8 +1599,11 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
     uint64_t nb_clusters;
     int ret;

-    /* The zero flag is only supported by version 3 and newer */
-    if (s->qcow_version < 3) {
+    /* The zero flag is only supported by version 3 and newer; we
+     * require the use of that flag if there is a backing file or if
+     * we are not allowed to unmap.  */
+    if (s->qcow_version < 3 &&
+        (bs->backing || !(flags & BDRV_REQ_MAY_UNMAP))) {
         return -ENOTSUP;
     }

-- 
2.9.3
