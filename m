Received: from eggs.gnu.org ([2001:4830:134:3::10]:55460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVG-0000We-5E
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003Ig-St
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:14 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:57 +0100
Message-Id: <8149f6ab70fda930585b8ee38a583a006343730c.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 29/32] qcow2: Rename l2_table in
 count_contiguous_clusters_unallocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices intead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3deb132fa4..b40a2e32e0 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -407,10 +407,10 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
 
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
@@ -418,7 +418,7 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
     assert(wanted_type == QCOW2_CLUSTER_ZERO_PLAIN ||
            wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t entry = be64_to_cpu(l2_table[i]);
+        uint64_t entry = be64_to_cpu(l2_slice[i]);
         QCow2ClusterType type = qcow2_get_cluster_type(entry);
 
         if (type != wanted_type) {
-- 
2.11.0
