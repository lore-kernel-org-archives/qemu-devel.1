Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuz-0005fW-Rs
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiuw-0000nN-0O
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:22 +0100
Message-Id: <20180111195225.4226-8-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 07/10] qcow2: Handle full/falloc
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Once qcow2_create2() can be called directly on an already existing node,
we must provide the 'full' and 'falloc' preallocation modes outside of
creating the image on the protocol layer. Fortunately, we have
preallocated truncate now which can provide this functionality.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 686b765c06..868e0e8a62 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2832,6 +2832,25 @@ static int qcow2_create2(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3068,15 +3087,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
 
     /* Create and open the file (protocol layer */
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
