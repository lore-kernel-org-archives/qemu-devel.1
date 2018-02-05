Received: from eggs.gnu.org ([2001:4830:134:3::10]:43124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5U-0007sJ-4X
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5S-0000zr-RO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:40 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:16 +0200
Message-Id: <d0d7dca8520db304524f52f49d8157595a707a35.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 16/39] qcow2: Prepare l2_allocate() for
 adding L2 slice support
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
---
 block/qcow2-cluster.c | 55 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8d92d623d8..57349928a9 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -300,38 +300,43 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
     /* allocate a new entry in the l2 cache */
 
     trace_qcow2_l2_allocate_get_empty(bs, l1_index);
-    ret = qcow2_cache_get_empty(bs, s->l2_table_cache, l2_offset, (void**) table);
-    if (ret < 0) {
-        goto fail;
-    }
-
-    l2_table = *table;
-
-    if ((old_l2_offset & L1E_OFFSET_MASK) == 0) {
-        /* if there was no old l2 table, clear the new table */
-        memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
-    } else {
-        uint64_t* old_table;
-
-        /* if there was an old l2 table, read it from the disk */
-        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_COW_READ);
-        ret = qcow2_cache_get(bs, s->l2_table_cache,
-            old_l2_offset & L1E_OFFSET_MASK,
-            (void**) &old_table);
+    {
+        ret = qcow2_cache_get_empty(bs, s->l2_table_cache,
+                                    l2_offset,
+                                    (void **) table);
         if (ret < 0) {
             goto fail;
         }
 
-        memcpy(l2_table, old_table, s->cluster_size);
+        l2_table = *table;
 
-        qcow2_cache_put(s->l2_table_cache, (void **) &old_table);
+        if ((old_l2_offset & L1E_OFFSET_MASK) == 0) {
+            /* if there was no old l2 table, clear the new table */
+            memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
+        } else {
+            uint64_t *old_table;
+
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
+        }
+
+        /* write the l2 table to the file */
+        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
+
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
2.11.0
