Received: from eggs.gnu.org ([2001:4830:134:3::10]:33883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF2-00020J-7k
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF0-0000XD-D8
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 30 Jul 2018 00:27:43 +0300
Message-Id: <20180729212744.23709-6-lbloch@janustech.com>
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/6] qcow2: Make the default L2 cache
 sufficient to cover the entire image
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

Sufficient L2 cache can noticeably improve the performance when using
large images with frequent I/O. The memory overhead is not significant,
as the cache size is only 1 MB for each 8 GB of virtual image size (with
the default cluster size of 64 KB). On systems with limited memory, one
can limit the cache size by the l2-cache-size and cache-size options.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c        | 10 ++++------
 block/qcow2.h        |  4 ----
 docs/qcow2-cache.txt | 21 +++++++++++----------
 qemu-options.hx      |  6 +++---
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 223d351e40..74f2cb10a4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -793,6 +793,9 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     *l2_cache_entry_size = qemu_opt_get_size(
         opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
 
+    uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
+    uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
+
     if (combined_cache_size_set) {
         if (l2_cache_size_set && refcount_cache_size_set) {
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
@@ -814,9 +817,6 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         } else if (refcount_cache_size_set) {
             *l2_cache_size = combined_cache_size - *refcount_cache_size;
         } else {
-            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
-            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
-
             /* Assign as much memory as possible to the L2 cache, and
              * use the remainder for the refcount cache */
             if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
@@ -830,9 +830,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         }
     } else {
         if (!l2_cache_size_set) {
-            *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
-                                 (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
-                                 * s->cluster_size);
+            *l2_cache_size = max_l2_cache;
         }
         if (!refcount_cache_size_set) {
             *refcount_cache_size = min_refcount_cache;
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..1b9005e13c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -73,10 +73,6 @@
 /* Must be at least 4 to cover all cases of refcount table growth */
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
 
-/* Whichever is more */
-#define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
-#define DEFAULT_L2_CACHE_BYTE_SIZE 1048576 /* bytes */
-
 #define DEFAULT_CLUSTER_SIZE 65536
 
 
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index fd9a6911cc..bcc03c8857 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -97,12 +97,14 @@ need:
    l2_cache_size = disk_size_GB * 131072
    refcount_cache_size = disk_size_GB * 32768
 
-QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
-cache of 256KB (262144 bytes), so using the formulas we've just seen
-we have
+QEMU will use a default L2 cache sufficient to cover the entire virtual
+size of an image, which with the default cluster size will result in 1MB
+of cache for every 8GB of virtual image size:
 
-   1048576 / 131072 = 8 GB of virtual disk covered by that cache
-    262144 /  32768 = 8 GB
+   65536 / 8 = 8192 = 8 GB / 1 MB
+
+A default refcount cache is 4 times the cluster size, which defaults to
+256KB (262144 bytes).
 
 
 How to configure the cache sizes
@@ -121,8 +123,8 @@ There are a few things that need to be taken into account:
  - Both caches must have a size that is a multiple of the cluster size
    (or the cache entry size: see "Using smaller cache sizes" below).
 
- - The default L2 cache size is 8 clusters or 1MB (whichever is more),
-   and the minimum is 2 clusters (or 2 cache entries, see below).
+ - The default L2 cache size is enough to cover the entire virtual size of
+   an image, and the minimum is 2 clusters (or 2 cache entries, see below).
 
  - The default (and minimum) refcount cache size is 4 clusters.
 
@@ -180,9 +182,8 @@ Some things to take into account:
    always uses the cluster size as the entry size.
 
  - If the L2 cache is big enough to hold all of the image's L2 tables
-   (as explained in the "Choosing the right cache sizes" section
-   earlier in this document) then none of this is necessary and you
-   can omit the "l2-cache-entry-size" parameter altogether.
+   (the default behavior) then none of this is necessary and you can
+   omit the "l2-cache-entry-size" parameter altogether.
 
 
 Reducing the memory usage
diff --git a/qemu-options.hx b/qemu-options.hx
index 18f3f87da5..c9e7764c13 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -756,9 +756,9 @@ The maximal total size of the L2 table and refcount block caches in bytes
 
 @item l2-cache-size
 The maximal size of the L2 table cache in bytes
-(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
-is larger; otherwise, as large as possible or needed within the cache-size,
-while permitting the requested or the minimal refcount cache size)
+(default: if cache-size is not defined - enough to cover the entire image;
+otherwise, as large as possible or needed within the cache-size, while
+permitting the requested or the minimal refcount cache size)
 
 @item refcount-cache-size
 The maximal size of the refcount block cache in bytes
-- 
2.17.1
