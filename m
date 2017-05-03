Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d63Qm-00021q-B4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d63Ql-0005yp-3x
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:11:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  4 May 2017 01:11:18 +0200
Message-Id: <20170503231120.23507-3-mreitz@redhat.com>
In-Reply-To: <20170503231120.23507-1-mreitz@redhat.com>
References: <20170503231120.23507-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] qcow2: Reuse preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Instead of just freeing preallocated zero clusters and completely
allocating them from scratch, reuse them.

We cannot do this in handle_copied(), however, since this is a COW
operation. Therefore, we have to add the new logic to handle_alloc() and
simply return the existing offset if it exists. The only catch is that
we have to convince qcow2_alloc_cluster_link_l2() not to free the old
clusters (because we have reused them).

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  3 ++
 block/qcow2-cluster.c | 80 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index f8aeb08794..8731f24b82 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -322,6 +322,9 @@ typedef struct QCowL2Meta
     /** Number of newly allocated clusters */
     int nb_clusters;
 
+    /** Do not free the old clusters */
+    bool keep_old_clusters;
+
     /**
      * Requests that overlap with this allocation and wait to be restarted
      * when the allocating request has completed.
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 100398c565..fb91fd8979 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -309,14 +309,20 @@ static int count_contiguous_clusters(int nb_clusters, int cluster_size,
         uint64_t *l2_table, uint64_t stop_flags)
 {
     int i;
+    int first_cluster_type;
     uint64_t mask = stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESSED;
     uint64_t first_entry = be64_to_cpu(l2_table[0]);
     uint64_t offset = first_entry & mask;
 
-    if (!offset)
+    if (!offset) {
         return 0;
+    }
 
-    assert(qcow2_get_cluster_type(first_entry) == QCOW2_CLUSTER_NORMAL);
+    /* must be allocated */
+    first_cluster_type = qcow2_get_cluster_type(first_entry);
+    assert(first_cluster_type == QCOW2_CLUSTER_NORMAL ||
+           (first_cluster_type == QCOW2_CLUSTER_ZERO &&
+            (first_entry & L2E_OFFSET_MASK) != 0));
 
     for (i = 0; i < nb_clusters; i++) {
         uint64_t l2_entry = be64_to_cpu(l2_table[i]) & mask;
@@ -835,7 +841,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      * Don't discard clusters that reach a refcount of 0 (e.g. compressed
      * clusters), the next write will reuse them anyway.
      */
-    if (j != 0) {
+    if (!m->keep_old_clusters && j != 0) {
         for (i = 0; i < j; i++) {
             qcow2_free_any_clusters(bs, be64_to_cpu(old_cluster[i]), 1,
                                     QCOW2_DISCARD_NEVER);
@@ -1132,8 +1138,9 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t entry;
     uint64_t nb_clusters;
     int ret;
+    bool keep_old_clusters = false;
 
-    uint64_t alloc_cluster_offset;
+    uint64_t alloc_cluster_offset = 0;
 
     trace_qcow2_handle_alloc(qemu_coroutine_self(), guest_offset, *host_offset,
                              *bytes);
@@ -1170,31 +1177,54 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
      * wrong with our code. */
     assert(nb_clusters > 0);
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    if (qcow2_get_cluster_type(entry) == QCOW2_CLUSTER_ZERO &&
+        (entry & L2E_OFFSET_MASK) != 0 && (entry & QCOW_OFLAG_COPIED) &&
+        (!*host_offset ||
+         start_of_cluster(s, *host_offset) == (entry & L2E_OFFSET_MASK)))
+    {
+        /* Try to reuse preallocated zero clusters; contiguous normal clusters
+         * would be fine, too, but count_cow_clusters() above has limited
+         * nb_clusters already to a range of COW clusters */
+        int preallocated_nb_clusters =
+            count_contiguous_clusters(nb_clusters, s->cluster_size,
+                                      &l2_table[l2_index], QCOW_OFLAG_COPIED);
+        assert(preallocated_nb_clusters > 0);
 
-    /* Allocate, if necessary at a given offset in the image file */
-    alloc_cluster_offset = start_of_cluster(s, *host_offset);
-    ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
-                                  &nb_clusters);
-    if (ret < 0) {
-        goto fail;
-    }
+        nb_clusters = preallocated_nb_clusters;
+        alloc_cluster_offset = entry & L2E_OFFSET_MASK;
 
-    /* Can't extend contiguous allocation */
-    if (nb_clusters == 0) {
-        *bytes = 0;
-        return 0;
+        /* We want to reuse these clusters, so qcow2_alloc_cluster_link_l2()
+         * should not free them. */
+        keep_old_clusters = true;
     }
 
-    /* !*host_offset would overwrite the image header and is reserved for "no
-     * host offset preferred". If 0 was a valid host offset, it'd trigger the
-     * following overlap check; do that now to avoid having an invalid value in
-     * *host_offset. */
+    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+
     if (!alloc_cluster_offset) {
-        ret = qcow2_pre_write_overlap_check(bs, 0, alloc_cluster_offset,
-                                            nb_clusters * s->cluster_size);
-        assert(ret < 0);
-        goto fail;
+        /* Allocate, if necessary at a given offset in the image file */
+        alloc_cluster_offset = start_of_cluster(s, *host_offset);
+        ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
+                                      &nb_clusters);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        /* Can't extend contiguous allocation */
+        if (nb_clusters == 0) {
+            *bytes = 0;
+            return 0;
+        }
+
+        /* !*host_offset would overwrite the image header and is reserved for
+         * "no host offset preferred". If 0 was a valid host offset, it'd
+         * trigger the following overlap check; do that now to avoid having an
+         * invalid value in *host_offset. */
+        if (!alloc_cluster_offset) {
+            ret = qcow2_pre_write_overlap_check(bs, 0, alloc_cluster_offset,
+                                                nb_clusters * s->cluster_size);
+            assert(ret < 0);
+            goto fail;
+        }
     }
 
     /*
@@ -1225,6 +1255,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .offset         = start_of_cluster(s, guest_offset),
         .nb_clusters    = nb_clusters,
 
+        .keep_old_clusters  = keep_old_clusters,
+
         .cow_start = {
             .offset     = 0,
             .nb_bytes   = offset_into_cluster(s, guest_offset),
-- 
2.12.2
