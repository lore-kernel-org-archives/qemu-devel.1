Received: from eggs.gnu.org ([2001:4830:134:3::10]:45882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79iI-0002kJ-9D
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79iH-0007lv-AT
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:14 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat,  6 May 2017 19:05:51 -0500
Message-Id: <20170507000552.20847-12-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-1-eblake@redhat.com>
References: <20170507000552.20847-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v13 11/12] qcow2: Assert that cluster
 operations are aligned
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
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v13: no change
v12: no change
v11: reserved for blkdebug half of v10
v10: rebase to context
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
index 6c59708..1b9592d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1559,11 +1559,10 @@ int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,

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

@@ -1646,9 +1645,17 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
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
     /* The zero flag is only supported by version 3 and newer */
     if (s->qcow_version < 3) {
         return -ENOTSUP;
-- 
2.9.3
