Received: from eggs.gnu.org ([2001:4830:134:3::10]:33713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl4-0001BH-15
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl2-00072g-PJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:08 +0100
Message-Id: <20180309161933.8168-32-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/56] file-win32: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to file-win32, which
enables image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-win32.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index 4a430d45f1..2e2f746bb1 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -553,30 +553,59 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return st.st_size;
 }
 
-static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
-                                           Error **errp)
+static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
 {
+    BlockdevCreateOptionsFile *file_opts;
     int fd;
-    int64_t total_size = 0;
 
-    strstart(filename, "file:", &filename);
+    assert(options->driver == BLOCKDEV_DRIVER_FILE);
+    file_opts = &options->u.file;
 
-    /* Read out options */
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
+    if (file_opts->has_preallocation) {
+        error_setg(errp, "Preallocation is not supported on Windows");
+        return -EINVAL;
+    }
+    if (file_opts->has_nocow) {
+        error_setg(errp, "nocow is not supported on Windows");
+        return -EINVAL;
+    }
 
-    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
+    fd = qemu_open(file_opts->filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
                    0644);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Could not create file");
         return -EIO;
     }
     set_sparse(fd);
-    ftruncate(fd, total_size);
+    ftruncate(fd, file_opts->size);
     qemu_close(fd);
+
     return 0;
 }
 
+static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
+{
+    BlockdevCreateOptions options;
+    int64_t total_size = 0;
+
+    strstart(filename, "file:", &filename);
+
+    /* Read out options */
+    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                          BDRV_SECTOR_SIZE);
+
+    options = (BlockdevCreateOptions) {
+        .driver     = BLOCKDEV_DRIVER_FILE,
+        .u.file     = {
+            .filename           = (char *) filename,
+            .size               = total_size,
+            .has_preallocation  = false,
+            .has_nocow          = false,
+        },
+    };
+    return raw_co_create(&options, errp);
+}
 
 static QemuOptsList raw_create_opts = {
     .name = "raw-create-opts",
-- 
2.13.6
