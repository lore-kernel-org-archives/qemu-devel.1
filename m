Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR6-0005HK-Af
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR5-0005qM-4X
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Apr 2017 20:17:11 -0500
Message-Id: <20170411011718.9152-7-eblake@redhat.com>
In-Reply-To: <20170411011718.9152-1-eblake@redhat.com>
References: <20170411011718.9152-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 06/13] qcow2: Assert that cluster operations
 are aligned
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

We already audited (in commit 0c1bd469) that qcow2_discard_clusters()
is only passed cluster-aligned start values; but we can further
tighten the assertion that the only unaligned end value is at EOF.

Recent commits have taken advantage of an unaligned tail cluster,
for both discard and write zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v9: rebase to master, by asserting that only tail cluster is unaligned
v7, v8: only earlier half of series submitted for 2.9
v6: avoid assertion on non-cluster-aligned image, use s->cluster_sectors
to avoid a shift, drop R-b
v5: no change
v4: new patch
---
 block/qcow2-cluster.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 12f44b2..362a855 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1519,11 +1519,10 @@ int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,

     end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);

-    /* The caller must cluster-align start; round end down except at EOF */
+    /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-    if (end_offset != bs->total_sectors * BDRV_SECTOR_SIZE) {
-        end_offset = start_of_cluster(s, end_offset);
-    }
+    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
+           end_offset == bs->total_sectors << BDRV_SECTOR_BITS);

     nb_clusters = size_to_clusters(s, end_offset - offset);

@@ -1596,9 +1595,17 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
                         int flags)
 {
     BDRVQcow2State *s = bs->opaque;
+    uint64_t end_offset;
     uint64_t nb_clusters;
     int ret;

+    end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);
+
+    /* Caller must pass aligned values, except at image end */
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
+           end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
+
     /* The zero flag is only supported by version 3 and newer; we
      * require the use of that flag if there is a backing file or if
      * we are not allowed to unmap.  */
-- 
2.9.3
