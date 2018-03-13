Received: from eggs.gnu.org ([2001:4830:134:3::10]:33409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1evlSO-0003Pt-LA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1evlSJ-0005u6-Gy
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:03:16 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 13 Mar 2018 17:02:11 +0200
Message-Id: <0b8f83b4f26071753dc409645ad8c6f6e215468a.1520952419.git.berto@igalia.com>
In-Reply-To: <cover.1520952419.git.berto@igalia.com>
References: <cover.1520952419.git.berto@igalia.com>
In-Reply-To: <cover.1520952419.git.berto@igalia.com>
References: <cover.1520952419.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/2] qcow2: Give the refcount cache the minimum
 possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

The L2 and refcount caches have default sizes that can be overriden
using the l2-cache-size and refcount-cache-size (an additional
parameter named cache-size sets the combined size of both caches).

Unless forced by one of the aforementioned parameters, QEMU will set
the unspecified sizes so that the L2 cache is 4 times larger than the
refcount cache.

This is based on the premise that the refcount metadata needs to be
only a fourth of the L2 metadata to cover the same amount of disk
space. This is incorrect for two reasons:

 a) The amount of disk covered by an L2 table depends solely on the
    cluster size, but in the case of a refcount block it depends on
    the cluster size *and* the width of each refcount entry.
    The 4/1 ratio is only valid with 16-bit entries (the default).

 b) When we talk about disk space and L2 tables we are talking about
    guest space (L2 tables map guest clusters to host clusters),
    whereas refcount blocks are used for host clusters (including
    L1/L2 tables and the refcount blocks themselves). On a fully
    populated (and uncompressed) qcow2 file, image size > virtual size
    so there are more refcount entries than L2 entries.

Problem (a) could be fixed by adjusting the algorithm to take into
account the refcount entry width. Problem (b) could be fixed by
increasing a bit the refcount cache size to account for the clusters
used for qcow2 metadata.

However this patch takes a completely different approach and instead
of keeping a ratio between both cache sizes it assigns as much as
possible to the L2 cache and the remainder to the refcount cache.

The reason is that L2 tables are used for every single I/O request
from the guest and the effect of increasing the cache is significant
and clearly measurable. Refcount blocks are however only used for
cluster allocation and internal snapshots and in practice are accessed
sequentially in most cases, so the effect of increasing the cache is
negligible (even when doing random writes from the guest).

So, make the refcount cache as small as possible unless the user
explicitly asks for a larger one.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              | 31 +++++++++++++++++++------------
 block/qcow2.h              |  4 ----
 tests/qemu-iotests/137.out |  2 +-
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7472af6931..8342b0186f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -802,23 +802,30 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         } else if (refcount_cache_size_set) {
             *l2_cache_size = combined_cache_size - *refcount_cache_size;
         } else {
-            *refcount_cache_size = combined_cache_size
-                                 / (DEFAULT_L2_REFCOUNT_SIZE_RATIO + 1);
-            *l2_cache_size = combined_cache_size - *refcount_cache_size;
+            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
+            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
+            uint64_t min_refcount_cache =
+                (uint64_t) MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
+
+            /* Assign as much memory as possible to the L2 cache, and
+             * use the remainder for the refcount cache */
+            if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
+                *l2_cache_size = max_l2_cache;
+                *refcount_cache_size = combined_cache_size - *l2_cache_size;
+            } else {
+                *refcount_cache_size =
+                    MIN(combined_cache_size, min_refcount_cache);
+                *l2_cache_size = combined_cache_size - *refcount_cache_size;
+            }
         }
     } else {
-        if (!l2_cache_size_set && !refcount_cache_size_set) {
+        if (!l2_cache_size_set) {
             *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
                                  (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
                                  * s->cluster_size);
-            *refcount_cache_size = *l2_cache_size
-                                 / DEFAULT_L2_REFCOUNT_SIZE_RATIO;
-        } else if (!l2_cache_size_set) {
-            *l2_cache_size = *refcount_cache_size
-                           * DEFAULT_L2_REFCOUNT_SIZE_RATIO;
-        } else if (!refcount_cache_size_set) {
-            *refcount_cache_size = *l2_cache_size
-                                 / DEFAULT_L2_REFCOUNT_SIZE_RATIO;
+        }
+        if (!refcount_cache_size_set) {
+            *refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
         }
     }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index ccb92a9696..cdf41055ae 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -77,10 +77,6 @@
 #define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
 #define DEFAULT_L2_CACHE_BYTE_SIZE 1048576 /* bytes */
 
-/* The refblock cache needs only a fourth of the L2 cache size to cover as many
- * clusters */
-#define DEFAULT_L2_REFCOUNT_SIZE_RATIO 4
-
 #define DEFAULT_CLUSTER_SIZE 65536
 
 
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index e28e1eadba..96724a6c33 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -22,7 +22,7 @@ refcount-cache-size may not exceed cache-size
 L2 cache size too big
 L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 L2 cache entry size must be a power of two between 512 and the cluster size (65536)
-L2 cache size too big
+Refcount cache size too big
 Conflicting values for qcow2 options 'overlap-check' ('constant') and 'overlap-check.template' ('all')
 Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
 Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
-- 
2.11.0
