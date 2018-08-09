Received: from eggs.gnu.org ([2001:4830:134:3::10]:48128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnst2-0004GL-5Y
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnssy-0006Vo-HT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:28 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Fri, 10 Aug 2018 00:53:00 +0300
Message-Id: <20180809215307.18241-2-lbloch@janustech.com>
In-Reply-To: <20180809215307.18241-1-lbloch@janustech.com>
References: <20180809215307.18241-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/8] qcow2: Options' documentation fixes
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

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 docs/qcow2-cache.txt | 16 +++++++++++-----
 qemu-options.hx      |  9 ++++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 8a09a5cc5f..0f157d859a 100644
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
@@ -130,6 +133,9 @@ There are a few things that need to be taken into account:
    memory as possible to the L2 cache before increasing the refcount
    cache size.
 
+ - At most two of "l2-cache-size", "refcount-cache-size", and "cache-size"
+   can be set simultaneously.
+
 Unlike L2 tables, refcount blocks are not used during normal I/O but
 only during allocations and internal snapshots. In most cases they are
 accessed sequentially (even during random guest I/O) so increasing the
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..f6804758d3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -752,15 +752,18 @@ image file)
 
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
2.17.1
