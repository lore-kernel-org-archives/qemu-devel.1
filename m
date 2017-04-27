Received: from eggs.gnu.org ([2001:4830:134:3::10]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVy-0007S1-73
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVw-00043Y-TZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:12 -0500
Message-Id: <20170427014626.11553-4-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-1-eblake@redhat.com>
References: <20170427014626.11553-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v10 03/17] qcow2: Reuse preallocated zero
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Instead of just freeing preallocated zero clusters and completely
allocating them from scratch, reuse them.

We cannot do this in handle_copied(), however, since this is a COW
operation. Therefore, we have to add the new logic to handle_alloc() and
simply return the existing offset if it exists. The only catch is that
we have to convince qcow2_alloc_cluster_link_l2() not to free the old
clusters (because we have reused them).

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v10: new patch. Max hasn't posted the patch directly on list, but
did mention it here:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03936.html
and that he would post it once he has tests. Well, my later patches
add a test that requires this one :)  The other two patches that
he mentioned there are also good, but not essential for my series
(and I didn't want to write tests to expose the behavior difference,
because it would deprive Max of that fun).
---
 block/qcow2.h         |  3 ++
 block/qcow2-cluster.c | 83 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index f8aeb08..8731f24 100644
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
index d1063df..db3d937 100644
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
@@ -857,7 +863,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      * Don't discard clusters that reach a refcount of 0 (e.g. compressed
      * clusters), the next write will reuse them anyway.
      */
-    if (j != 0) {
+    if (!m->keep_old_clusters && j != 0) {
         for (i = 0; i < j; i++) {
             qcow2_free_any_clusters(bs, be64_to_cpu(old_cluster[i]), 1,
                                     QCOW2_DISCARD_NEVER);
@@ -1154,8 +1160,9 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t entry;
     uint64_t nb_clusters;
     int ret;
+    bool keep_old_clusters = false;

-    uint64_t alloc_cluster_offset;
+    uint64_t alloc_cluster_offset = 0;

     trace_qcow2_handle_alloc(qemu_coroutine_self(), guest_offset, *host_offset,
                              *bytes);
@@ -1192,31 +1199,53 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
      * wrong with our code. */
     assert(nb_clusters > 0);

+    if (!*host_offset && qcow2_get_cluster_type(entry) == QCOW2_CLUSTER_ZERO &&
+        (entry & L2E_OFFSET_MASK) != 0 && (entry & QCOW_OFLAG_COPIED))
+    {
+        /* Try to reuse preallocated zero clusters; contiguous normal clusters
+         * would be fine, too, but count_cow_clusters() above has limited
+         * nb_clusters already to a range of COW clusters */
+        int preallocated_nb_clusters =
+            count_contiguous_clusters(nb_clusters, s->cluster_size, l2_table,
+                                      QCOW_OFLAG_COPIED);
+
+        if (preallocated_nb_clusters) {
+            nb_clusters = preallocated_nb_clusters;
+            alloc_cluster_offset = entry & L2E_OFFSET_MASK;
+
+            /* We want to reuse these clusters, so qcow2_alloc_cluster_link_l2()
+             * should not free them. */
+            keep_old_clusters = true;
+        }
+    }
+
     qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);

-    /* Allocate, if necessary at a given offset in the image file */
-    alloc_cluster_offset = start_of_cluster(s, *host_offset);
-    ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
-                                  &nb_clusters);
-    if (ret < 0) {
-        goto fail;
-    }
-
-    /* Can't extend contiguous allocation */
-    if (nb_clusters == 0) {
-        *bytes = 0;
-        return 0;
-    }
-
-    /* !*host_offset would overwrite the image header and is reserved for "no
-     * host offset preferred". If 0 was a valid host offset, it'd trigger the
-     * following overlap check; do that now to avoid having an invalid value in
-     * *host_offset. */
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
@@ -1247,6 +1276,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .offset         = start_of_cluster(s, guest_offset),
         .nb_clusters    = nb_clusters,

+        .keep_old_clusters  = keep_old_clusters,
+
         .cow_start = {
             .offset     = 0,
             .nb_bytes   = offset_into_cluster(s, guest_offset),
-- 
2.9.3
