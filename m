Received: from eggs.gnu.org ([2001:4830:134:3::10]:60620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKkm8-0000r7-D5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKkm7-00075Z-FJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:24 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 13 Jun 2017 15:16:37 +0300
Message-Id: <20170613121639.17853-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/4] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pbutsykin@virtuozzo.com, den@openvz.org

Whenever l2/refcount table clusters are discarded from the file we can
automatically drop unnecessary content of the cache tables. This reduces
the chance of eviction useful cache data and eliminates inconsistent data
in thecache with the data in the file.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/qcow2-cache.c    | 21 +++++++++++++++++++++
 block/qcow2-refcount.c |  5 +++++
 block/qcow2.h          |  1 +
 3 files changed, 27 insertions(+)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147392..7931edf237 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -411,3 +411,24 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
     assert(c->entries[i].offset != 0);
     c->entries[i].dirty = true;
 }
+
+void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset)
+{
+    int i;
+
+    for (i = 0; i < c->size; i++) {
+        if (c->entries[i].offset == offset) {
+            goto found; /* table offset */
+        }
+    }
+    return;
+
+found:
+    assert(c->entries[i].ref == 0);
+
+    c->entries[i].offset = 0;
+    c->entries[i].lru_counter = 0;
+    c->entries[i].dirty = false;
+
+    qcow2_cache_table_release(bs, c, i, 1);
+}
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..576ab551d6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -767,6 +767,11 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         s->set_refcount(refcount_block, block_index, refcount);
 
         if (refcount == 0 && s->discard_passthrough[type]) {
+            qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+            qcow2_cache_discard(bs, s->refcount_block_cache, offset);
+
+            qcow2_cache_discard(bs, s->l2_table_cache, offset);
+
             update_refcount_discard(bs, cluster_offset, s->cluster_size);
         }
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc30dc..07faa6dc78 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -597,5 +597,6 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
 int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
+void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset);
 
 #endif
-- 
2.13.0
