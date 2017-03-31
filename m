Received: from eggs.gnu.org ([2001:4830:134:3::10]:42034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu1gV-0002zB-Cq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu1gU-00071Y-Gz
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 14:54:07 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 31 Mar 2017 13:53:55 -0500
Message-Id: <20170331185356.2479-3-eblake@redhat.com>
In-Reply-To: <20170331185356.2479-1-eblake@redhat.com>
References: <20170331185356.2479-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v8 2/3] qcow2: Discard unaligned tail when
 wiping image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

There is a subtle difference between the fast (qcow2v3 with no
extra data) and slow path (qcow2v2 format [aka 0.10], or when a
snapshot is present) of qcow2_make_empty().  The slow path fails
to discard the final (partial) cluster of an unaligned image.

The problem stems from the fact that qcow2_discard_clusters() was
silently ignoring sub-cluster head and tail on unaligned requests.
A quick audit of all callers shows that qcow2_snapshot_create() has
always passed a cluster-aligned request since the call was added
in commit 1ebf561; qcow2_co_pdiscard() has passed a cluster-aligned
request since commit ecdbead taught the block layer about preferred
discard alignment; and qcow2_make_empty() was fixed to pass an
aligned start (but not necessarily end) in commit a3e1505.

Asserting that the start is always aligned also points out that we
now have a dead check: rounding the end offset down can never result
in a value less than the aligned start offset (the check was rendered
dead with commit ecdbead).  Meanwhile, we do not want to round the
end cluster down in the one case of the end offset matching the
(unaligned) file size - that final partial cluster should still be
discarded.

With those fixes in place, the fast and slow paths are back in sync
at discarding an entire image; the next patch will update
qemu-iotests to ensure we don't regress.

Note that bdrv_co_pdiscard ignores ALL partial cluster requests,
including the partial cluster at the end of an image; it can be
argued that the partial cluster at the end should be special-cased
so that a guest issuing discard requests at proper alignments
everywhere else can likewise empty the entire image.  But that
optimization is left for another day.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v8: swap patch order
v7: new patch
---
 block/qcow2-cluster.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 78c11d4..100398c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1519,12 +1519,10 @@ int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,

     end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);

-    /* Round start up and end down */
-    offset = align_offset(offset, s->cluster_size);
-    end_offset = start_of_cluster(s, end_offset);
-
-    if (offset > end_offset) {
-        return 0;
+    /* The caller must cluster-align start; round end down except at EOF */
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    if (end_offset != bs->total_sectors * BDRV_SECTOR_SIZE) {
+        end_offset = start_of_cluster(s, end_offset);
     }

     nb_clusters = size_to_clusters(s, end_offset - offset);
-- 
2.9.3
