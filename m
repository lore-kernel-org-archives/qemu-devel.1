Received: from eggs.gnu.org ([2001:4830:134:3::10]:55555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVI-0000X3-0a
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0003Lw-KO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:39 +0100
Message-Id: <4007dce42901324c3d129917d555d3fec4fb82a2.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 11/32] qcow2: Remove BDS parameter from
 qcow2_cache_is_table_offset()
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

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_get_table_addr(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c    | 3 +--
 block/qcow2-refcount.c | 6 +++---
 block/qcow2.h          | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1cf7915871..2fcecbd7a8 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -428,8 +428,7 @@ void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table)
     c->entries[i].dirty = true;
 }
 
-void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
-                                  uint64_t offset)
+void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset)
 {
     int i;
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index d3a0f7a274..51094fbcfb 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -871,14 +871,14 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         if (refcount == 0) {
             void *table;
 
-            table = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
+            table = qcow2_cache_is_table_offset(s->refcount_block_cache,
                                                 offset);
             if (table != NULL) {
                 qcow2_cache_put(s->refcount_block_cache, &refcount_block);
                 qcow2_cache_discard(s->refcount_block_cache, table);
             }
 
-            table = qcow2_cache_is_table_offset(bs, s->l2_table_cache, offset);
+            table = qcow2_cache_is_table_offset(s->l2_table_cache, offset);
             if (table != NULL) {
                 qcow2_cache_discard(s->l2_table_cache, table);
             }
@@ -3140,7 +3140,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
         s->free_cluster_index = cluster_index;
     }
 
-    refblock = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
+    refblock = qcow2_cache_is_table_offset(s->refcount_block_cache,
                                            discard_block_offs);
     if (refblock) {
         /* discard refblock from the cache if refblock is cached */
diff --git a/block/qcow2.h b/block/qcow2.h
index 64354b6589..dce355521f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -657,8 +657,7 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 void qcow2_cache_put(Qcow2Cache *c, void **table);
-void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
-                                  uint64_t offset);
+void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset);
 void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
-- 
2.11.0
