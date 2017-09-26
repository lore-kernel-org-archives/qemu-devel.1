Received: from eggs.gnu.org ([2001:4830:134:3::10]:33198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkq-0001rG-0d
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkp-0005f7-0t
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:22:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:30 +0200
Message-Id: <20170926142133.2498-22-kwolf@redhat.com>
In-Reply-To: <20170926142133.2498-1-kwolf@redhat.com>
References: <20170926142133.2498-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/24] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

Whenever l2/refcount table clusters are discarded from the file we can
automatically drop unnecessary content of the cache tables. This reduces
the chance of eviction useful cache data and eliminates inconsistent data
in the cache with the data in the file.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170918124230.8152-3-pbutsykin@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |  3 +++
 block/qcow2-cache.c    | 26 ++++++++++++++++++++++++++
 block/qcow2-refcount.c | 20 ++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 96a8d43c17..52c374e9ed 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -649,6 +649,9 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
+void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
+                                  uint64_t offset);
+void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
 
 /* qcow2-bitmap.c functions */
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147392..75746a7f43 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -411,3 +411,29 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
     assert(c->entries[i].offset != 0);
     c->entries[i].dirty = true;
 }
+
+void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
+                                  uint64_t offset)
+{
+    int i;
+
+    for (i = 0; i < c->size; i++) {
+        if (c->entries[i].offset == offset) {
+            return qcow2_cache_get_table_addr(bs, c, i);
+        }
+    }
+    return NULL;
+}
+
+void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
+{
+    int i = qcow2_cache_get_table_idx(bs, c, table);
+
+    assert(c->entries[i].ref == 0);
+
+    c->entries[i].offset = 0;
+    c->entries[i].lru_counter = 0;
+    c->entries[i].dirty = false;
+
+    qcow2_cache_table_release(bs, c, i, 1);
+}
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 168fc32e7b..8c17c0e3aa 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -861,8 +861,24 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         }
         s->set_refcount(refcount_block, block_index, refcount);
 
-        if (refcount == 0 && s->discard_passthrough[type]) {
-            update_refcount_discard(bs, cluster_offset, s->cluster_size);
+        if (refcount == 0) {
+            void *table;
+
+            table = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
+                                                offset);
+            if (table != NULL) {
+                qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+                qcow2_cache_discard(bs, s->refcount_block_cache, table);
+            }
+
+            table = qcow2_cache_is_table_offset(bs, s->l2_table_cache, offset);
+            if (table != NULL) {
+                qcow2_cache_discard(bs, s->l2_table_cache, table);
+            }
+
+            if (s->discard_passthrough[type]) {
+                update_refcount_discard(bs, cluster_offset, s->cluster_size);
+            }
         }
     }
 
-- 
2.13.5
