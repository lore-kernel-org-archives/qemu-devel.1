Received: from eggs.gnu.org ([2001:4830:134:3::10]:37676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBE-00036d-4v
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBD-0008LQ-1e
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:53 +0200
Message-Id: <1494513181-7900-51-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 50/58] qcow2: Name typedef for cluster type
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

Although it doesn't add all that much type safety (this is C, after
all), it does add a bit of legibility to use the name QCow2ClusterType
instead of a plain int.

In particular, qcow2_get_cluster_offset() has an overloaded return
type; a QCow2ClusterType on success, and -errno on failure; keeping
the cluster type in a separate variable makes it slightly easier for
the next patch to make further computations based on the type.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170507000552.20847-6-eblake@redhat.com
[mreitz: Use the new type in two more places (one of them pulled from
         the next patch)]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c  | 21 +++++++++++----------
 block/qcow2-refcount.c |  2 +-
 block/qcow2.h          |  6 +++---
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f3bfce6..26f9e0e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -309,7 +309,7 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
         uint64_t *l2_table, uint64_t stop_flags)
 {
     int i;
-    int first_cluster_type;
+    QCow2ClusterType first_cluster_type;
     uint64_t mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
     uint64_t first_entry = be64_to_cpu(l2_table[0]);
     uint64_t offset = first_entry & mask;
@@ -340,7 +340,7 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
  */
 static int count_contiguous_clusters_unallocated(int nb_clusters,
                                                  uint64_t *l2_table,
-                                                 int wanted_type)
+                                                 QCow2ClusterType wanted_type)
 {
     int i;
 
@@ -348,7 +348,7 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
            wanted_type == QCOW2_CLUSTER_UNALLOCATED);
     for (i = 0; i < nb_clusters; i++) {
         uint64_t entry = be64_to_cpu(l2_table[i]);
-        int type = qcow2_get_cluster_type(entry);
+        QCow2ClusterType type = qcow2_get_cluster_type(entry);
 
         if (type != wanted_type || entry & L2E_OFFSET_MASK) {
             break;
@@ -500,6 +500,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     int l1_bits, c;
     unsigned int offset_in_cluster;
     uint64_t bytes_available, bytes_needed, nb_clusters;
+    QCow2ClusterType type;
     int ret;
 
     offset_in_cluster = offset_into_cluster(s, offset);
@@ -522,13 +523,13 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 
     l1_index = offset >> l1_bits;
     if (l1_index >= s->l1_size) {
-        ret = QCOW2_CLUSTER_UNALLOCATED;
+        type = QCOW2_CLUSTER_UNALLOCATED;
         goto out;
     }
 
     l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
     if (!l2_offset) {
-        ret = QCOW2_CLUSTER_UNALLOCATED;
+        type = QCOW2_CLUSTER_UNALLOCATED;
         goto out;
     }
 
@@ -557,8 +558,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
      * true */
     assert(nb_clusters <= INT_MAX);
 
-    ret = qcow2_get_cluster_type(*cluster_offset);
-    switch (ret) {
+    type = qcow2_get_cluster_type(*cluster_offset);
+    switch (type) {
     case QCOW2_CLUSTER_COMPRESSED:
         /* Compressed clusters can only be processed one by one */
         c = 1;
@@ -633,7 +634,7 @@ out:
     assert(bytes_available - offset_in_cluster <= UINT_MAX);
     *bytes = bytes_available - offset_in_cluster;
 
-    return ret;
+    return type;
 
 fail:
     qcow2_cache_put(bs, s->l2_table_cache, (void **)&l2_table);
@@ -891,7 +892,7 @@ static int count_cow_clusters(BDRVQcow2State *s, int nb_clusters,
 
     for (i = 0; i < nb_clusters; i++) {
         uint64_t l2_entry = be64_to_cpu(l2_table[l2_index + i]);
-        int cluster_type = qcow2_get_cluster_type(l2_entry);
+        QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
 
         switch(cluster_type) {
         case QCOW2_CLUSTER_NORMAL:
@@ -1757,7 +1758,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
         for (j = 0; j < s->l2_size; j++) {
             uint64_t l2_entry = be64_to_cpu(l2_table[j]);
             int64_t offset = l2_entry & L2E_OFFSET_MASK;
-            int cluster_type = qcow2_get_cluster_type(l2_entry);
+            QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
             bool preallocated = offset != 0;
 
             if (cluster_type != QCOW2_CLUSTER_ZERO) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 908dbe5..e639b34 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1640,7 +1640,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
         for (j = 0; j < s->l2_size; j++) {
             uint64_t l2_entry = be64_to_cpu(l2_table[j]);
             uint64_t data_offset = l2_entry & L2E_OFFSET_MASK;
-            int cluster_type = qcow2_get_cluster_type(l2_entry);
+            QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
 
             if ((cluster_type == QCOW2_CLUSTER_NORMAL) ||
                 ((cluster_type == QCOW2_CLUSTER_ZERO) && (data_offset != 0))) {
diff --git a/block/qcow2.h b/block/qcow2.h
index 8731f24..c148bbc 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -349,12 +349,12 @@ typedef struct QCowL2Meta
     QLIST_ENTRY(QCowL2Meta) next_in_flight;
 } QCowL2Meta;
 
-enum {
+typedef enum QCow2ClusterType {
     QCOW2_CLUSTER_UNALLOCATED,
     QCOW2_CLUSTER_NORMAL,
     QCOW2_CLUSTER_COMPRESSED,
     QCOW2_CLUSTER_ZERO
-};
+} QCow2ClusterType;
 
 typedef enum QCow2MetadataOverlap {
     QCOW2_OL_MAIN_HEADER_BITNR    = 0,
@@ -443,7 +443,7 @@ static inline uint64_t qcow2_max_refcount_clusters(BDRVQcow2State *s)
     return QCOW_MAX_REFTABLE_SIZE >> s->cluster_bits;
 }
 
-static inline int qcow2_get_cluster_type(uint64_t l2_entry)
+static inline QCow2ClusterType qcow2_get_cluster_type(uint64_t l2_entry)
 {
     if (l2_entry & QCOW_OFLAG_COMPRESSED) {
         return QCOW2_CLUSTER_COMPRESSED;
-- 
1.8.3.1
