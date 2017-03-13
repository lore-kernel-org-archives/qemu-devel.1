Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXiB-0007YF-Ny
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnXiA-0001un-Ea
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:41:03 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Mar 2017 22:40:36 +0100
Message-Id: <20170313214045.26857-5-mreitz@redhat.com>
In-Reply-To: <20170313214001.26339-1-mreitz@redhat.com>
References: <20170313214001.26339-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix: Generalize
 raw_regular_truncate
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

Currently, raw_regular_truncate() is intended for setting the size of a
newly created file. However, we also want to use it for truncating an
existing file in which case only the newly added space (when growing)
should be preallocated.

This also means that if resizing failed, we should try to restore the
original file size. This is important when using preallocation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35a9e43f3e..cd229324ba 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1384,11 +1384,39 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
-static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
+/**
+ * Truncates the given regular file @fd to @offset and, when growing, fills the
+ * new space according to @prealloc.
+ *
+ * @create must be true iff the file is new. In that case, @bs is ignored. If
+ * @create is false, @bs must be valid and correspond to the same file as @fd.
+ */
+static int raw_regular_truncate(int fd, BlockDriverState *bs, int64_t offset,
+                                PreallocMode prealloc, bool create,
                                 Error **errp)
 {
     int result = 0;
-    char *buf;
+    int64_t current_length = 0;
+    char *buf = NULL;
+
+    assert(create || bs);
+    if (!create) {
+        BDRVRawState *s = bs->opaque;
+        assert(s->fd == fd);
+    }
+
+    if (!create) {
+        current_length = bdrv_getlength(bs);
+        if (current_length < 0) {
+            error_setg_errno(errp, -current_length,
+                             "Could not inquire current length");
+            return -current_length;
+        }
+
+        if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
+            return -ENOTSUP;
+        }
+    }
 
     switch (prealloc) {
 #ifdef CONFIG_POSIX_FALLOCATE
@@ -1398,17 +1426,17 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
          * file systems that do not support fallocate(), trying to check if a
          * block is allocated before allocating it, so don't do that here.
          */
-        result = -posix_fallocate(fd, 0, offset);
+        result = -posix_fallocate(fd, current_length, offset - current_length);
         if (result != 0) {
             /* posix_fallocate() doesn't set errno. */
             error_setg_errno(errp, -result,
-                             "Could not preallocate data for the new file");
+                             "Could not preallocate new data");
         }
-        return result;
+        goto out;
 #endif
     case PREALLOC_MODE_FULL:
     {
-        int64_t num = 0, left = offset;
+        int64_t num = 0, left = offset - current_length;
 
         /*
          * Knowing the final size from the beginning could allow the file
@@ -1418,19 +1446,27 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
         if (ftruncate(fd, offset) != 0) {
             result = -errno;
             error_setg_errno(errp, -result, "Could not resize file");
-            return result;
+            goto out;
         }
 
         buf = g_malloc0(65536);
 
+        result = lseek(fd, current_length, SEEK_SET);
+        if (result < 0) {
+            result = -errno;
+            error_setg_errno(errp, -result,
+                             "Failed to seek to the old end of file");
+            goto out;
+        }
+
         while (left > 0) {
             num = MIN(left, 65536);
             result = write(fd, buf, num);
             if (result < 0) {
                 result = -errno;
                 error_setg_errno(errp, -result,
-                                 "Could not write to the new file");
-                break;
+                                 "Could not write zeros for preallocation");
+                goto out;
             }
             left -= result;
         }
@@ -1439,11 +1475,11 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
             if (result < 0) {
                 result = -errno;
                 error_setg_errno(errp, -result,
-                                 "Could not flush new file to disk");
+                                 "Could not flush file to disk");
+                goto out;
             }
         }
-        g_free(buf);
-        return result;
+        goto out;
     }
     case PREALLOC_MODE_OFF:
         if (ftruncate(fd, offset) != 0) {
@@ -1457,6 +1493,17 @@ static int raw_regular_truncate(int fd, int64_t offset, PreallocMode prealloc,
                    PreallocMode_lookup[prealloc]);
         return result;
     }
+
+out:
+    if (result < 0 && !create) {
+        if (ftruncate(fd, current_length) < 0) {
+            error_report("Failed to restore old file length: %s",
+                         strerror(errno));
+        }
+    }
+
+    g_free(buf);
+    return result;
 }
 
 static int raw_truncate(BlockDriverState *bs, int64_t offset,
@@ -1727,7 +1774,7 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 #endif
     }
 
-    result = raw_regular_truncate(fd, total_size, prealloc, errp);
+    result = raw_regular_truncate(fd, NULL, total_size, prealloc, true, errp);
     if (result < 0) {
         goto out_close;
     }
-- 
2.12.0
