Received: from eggs.gnu.org ([2001:4830:134:3::10]:44035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXii-000831-LH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXie-00028L-Jb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:41:33 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:41:15 +0100
Message-Id: <20170313214117.27350-5-mreitz@redhat.com>
In-Reply-To: <20170313214001.26339-1-mreitz@redhat.com>
References: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 14/16] block/qcow2: falloc/full
 preallocating growth
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

Implement the preallocation modes falloc and full for growing qcow2
images.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 80fb815b15..b6b08d70da 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2604,7 +2604,9 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
     int64_t new_l1_size;
     int ret;
 
-    if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_METADATA) {
+    if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_METADATA &&
+        prealloc != PREALLOC_MODE_FALLOC && prealloc != PREALLOC_MODE_FULL)
+    {
         error_setg(errp, "Unsupported preallocation mode '%s'",
                    PreallocMode_lookup[prealloc]);
         return -ENOTSUP;
@@ -2649,6 +2651,38 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         }
         break;
 
+    case PREALLOC_MODE_FALLOC:
+    case PREALLOC_MODE_FULL:
+    {
+        uint64_t additional_size = qcow2_calc_size_usage(bs, old_length, offset,
+                                                         s->cluster_bits,
+                                                         s->refcount_order);
+        int64_t old_file_length = bdrv_getlength(bs->file->bs);
+        if (old_file_length < 0) {
+            error_setg(errp, "Failed to inquire file length");
+            return old_file_length;
+        }
+
+        old_file_length = ROUND_UP(old_file_length, s->cluster_size);
+
+        ret = bdrv_truncate(bs->file, old_file_length + additional_size,
+                            prealloc, errp);
+        if (ret < 0) {
+            error_prepend(errp, "Failed to resize underlying file");
+            return ret;
+        }
+
+        /* Ensure that preallocation is done in the preallocated area */
+        s->free_cluster_index = old_file_length / s->cluster_size;
+        ret = preallocate(bs, old_length, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Preallocation failed, image may now "
+                             "occupy more space than necessary");
+            return ret;
+        }
+        break;
+    }
+
     default:
         g_assert_not_reached();
     }
-- 
2.12.0
