Received: from eggs.gnu.org ([2001:4830:134:3::10]:47534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmP-00058u-1B
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmM-0000Go-0V
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:41 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed, 25 Jul 2018 17:27:57 +0300
Message-Id: <20180725142758.9980-4-lbloch@janustech.com>
In-Reply-To: <20180725142758.9980-1-lbloch@janustech.com>
References: <20180725142758.9980-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 3/4] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

An option "l2-cache-full" is introduced to automatically set the qcow2
L2 cache to a sufficient value for covering the entire image. The memory
overhead when using this option is not big (1 MB for each 8 GB of
virtual image size with the default cluster size) and it can noticeably
improve performance when using large images with frequent I/O.
Previously, for this functionality the correct L2 cache size needed to
be calculated manually or with a script, and then this size needed to be
passed to the "l2-cache-size" option. Now it is sufficient to just pass
the boolean "l2-cache-full" option.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c        | 35 ++++++++++++++++++++++++++++-------
 block/qcow2.h        |  1 +
 docs/qcow2-cache.txt | 15 +++++++++++----
 qapi/block-core.json |  8 +++++++-
 qemu-options.hx      |  6 +++++-
 5 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..d8de9be3cd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -695,6 +695,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Maximum L2 table cache size",
         },
+        {
+            .name = QCOW2_OPT_L2_CACHE_FULL,
+            .type = QEMU_OPT_BOOL,
+            .help = "Create full coverage of the image with the L2 cache",
+        },
         {
             .name = QCOW2_OPT_L2_CACHE_ENTRY_SIZE,
             .type = QEMU_OPT_SIZE,
@@ -779,10 +784,12 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     BDRVQcow2State *s = bs->opaque;
     uint64_t combined_cache_size;
     bool l2_cache_size_set, refcount_cache_size_set, combined_cache_size_set;
+    bool l2_cache_full_set;
     int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
 
     combined_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE);
     l2_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
+    l2_cache_full_set = qemu_opt_get_bool(opts, QCOW2_OPT_L2_CACHE_FULL, 0);
     refcount_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_REFCOUNT_CACHE_SIZE);
 
     combined_cache_size = qemu_opt_get_size(opts, QCOW2_OPT_CACHE_SIZE, 0);
@@ -793,6 +800,17 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     *l2_cache_entry_size = qemu_opt_get_size(
         opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
 
+    uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
+    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
+
+    if (l2_cache_size_set && l2_cache_full_set) {
+        error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " and "
+                   QCOW2_OPT_L2_CACHE_FULL " may not be set at the same time");
+        return;
+    } else if (l2_cache_full_set) {
+        *l2_cache_size = max_l2_cache;
+    }
+
     if (combined_cache_size_set) {
         if (l2_cache_size_set && refcount_cache_size_set) {
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
@@ -800,8 +818,14 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                        "at the same time");
             return;
         } else if (*l2_cache_size > combined_cache_size) {
-            error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
-                       QCOW2_OPT_CACHE_SIZE);
+            if (l2_cache_full_set) {
+                error_setg(errp, QCOW2_OPT_CACHE_SIZE " must be greater than "
+                           "the full L2 cache if " QCOW2_OPT_L2_CACHE_FULL
+                           " is used");
+            } else {
+                error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
+                           QCOW2_OPT_CACHE_SIZE);
+            }
             return;
         } else if (*refcount_cache_size > combined_cache_size) {
             error_setg(errp, QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not exceed "
@@ -809,14 +833,11 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
             return;
         }
 
-        if (l2_cache_size_set) {
+        if (l2_cache_size_set || l2_cache_full_set) {
             *refcount_cache_size = combined_cache_size - *l2_cache_size;
         } else if (refcount_cache_size_set) {
             *l2_cache_size = combined_cache_size - *refcount_cache_size;
         } else {
-            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
-            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
-
             /* Assign as much memory as possible to the L2 cache, and
              * use the remainder for the refcount cache */
             if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
@@ -829,7 +850,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
             }
         }
     } else {
-        if (!l2_cache_size_set) {
+        if (!l2_cache_size_set && !l2_cache_full_set) {
             *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
                                  (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
                                  * s->cluster_size);
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..151e014bd8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -97,6 +97,7 @@
 #define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY "overlap-check.bitmap-directory"
 #define QCOW2_OPT_CACHE_SIZE "cache-size"
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
+#define QCOW2_OPT_L2_CACHE_FULL "l2-cache-full"
 #define QCOW2_OPT_L2_CACHE_ENTRY_SIZE "l2-cache-entry-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 3673f2be0e..bae21061f3 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -110,11 +110,12 @@ How to configure the cache sizes
 Cache sizes can be configured using the -drive option in the
 command-line, or the 'blockdev-add' QMP command.
 
-There are three options available, and all of them take bytes:
+There are four options available:
 
-"l2-cache-size":         maximum size of the L2 table cache
-"refcount-cache-size":   maximum size of the refcount block cache
-"cache-size":            maximum size of both caches combined
+"l2-cache-size":         maximum size of the L2 table cache (bytes, K, M)
+"refcount-cache-size":   maximum size of the refcount block cache (bytes, K, M)
+"cache-size":            maximum size of both caches combined (bytes, K, M)
+"l2-cache-full":         make the L2 cache cover the full image (boolean)
 
 There are a few things that need to be taken into account:
 
@@ -130,6 +131,12 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+- If "l2-cache-full" is specified, QEMU will assign enough memory
+  to the L2 cache to cover the entire size of the image.
+
+- "l2-cache-size" and "l2-cache-full" can not be set simultaneously, as
+  setting "l2-cache-full" already implies a specific size for the L2 cache.
+
 - At most two of "l2-cache-size", "refcount-cache-size", and "cache-size"
   can be set simultaneously.
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d40d5ecc3b..c584059e23 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2812,7 +2812,12 @@
 #                         refcount block caches in bytes (since 2.2)
 #
 # @l2-cache-size:         the maximum size of the L2 table cache in
-#                         bytes (since 2.2)
+#                         bytes (mutually exclusive with l2-cache-full)
+#                         (since 2.2)
+#
+# @l2-cache-full:         make the L2 table cache large enough to cover the
+#                         entire image (mutually exclusive with l2-cache-size)
+#                         (since 3.1)
 #
 # @l2-cache-entry-size:   the size of each entry in the L2 cache in
 #                         bytes. It must be a power of two between 512
@@ -2840,6 +2845,7 @@
             '*overlap-check': 'Qcow2OverlapChecks',
             '*cache-size': 'int',
             '*l2-cache-size': 'int',
+            '*l2-cache-full': 'bool',
             '*l2-cache-entry-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
diff --git a/qemu-options.hx b/qemu-options.hx
index 13ece21cb6..b493371704 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -754,11 +754,15 @@ image file)
 The maximum total size of the L2 table and refcount block caches in bytes
 
 @item l2-cache-size
-The maximum size of the L2 table cache.
+The maximum size of the L2 table cache. (Mutually exclusive with l2-cache-full)
 (default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
 is larger; otherwise, as large as possible or needed within the cache-size,
 while permitting the requested or the minimal refcount cache size)
 
+@item l2-cache-full
+Make the L2 table cache large enough to cover the entire image (mutually
+exclusive with l2-cache-size) (on/off; default: off)
+
 @item refcount-cache-size
 The maximum size of the refcount block cache in bytes
 (default: 4 times the cluster size, or any portion of the cache-size, if it is
-- 
2.14.1
