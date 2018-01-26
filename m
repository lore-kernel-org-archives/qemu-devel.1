Received: from eggs.gnu.org ([2001:4830:134:3::10]:47902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5zf-0000tO-Fn
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5ze-0002E3-Dz
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:32:43 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:38 +0200
Message-Id: <245ecc9693e29fa6398d20ac5a90ef8dcdc23cda.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 11/39] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_get_table_addr(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-cache.c    | 3 +--
 block/qcow2-refcount.c | 6 +++---
 block/qcow2.h          | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 8d0b65e671..b1aa42477e 100644
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
index 361b39d5cc..9df380d52c 100644
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
@@ -3186,7 +3186,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
         s->free_cluster_index = cluster_index;
     }
 
-    refblock = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
+    refblock = qcow2_cache_is_table_offset(s->refcount_block_cache,
                                            discard_block_offs);
     if (refblock) {
         /* discard refblock from the cache if refblock is cached */
diff --git a/block/qcow2.h b/block/qcow2.h
index f6552fe9c3..cb8dd784fa 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -654,8 +654,7 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
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
