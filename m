Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eotHo-00049h-Ey
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eotHk-0001kA-Ho
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:59:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 22 Feb 2018 09:59:21 -0600
Message-Id: <20180222155922.9833-4-eblake@redhat.com>
In-Reply-To: <20180222155922.9833-1-eblake@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] qcow2: Don't allow overflow during
 cluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com, Max Reitz <mreitz@redhat.com>

Our code was already checking that we did not attempt to
allocate more clusters than what would fit in an INT64 (the
physical maximimum if we can access a full off_t's worth of
data).  But this does not catch smaller limits enforced by
various spots in the qcow2 image description: L1 and normal
clusters of L2 are documented as having bits 63-56 reserved
for other purposes, capping our maximum offset at 64PB (bit
55 is the maximum bit set).  And for compressed images with
2M clusters, the cap drops the maximum offset to bit 48, or
a maximum offset of 512TB.  If we overflow that offset, we
would write compressed data into one place, but try to
decompress from another, which won't work.

I don't have 512TB handy to prove whether things break if we
compress so much data that we overflow that limit, and don't
think that iotests can (quickly) test it either.  Test 138
comes close (it corrupts an image into thinking something lives
at 32PB, which is half the maximum for L1 sizing - although
it relies on 512-byte clusters).  But that test points out
that we will generally hit other limits first (such as running
out of memory for the refcount table, or exceeding file system
limits like 16TB on ext4, etc), so this is more a theoretical
safety valve than something likely to be hit.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: use s->cluster_offset_mask instead of open-coding it [Berto],
use MIN() to clamp offset on small cluster size, add spec patch
first to justify clamping even on refcount allocations
---
 block/qcow2.h          |  6 ++++++
 block/qcow2-refcount.c | 21 ++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 883802241fb..560008c331d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -41,6 +41,12 @@
 #define QCOW_MAX_CRYPT_CLUSTERS 32
 #define QCOW_MAX_SNAPSHOTS 65536

+/* Field widths in qcow2 mean normal cluster offsets cannot reach
+ * 64PB; depending on cluster size, compressed clusters can have a
+ * smaller limit (64PB for up to 16k clusters, then ramps down to
+ * 512TB for 2M clusters).  */
+#define QCOW_MAX_CLUSTER_OFFSET ((1ULL << 56) - 1)
+
 /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
 #define QCOW_MAX_REFTABLE_SIZE 0x800000
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 28afbb1b5ea..c46a2257a9e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -31,7 +31,8 @@
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"

-static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
+static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
+                                    uint64_t max);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                             int64_t offset, int64_t length, uint64_t addend,
                             bool decrease, enum qcow2_discard_type type);
@@ -362,7 +363,8 @@ static int alloc_refcount_block(BlockDriverState *bs,
     }

     /* Allocate the refcount block itself and mark it as used */
-    int64_t new_block = alloc_clusters_noref(bs, s->cluster_size);
+    int64_t new_block = alloc_clusters_noref(bs, s->cluster_size,
+                                             QCOW_MAX_CLUSTER_OFFSET);
     if (new_block < 0) {
         return new_block;
     }
@@ -947,7 +949,8 @@ int qcow2_update_cluster_refcount(BlockDriverState *bs,


 /* return < 0 if error */
-static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size)
+static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size,
+                                    uint64_t max)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t i, nb_clusters, refcount;
@@ -972,9 +975,9 @@ retry:
     }

     /* Make sure that all offsets in the "allocated" range are representable
-     * in an int64_t */
+     * in the requested max */
     if (s->free_cluster_index > 0 &&
-        s->free_cluster_index - 1 > (INT64_MAX >> s->cluster_bits))
+        s->free_cluster_index - 1 > (max >> s->cluster_bits))
     {
         return -EFBIG;
     }
@@ -994,7 +997,7 @@ int64_t qcow2_alloc_clusters(BlockDriverState *bs, uint64_t size)

     BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
     do {
-        offset = alloc_clusters_noref(bs, size);
+        offset = alloc_clusters_noref(bs, size, QCOW_MAX_CLUSTER_OFFSET);
         if (offset < 0) {
             return offset;
         }
@@ -1076,7 +1079,11 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, int size)
     free_in_cluster = s->cluster_size - offset_into_cluster(s, offset);
     do {
         if (!offset || free_in_cluster < size) {
-            int64_t new_cluster = alloc_clusters_noref(bs, s->cluster_size);
+            int64_t new_cluster;
+
+            new_cluster = alloc_clusters_noref(bs, s->cluster_size,
+                                               MIN(s->cluster_offset_mask,
+                                                   QCOW_MAX_CLUSTER_OFFSET));
             if (new_cluster < 0) {
                 return new_cluster;
             }
-- 
2.14.3
