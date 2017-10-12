Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dJw-0004Co-TJ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dJt-0006T6-LQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:14:40 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:31 +0300
Message-Id: <1a3e96bdf2db90566105fe2e5d62d812aef2dcb8.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 17/31] qcow2: Update get_cluster_table() to
 support L2 slices
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

This patch updates get_cluster_table() to return L2 slices instead of
full L2 tables.

The code itself needs almost no changes, it only needs to call
offset_to_l2_slice_index() instead of offset_to_l2_index(). This patch
also renames all the relevant variables and the documentation.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index d3548cc667..580fb50869 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -652,20 +652,20 @@ fail:
  * get_cluster_table
  *
  * for a given disk offset, load (and allocate if needed)
- * the l2 table.
+ * the appropiate slice of its l2 table.
  *
- * the cluster index in the l2 table is given to the caller.
+ * the cluster index in the l2 slice is given to the caller.
  *
  * Returns 0 on success, -errno in failure case
  */
 static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
-                             uint64_t **new_l2_table,
+                             uint64_t **new_l2_slice,
                              int *new_l2_index)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
     uint64_t l1_index, l2_offset;
-    uint64_t *l2_table = NULL;
+    uint64_t *l2_slice = NULL;
     int ret;
 
     /* seek to the l2 offset in the l1 table */
@@ -687,11 +687,11 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         return -EIO;
     }
 
-    /* seek the l2 table of the given l2 offset */
+    /* seek the l2 slice of the given l2 offset */
 
     if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
-        /* load the l2 table in memory */
-        ret = l2_load(bs, offset, l2_offset, &l2_table);
+        /* load the l2 slice in memory */
+        ret = l2_load(bs, offset, l2_offset, &l2_slice);
         if (ret < 0) {
             return ret;
         }
@@ -706,8 +706,8 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         /* Get the offset of the newly-allocated l2 table */
         new_l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
         assert(offset_into_cluster(s, new_l2_offset) == 0);
-        /* Load the l2 table in memory */
-        ret = l2_load(bs, offset, new_l2_offset, &l2_table);
+        /* Load the l2 slice in memory */
+        ret = l2_load(bs, offset, new_l2_offset, &l2_slice);
         if (ret < 0) {
             return ret;
         }
@@ -721,9 +721,9 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = offset_to_l2_index(s, offset);
+    l2_index = offset_to_l2_slice_index(s, offset);
 
-    *new_l2_table = l2_table;
+    *new_l2_slice = l2_slice;
     *new_l2_index = l2_index;
 
     return 0;
-- 
2.11.0
