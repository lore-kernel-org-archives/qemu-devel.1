Received: from eggs.gnu.org ([2001:4830:134:3::10]:42890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dG7-00011S-0g
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dG5-0000mD-G0
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:42 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:45 +0300
Message-Id: <aed4d72942c78419f3f3f767606e2aec7cb6cf70.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 31/31] qcow2: Allow configuring the L2 slice
 size
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

Now that the code is ready to handle L2 slices we can finally add an
option to allow configuring their size.

An L2 slice is the portion of an L2 table that is read by the qcow2
cache. Until now the cache was always reading full L2 tables, and
since the L2 table size is equal to the cluster size this was not very
efficient with large clusters. Here's a more detailed explanation of
why it makes sense to have smaller cache entries in order to load L2
data:

   https://lists.gnu.org/archive/html/qemu-block/2017-09/msg00635.html

This patch introduces a new command-line option to the qcow2 driver
named l2-cache-entry-size (cf. l2-cache-size). The cache entry size
has the same restrictions as the cluster size: it must be a power of
two and it has the same range of allowed values, with the additional
requirement that it must not be larger than the cluster size.

The L2 cache entry size (L2 slice size) remains equal to the cluster
size for now by default, so this feature must be explicitly enabled.
Although my tests show that 4KB slices consistently improve
performance and give the best results, let's wait and make more tests
with different cluster sizes before deciding on an optimal default.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 10 ++++++++--
 block/qcow2.c       | 33 +++++++++++++++++++++++++++------
 block/qcow2.h       |  4 +++-
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 788a1fb31d..313481f5bd 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -108,14 +108,20 @@ void qcow2_cache_clean_unused(Qcow2Cache *c)
     c->cache_clean_lru_counter = c->lru_counter;
 }
 
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables)
+Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
+                               unsigned table_size)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2Cache *c;
 
+    assert(num_tables > 0);
+    assert(is_power_of_2(table_size));
+    assert(table_size >= (1 << MIN_CLUSTER_BITS));
+    assert(table_size <= s->cluster_size);
+
     c = g_new0(Qcow2Cache, 1);
     c->size = num_tables;
-    c->table_size = s->cluster_size;
+    c->table_size = table_size;
     c->entries = g_try_new0(Qcow2CachedTable, num_tables);
     c->table_array = qemu_try_blockalign(bs->file->bs,
                                          (size_t) num_tables * c->table_size);
diff --git a/block/qcow2.c b/block/qcow2.c
index 63e88a1d6e..ea984ce9a6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -663,6 +663,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .help = "Maximum L2 table cache size",
         },
         {
+            .name = QCOW2_OPT_L2_CACHE_ENTRY_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Size of each entry in the L2 cache",
+        },
+        {
             .name = QCOW2_OPT_REFCOUNT_CACHE_SIZE,
             .type = QEMU_OPT_SIZE,
             .help = "Maximum refcount block cache size",
@@ -734,6 +739,7 @@ static void qcow2_attach_aio_context(BlockDriverState *bs,
 
 static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *l2_cache_size,
+                             uint64_t *l2_cache_entry_size,
                              uint64_t *refcount_cache_size, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -789,6 +795,17 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                                  / DEFAULT_L2_REFCOUNT_SIZE_RATIO;
         }
     }
+
+    *l2_cache_entry_size = qemu_opt_get_size(
+        opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
+    if (*l2_cache_entry_size < (1 << MIN_CLUSTER_BITS) ||
+        *l2_cache_entry_size > s->cluster_size ||
+        !is_power_of_2(*l2_cache_entry_size)) {
+        error_setg(errp, "L2 cache entry size must be a power of two "
+                   " between %d and the cluster size (%d)",
+                   1 << MIN_CLUSTER_BITS, s->cluster_size);
+        return;
+    }
 }
 
 typedef struct Qcow2ReopenState {
@@ -811,7 +828,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     QemuOpts *opts = NULL;
     const char *opt_overlap_check, *opt_overlap_check_template;
     int overlap_check_template = 0;
-    uint64_t l2_cache_size, refcount_cache_size;
+    uint64_t l2_cache_size, l2_cache_entry_size, refcount_cache_size;
     int i;
     const char *encryptfmt;
     QDict *encryptopts = NULL;
@@ -830,8 +847,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     }
 
     /* get L2 table/refcount block cache size from command line options */
-    read_cache_sizes(bs, opts, &l2_cache_size, &refcount_cache_size,
-                     &local_err);
+    read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
+                     &refcount_cache_size, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -876,9 +893,13 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
     }
 
-    r->l2_slice_size = s->cluster_size / sizeof(uint64_t);
-    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size);
-    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size);
+    l2_cache_size *= s->cluster_size / l2_cache_entry_size;
+
+    r->l2_slice_size = l2_cache_entry_size / sizeof(uint64_t);
+    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size,
+                                           l2_cache_entry_size);
+    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size,
+                                                 s->cluster_size);
     if (r->l2_table_cache == NULL || r->refcount_block_cache == NULL) {
         error_setg(errp, "Could not allocate metadata caches");
         ret = -ENOMEM;
diff --git a/block/qcow2.h b/block/qcow2.h
index 341d841836..7ef5dbcc2a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -100,6 +100,7 @@
 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
 #define QCOW2_OPT_CACHE_SIZE "cache-size"
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
+#define QCOW2_OPT_L2_CACHE_ENTRY_SIZE "l2-cache-entry-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
 
@@ -656,7 +657,8 @@ void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs);
 
 /* qcow2-cache.c functions */
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
+Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
+                               unsigned table_size);
 int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
-- 
2.11.0
