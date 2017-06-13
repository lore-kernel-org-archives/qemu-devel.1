Received: from eggs.gnu.org ([2001:4830:134:3::10]:48359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlxB-0001QP-NY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dKlxA-0000Wr-B8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dKlxA-0000WW-19
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:33:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Jun 2017 14:33:23 +0100
Message-Id: <20170613133329.23653-4-stefanha@redhat.com>
In-Reply-To: <20170613133329.23653-1-stefanha@redhat.com>
References: <20170613133329.23653-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v7 3/9] qcow2: extract preallocation
 calculation function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Calculating the preallocated image size will be needed to implement
.bdrv_measure().  Extract the code out into a separate function.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 136 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 59 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b3ba5da..22b261a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2096,6 +2096,80 @@ static int preallocate(BlockDriverState *bs)
     return 0;
 }
 
+/**
+ * qcow2_calc_prealloc_size:
+ * @total_size: virtual disk size in bytes
+ * @cluster_size: cluster size in bytes
+ * @refcount_order: refcount bits power-of-2 exponent
+ *
+ * Returns: Total number of bytes required for the fully allocated image
+ * (including metadata).
+ */
+static int64_t qcow2_calc_prealloc_size(int64_t total_size,
+                                        size_t cluster_size,
+                                        int refcount_order)
+{
+    /* Note: The following calculation does not need to be exact; if it is a
+     * bit off, either some bytes will be "leaked" (which is fine) or we
+     * will need to increase the file size by some bytes (which is fine,
+     * too, as long as the bulk is allocated here). Therefore, using
+     * floating point arithmetic is fine. */
+    int64_t meta_size = 0;
+    uint64_t nreftablee, nrefblocke, nl1e, nl2e, refblock_count;
+    int64_t aligned_total_size = align_offset(total_size, cluster_size);
+    int cluster_bits = ctz32(cluster_size);
+    int refblock_bits, refblock_size;
+    /* refcount entry size in bytes */
+    double rces = (1 << refcount_order) / 8.;
+
+    /* see qcow2_open() */
+    refblock_bits = cluster_bits - (refcount_order - 3);
+    refblock_size = 1 << refblock_bits;
+
+    /* header: 1 cluster */
+    meta_size += cluster_size;
+
+    /* total size of L2 tables */
+    nl2e = aligned_total_size / cluster_size;
+    nl2e = align_offset(nl2e, cluster_size / sizeof(uint64_t));
+    meta_size += nl2e * sizeof(uint64_t);
+
+    /* total size of L1 tables */
+    nl1e = nl2e * sizeof(uint64_t) / cluster_size;
+    nl1e = align_offset(nl1e, cluster_size / sizeof(uint64_t));
+    meta_size += nl1e * sizeof(uint64_t);
+
+    /* total size of refcount blocks
+     *
+     * note: every host cluster is reference-counted, including metadata
+     * (even refcount blocks are recursively included).
+     * Let:
+     *   a = total_size (this is the guest disk size)
+     *   m = meta size not including refcount blocks and refcount tables
+     *   c = cluster size
+     *   y1 = number of refcount blocks entries
+     *   y2 = meta size including everything
+     *   rces = refcount entry size in bytes
+     * then,
+     *   y1 = (y2 + a)/c
+     *   y2 = y1 * rces + y1 * rces * sizeof(u64) / c + m
+     * we can get y1:
+     *   y1 = (a + m) / (c - rces - rces * sizeof(u64) / c)
+     */
+    nrefblocke = (aligned_total_size + meta_size + cluster_size)
+        / (cluster_size - rces - rces * sizeof(uint64_t)
+                / cluster_size);
+    refblock_count = DIV_ROUND_UP(nrefblocke, refblock_size);
+    meta_size += refblock_count * cluster_size;
+
+    /* total size of refcount tables */
+    nreftablee = align_offset(refblock_count,
+                              cluster_size / sizeof(uint64_t));
+    meta_size += nreftablee * sizeof(uint64_t);
+
+    return meta_size + aligned_total_size;
+}
+
 static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
@@ -2134,65 +2208,9 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     int ret;
 
     if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
-        /* Note: The following calculation does not need to be exact; if it is a
-         * bit off, either some bytes will be "leaked" (which is fine) or we
-         * will need to increase the file size by some bytes (which is fine,
-         * too, as long as the bulk is allocated here). Therefore, using
-         * floating point arithmetic is fine. */
-        int64_t meta_size = 0;
-        uint64_t nreftablee, nrefblocke, nl1e, nl2e, refblock_count;
-        int64_t aligned_total_size = align_offset(total_size, cluster_size);
-        int refblock_bits, refblock_size;
-        /* refcount entry size in bytes */
-        double rces = (1 << refcount_order) / 8.;
-
-        /* see qcow2_open() */
-        refblock_bits = cluster_bits - (refcount_order - 3);
-        refblock_size = 1 << refblock_bits;
-
-        /* header: 1 cluster */
-        meta_size += cluster_size;
-
-        /* total size of L2 tables */
-        nl2e = aligned_total_size / cluster_size;
-        nl2e = align_offset(nl2e, cluster_size / sizeof(uint64_t));
-        meta_size += nl2e * sizeof(uint64_t);
-
-        /* total size of L1 tables */
-        nl1e = nl2e * sizeof(uint64_t) / cluster_size;
-        nl1e = align_offset(nl1e, cluster_size / sizeof(uint64_t));
-        meta_size += nl1e * sizeof(uint64_t);
-
-        /* total size of refcount blocks
-         *
-         * note: every host cluster is reference-counted, including metadata
-         * (even refcount blocks are recursively included).
-         * Let:
-         *   a = total_size (this is the guest disk size)
-         *   m = meta size not including refcount blocks and refcount tables
-         *   c = cluster size
-         *   y1 = number of refcount blocks entries
-         *   y2 = meta size including everything
-         *   rces = refcount entry size in bytes
-         * then,
-         *   y1 = (y2 + a)/c
-         *   y2 = y1 * rces + y1 * rces * sizeof(u64) / c + m
-         * we can get y1:
-         *   y1 = (a + m) / (c - rces - rces * sizeof(u64) / c)
-         */
-        nrefblocke = (aligned_total_size + meta_size + cluster_size)
-                   / (cluster_size - rces - rces * sizeof(uint64_t)
-                                                 / cluster_size);
-        refblock_count = DIV_ROUND_UP(nrefblocke, refblock_size);
-        meta_size += refblock_count * cluster_size;
-
-        /* total size of refcount tables */
-        nreftablee = align_offset(refblock_count,
-                                  cluster_size / sizeof(uint64_t));
-        meta_size += nreftablee * sizeof(uint64_t);
-
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-                            aligned_total_size + meta_size, &error_abort);
+        int64_t prealloc_size =
+            qcow2_calc_prealloc_size(total_size, cluster_size, refcount_order);
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_abort);
         qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_lookup[prealloc],
                      &error_abort);
     }
-- 
2.9.4
