Received: from eggs.gnu.org ([2001:4830:134:3::10]:52838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele23-0003KZ-0g
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1y-0005ZO-HZ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:06 +0100
Message-Id: <20180213170529.10858-33-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/55] qcow2: Prepare l2_allocate() for adding
 L2 slice support
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

Adding support for L2 slices to l2_allocate() needs (among other
things) an extra loop that iterates over all slices of a new L2 table.

Putting all changes in one patch would make it hard to read because
all semantic changes would be mixed with pure indentation changes.

To make things easier this patch simply creates a new block and
changes the indentation of all lines of code inside it. Thus, all
modifications in this patch are cosmetic. There are no semantic
changes and no variables are renamed yet. The next patch will take
care of that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: d0d7dca8520db304524f52f49d8157595a707a35.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 53 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 542080aed0..3f7272441d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -299,38 +299,43 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
     /* allocate a new entry in the l2 cache */
 
     trace_qcow2_l2_allocate_get_empty(bs, l1_index);
-    ret = qcow2_cache_get_empty(bs, s->l2_table_cache, l2_offset, (void**) table);
-    if (ret < 0) {
-        goto fail;
-    }
+    {
+        ret = qcow2_cache_get_empty(bs, s->l2_table_cache,
+                                    l2_offset,
+                                    (void **) table);
+        if (ret < 0) {
+            goto fail;
+        }
 
-    l2_table = *table;
+        l2_table = *table;
 
-    if ((old_l2_offset & L1E_OFFSET_MASK) == 0) {
-        /* if there was no old l2 table, clear the new table */
-        memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
-    } else {
-        uint64_t* old_table;
+        if ((old_l2_offset & L1E_OFFSET_MASK) == 0) {
+            /* if there was no old l2 table, clear the new table */
+            memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
+        } else {
+            uint64_t *old_table;
 
-        /* if there was an old l2 table, read it from the disk */
-        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_COW_READ);
-        ret = qcow2_cache_get(bs, s->l2_table_cache,
-            old_l2_offset & L1E_OFFSET_MASK,
-            (void**) &old_table);
-        if (ret < 0) {
-            goto fail;
+            /* if there was an old l2 table, read it from the disk */
+            BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_COW_READ);
+            ret = qcow2_cache_get(bs, s->l2_table_cache,
+                                  old_l2_offset & L1E_OFFSET_MASK,
+                                  (void **) &old_table);
+            if (ret < 0) {
+                goto fail;
+            }
+
+            memcpy(l2_table, old_table, s->cluster_size);
+
+            qcow2_cache_put(s->l2_table_cache, (void **) &old_table);
         }
 
-        memcpy(l2_table, old_table, s->cluster_size);
+        /* write the l2 table to the file */
+        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
 
-        qcow2_cache_put(s->l2_table_cache, (void **) &old_table);
+        trace_qcow2_l2_allocate_write_l2(bs, l1_index);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     }
 
-    /* write the l2 table to the file */
-    BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
-
-    trace_qcow2_l2_allocate_write_l2(bs, l1_index);
-    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret < 0) {
         goto fail;
-- 
2.13.6
