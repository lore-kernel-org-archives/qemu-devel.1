Received: from eggs.gnu.org ([2001:4830:134:3::10]:42865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dG5-00010I-9l
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dG4-0000ii-Dx
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:41 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:42 +0300
Message-Id: <97641359a12a95f2cc8cad3441432c552da6d369.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 28/31] qcow2: Rename l2_table in
 count_contiguous_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices intead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e7b07d3366..a961901da0 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -363,19 +363,19 @@ fail:
 }
 
 /*
- * Checks how many clusters in a given L2 table are contiguous in the image
+ * Checks how many clusters in a given L2 slice are contiguous in the image
  * file. As soon as one of the flags in the bitmask stop_flags changes compared
  * to the first cluster, the search is stopped and the cluster is not counted
  * as contiguous. (This allows it, for example, to stop at the first compressed
  * cluster which may require a different handling)
  */
 static int count_contiguous_clusters(int nb_clusters, int cluster_size,
-        uint64_t *l2_table, uint64_t stop_flags)
+        uint64_t *l2_slice, uint64_t stop_flags)
 {
     int i;
     QCow2ClusterType first_cluster_type;
     uint64_t mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
-    uint64_t first_entry = be64_to_cpu(l2_table[0]);
+    uint64_t first_entry = be64_to_cpu(l2_slice[0]);
     uint64_t offset = first_entry & mask;
 
     if (!offset) {
@@ -388,7 +388,7 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
            first_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t l2_entry = be64_to_cpu(l2_table[i]) & mask;
+        uint64_t l2_entry = be64_to_cpu(l2_slice[i]) & mask;
         if (offset + (uint64_t) i * cluster_size != l2_entry) {
             break;
         }
-- 
2.11.0
