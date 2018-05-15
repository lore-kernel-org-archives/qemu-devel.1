Received: from eggs.gnu.org ([2001:4830:134:3::10]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4Z-0006pC-4D
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4U-0001YK-AT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:17 +0200
Message-Id: <20180515154033.19899-22-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/37] docs: Document the new default sizes of
 the qcow2 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

We have just reduced the refcount cache size to the minimum unless
the user explicitly requests a larger one, so we have to update the
documentation to reflect this change.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: c5f0bde23558dd9d33b21fffc76ac9953cc19c56.1523968389.git.berto@igalia.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/qcow2-cache.txt | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index 170191a242..8a09a5cc5f 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -116,31 +116,30 @@ There are three options available, and all of them take bytes:
 "refcount-cache-size":   maximum size of the refcount block cache
 "cache-size":            maximum size of both caches combined
 
-There are two things that need to be taken into account:
+There are a few things that need to be taken into account:
 
  - Both caches must have a size that is a multiple of the cluster size
    (or the cache entry size: see "Using smaller cache sizes" below).
 
- - If you only set one of the options above, QEMU will automatically
-   adjust the others so that the L2 cache is 4 times bigger than the
-   refcount cache.
+ - The default L2 cache size is 8 clusters or 1MB (whichever is more),
+   and the minimum is 2 clusters (or 2 cache entries, see below).
 
-This means that these options are equivalent:
+ - The default (and minimum) refcount cache size is 4 clusters.
 
-   -drive file=hd.qcow2,l2-cache-size=2097152
-   -drive file=hd.qcow2,refcount-cache-size=524288
-   -drive file=hd.qcow2,cache-size=2621440
+ - If only "cache-size" is specified then QEMU will assign as much
+   memory as possible to the L2 cache before increasing the refcount
+   cache size.
 
-The reason for this 1/4 ratio is to ensure that both caches cover the
-same amount of disk space. Note however that this is only valid with
-the default value of refcount_bits (16). If you are using a different
-value you might want to calculate both cache sizes yourself since QEMU
-will always use the same 1/4 ratio.
+Unlike L2 tables, refcount blocks are not used during normal I/O but
+only during allocations and internal snapshots. In most cases they are
+accessed sequentially (even during random guest I/O) so increasing the
+refcount cache size won't have any measurable effect in performance
+(this can change if you are using internal snapshots, so you may want
+to think about increasing the cache size if you use them heavily).
 
-It's also worth mentioning that there's no strict need for both caches
-to cover the same amount of disk space. The refcount cache is used
-much less often than the L2 cache, so it's perfectly reasonable to
-keep it small.
+Before QEMU 2.12 the refcount cache had a default size of 1/4 of the
+L2 cache size. This resulted in unnecessarily large caches, so now the
+refcount cache is as small as possible unless overridden by the user.
 
 
 Using smaller cache entries
-- 
2.13.6
