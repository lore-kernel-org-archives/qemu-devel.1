Received: from eggs.gnu.org ([2001:4830:134:3::10]:41640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnloZ-0004Ng-NN
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnloW-0004dE-9m
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:21:23 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Thu,  9 Aug 2018 17:20:43 +0300
Message-Id: <20180809142046.12311-3-lbloch@janustech.com>
In-Reply-To: <20180809142046.12311-1-lbloch@janustech.com>
References: <20180809142046.12311-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/5] qcow2: Assign the L2 cache relatively
 to image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

Sufficient L2 cache can noticeably improve the performance when using
large images with frequent I/O. The memory overhead is not significant
in most cases, as the cache size is only 1 MB for each 8 GB of virtual
image size (with the default cluster size of 64 KB).

Previously, the L2 cache was allocated without considering the image
size, and an option existed to manually determine this size. Thus to
achieve full coverage of the image by the L2 cache (i.e. use more than
the default value of MAX(1 MB, 8 clusters)), a user needed to calculate
the required size manually or using a script, and pass this value to the
'l2-cache-size' option.

Now, the L2 cache is assigned taking the actual image size into account,
and will cover the entire image, unless the size needed for that is
larger than a certain maximum. This maximum is set to 32 MB by default
(enough to cover a 256 GB image using the default cluster size) but can
be increased or decreased using the 'l2-cache-size' option. This option
was previously documented as the *maximum* L2 cache size, and this patch
makes it behave as such, instead of as a constant size. Also, the
existing option 'cache-size' can limit the sum of both L2 and refcount
caches, as previously.

Additionally, some minor related changes were made:
* Refactoring in the immediate proximity of the functional changes.
* refcount-cache-size is not ensured to be at least at its minimum size
  in read_cache_sizes(), as it is set to at least the minimum size in
  qcow2_update_options_prepare() anyway.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c              | 38 ++++++++++++++++----------------------
 block/qcow2.h              |  4 +---
 docs/qcow2-cache.txt       | 26 ++++++++++++++++----------
 qemu-options.hx            |  6 +++---
 tests/qemu-iotests/137     |  1 -
 tests/qemu-iotests/137.out |  1 -
 6 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..092bd17975 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -777,21 +777,27 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *refcount_cache_size, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t combined_cache_size;
+    uint64_t combined_cache_size, l2_cache_max_setting;
     bool l2_cache_size_set, refcount_cache_size_set, combined_cache_size_set;
-    int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
+    uint64_t min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
+    uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
+    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
 
     combined_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE);
     l2_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
     refcount_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_REFCOUNT_CACHE_SIZE);
 
     combined_cache_size = qemu_opt_get_size(opts, QCOW2_OPT_CACHE_SIZE, 0);
-    *l2_cache_size = qemu_opt_get_size(opts, QCOW2_OPT_L2_CACHE_SIZE, 0);
+    l2_cache_max_setting = qemu_opt_get_size(opts, QCOW2_OPT_L2_CACHE_SIZE,
+                                             DEFAULT_L2_CACHE_MAX_SIZE);
     *refcount_cache_size = qemu_opt_get_size(opts,
                                              QCOW2_OPT_REFCOUNT_CACHE_SIZE, 0);
 
-    *l2_cache_entry_size = qemu_opt_get_size(
-        opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
+    *l2_cache_entry_size = qemu_opt_get_size(opts,
+                                             QCOW2_OPT_L2_CACHE_ENTRY_SIZE,
+                                             s->cluster_size);
+
+    *l2_cache_size = MIN(max_l2_cache, l2_cache_max_setting);
 
     if (combined_cache_size_set) {
         if (l2_cache_size_set && refcount_cache_size_set) {
@@ -799,7 +805,8 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                        " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
                        "at the same time");
             return;
-        } else if (*l2_cache_size > combined_cache_size) {
+        } else if (l2_cache_size_set &&
+                   (l2_cache_max_setting > combined_cache_size)) {
             error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
                        QCOW2_OPT_CACHE_SIZE);
             return;
@@ -814,29 +821,16 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         } else if (refcount_cache_size_set) {
             *l2_cache_size = combined_cache_size - *refcount_cache_size;
         } else {
-            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
-            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
-
             /* Assign as much memory as possible to the L2 cache, and
              * use the remainder for the refcount cache */
-            if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
-                *l2_cache_size = max_l2_cache;
+            if (combined_cache_size >= *l2_cache_size + min_refcount_cache) {
                 *refcount_cache_size = combined_cache_size - *l2_cache_size;
             } else {
-                *refcount_cache_size =
-                    MIN(combined_cache_size, min_refcount_cache);
+                *refcount_cache_size = MIN(combined_cache_size,
+                                           min_refcount_cache);
                 *l2_cache_size = combined_cache_size - *refcount_cache_size;
             }
         }
-    } else {
-        if (!l2_cache_size_set) {
-            *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
-                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
-                                 * s->cluster_size);
-        }
-        if (!refcount_cache_size_set) {
-            *refcount_cache_size = min_refcount_cache;
-        }
     }
 
     if (*l2_cache_entry_size < (1 << MIN_CLUSTER_BITS) ||
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..d77a31d932 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -73,9 +73,7 @@
 /* Must be at least 4 to cover all cases of refcount table growth */
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
 
-/* Whichever is more */
-#define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
-#define DEFAULT_L2_CACHE_BYTE_SIZE 1048576 /* bytes */
+#define DEFAULT_L2_CACHE_MAX_SIZE 0x2000000U /* bytes */
 
 #define DEFAULT_CLUSTER_SIZE 65536
 
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 5bf2a8ad29..6ad1081d1a 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -97,12 +97,15 @@ need:
    l2_cache_size = disk_size_GB * 131072
    refcount_cache_size = disk_size_GB * 32768
 
-QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
-cache of 256KB (262144 bytes), so using the formulas we've just seen
-we have
+With the default cluster size, to cover each 8 GB of the virtual image
+size, 1MB of L2 cache is needed:
 
-   1048576 / 131072 = 8 GB of virtual disk covered by that cache
-    262144 /  32768 = 8 GB
+   65536 / 8 = 8192 = 8 GB / 1 MB
+
+A default refcount cache is 4 times the cluster size, which defaults to
+256 KB (262144 bytes). This is sufficient for 8 GB of image size:
+
+   262144 / 32768 = 8 GB
 
 
 How to configure the cache sizes
@@ -121,8 +124,11 @@ There are a few things that need to be taken into account:
  - Both caches must have a size that is a multiple of the cluster size
    (or the cache entry size: see "Using smaller cache sizes" below).
 
- - The default L2 cache size is 8 clusters or 1MB (whichever is more),
-   and the minimum is 2 clusters (or 2 cache entries, see below).
+ - The default L2 cache size will cover the entire virtual size of an
+   image, up to a certain maximum. This maximum is 32 MB by default
+   (enough for image sizes of up to 256 GB with the default cluster size)
+   and it can be reduced or enlarged using the "l2-cache-size" option.
+   The minimum is 2 clusters (or 2 cache entries, see below).
 
  - The default (and minimum) refcount cache size is 4 clusters.
 
@@ -180,9 +186,9 @@ Some things to take into account:
    always uses the cluster size as the entry size.
 
  - If the L2 cache is big enough to hold all of the image's L2 tables
-   (as explained in the "Choosing the right cache sizes" section
-   earlier in this document) then none of this is necessary and you
-   can omit the "l2-cache-entry-size" parameter altogether.
+   (the default behavior for images of up to 256 GB in size) then none
+   of this is necessary and you can omit the "l2-cache-entry-size"
+   parameter altogether.
 
 
 Reducing the memory usage
diff --git a/qemu-options.hx b/qemu-options.hx
index f6804758d3..4c44cdbc23 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -756,9 +756,9 @@ The maximum total size of the L2 table and refcount block caches in bytes
 
 @item l2-cache-size
 The maximum size of the L2 table cache in bytes
-(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
-is larger; otherwise, as large as possible or needed within the cache-size,
-while permitting the requested or the minimal refcount cache size)
+(default: if cache-size is not specified - 32M; otherwise, as large as possible
+within the cache-size, while permitting the requested or the minimal refcount
+cache size)
 
 @item refcount-cache-size
 The maximum size of the refcount block cache in bytes
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 87965625d8..e3fb078588 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -109,7 +109,6 @@ $QEMU_IO \
     -c "reopen -o cache-size=1M,l2-cache-size=64k,refcount-cache-size=64k" \
     -c "reopen -o cache-size=1M,l2-cache-size=2M" \
     -c "reopen -o cache-size=1M,refcount-cache-size=2M" \
-    -c "reopen -o l2-cache-size=256T" \
     -c "reopen -o l2-cache-entry-size=33k" \
     -c "reopen -o l2-cache-entry-size=128k" \
     -c "reopen -o refcount-cache-size=256T" \
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 6a2ffc71fd..70f245ae7a 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -19,7 +19,6 @@ Parameter 'lazy-refcounts' expects 'on' or 'off'
 cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
 l2-cache-size may not exceed cache-size
 refcount-cache-size may not exceed cache-size
-L2 cache size too big
 L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 Refcount cache size too big
-- 
2.17.1
