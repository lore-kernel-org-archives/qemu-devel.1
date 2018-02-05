Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eihrJ-0002Bi-4z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eihrD-0006CC-5M
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:35:01 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:10 +0200
Message-Id: <9724f7e38e763ad3be32627c6b7fe8df9edb1476.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 10/39] qcow2: Remove BDS parameter from
 qcow2_cache_discard()
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
to qcow2_cache_get_table_idx() and qcow2_cache_table_release(). This
is no longer necessary so this parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cache.c    | 2 +-
 block/qcow2-refcount.c | 6 +++---
 block/qcow2.h          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 03b3e03c6c..8d0b65e671 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -441,7 +441,7 @@ void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
     return NULL;
 }
 
-void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
+void qcow2_cache_discard(Qcow2Cache *c, void *table)
 {
     int i = qcow2_cache_get_table_idx(c, table);
 
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 65af05dd23..361b39d5cc 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -875,12 +875,12 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                                                 offset);
             if (table != NULL) {
                 qcow2_cache_put(s->refcount_block_cache, &refcount_block);
-                qcow2_cache_discard(bs, s->refcount_block_cache, table);
+                qcow2_cache_discard(s->refcount_block_cache, table);
             }
 
             table = qcow2_cache_is_table_offset(bs, s->l2_table_cache, offset);
             if (table != NULL) {
-                qcow2_cache_discard(bs, s->l2_table_cache, table);
+                qcow2_cache_discard(s->l2_table_cache, table);
             }
 
             if (s->discard_passthrough[type]) {
@@ -3190,7 +3190,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
                                            discard_block_offs);
     if (refblock) {
         /* discard refblock from the cache if refblock is cached */
-        qcow2_cache_discard(bs, s->refcount_block_cache, refblock);
+        qcow2_cache_discard(s->refcount_block_cache, refblock);
     }
     update_refcount_discard(bs, discard_block_offs, s->cluster_size);
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 7e2781ffa4..f6552fe9c3 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -656,7 +656,7 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 void qcow2_cache_put(Qcow2Cache *c, void **table);
 void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
                                   uint64_t offset);
-void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
+void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-- 
2.11.0
