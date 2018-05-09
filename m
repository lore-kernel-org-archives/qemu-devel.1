Received: from eggs.gnu.org ([2001:4830:134:3::10]:49774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGX1z-0007IT-PV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGX1y-0006o9-Rt
	for qemu-devel@nongnu.org; Wed, 09 May 2018 17:53:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 23:53:35 +0200
Message-Id: <20180509215336.31304-3-mreitz@redhat.com>
In-Reply-To: <20180509215336.31304-1-mreitz@redhat.com>
References: <20180509215336.31304-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block/file-posix: File locking during
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

When creating a file, we should take the WRITE and RESIZE permissions.
We do not need either for the creation itself, but we do need them for
clearing and resizing it.  So we can take the proper permissions by
replacing O_TRUNC with an explicit truncation to 0, and by taking the
appropriate file locks between those two steps.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c98a4a1556..370a4833e4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1992,6 +1992,7 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
 {
     BlockdevCreateOptionsFile *file_opts;
     int fd;
+    int perm, shared;
     int result = 0;
 
     /* Validate options and set default values */
@@ -2006,14 +2007,44 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
     /* Create file */
-    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
-                   0644);
+    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
     if (fd < 0) {
         result = -errno;
         error_setg_errno(errp, -result, "Could not create file");
         goto out;
     }
 
+    /* Take permissions: We want to discard everything, so we need
+     * BLK_PERM_WRITE; and truncation to the desired size requires
+     * BLK_PERM_RESIZE.
+     * On the other hand, we cannot share the RESIZE permission
+     * because we promise that after this function, the file has the
+     * size given in the options.  If someone else were to resize it
+     * concurrently, we could not guarantee that.
+     * Note that after this function, we can no longer guarantee that
+     * the file is not touched by a third party, so it may be resized
+     * then. */
+    perm = BLK_PERM_WRITE | BLK_PERM_RESIZE;
+    shared = BLK_PERM_ALL & ~BLK_PERM_RESIZE;
+
+    /* Step one: Take locks */
+    result = raw_apply_lock_bytes(fd, perm, shared, false, errp);
+    if (result < 0) {
+        goto out_close;
+    }
+
+    /* Step two: Check that nobody else has taken conflicting locks */
+    result = raw_check_lock_bytes(fd, perm, shared, errp);
+    if (result < 0) {
+        goto out_close;
+    }
+
+    /* Clear the file by truncating it to 0 */
+    result = raw_regular_truncate(fd, 0, PREALLOC_MODE_OFF, errp);
+    if (result < 0) {
+        goto out_close;
+    }
+
     if (file_opts->nocow) {
 #ifdef __linux__
         /* Set NOCOW flag to solve performance issue on fs like btrfs.
@@ -2029,6 +2060,8 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
 #endif
     }
 
+    /* Resize and potentially preallocate the file to the desired
+     * final size */
     result = raw_regular_truncate(fd, file_opts->size, file_opts->preallocation,
                                   errp);
     if (result < 0) {
-- 
2.14.3
