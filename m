Received: from eggs.gnu.org ([2001:4830:134:3::10]:45452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dKS-0004g0-1g
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dKO-0006rg-PE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:15:12 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:17 +0300
Message-Id: <1aabec73c000402304473c0f1afe1278a4658da3.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 03/31] qcow2: Remove BDS parameter from
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

This function was only using the BlockDriverState parameter to get the
cache table size (since it was equal to the cluster size). This is no
longer necessary so this parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 72cb7148ff..98bd77f3fb 100644
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
@@ -66,7 +65,7 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
 {
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
-    void *t = qcow2_cache_get_table_addr(bs, c, i);
+    void *t = qcow2_cache_get_table_addr(c, i);
     int align = getpagesize();
     size_t mem_size = (size_t) c->table_size * num_tables;
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
@@ -210,7 +209,7 @@ static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
     }
 
     ret = bdrv_pwrite(bs->file, c->entries[i].offset,
-                      qcow2_cache_get_table_addr(bs, c, i), c->table_size);
+                      qcow2_cache_get_table_addr(c, i), c->table_size);
     if (ret < 0) {
         return ret;
     }
@@ -357,7 +356,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
         }
 
         ret = bdrv_pread(bs->file, offset,
-                         qcow2_cache_get_table_addr(bs, c, i),
+                         qcow2_cache_get_table_addr(c, i),
                          c->table_size);
         if (ret < 0) {
             return ret;
@@ -369,7 +368,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
     /* And return the right table */
 found:
     c->entries[i].ref++;
-    *table = qcow2_cache_get_table_addr(bs, c, i);
+    *table = qcow2_cache_get_table_addr(c, i);
 
     trace_qcow2_cache_get_done(qemu_coroutine_self(),
                                c == s->l2_table_cache, i);
@@ -418,7 +417,7 @@ void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
 
     for (i = 0; i < c->size; i++) {
         if (c->entries[i].offset == offset) {
-            return qcow2_cache_get_table_addr(bs, c, i);
+            return qcow2_cache_get_table_addr(c, i);
         }
     }
     return NULL;
-- 
2.11.0
