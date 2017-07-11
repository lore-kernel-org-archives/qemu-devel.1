Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxm0-0001lJ-Qy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlu-000723-9r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:23 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:53 +0200
Message-Id: <20170711160814.20941-65-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 64/85] qcow2: make refcount size calculation
 conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The refcount metadata size calculation is inaccurate and can produce
numbers that are too small.  This is bad because we should calculate a
conservative number - one that is guaranteed to be large enough.

This patch switches the approach to a fixed point calculation because
the existing equation is hard to solve when inaccuracies are taken care
of.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170705125738.8777-5-stefanha@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 83 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0506c7e..eb57013 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2537,6 +2537,43 @@ static int preallocate(BlockDriverState *bs)
     return 0;
 }
 
+/* qcow2_refcount_metadata_size:
+ * @clusters: number of clusters to refcount (including data and L1/L2 tables)
+ * @cluster_size: size of a cluster, in bytes
+ * @refcount_order: refcount bits power-of-2 exponent
+ *
+ * Returns: Number of bytes required for refcount blocks and table metadata.
+ */
+static int64_t qcow2_refcount_metadata_size(int64_t clusters,
+                                            size_t cluster_size,
+                                            int refcount_order)
+{
+    /*
+     * Every host cluster is reference-counted, including metadata (even
+     * refcount metadata is recursively included).
+     *
+     * An accurate formula for the size of refcount metadata size is difficult
+     * to derive.  An easier method of calculation is finding the fixed point
+     * where no further refcount blocks or table clusters are required to
+     * reference count every cluster.
+     */
+    int64_t blocks_per_table_cluster = cluster_size / sizeof(uint64_t);
+    int64_t refcounts_per_block = cluster_size * 8 / (1 << refcount_order);
+    int64_t table = 0;  /* number of refcount table clusters */
+    int64_t blocks = 0; /* number of refcount block clusters */
+    int64_t last;
+    int64_t n = 0;
+
+    do {
+        last = n;
+        blocks = DIV_ROUND_UP(clusters + table + blocks, refcounts_per_block);
+        table = DIV_ROUND_UP(blocks, blocks_per_table_cluster);
+        n = clusters + blocks + table;
+    } while (n != last);
+
+    return (blocks + table) * cluster_size;
+}
+
 /**
  * qcow2_calc_prealloc_size:
  * @total_size: virtual disk size in bytes
@@ -2550,22 +2587,9 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
                                         size_t cluster_size,
                                         int refcount_order)
 {
-    /* Note: The following calculation does not need to be exact; if it is a
-     * bit off, either some bytes will be "leaked" (which is fine) or we
-     * will need to increase the file size by some bytes (which is fine,
-     * too, as long as the bulk is allocated here). Therefore, using
-     * floating point arithmetic is fine. */
     int64_t meta_size = 0;
-    uint64_t nreftablee, nrefblocke, nl1e, nl2e, refblock_count;
+    uint64_t nl1e, nl2e;
     int64_t aligned_total_size = align_offset(total_size, cluster_size);
-    int cluster_bits = ctz32(cluster_size);
-    int refblock_bits, refblock_size;
-    /* refcount entry size in bytes */
-    double rces = (1 << refcount_order) / 8.;
-
-    /* see qcow2_open() */
-    refblock_bits = cluster_bits - (refcount_order - 3);
-    refblock_size = 1 << refblock_bits;
 
     /* header: 1 cluster */
     meta_size += cluster_size;
@@ -2580,33 +2604,10 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
     nl1e = align_offset(nl1e, cluster_size / sizeof(uint64_t));
     meta_size += nl1e * sizeof(uint64_t);
 
-    /* total size of refcount blocks
-     *
-     * note: every host cluster is reference-counted, including metadata
-     * (even refcount blocks are recursively included).
-     * Let:
-     *   a = total_size (this is the guest disk size)
-     *   m = meta size not including refcount blocks and refcount tables
-     *   c = cluster size
-     *   y1 = number of refcount blocks entries
-     *   y2 = meta size including everything
-     *   rces = refcount entry size in bytes
-     * then,
-     *   y1 = (y2 + a)/c
-     *   y2 = y1 * rces + y1 * rces * sizeof(u64) / c + m
-     * we can get y1:
-     *   y1 = (a + m) / (c - rces - rces * sizeof(u64) / c)
-     */
-    nrefblocke = (aligned_total_size + meta_size + cluster_size)
-        / (cluster_size - rces - rces * sizeof(uint64_t)
-                / cluster_size);
-    refblock_count = DIV_ROUND_UP(nrefblocke, refblock_size);
-    meta_size += refblock_count * cluster_size;
-
-    /* total size of refcount tables */
-    nreftablee = align_offset(refblock_count,
-                              cluster_size / sizeof(uint64_t));
-    meta_size += nreftablee * sizeof(uint64_t);
+    /* total size of refcount table and blocks */
+    meta_size += qcow2_refcount_metadata_size(
+            (meta_size + aligned_total_size) / cluster_size,
+            cluster_size, refcount_order);
 
     return meta_size + aligned_total_size;
 }
-- 
2.9.4
