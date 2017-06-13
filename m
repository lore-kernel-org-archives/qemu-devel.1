Received: from eggs.gnu.org ([2001:4830:134:3::10]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsK7-0006ah-Hd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsK6-0001hh-GZ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:59 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:21:02 +0200
Message-Id: <20170613202107.10125-12-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/16] block/qcow2: Metadata preallocation
 for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

We can support PREALLOC_MODE_METADATA by invoking preallocate() in
qcow2_truncate().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c1aec07..f007aa8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2616,10 +2616,11 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                           PreallocMode prealloc, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
+    uint64_t old_length;
     int64_t new_l1_size;
     int ret;
 
-    if (prealloc != PREALLOC_MODE_OFF) {
+    if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_METADATA) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
                    PreallocMode_lookup[prealloc]);
         return -ENOTSUP;
@@ -2636,8 +2637,10 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         return -ENOTSUP;
     }
 
+    old_length = bs->total_sectors * 512;
+
     /* shrinking is currently not supported */
-    if (offset < bs->total_sectors * 512) {
+    if (offset < old_length) {
         error_setg(errp, "qcow2 doesn't support shrinking images yet");
         return -ENOTSUP;
     }
@@ -2649,6 +2652,32 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
         return ret;
     }
 
+    switch (prealloc) {
+    case PREALLOC_MODE_OFF:
+        break;
+
+    case PREALLOC_MODE_METADATA:
+        ret = preallocate(bs, old_length, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Preallocation failed");
+            return ret;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    if (prealloc != PREALLOC_MODE_OFF) {
+        /* Flush metadata before actually changing the image size */
+        ret = bdrv_flush(bs);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to flush the preallocated area to disk");
+            return ret;
+        }
+    }
+
     /* write updated header.size */
     offset = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
-- 
2.9.4
