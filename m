Received: from eggs.gnu.org ([2001:4830:134:3::10]:39405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFLX9-0000c8-ET
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFLX4-0005Z6-B5
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:48:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  9 Dec 2016 15:47:04 +0200
Message-Id: <e0e7bc0b085d6694f549eb10fecba6563edc0449.1481290956.git.berto@igalia.com>
In-Reply-To: <cover.1481290956.git.berto@igalia.com>
References: <cover.1481290956.git.berto@igalia.com>
In-Reply-To: <cover.1481290956.git.berto@igalia.com>
References: <cover.1481290956.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH RFC 1/1] qcow2: Allow storing the qcow2 L2
 cache in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

In scenarios where we have a large qcow2 file stored in a slow storage
backend, we can save memory by storing its L2 cache in a faster drive
rather than keeping it in RAM.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--------
 block/qcow2.c       | 11 +++++++++--
 block/qcow2.h       |  3 ++-
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147..8ba8ed9 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/mmap-alloc.h"
 #include "block/block_int.h"
 #include "qemu-common.h"
 #include "qcow2.h"
@@ -36,6 +37,7 @@ typedef struct Qcow2CachedTable {
 } Qcow2CachedTable;
 
 struct Qcow2Cache {
+    int                     fd;
     Qcow2CachedTable       *entries;
     struct Qcow2Cache      *depends;
     int                     size;
@@ -63,7 +65,7 @@ static inline int qcow2_cache_get_table_idx(BlockDriverState *bs,
 }
 
 static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
-                                      int i, int num_tables)
+                                      int i, int num_tables, bool flush)
 {
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
@@ -74,6 +76,10 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
     size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
     if (length > 0) {
+        if (flush) {
+            assert(c->fd > 0);
+            msync((uint8_t *) t + offset, length, MS_SYNC);
+        }
         madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
     }
 #endif
@@ -106,26 +112,50 @@ void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c)
         }
 
         if (to_clean > 0) {
-            qcow2_cache_table_release(bs, c, i - to_clean, to_clean);
+            qcow2_cache_table_release(bs, c, i - to_clean, to_clean, false);
         }
     }
 
     c->cache_clean_lru_counter = c->lru_counter;
 }
 
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables)
+Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
+                               const char *cache_file_path)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2Cache *c;
+    size_t total_size = (size_t) num_tables * s->cluster_size;
 
     c = g_new0(Qcow2Cache, 1);
     c->size = num_tables;
     c->entries = g_try_new0(Qcow2CachedTable, num_tables);
-    c->table_array = qemu_try_blockalign(bs->file->bs,
-                                         (size_t) num_tables * s->cluster_size);
+    if (cache_file_path) {
+        size_t align = MAX(bdrv_opt_mem_align(bs->file->bs), getpagesize());
+        char *filename = g_strdup_printf("%s/qemu-qcow2-cache.XXXXXX",
+                                         cache_file_path);
+        c->fd = mkstemp(filename);
+        if (c->fd > 0) {
+            unlink(filename);
+        }
+        g_free(filename);
+        if (c->fd == -1 || ftruncate(c->fd, total_size)) {
+            goto out;
+        }
+        c->table_array = qemu_ram_mmap(c->fd, total_size, align, true);
+    } else {
+        c->table_array = qemu_try_blockalign(bs->file->bs, total_size);
+    }
 
+out:
     if (!c->entries || !c->table_array) {
-        qemu_vfree(c->table_array);
+        if (cache_file_path) {
+            qemu_ram_munmap(c->table_array, total_size);
+            if (c->fd > 0) {
+                close(c->fd);
+            }
+        } else {
+            qemu_vfree(c->table_array);
+        }
         g_free(c->entries);
         g_free(c);
         c = NULL;
@@ -142,7 +172,14 @@ int qcow2_cache_destroy(BlockDriverState *bs, Qcow2Cache *c)
         assert(c->entries[i].ref == 0);
     }
 
-    qemu_vfree(c->table_array);
+    if (c->fd) {
+        BDRVQcow2State *s = bs->opaque;
+        size_t total_size = (size_t) c->size * s->cluster_size;
+        qemu_ram_munmap(c->table_array, total_size);
+        close(c->fd);
+    } else {
+        qemu_vfree(c->table_array);
+    }
     g_free(c->entries);
     g_free(c);
 
@@ -297,7 +334,7 @@ int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c)
         c->entries[i].lru_counter = 0;
     }
 
-    qcow2_cache_table_release(bs, c, 0, c->size);
+    qcow2_cache_table_release(bs, c, 0, c->size, false);
 
     c->lru_counter = 0;
 
@@ -399,6 +436,9 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
 
     if (c->entries[i].ref == 0) {
         c->entries[i].lru_counter = ++c->lru_counter;
+        if (c->fd) {
+            qcow2_cache_table_release(bs, c, i, 1, true);
+        }
     }
 
     assert(c->entries[i].ref >= 0);
diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8..4d5d092 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -461,6 +461,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_NUMBER,
             .help = "Clean unused cache entries after this time (in seconds)",
         },
+        {
+            .name = "l2-cache-path",
+            .type = QEMU_OPT_STRING,
+            .help = "Directory where to store the L2 cache",
+        },
         { /* end of list */ }
     },
 };
@@ -656,8 +661,10 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
     }
 
-    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size);
-    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size);
+    const char *path = qemu_opt_get(opts, "l2-cache-path");
+
+    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size, path);
+    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size, NULL);
     if (r->l2_table_cache == NULL || r->refcount_block_cache == NULL) {
         error_setg(errp, "Could not allocate metadata caches");
         ret = -ENOMEM;
diff --git a/block/qcow2.h b/block/qcow2.h
index 1823414..494f1ed 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -569,7 +569,8 @@ void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs);
 
 /* qcow2-cache.c functions */
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
+Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
+                               const char *cache_file_path);
 int qcow2_cache_destroy(BlockDriverState* bs, Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
-- 
2.10.2
