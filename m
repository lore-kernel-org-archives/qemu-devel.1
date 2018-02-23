Received: from eggs.gnu.org ([2001:4830:134:3::10]:49915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIz1-0000ad-78
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIz0-0004B3-Al
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:20 +0100
Message-Id: <20180223192549.26666-8-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-1-kwolf@redhat.com>
References: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/36] qcow2: Handle full/falloc
 preallocation in qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Once qcow2_create2() can be called directly on an already existing node,
we must provide the 'full' and 'falloc' preallocation modes outside of
creating the image on the protocol layer. Fortunately, we have
preallocated truncate now which can provide this functionality.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 9a2028b3cf..64bf2863cd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2872,6 +2872,25 @@ static int qcow2_create2(BlockdevCreateOptions *create_options, Error **errp)
     }
     blk_set_allow_write_beyond_eof(blk, true);
 
+    /* Clear the protocol layer and preallocate it if necessary */
+    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (qcow2_opts->preallocation == PREALLOC_MODE_FULL ||
+        qcow2_opts->preallocation == PREALLOC_MODE_FALLOC)
+    {
+        int64_t prealloc_size =
+            qcow2_calc_prealloc_size(qcow2_opts->size, cluster_size,
+                                     refcount_order);
+
+        ret = blk_truncate(blk, prealloc_size, qcow2_opts->preallocation, errp);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
     /* Write the header */
     QEMU_BUILD_BUG_ON((1 << MIN_CLUSTER_BITS) < sizeof(*header));
     header = g_malloc0(cluster_size);
@@ -3108,15 +3127,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
 
     /* Create and open the file (protocol layer) */
-    if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
-        int refcount_order = ctz32(refcount_bits);
-        int64_t prealloc_size =
-            qcow2_calc_prealloc_size(size, cluster_size, refcount_order);
-        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, prealloc_size, &error_abort);
-        qemu_opt_set(opts, BLOCK_OPT_PREALLOC, PreallocMode_str(prealloc),
-                     &error_abort);
-    }
-
     ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
         goto finish;
-- 
2.13.6
