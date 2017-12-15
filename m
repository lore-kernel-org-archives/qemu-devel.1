Received: from eggs.gnu.org ([2001:4830:134:3::10]:55567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVI-0000X8-4u
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003Hm-BI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:59 +0100
Message-Id: <8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 31/32] qcow2: Allow configuring the L2 slice
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

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
index 2fcecbd7a8..fe58d1ec70 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -120,14 +120,20 @@ void qcow2_cache_clean_unused(Qcow2Cache *c)
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
index 38c2ccf210..fb6b352c66 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -666,6 +666,11 @@ static QemuOptsList qcow2_runtime_opts = {
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
@@ -737,6 +742,7 @@ static void qcow2_attach_aio_context(BlockDriverState *bs,
 
 static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *l2_cache_size,
+                             uint64_t *l2_cache_entry_size,
                              uint64_t *refcount_cache_size, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -792,6 +798,17 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
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
+                   "between %d and the cluster size (%d)",
+                   1 << MIN_CLUSTER_BITS, s->cluster_size);
+        return;
+    }
 }
 
 typedef struct Qcow2ReopenState {
@@ -814,7 +831,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     QemuOpts *opts = NULL;
     const char *opt_overlap_check, *opt_overlap_check_template;
     int overlap_check_template = 0;
-    uint64_t l2_cache_size, refcount_cache_size;
+    uint64_t l2_cache_size, l2_cache_entry_size, refcount_cache_size;
     int i;
     const char *encryptfmt;
     QDict *encryptopts = NULL;
@@ -833,8 +850,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     }
 
     /* get L2 table/refcount block cache size from command line options */
-    read_cache_sizes(bs, opts, &l2_cache_size, &refcount_cache_size,
-                     &local_err);
+    read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
+                     &refcount_cache_size, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -879,9 +896,13 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
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
index 1894d1d028..1f5f0d56a6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -100,6 +100,7 @@
 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
 #define QCOW2_OPT_CACHE_SIZE "cache-size"
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
+#define QCOW2_OPT_L2_CACHE_ENTRY_SIZE "l2-cache-entry-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
 
@@ -650,7 +651,8 @@ void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs);
 
 /* qcow2-cache.c functions */
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
+Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
+                               unsigned table_size);
 int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
-- 
2.11.0
