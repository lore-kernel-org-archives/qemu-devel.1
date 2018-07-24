Received: from eggs.gnu.org ([2001:4830:134:3::10]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGv-00052U-QI
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGt-0006Gg-2a
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:33 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 15:17:50 +0300
Message-Id: <20180724121753.5753-2-lbloch@janustech.com>
In-Reply-To: <20180724121753.5753-1-lbloch@janustech.com>
References: <20180724121753.5753-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/4] qcow2: Introduce an option for sufficient
 L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

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
 block/qcow2.c        | 37 +++++++++++++++++++++++++++++--------
 block/qcow2.h        |  1 +
 qapi/block-core.json |  4 ++++
 qemu-options.hx      |  4 ++++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6162ed8be2..101b8b474b 100644
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
+    l2_cache_full_set = qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_FULL);
     refcount_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_REFCOUNT_CACHE_SIZE);
 
     combined_cache_size = qemu_opt_get_size(opts, QCOW2_OPT_CACHE_SIZE, 0);
@@ -793,15 +800,32 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
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
                        " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
-                       "the same time");
+                       "at the same time");
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
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d40d5ecc3b..53c7d2efd8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2814,6 +2814,9 @@
 # @l2-cache-size:         the maximum size of the L2 table cache in
 #                         bytes (since 2.2)
 #
+# @l2-cache-full:         make the L2 table cache large enough to cover the
+#                         entire image (since 3.1)
+#
 # @l2-cache-entry-size:   the size of each entry in the L2 cache in
 #                         bytes. It must be a power of two between 512
 #                         and the cluster size. The default value is
@@ -2840,6 +2843,7 @@
             '*overlap-check': 'Qcow2OverlapChecks',
             '*cache-size': 'int',
             '*l2-cache-size': 'int',
+            '*l2-cache-full': 'bool',
             '*l2-cache-entry-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..be4d862795 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -758,6 +758,10 @@ The maximum total size of the L2 table and refcount block caches in bytes
 The maximum size of the L2 table cache in bytes
 (default: 4/5 of the total cache size)
 
+@item l2-cache-full
+Make the L2 table cache large enough to cover the entire image
+(on/off; default: off)
+
 @item refcount-cache-size
 The maximum size of the refcount block cache in bytes
 (default: 1/5 of the total cache size)
-- 
2.14.1
