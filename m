Received: from eggs.gnu.org ([2001:4830:134:3::10]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele20-0003HO-L5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1z-0005aP-N0
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:08 +0100
Message-Id: <20180213170529.10858-35-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 34/55] qcow2: Refactor get_cluster_table()
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

After the previous patch we're now always using l2_load() in
get_cluster_table() regardless of whether a new L2 table has to be
allocated or not.

This patch refactors that part of the code to use one single l2_load()
call.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: ce31758c4a1fadccea7a6ccb93951eb01d95fd4c.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 4aa9ea7b29..044eccda72 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -694,15 +694,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         return -EIO;
     }
 
-    /* seek the l2 table of the given l2 offset */
-
-    if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
-        /* load the l2 table in memory */
-        ret = l2_load(bs, offset, l2_offset, &l2_table);
-        if (ret < 0) {
-            return ret;
-        }
-    } else {
+    if (!(s->l1_table[l1_index] & QCOW_OFLAG_COPIED)) {
         /* First allocate a new L2 table (and do COW if needed) */
         ret = l2_allocate(bs, l1_index);
         if (ret < 0) {
@@ -718,11 +710,12 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
         /* Get the offset of the newly-allocated l2 table */
         l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
         assert(offset_into_cluster(s, l2_offset) == 0);
-        /* Load the l2 table in memory */
-        ret = l2_load(bs, offset, l2_offset, &l2_table);
-        if (ret < 0) {
-            return ret;
-        }
+    }
+
+    /* load the l2 table in memory */
+    ret = l2_load(bs, offset, l2_offset, &l2_table);
+    if (ret < 0) {
+        return ret;
     }
 
     /* find the cluster offset for the given disk offset */
-- 
2.13.6
