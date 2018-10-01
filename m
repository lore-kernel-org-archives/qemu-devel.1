Received: from eggs.gnu.org ([2001:4830:134:3::10]:57935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rE-0002Xv-3w
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rC-0007KN-1l
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:54 +0200
Message-Id: <20181001171901.11004-17-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/23] qcow2: Increase the default upper limit
 on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Leonid Bloch <lbloch@janustech.com>

The upper limit on the L2 cache size is increased from 1 MB to 32 MB
on Linux platforms, and to 8 MB on other platforms (this difference is
caused by the ability to set intervals for cache cleaning on Linux
platforms only).

This is done in order to allow default full coverage with the L2 cache
for images of up to 256 GB in size (was 8 GB). Note, that only the
needed amount to cover the full image is allocated. The value which is
changed here is just the upper limit on the L2 cache size, beyond which
it will not grow, even if the size of the image will require it to.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qcow2-cache.txt | 15 +++++++++------
 block/qcow2.h        |  6 +++++-
 qemu-options.hx      |  6 +++---
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 750447ea4f..1fcc0658b2 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -125,12 +125,15 @@ There are a few things that need to be taken into account:
  - Both caches must have a size that is a multiple of the cluster size
    (or the cache entry size: see "Using smaller cache sizes" below).
 
- - The maximum L2 cache size is 1 MB by default (enough for full coverage
-   of 8 GB images, with the default cluster size). This value can be
-   modified using the "l2-cache-size" option. QEMU will not use more memory
-   than needed to hold all of the image's L2 tables, regardless of this max.
-   value. The minimal L2 cache size is 2 clusters (or 2 cache entries, see
-   below).
+ - The maximum L2 cache size is 32 MB by default on Linux platforms (enough
+   for full coverage of 256 GB images, with the default cluster size). This
+   value can be modified using the "l2-cache-size" option. QEMU will not use
+   more memory than needed to hold all of the image's L2 tables, regardless
+   of this max. value.
+   On non-Linux platforms the maximal value is smaller by default (8 MB) and
+   this difference stems from the fact that on Linux the cache can be cleared
+   periodically if needed, using the "cache-clean-interval" option (see below).
+   The minimal L2 cache size is 2 clusters (or 2 cache entries, see below).
 
  - The default (and minimum) refcount cache size is 4 clusters.
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 2f8c1fd15c..0f0e3534bf 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -74,7 +74,11 @@
 /* Must be at least 4 to cover all cases of refcount table growth */
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
 
-#define DEFAULT_L2_CACHE_MAX_SIZE S_1MiB
+#ifdef CONFIG_LINUX
+#define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
+#else
+#define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
+#endif
 
 #define DEFAULT_CLUSTER_SIZE S_64KiB
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 6eef0f5651..14aee78c6c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -736,9 +736,9 @@ The maximum total size of the L2 table and refcount block caches in bytes
 
 @item l2-cache-size
 The maximum size of the L2 table cache in bytes
-(default: if cache-size is not specified - 1M; otherwise, as large as possible
-within the cache-size, while permitting the requested or the minimal refcount
-cache size)
+(default: if cache-size is not specified - 32M on Linux platforms, and 8M on
+non-Linux platforms; otherwise, as large as possible within the cache-size,
+while permitting the requested or the minimal refcount cache size)
 
 @item refcount-cache-size
 The maximum size of the refcount block cache in bytes
-- 
2.13.6
