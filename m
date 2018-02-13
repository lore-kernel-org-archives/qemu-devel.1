Received: from eggs.gnu.org ([2001:4830:134:3::10]:53321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2J-0003d3-5r
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2I-0005qY-6R
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:24 +0100
Message-Id: <20180213170529.10858-51-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 50/55] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices instead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 78bcc54bc632574dd0b900a77a00a1b6ffc359e6.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 54ae210b43..074a4aaf1e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -406,10 +406,10 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
 
 /*
  * Checks how many consecutive unallocated clusters in a given L2
- * table have the same cluster type.
+ * slice have the same cluster type.
  */
 static int count_contiguous_clusters_unallocated(int nb_clusters,
-                                                 uint64_t *l2_table,
+                                                 uint64_t *l2_slice,
                                                  QCow2ClusterType wanted_type)
 {
     int i;
@@ -417,7 +417,7 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
     assert(wanted_type == QCOW2_CLUSTER_ZERO_PLAIN ||
            wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t entry = be64_to_cpu(l2_table[i]);
+        uint64_t entry = be64_to_cpu(l2_slice[i]);
         QCow2ClusterType type = qcow2_get_cluster_type(entry);
 
         if (type != wanted_type) {
-- 
2.13.6
