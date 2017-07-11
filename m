Received: from eggs.gnu.org ([2001:4830:134:3::10]:47169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmT-0002Id-1w
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmS-0007PR-4Z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:06 +0200
Message-Id: <20170711160814.20941-78-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 77/85] block/file-posix: Preallocation for
 truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

By using raw_regular_truncate() in raw_truncate(), we can now easily
support preallocation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170613202107.10125-9-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 59154ea..cfbb236 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1745,12 +1745,6 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
     struct stat st;
     int ret;
 
-    if (prealloc != PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_lookup[prealloc]);
-        return -ENOTSUP;
-    }
-
     if (fstat(s->fd, &st)) {
         ret = -errno;
         error_setg_errno(errp, -ret, "Failed to fstat() the file");
@@ -1758,12 +1752,16 @@ static int raw_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     if (S_ISREG(st.st_mode)) {
-        if (ftruncate(s->fd, offset) < 0) {
-            ret = -errno;
-            error_setg_errno(errp, -ret, "Failed to resize the file");
-            return ret;
-        }
-    } else if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
+        return raw_regular_truncate(s->fd, offset, prealloc, errp);
+    }
+
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Preallocation mode '%s' unsupported for this "
+                   "non-regular file", PreallocMode_lookup[prealloc]);
+        return -ENOTSUP;
+    }
+
+    if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
         if (offset > raw_getlength(bs)) {
             error_setg(errp, "Cannot grow device files");
             return -EINVAL;
-- 
2.9.4
