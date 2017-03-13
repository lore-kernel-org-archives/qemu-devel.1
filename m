Received: from eggs.gnu.org ([2001:4830:134:3::10]:43999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXid-0007xN-M1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXic-00027H-79
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:41:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:41:13 +0100
Message-Id: <20170313214117.27350-3-mreitz@redhat.com>
In-Reply-To: <20170313214001.26339-1-mreitz@redhat.com>
References: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 12/16] block/qcow2: Extract
 qcow2_calc_size_usage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

We will need very similar functionality for full/falloc preallocation in
qcow2_truncate(). Although we will not be able to reuse much of the
actual code, it still makes sense to keep all of this in one place.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 126 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5dc95ff0a5..21b2b3cd53 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2101,6 +2101,70 @@ done:
     return ret;
 }
 
+static uint64_t qcow2_calc_size_usage(uint64_t new_size,
+                                      int cluster_bits, int refcount_order)
+{
+    size_t cluster_size = 1u << cluster_bits;
+
+    /* Note: The following calculation does not need to be exact; if it is a
+     * bit off, either some bytes will be "leaked" (which is fine) or we
+     * will need to increase the file size by some bytes (which is fine,
+     * too, as long as the bulk is allocated here). Therefore, using
+     * floating point arithmetic is fine. */
+    int64_t meta_size = 0;
+    uint64_t nreftablee, nrefblocke, nl1e, nl2e;
+    uint64_t aligned_total_size = align_offset(new_size, cluster_size);
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
+               / (cluster_size - rces - rces * sizeof(uint64_t)
+                                             / cluster_size);
+    meta_size += DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;
+
+    /* total size of refcount tables */
+    nreftablee = nrefblocke / refblock_size;
+    nreftablee = align_offset(nreftablee, cluster_size / sizeof(uint64_t));
+    meta_size += nreftablee * sizeof(uint64_t);
+
+    return aligned_total_size + meta_size;
+}
+
 static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
@@ -2139,64 +2203,10 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     int ret;
 
     if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
-        /* Note: The following calculation does not need to be exact; if it is a
-         * bit off, either some bytes will be "leaked" (which is fine) or we
-         * will need to increase the file size by some bytes (which is fine,
-         * too, as long as the bulk is allocated here). Therefore, using
-         * floating point arithmetic is fine. */
-        int64_t meta_size = 0;
-        uint64_t nreftablee, nrefblocke, nl1e, nl2e;
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
-        meta_size += DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;
-
-        /* total size of refcount tables */
-        nreftablee = nrefblocke / refblock_size;
-        nreftablee = align_offset(nreftablee, cluster_size / sizeof(uint64_t));
-        meta_size += nreftablee * sizeof(uint64_t);
-
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-                            aligned_total_size + meta_size, &error_abort);
+        uint64_t file_size = qcow2_calc_size_usage(total_size, cluster_bits,
+                                                   refcount_order);
+
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, file_size, &error_abort);
         qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_lookup[prealloc],
                      &error_abort);
     }
-- 
2.12.0
