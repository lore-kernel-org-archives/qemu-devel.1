Received: from eggs.gnu.org ([2001:4830:134:3::10]:57922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rD-0002XU-Qs
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007K2-V8
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:49 +0200
Message-Id: <20181001171901.11004-12-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/23] qcow2: Options' documentation fixes
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

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qcow2-cache.txt | 21 ++++++++++++++-------
 qemu-options.hx      |  9 ++++++---
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 8a09a5cc5f..7e28b41bd3 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -79,14 +79,14 @@ Choosing the right cache sizes
 In order to choose the cache sizes we need to know how they relate to
 the amount of allocated space.
 
-The amount of virtual disk that can be mapped by the L2 and refcount
+The part of the virtual disk that can be mapped by the L2 and refcount
 caches (in bytes) is:
 
    disk_size = l2_cache_size * cluster_size / 8
    disk_size = refcount_cache_size * cluster_size * 8 / refcount_bits
 
 With the default values for cluster_size (64KB) and refcount_bits
-(16), that is
+(16), this becomes:
 
    disk_size = l2_cache_size * 8192
    disk_size = refcount_cache_size * 32768
@@ -97,12 +97,16 @@ need:
    l2_cache_size = disk_size_GB * 131072
    refcount_cache_size = disk_size_GB * 32768
 
-QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
-cache of 256KB (262144 bytes), so using the formulas we've just seen
-we have
+For example, 1MB of L2 cache is needed to cover every 8 GB of the virtual
+image size (given that the default cluster size is used):
 
-   1048576 / 131072 = 8 GB of virtual disk covered by that cache
-    262144 /  32768 = 8 GB
+   8 GB / 8192 = 1 MB
+
+The refcount cache is 4 times the cluster size by default. With the default
+cluster size of 64 KB, it is 256 KB (262144 bytes). This is sufficient for
+8 GB of image size:
+
+   262144 * 32768 = 8 GB
 
 
 How to configure the cache sizes
@@ -130,6 +134,9 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+ - At most two of "l2-cache-size", "refcount-cache-size", and "cache-size"
+   can be set simultaneously.
+
 Unlike L2 tables, refcount blocks are not used during normal I/O but
 only during allocations and internal snapshots. In most cases they are
 accessed sequentially (even during random guest I/O) so increasing the
diff --git a/qemu-options.hx b/qemu-options.hx
index a642ad297f..2db6247eff 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -732,15 +732,18 @@ image file)
 
 @item cache-size
 The maximum total size of the L2 table and refcount block caches in bytes
-(default: 1048576 bytes or 8 clusters, whichever is larger)
+(default: the sum of l2-cache-size and refcount-cache-size)
 
 @item l2-cache-size
 The maximum size of the L2 table cache in bytes
-(default: 4/5 of the total cache size)
+(default: if cache-size is not defined - 1048576 bytes or 8 clusters, whichever
+is larger; otherwise, as large as possible or needed within the cache-size,
+while permitting the requested or the minimal refcount cache size)
 
 @item refcount-cache-size
 The maximum size of the refcount block cache in bytes
-(default: 1/5 of the total cache size)
+(default: 4 times the cluster size; or if cache-size is specified, the part of
+it which is not used for the L2 cache)
 
 @item cache-clean-interval
 Clean unused entries in the L2 and refcount caches. The interval is in seconds.
-- 
2.13.6
