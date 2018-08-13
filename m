Received: from eggs.gnu.org ([2001:4830:134:3::10]:44553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fS-1s
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lg-0001jK-Uc
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:26 +0300
Message-Id: <20180813010729.4844-6-lbloch@janustech.com>
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 5/8] qcow2: Increase the default upper limit
 on the L2 cache size
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

The upper limit on the L2 cache size is increased from 1 MB to 32 MB.
This is done in order to allow default full coverage with the L2 cache
for images of up to 256 GB in size (was 8 GB). Note, that only the
needed amount to cover the full image is allocated. The value which is
changed here is just the upper limit on the L2 cache size, beyond which
it will not grow, even if the size of the image will require it to.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h        | 2 +-
 docs/qcow2-cache.txt | 4 ++--
 qemu-options.hx      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index d917b5f577..e699a55d02 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -74,7 +74,7 @@
 /* Must be at least 4 to cover all cases of refcount table growth */
 #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
 
-#define DEFAULT_L2_CACHE_MAX_SIZE (1 * MiB)
+#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
 
 #define DEFAULT_CLUSTER_SIZE (64 * KiB)
 
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index e89e74b372..0fc438f397 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -124,8 +124,8 @@ There are a few things that need to be taken into account:
  - Both caches must have a size that is a multiple of the cluster size
    (or the cache entry size: see "Using smaller cache sizes" below).
 
- - The maximum L2 cache size is 1 MB by default (enough for full coverage
-   of 8 GB images, with the default cluster size). This value can be
+ - The maximum L2 cache size is 32 MB by default (enough for full coverage
+   of 256 GB images, with the default cluster size). This value can be
    modified using the "l2-cache-size" option. QEMU will not use more memory
    than needed to hold all of the image's L2 tables, regardless of this max.
    value. The minimal L2 cache size is 2 clusters (or 2 cache entries, see
diff --git a/qemu-options.hx b/qemu-options.hx
index 22e8e2d113..4c44cdbc23 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -756,7 +756,7 @@ The maximum total size of the L2 table and refcount block caches in bytes
 
 @item l2-cache-size
 The maximum size of the L2 table cache in bytes
-(default: if cache-size is not specified - 1M; otherwise, as large as possible
+(default: if cache-size is not specified - 32M; otherwise, as large as possible
 within the cache-size, while permitting the requested or the minimal refcount
 cache size)
 
-- 
2.17.1
