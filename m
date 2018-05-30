Received: from eggs.gnu.org ([2001:4830:134:3::10]:55396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3T6-0007VZ-T7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3T6-0006pr-1A
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:56:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 30 May 2018 17:56:31 +0200
Message-Id: <20180530155647.14090-2-kwolf@redhat.com>
In-Reply-To: <20180530155647.14090-1-kwolf@redhat.com>
References: <20180530155647.14090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/17] qcow2: Fix Coverity warning when
 calculating the refcount cache size
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

MIN_REFCOUNT_CACHE_SIZE is 4 and the cluster size is guaranteed to be
at most 2MB, so the minimum refcount cache size (in bytes) is always
going to fit in a 32-bit integer.

Coverity doesn't know that, and since we're storing the result in a
uint64_t (*refcount_cache_size) it thinks that we need the 64 bits and
that we probably want to do a 64-bit multiplication to prevent the
result from being truncated.

This is a false positive in this case, but it's a fair warning.
We could do a 64-bit multiplication to get rid of it, but since we
know that a 32-bit variable is enough to store this value let's simply
reuse min_refcount_cache, make it a normal int and stop doing casts.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6d532470a8..a007dc4246 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -768,6 +768,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     BDRVQcow2State *s = bs->opaque;
     uint64_t combined_cache_size;
     bool l2_cache_size_set, refcount_cache_size_set, combined_cache_size_set;
+    int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
 
     combined_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE);
     l2_cache_size_set = qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
@@ -804,8 +805,6 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         } else {
             uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
             uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
-            uint64_t min_refcount_cache =
-                (uint64_t) MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
 
             /* Assign as much memory as possible to the L2 cache, and
              * use the remainder for the refcount cache */
@@ -825,7 +824,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                                  * s->cluster_size);
         }
         if (!refcount_cache_size_set) {
-            *refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
+            *refcount_cache_size = min_refcount_cache;
         }
     }
 
-- 
2.13.6
