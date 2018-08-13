Received: from eggs.gnu.org ([2001:4830:134:3::10]:44556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fT-2N
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lg-0001j0-Dp
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:25 +0300
Message-Id: <20180813010729.4844-5-lbloch@janustech.com>
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 4/8] qcow2: Assign the L2 cache relatively
 to the image size
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
large images with frequent I/O.

Previously, unless 'cache-size' was specified and was large enough, the
L2 cache was set to a certain size without taking the virtual image size
into account.

Now, the L2 cache assignment is aware of the virtual size of the image,
and will cover the entire image, unless the cache size needed for that is
larger than a certain maximum. This maximum is set to 1 MB by default
(enough to cover an 8 GB image with the default cluster size) but can
be increased or decreased using the 'l2-cache-size' option. This option
was previously documented as the *maximum* L2 cache size, and this patch
makes it behave as such, instead of as a constant size. Also, the
existing option 'cache-size' can limit the sum of both L2 and refcount
caches, as previously.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c              | 21 +++++++++------------
 block/qcow2.h              |  4 +---
 docs/qcow2-cache.txt       | 15 ++++++++++-----
 qemu-options.hx            |  6 +++---
 tests/qemu-iotests/137     |  1 -
 tests/qemu-iotests/137.out |  1 -
 6 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7949d15fc6..01c39c56c0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -777,29 +777,35 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                              uint64_t *refcount_cache_size, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t combined_cache_size;
+    uint64_t combined_cache_size, l2_cache_max_setting;
     bool l2_cache_size_set, refcount_cache_size_set, combined_cache_size_set;
     int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
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
 
     *l2_cache_entry_size = qemu_opt_get_size(
         opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
 
+    *l2_cache_size = MIN(max_l2_cache, l2_cache_max_setting);
+
     if (combined_cache_size_set) {
         if (l2_cache_size_set && refcount_cache_size_set) {
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
                        " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
                        "at the same time");
             return;
-        } else if (*l2_cache_size > combined_cache_size) {
+        } else if (l2_cache_size_set &&
+                   (l2_cache_max_setting > combined_cache_size)) {
             error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
                        QCOW2_OPT_CACHE_SIZE);
             return;
@@ -814,9 +820,6 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         } else if (refcount_cache_size_set) {
             *l2_cache_size = combined_cache_size - *refcount_cache_size;
         } else {
-            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
-            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
-
             /* Assign as much memory as possible to the L2 cache, and
              * use the remainder for the refcount cache */
             if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
@@ -828,12 +831,6 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                 *l2_cache_size = combined_cache_size - *refcount_cache_size;
             }
         }
-    } else {
-        if (!l2_cache_size_set) {
-            *l2_cache_size = MAX(DEFAULT_L2_CACHE_SIZE,
-                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
-                                 * s->cluster_size);
-        }
     }
     /* l2_cache_size and refcount_cache_size are ensured to have at least
      * their minimum values in qcow2_update_options_prepare() */
diff --git a/block/qcow2.h b/block/qcow2.h
index 39e1b279f8..d917b5f577 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -74,9 +74,7 @@
 /* Must be at least 4 to cover all cases of refcount table growth */
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
 
-/* Whichever is more */
-#define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
-#define DEFAULT_L2_CACHE_SIZE (1 * MiB)
+#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
 
 #define DEFAULT_CLUSTER_SIZE (64 * KiB)
 
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 2326db01b9..e89e74b372 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -124,8 +124,12 @@ There are a few things that need to be taken into account:
  - Both caches must have a size that is a multiple of the cluster size
    (or the cache entry size: see "Using smaller cache sizes" below).
 
- - The default L2 cache size is 8 clusters or 1MB (whichever is more),
-   and the minimum is 2 clusters (or 2 cache entries, see below).
+ - The maximum L2 cache size is 1 MB by default (enough for full coverage
+   of 8 GB images, with the default cluster size). This value can be
+   modified using the "l2-cache-size" option. QEMU will not use more memory
+   than needed to hold all of the image's L2 tables, regardless of this max.
+   value. The minimal L2 cache size is 2 clusters (or 2 cache entries, see
+   below).
 
  - The default (and minimum) refcount cache size is 4 clusters.
 
@@ -183,9 +187,10 @@ Some things to take into account:
    always uses the cluster size as the entry size.
 
  - If the L2 cache is big enough to hold all of the image's L2 tables
-   (as explained in the "Choosing the right cache sizes" section
-   earlier in this document) then none of this is necessary and you
-   can omit the "l2-cache-entry-size" parameter altogether.
+   (as explained in the "Choosing the right cache sizes" and "How to
+   configure the cache sizes" sections in this document) then none of
+   this is necessary and you can omit the "l2-cache-entry-size"
+   parameter altogether.
 
 
 Reducing the memory usage
diff --git a/qemu-options.hx b/qemu-options.hx
index f6804758d3..22e8e2d113 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -756,9 +756,9 @@ The maximum total size of the L2 table and refcount block caches in bytes
 
 @item l2-cache-size
 The maximum size of the L2 table cache in bytes
-(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
-is larger; otherwise, as large as possible or needed within the cache-size,
-while permitting the requested or the minimal refcount cache size)
+(default: if cache-size is not specified - 1M; otherwise, as large as possible
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
