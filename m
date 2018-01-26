Received: from eggs.gnu.org ([2001:4830:134:3::10]:44452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5nJ-000713-DC
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5nF-0000cJ-EW
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:19:57 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:46 +0200
Message-Id: <9c3d818ac202b776dbe73080d017e2c179c5babd.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 19/39] qcow2: Update get_cluster_table() to
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This patch updates get_cluster_table() to return L2 slices instead of
full L2 tables.

The code itself needs almost no changes, it only needs to call
offset_to_l2_slice_index() instead of offset_to_l2_index(). This patch
also renames all the relevant variables and the documentation.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0c0cab85e8..416d48fa77 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -660,20 +660,20 @@ fail:
  * get_cluster_table
  *
  * for a given disk offset, load (and allocate if needed)
- * the l2 table.
+ * the appropriate slice of its l2 table.
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
@@ -713,17 +713,17 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         assert(offset_into_cluster(s, l2_offset) == 0);
     }
 
-    /* load the l2 table in memory */
-    ret = l2_load(bs, offset, l2_offset, &l2_table);
+    /* load the l2 slice in memory */
+    ret = l2_load(bs, offset, l2_offset, &l2_slice);
     if (ret < 0) {
         return ret;
     }
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = offset_to_l2_index(s, offset);
+    l2_index = offset_to_l2_slice_index(s, offset);
 
-    *new_l2_table = l2_table;
+    *new_l2_slice = l2_slice;
     *new_l2_index = l2_index;
 
     return 0;
-- 
2.11.0
