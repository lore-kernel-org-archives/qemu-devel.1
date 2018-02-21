Received: from eggs.gnu.org ([2001:4830:134:3::10]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrX-00010D-Vd
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrU-0002pm-4r
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:43 +0100
Message-Id: <20180221135404.27598-16-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-1-kwolf@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/36] file-posix: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to file, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 20 +++++++++++++-
 block/file-posix.c   | 77 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 359195a1a3..0040795603 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3359,6 +3359,24 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
+# @BlockdevCreateOptionsFile:
+#
+# Driver specific image creation options for file.
+#
+# @filename         Filename for the new image file
+# @size             Size of the virtual disk in bytes
+# @preallocation    Preallocation mode for the new image (default: off)
+# @nocow            Turn off copy-on-write (valid only on btrfs; default: off)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsFile',
+  'data': { 'filename':         'str',
+            'size':             'size',
+            '*preallocation':   'PreallocMode',
+            '*nocow':           'bool' } }
+
+##
 # @BlockdevQcow2Version:
 #
 # @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
@@ -3429,7 +3447,7 @@
       'bochs':          'BlockdevCreateNotSupported',
       'cloop':          'BlockdevCreateNotSupported',
       'dmg':            'BlockdevCreateNotSupported',
-      'file':           'BlockdevCreateNotSupported',
+      'file':           'BlockdevCreateOptionsFile',
       'ftp':            'BlockdevCreateNotSupported',
       'ftps':           'BlockdevCreateNotSupported',
       'gluster':        'BlockdevCreateNotSupported',
diff --git a/block/file-posix.c b/block/file-posix.c
index f1591c3849..ba14ed9459 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1982,33 +1982,25 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return (int64_t)st.st_blocks * 512;
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
 {
+    BlockdevCreateOptionsFile *file_opts;
     int fd;
     int result = 0;
-    int64_t total_size = 0;
-    bool nocow = false;
-    PreallocMode prealloc;
-    char *buf = NULL;
-    Error *local_err = NULL;
 
-    strstart(filename, "file:", &filename);
+    /* Validate options and set default values */
+    assert(options->driver == BLOCKDEV_DRIVER_FILE);
+    file_opts = &options->u.file;
 
-    /* Read out options */
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-    nocow = qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
-    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
-                               PREALLOC_MODE_OFF, &local_err);
-    g_free(buf);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        result = -EINVAL;
-        goto out;
+    if (!file_opts->has_nocow) {
+        file_opts->nocow = false;
+    }
+    if (!file_opts->has_preallocation) {
+        file_opts->preallocation = PREALLOC_MODE_OFF;
     }
 
-    fd = qemu_open(filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+    /* Create file */
+    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
                    0644);
     if (fd < 0) {
         result = -errno;
@@ -2016,7 +2008,7 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
         goto out;
     }
 
-    if (nocow) {
+    if (file_opts->nocow) {
 #ifdef __linux__
         /* Set NOCOW flag to solve performance issue on fs like btrfs.
          * This is an optimisation. The FS_IOC_SETFLAGS ioctl return value
@@ -2031,7 +2023,8 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
 #endif
     }
 
-    result = raw_regular_truncate(fd, total_size, prealloc, errp);
+    result = raw_regular_truncate(fd, file_opts->size, file_opts->preallocation,
+                                  errp);
     if (result < 0) {
         goto out_close;
     }
@@ -2045,6 +2038,45 @@ out:
     return result;
 }
 
+static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+{
+    BlockdevCreateOptions options;
+    int64_t total_size = 0;
+    bool nocow = false;
+    PreallocMode prealloc;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /* Skip file: protocol prefix */
+    strstart(filename, "file:", &filename);
+
+    /* Read out options */
+    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                          BDRV_SECTOR_SIZE);
+    nocow = qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
+    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
+                               PREALLOC_MODE_OFF, &local_err);
+    g_free(buf);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    options = (BlockdevCreateOptions) {
+        .driver     = BLOCKDEV_DRIVER_FILE,
+        .u.file     = {
+            .filename           = (char *) filename,
+            .size               = total_size,
+            .has_preallocation  = true,
+            .preallocation      = prealloc,
+            .has_nocow          = true,
+            .nocow              = nocow,
+        },
+    };
+    return raw_co_create(&options, errp);
+}
+
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -2276,6 +2308,7 @@ BlockDriver bdrv_file = {
     .bdrv_reopen_commit = raw_reopen_commit,
     .bdrv_reopen_abort = raw_reopen_abort,
     .bdrv_close = raw_close,
+    .bdrv_co_create = raw_co_create,
     .bdrv_create = raw_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = raw_co_block_status,
-- 
2.13.6
