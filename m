Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBX-0003Sy-3V
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBW-0000K7-6i
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:59 +0200
Message-Id: <1494513181-7900-57-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 56/58] qcow2: Assert that cluster operations are
 aligned
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

We already audited (in commit 0c1bd469) that qcow2_discard_clusters()
is only passed cluster-aligned start values; but we can further
tighten the assertion that the only unaligned end value is at EOF.

Recent commits have taken advantage of an unaligned tail cluster,
for both discard and write zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170507000552.20847-12-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e2c5759..43bde56 100644
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
1.8.3.1
