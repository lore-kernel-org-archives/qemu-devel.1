Received: from eggs.gnu.org ([2001:4830:134:3::10]:33782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl5-0001E3-Kc
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl3-00073h-BH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:09 +0100
Message-Id: <20180309161933.8168-33-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/56] gluster: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to gluster, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json |  18 ++++++-
 block/gluster.c      | 135 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 108 insertions(+), 45 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 41955b097f..9170fbf6e6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3377,6 +3377,22 @@
             '*nocow':           'bool' } }
 
 ##
+# @BlockdevCreateOptionsGluster:
+#
+# Driver specific image creation options for gluster.
+#
+# @location         Where to store the new image file
+# @size             Size of the virtual disk in bytes
+# @preallocation    Preallocation mode for the new image (default: off)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsGluster',
+  'data': { 'location':         'BlockdevOptionsGluster',
+            'size':             'size',
+            '*preallocation':   'PreallocMode' } }
+
+##
 # @BlockdevQcow2Version:
 #
 # @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
@@ -3450,7 +3466,7 @@
       'file':           'BlockdevCreateOptionsFile',
       'ftp':            'BlockdevCreateNotSupported',
       'ftps':           'BlockdevCreateNotSupported',
-      'gluster':        'BlockdevCreateNotSupported',
+      'gluster':        'BlockdevCreateOptionsGluster',
       'host_cdrom':     'BlockdevCreateNotSupported',
       'host_device':    'BlockdevCreateNotSupported',
       'http':           'BlockdevCreateNotSupported',
diff --git a/block/gluster.c b/block/gluster.c
index 79b4cfdf74..63d3c37d4c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -655,9 +655,11 @@ out:
     return -errno;
 }
 
-static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
-                                      const char *filename,
-                                      QDict *options, Error **errp)
+/* Converts options given in @filename and the @options QDict into the QAPI
+ * object @gconf. */
+static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
+                              const char *filename,
+                              QDict *options, Error **errp)
 {
     int ret;
     if (filename) {
@@ -668,8 +670,7 @@ static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
                                     "[host[:port]]volume/path[?socket=...]"
                                     "[,file.debug=N]"
                                     "[,file.logfile=/path/filename.log]\n");
-            errno = -ret;
-            return NULL;
+            return ret;
         }
     } else {
         ret = qemu_gluster_parse_json(gconf, options, errp);
@@ -685,10 +686,23 @@ static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
                              "file.server.1.transport=unix,"
                              "file.server.1.socket=/var/run/glusterd.socket ..."
                              "\n");
-            errno = -ret;
-            return NULL;
+            return ret;
         }
+    }
 
+    return 0;
+}
+
+static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
+                                      const char *filename,
+                                      QDict *options, Error **errp)
+{
+    int ret;
+
+    ret = qemu_gluster_parse(gconf, filename, options, errp);
+    if (ret < 0) {
+        errno = -ret;
+        return NULL;
     }
 
     return qemu_gluster_glfs_init(gconf, errp);
@@ -1021,20 +1035,72 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
     return 0;
 }
 
+static int qemu_gluster_co_create(BlockdevCreateOptions *options,
+                                  Error **errp)
+{
+    BlockdevCreateOptionsGluster *opts = &options->u.gluster;
+    struct glfs *glfs;
+    struct glfs_fd *fd = NULL;
+    int ret = 0;
+
+    assert(options->driver == BLOCKDEV_DRIVER_GLUSTER);
+
+    glfs = qemu_gluster_glfs_init(opts->location, errp);
+    if (!glfs) {
+        ret = -errno;
+        goto out;
+    }
+
+    fd = glfs_creat(glfs, opts->location->path,
+                    O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR | S_IWUSR);
+    if (!fd) {
+        ret = -errno;
+        goto out;
+    }
+
+    ret = qemu_gluster_do_truncate(fd, opts->size, opts->preallocation, errp);
+
+out:
+    if (fd) {
+        if (glfs_close(fd) != 0 && ret == 0) {
+            ret = -errno;
+        }
+    }
+    glfs_clear_preopened(glfs);
+    return ret;
+}
+
 static int coroutine_fn qemu_gluster_co_create_opts(const char *filename,
                                                     QemuOpts *opts,
                                                     Error **errp)
 {
+    BlockdevCreateOptions *options;
+    BlockdevCreateOptionsGluster *gopts;
     BlockdevOptionsGluster *gconf;
-    struct glfs *glfs;
-    struct glfs_fd *fd = NULL;
-    int ret = 0;
-    PreallocMode prealloc;
-    int64_t total_size = 0;
     char *tmp = NULL;
     Error *local_err = NULL;
+    int ret;
+
+    options = g_new0(BlockdevCreateOptions, 1);
+    options->driver = BLOCKDEV_DRIVER_GLUSTER;
+    gopts = &options->u.gluster;
 
     gconf = g_new0(BlockdevOptionsGluster, 1);
+    gopts->location = gconf;
+
+    gopts->size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                           BDRV_SECTOR_SIZE);
+
+    tmp = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    gopts->preallocation = qapi_enum_parse(&PreallocMode_lookup, tmp,
+                                           PREALLOC_MODE_OFF, &local_err);
+    g_free(tmp);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
     gconf->debug = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
                                            GLUSTER_DEBUG_DEFAULT);
     if (gconf->debug < 0) {
@@ -1050,42 +1116,19 @@ static int coroutine_fn qemu_gluster_co_create_opts(const char *filename,
     }
     gconf->has_logfile = true;
 
-    glfs = qemu_gluster_init(gconf, filename, NULL, errp);
-    if (!glfs) {
-        ret = -errno;
-        goto out;
-    }
-
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-
-    tmp = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc = qapi_enum_parse(&PreallocMode_lookup, tmp, PREALLOC_MODE_OFF,
-                               &local_err);
-    g_free(tmp);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto out;
+    ret = qemu_gluster_parse(gconf, filename, NULL, errp);
+    if (ret < 0) {
+        goto fail;
     }
 
-    fd = glfs_creat(glfs, gconf->path,
-                    O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR | S_IWUSR);
-    if (!fd) {
-        ret = -errno;
-        goto out;
+    ret = qemu_gluster_co_create(options, errp);
+    if (ret < 0) {
+        goto fail;
     }
 
-    ret = qemu_gluster_do_truncate(fd, total_size, prealloc, errp);
-
-out:
-    if (fd) {
-        if (glfs_close(fd) != 0 && ret == 0) {
-            ret = -errno;
-        }
-    }
-    qapi_free_BlockdevOptionsGluster(gconf);
-    glfs_clear_preopened(glfs);
+    ret = 0;
+fail:
+    qapi_free_BlockdevCreateOptions(options);
     return ret;
 }
 
@@ -1436,6 +1479,7 @@ static BlockDriver bdrv_gluster = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
@@ -1464,6 +1508,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
@@ -1492,6 +1537,7 @@ static BlockDriver bdrv_gluster_unix = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
@@ -1526,6 +1572,7 @@ static BlockDriver bdrv_gluster_rdma = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
-- 
2.13.6
