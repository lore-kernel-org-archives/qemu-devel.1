Received: from eggs.gnu.org ([2001:4830:134:3::10]:55594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVI-0000XP-M3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0003Mi-PH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:38 +0100
Message-Id: <8512f9f7a0afd366b2e951617cf553b1f16e8be6.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 10/32] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_get_table_idx() and qcow2_cache_table_release(). This
is no longer necessary so this parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c    | 2 +-
 block/qcow2-refcount.c | 6 +++---
 block/qcow2.h          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 402ae952e0..1cf7915871 100644
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
index 2c37492b4d..d3a0f7a274 100644
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
@@ -3144,7 +3144,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
                                            discard_block_offs);
     if (refblock) {
         /* discard refblock from the cache if refblock is cached */
-        qcow2_cache_discard(bs, s->refcount_block_cache, refblock);
+        qcow2_cache_discard(s->refcount_block_cache, refblock);
     }
     update_refcount_discard(bs, discard_block_offs, s->cluster_size);
 
diff --git a/block/qcow2.h b/block/qcow2.h
index a9d619576a..64354b6589 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -659,7 +659,7 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 void qcow2_cache_put(Qcow2Cache *c, void **table);
 void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
                                   uint64_t offset);
-void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
+void qcow2_cache_discard(Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-- 
2.11.0
