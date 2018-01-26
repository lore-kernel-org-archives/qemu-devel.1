Received: from eggs.gnu.org ([2001:4830:134:3::10]:57889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef6Nu-00084B-Nq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef6Ns-0005em-UL
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:57:46 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 17:00:03 +0200
Message-Id: <b21398747c4eb0c0a9c1ec3ac6b75f354d039026.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 36/39] qcow2: Allow configuring the L2 slice
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

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

Now that the cache entry size is not necessarily equal to the cluster
size we need to reflect that in the MIN_L2_CACHE_SIZE documentation.
That minimum value is a requirement of the COW algorithm: we need to
read two L2 slices (and not two L2 tables) in order to do COW, see
l2_allocate() for the actual code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c  | 10 ++++++++--
 block/qcow2.c        | 34 +++++++++++++++++++++++++++-------
 block/qcow2.h        |  6 ++++--
 qapi/block-core.json |  6 ++++++
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index b1aa42477e..d9dafa31e5 100644
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
index 529becfa30..98762433a0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -674,6 +674,11 @@ static QemuOptsList qcow2_runtime_opts = {
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
@@ -745,6 +750,7 @@ static void qcow2_attach_aio_context(BlockDriverState *bs,
 
 static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *l2_cache_size,
+                             uint64_t *l2_cache_entry_size,
                              uint64_t *refcount_cache_size, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -760,6 +766,9 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     *refcount_cache_size = qemu_opt_get_size(opts,
                                              QCOW2_OPT_REFCOUNT_CACHE_SIZE, 0);
 
+    *l2_cache_entry_size = qemu_opt_get_size(
+        opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
+
     if (combined_cache_size_set) {
         if (l2_cache_size_set && refcount_cache_size_set) {
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
@@ -800,6 +809,15 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                                  / DEFAULT_L2_REFCOUNT_SIZE_RATIO;
         }
     }
+
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
@@ -822,7 +840,7 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     QemuOpts *opts = NULL;
     const char *opt_overlap_check, *opt_overlap_check_template;
     int overlap_check_template = 0;
-    uint64_t l2_cache_size, refcount_cache_size;
+    uint64_t l2_cache_size, l2_cache_entry_size, refcount_cache_size;
     int i;
     const char *encryptfmt;
     QDict *encryptopts = NULL;
@@ -841,15 +859,15 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     }
 
     /* get L2 table/refcount block cache size from command line options */
-    read_cache_sizes(bs, opts, &l2_cache_size, &refcount_cache_size,
-                     &local_err);
+    read_cache_sizes(bs, opts, &l2_cache_size, &l2_cache_entry_size,
+                     &refcount_cache_size, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
     }
 
-    l2_cache_size /= s->cluster_size;
+    l2_cache_size /= l2_cache_entry_size;
     if (l2_cache_size < MIN_L2_CACHE_SIZE) {
         l2_cache_size = MIN_L2_CACHE_SIZE;
     }
@@ -887,9 +905,11 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
     }
 
-    r->l2_slice_size = s->cluster_size / sizeof(uint64_t);
-    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size);
-    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size);
+    r->l2_slice_size = l2_cache_entry_size / sizeof(uint64_t);
+    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size,
+                                           l2_cache_entry_size);
+    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size,
+                                                 s->cluster_size);
     if (r->l2_table_cache == NULL || r->refcount_block_cache == NULL) {
         error_setg(errp, "Could not allocate metadata caches");
         ret = -ENOMEM;
diff --git a/block/qcow2.h b/block/qcow2.h
index 87b5c4063e..d20753f140 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -68,7 +68,7 @@
 #define MAX_CLUSTER_BITS 21
 
 /* Must be at least 2 to cover COW */
-#define MIN_L2_CACHE_SIZE 2 /* clusters */
+#define MIN_L2_CACHE_SIZE 2 /* cache entries */
 
 /* Must be at least 4 to cover all cases of refcount table growth */
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
@@ -100,6 +100,7 @@
 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
 #define QCOW2_OPT_CACHE_SIZE "cache-size"
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
+#define QCOW2_OPT_L2_CACHE_ENTRY_SIZE "l2-cache-entry-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
 
@@ -647,7 +648,8 @@ void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs);
 
 /* qcow2-cache.c functions */
-Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
+Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
+                               unsigned table_size);
 int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8225308904..8556123cf4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2507,6 +2507,11 @@
 # @l2-cache-size:         the maximum size of the L2 table cache in
 #                         bytes (since 2.2)
 #
+# @l2-cache-entry-size:   the size of each entry in the L2 cache in
+#                         bytes. It must be a power of two between 512
+#                         and the cluster size. The default value is
+#                         the cluster size (since 2.12)
+#
 # @refcount-cache-size:   the maximum size of the refcount block cache
 #                         in bytes (since 2.2)
 #
@@ -2528,6 +2533,7 @@
             '*overlap-check': 'Qcow2OverlapChecks',
             '*cache-size': 'int',
             '*l2-cache-size': 'int',
+            '*l2-cache-entry-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
             '*encrypt': 'BlockdevQcow2Encryption' } }
-- 
2.11.0
