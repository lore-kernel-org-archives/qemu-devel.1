Received: from eggs.gnu.org ([2001:4830:134:3::10]:55381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WQ-E8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVB-0003FP-7a
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:31 +0100
Message-Id: <44e3c682947299e968706e058ac665fbac5bb719.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 03/32] qcow2: Remove BDS parameter from
 qcow2_cache_get_table_addr()
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

This function was only using the BlockDriverState parameter to get the
cache table size (since it was equal to the cluster size). This is no
longer necessary so this parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d068fed98e..ff793fc532 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -46,8 +46,7 @@ struct Qcow2Cache {
     uint64_t                cache_clean_lru_counter;
 };
 
-static inline void *qcow2_cache_get_table_addr(BlockDriverState *bs,
-                    Qcow2Cache *c, int table)
+static inline void *qcow2_cache_get_table_addr(Qcow2Cache *c, int table)
 {
     return (uint8_t *) c->table_array + (size_t) table * c->table_size;
 }
@@ -78,7 +77,7 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
 {
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
-    void *t = qcow2_cache_get_table_addr(bs, c, i);
+    void *t = qcow2_cache_get_table_addr(c, i);
     int align = getpagesize();
     size_t mem_size = (size_t) c->table_size * num_tables;
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
@@ -222,7 +221,7 @@ static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
     }
 
     ret = bdrv_pwrite(bs->file, c->entries[i].offset,
-                      qcow2_cache_get_table_addr(bs, c, i), c->table_size);
+                      qcow2_cache_get_table_addr(c, i), c->table_size);
     if (ret < 0) {
         return ret;
     }
@@ -378,7 +377,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
         }
 
         ret = bdrv_pread(bs->file, offset,
-                         qcow2_cache_get_table_addr(bs, c, i),
+                         qcow2_cache_get_table_addr(c, i),
                          c->table_size);
         if (ret < 0) {
             return ret;
@@ -390,7 +389,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
     /* And return the right table */
 found:
     c->entries[i].ref++;
-    *table = qcow2_cache_get_table_addr(bs, c, i);
+    *table = qcow2_cache_get_table_addr(c, i);
 
     trace_qcow2_cache_get_done(qemu_coroutine_self(),
                                c == s->l2_table_cache, i);
@@ -439,7 +438,7 @@ void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
 
     for (i = 0; i < c->size; i++) {
         if (c->entries[i].offset == offset) {
-            return qcow2_cache_get_table_addr(bs, c, i);
+            return qcow2_cache_get_table_addr(c, i);
         }
     }
     return NULL;
-- 
2.11.0
