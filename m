Received: from eggs.gnu.org ([2001:4830:134:3::10]:59186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSjsk-0005OO-QK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dSjsg-0003H3-Ka
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dSjsg-0003Gg-BK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:58:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  5 Jul 2017 13:57:33 +0100
Message-Id: <20170705125738.8777-5-stefanha@redhat.com>
In-Reply-To: <20170705125738.8777-1-stefanha@redhat.com>
References: <20170705125738.8777-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v9 4/9] qcow2: make refcount size calculation
 conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The refcount metadata size calculation is inaccurate and can produce
numbers that are too small.  This is bad because we should calculate a
conservative number - one that is guaranteed to be large enough.

This patch switches the approach to a fixed point calculation because
the existing equation is hard to solve when inaccuracies are taken care
of.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 83 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 058cc56..538f867 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2140,6 +2140,43 @@ static int preallocate(BlockDriverState *bs)
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
@@ -2153,22 +2190,9 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
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
@@ -2183,33 +2207,10 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
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
