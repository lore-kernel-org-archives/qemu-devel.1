Received: from eggs.gnu.org ([2001:4830:134:3::10]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBC-00034u-Bx
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBB-0008Jy-Ab
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:52 +0200
Message-Id: <1494513181-7900-50-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 49/58] qcow2: Correctly report status of
 preallocated zero clusters
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

We were throwing away the preallocation information associated with
zero clusters.  But we should be matching the well-defined semantics
in bdrv_get_block_status(), where (BDRV_BLOCK_ZERO |
BDRV_BLOCK_OFFSET_VALID) informs the user which offset is reserved,
while still reminding the user that reading from that offset is
likely to read garbage.

count_contiguous_clusters_by_type() is now used only for unallocated
cluster runs, hence it gets renamed and tightened.

Making this change lets us see which portions of an image are zero
but preallocated, when using qemu-img map --output=json.  The
--output=human side intentionally ignores all zero clusters, whether
or not they are preallocated.

The fact that there is no change to qemu-iotests './check -qcow2'
merely means that we aren't yet testing this aspect of qemu-img;
a later patch will add a test.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170507000552.20847-5-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 335a505..f3bfce6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -334,16 +334,23 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
 	return i;
 }
 
-static int count_contiguous_clusters_by_type(int nb_clusters,
-                                             uint64_t *l2_table,
-                                             int wanted_type)
+/*
+ * Checks how many consecutive unallocated clusters in a given L2
+ * table have the same cluster type.
+ */
+static int count_contiguous_clusters_unallocated(int nb_clusters,
+                                                 uint64_t *l2_table,
+                                                 int wanted_type)
 {
     int i;
 
+    assert(wanted_type == QCOW2_CLUSTER_ZERO ||
+           wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
-        int type = qcow2_get_cluster_type(be64_to_cpu(l2_table[i]));
+        uint64_t entry = be64_to_cpu(l2_table[i]);
+        int type = qcow2_get_cluster_type(entry);
 
-        if (type != wanted_type) {
+        if (type != wanted_type || entry & L2E_OFFSET_MASK) {
             break;
         }
     }
@@ -565,14 +572,32 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
             ret = -EIO;
             goto fail;
         }
-        c = count_contiguous_clusters_by_type(nb_clusters, &l2_table[l2_index],
-                                              QCOW2_CLUSTER_ZERO);
-        *cluster_offset = 0;
+        /* Distinguish between pure zero clusters and pre-allocated ones */
+        if (*cluster_offset & L2E_OFFSET_MASK) {
+            c = count_contiguous_clusters(nb_clusters, s->cluster_size,
+                                          &l2_table[l2_index], QCOW_OFLAG_ZERO);
+            *cluster_offset &= L2E_OFFSET_MASK;
+            if (offset_into_cluster(s, *cluster_offset)) {
+                qcow2_signal_corruption(bs, true, -1, -1,
+                                        "Preallocated zero cluster offset %#"
+                                        PRIx64 " unaligned (L2 offset: %#"
+                                        PRIx64 ", L2 index: %#x)",
+                                        *cluster_offset, l2_offset, l2_index);
+                ret = -EIO;
+                goto fail;
+            }
+        } else {
+            c = count_contiguous_clusters_unallocated(nb_clusters,
+                                                      &l2_table[l2_index],
+                                                      QCOW2_CLUSTER_ZERO);
+            *cluster_offset = 0;
+        }
         break;
     case QCOW2_CLUSTER_UNALLOCATED:
         /* how many empty clusters ? */
-        c = count_contiguous_clusters_by_type(nb_clusters, &l2_table[l2_index],
-                                              QCOW2_CLUSTER_UNALLOCATED);
+        c = count_contiguous_clusters_unallocated(nb_clusters,
+                                                  &l2_table[l2_index],
+                                                  QCOW2_CLUSTER_UNALLOCATED);
         *cluster_offset = 0;
         break;
     case QCOW2_CLUSTER_NORMAL:
-- 
1.8.3.1
