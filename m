Received: from eggs.gnu.org ([2001:4830:134:3::10]:34343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4Yc-00018I-GM
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4YW-0000G5-I8
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:18 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 18:09:26 +0200
Message-Id: <20170403160936.28293-7-mreitz@redhat.com>
In-Reply-To: <20170403160936.28293-1-mreitz@redhat.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 06/16] block/file-posix: Extract
 raw_regular_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This functionality is part of raw_create() which we will be able to
reuse nicely in raw_truncate().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 144 +++++++++++++++++++++++++++++------------------------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index cab77db963..e6b6fa30ce 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1407,6 +1407,81 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
+static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
+                                Error **errp)
+{
+    int result = 0;
+    char *buf;
+
+    switch (prealloc) {
+#ifdef CONFIG_POSIX_FALLOCATE
+    case PREALLOC_MODE_FALLOC:
+        /*
+         * Truncating before posix_fallocate() makes it about twice slower on
+         * file systems that do not support fallocate(), trying to check if a
+         * block is allocated before allocating it, so don't do that here.
+         */
+        result = -posix_fallocate(fd, 0, offset);
+        if (result != 0) {
+            /* posix_fallocate() doesn't set errno. */
+            error_setg_errno(errp, -result,
+                             "Could not preallocate data for the new file");
+        }
+        return result;
+#endif
+    case PREALLOC_MODE_FULL:
+    {
+        int64_t num = 0, left = offset;
+
+        /*
+         * Knowing the final size from the beginning could allow the file
+         * system driver to do less allocations and possibly avoid
+         * fragmentation of the file.
+         */
+        if (ftruncate(fd, offset) != 0) {
+            result = -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+            return result;
+        }
+
+        buf = g_malloc0(65536);
+
+        while (left > 0) {
+            num = MIN(left, 65536);
+            result = write(fd, buf, num);
+            if (result < 0) {
+                result = -errno;
+                error_setg_errno(errp, -result,
+                                 "Could not write to the new file");
+                break;
+            }
+            left -= result;
+        }
+        if (result >= 0) {
+            result = fsync(fd);
+            if (result < 0) {
+                result = -errno;
+                error_setg_errno(errp, -result,
+                                 "Could not flush new file to disk");
+            }
+        }
+        g_free(buf);
+        return result;
+    }
+    case PREALLOC_MODE_OFF:
+        if (ftruncate(fd, offset) != 0) {
+            result = -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+        }
+        return result;
+    default:
+        result = -ENOTSUP;
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_lookup[prealloc]);
+        return result;
+    }
+}
+
 static int raw_truncate(BlockDriverState *bs, int64_t offset,
                         PreallocMode prealloc, Error **errp)
 {
@@ -1675,72 +1750,9 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 #endif
     }
 
-    switch (prealloc) {
-#ifdef CONFIG_POSIX_FALLOCATE
-    case PREALLOC_MODE_FALLOC:
-        /*
-         * Truncating before posix_fallocate() makes it about twice slower on
-         * file systems that do not support fallocate(), trying to check if a
-         * block is allocated before allocating it, so don't do that here.
-         */
-        result = -posix_fallocate(fd, 0, total_size);
-        if (result != 0) {
-            /* posix_fallocate() doesn't set errno. */
-            error_setg_errno(errp, -result,
-                             "Could not preallocate data for the new file");
-        }
-        break;
-#endif
-    case PREALLOC_MODE_FULL:
-    {
-        int64_t num = 0, left = total_size;
-
-        /*
-         * Knowing the final size from the beginning could allow the file
-         * system driver to do less allocations and possibly avoid
-         * fragmentation of the file.
-         */
-        if (ftruncate(fd, total_size) != 0) {
-            result = -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-            goto out_close;
-        }
-
-        buf = g_malloc0(65536);
-
-        while (left > 0) {
-            num = MIN(left, 65536);
-            result = write(fd, buf, num);
-            if (result < 0) {
-                result = -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not write to the new file");
-                break;
-            }
-            left -= result;
-        }
-        if (result >= 0) {
-            result = fsync(fd);
-            if (result < 0) {
-                result = -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not flush new file to disk");
-            }
-        }
-        g_free(buf);
-        break;
-    }
-    case PREALLOC_MODE_OFF:
-        if (ftruncate(fd, total_size) != 0) {
-            result = -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-        }
-        break;
-    default:
-        result = -ENOTSUP;
-        error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_lookup[prealloc]);
-        break;
+    result = raw_regular_truncate(fd, total_size, prealloc, errp);
+    if (result < 0) {
+        goto out_close;
     }
 
 out_close:
-- 
2.12.1
