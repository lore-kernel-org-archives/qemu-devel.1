Received: from eggs.gnu.org ([2001:4830:134:3::10]:33442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKku-00011t-MH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkt-0006qy-NL
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:59 +0100
Message-Id: <20180309161933.8168-23-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/56] qcow2: Handle full/falloc preallocation
 in qcow2_co_create()
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

Once qcow2_co_create() can be called directly on an already existing
node, we must provide the 'full' and 'falloc' preallocation modes
outside of creating the image on the protocol layer. Fortunately, we
have preallocated truncate now which can provide this functionality.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e1821eb3c8..933c612754 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2908,6 +2908,25 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
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
@@ -3145,15 +3164,6 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 
 
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
