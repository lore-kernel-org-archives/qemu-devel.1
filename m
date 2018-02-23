Received: from eggs.gnu.org ([2001:4830:134:3::10]:50614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzo-0001Ru-8h
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzm-0005Rk-TJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:27:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:45 +0100
Message-Id: <20180223192549.26666-33-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-1-kwolf@redhat.com>
References: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 32/36] ssh: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to ssh, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 16 ++++++++-
 block/ssh.c          | 92 +++++++++++++++++++++++++++++-----------------------
 2 files changed, 67 insertions(+), 41 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 431d4a4fb2..2f7fab46eb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3593,6 +3593,20 @@
             '*object-size':     'size' } }
 
 ##
+# @BlockdevCreateOptionsSsh:
+#
+# Driver specific image creation options for SSH.
+#
+# @location         Where to store the new image file
+# @size             Size of the virtual disk in bytes
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsSsh',
+  'data': { 'location':         'BlockdevOptionsSsh',
+            'size':             'size' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3644,7 +3658,7 @@
       'rbd':            'BlockdevCreateOptionsRbd',
       'replication':    'BlockdevCreateNotSupported',
       'sheepdog':       'BlockdevCreateOptionsSheepdog',
-      'ssh':            'BlockdevCreateNotSupported',
+      'ssh':            'BlockdevCreateOptionsSsh',
       'throttle':       'BlockdevCreateNotSupported',
       'vdi':            'BlockdevCreateNotSupported',
       'vhdx':           'BlockdevCreateNotSupported',
diff --git a/block/ssh.c b/block/ssh.c
index 77bc20041f..bd3044e5f6 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -826,64 +826,75 @@ static QemuOptsList ssh_create_opts = {
     }
 };
 
-static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
+static int ssh_co_create(BlockdevCreateOptions *options, Error **errp)
 {
-    int r, ret;
-    int64_t total_size = 0;
-    QDict *uri_options = NULL;
-    BlockdevOptionsSsh *ssh_opts = NULL;
+    BlockdevCreateOptionsSsh *opts = &options->u.ssh;
     BDRVSSHState s;
-    ssize_t r2;
     char c[1] = { '\0' };
+    int ret;
+
+    assert(options->driver == BLOCKDEV_DRIVER_SSH);
 
     ssh_state_init(&s);
 
+    ret = connect_to_ssh(&s, opts->location,
+                         LIBSSH2_FXF_READ|LIBSSH2_FXF_WRITE|
+                         LIBSSH2_FXF_CREAT|LIBSSH2_FXF_TRUNC,
+                         0644, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    if (opts->size > 0) {
+        libssh2_sftp_seek64(s.sftp_handle, opts->size - 1);
+        ret = libssh2_sftp_write(s.sftp_handle, c, 1);
+        if (ret < 0) {
+            sftp_error_setg(errp, &s, "truncate failed");
+            ret = -EINVAL;
+            goto fail;
+        }
+        s.attrs.filesize = opts->size;
+    }
+
+    ret = 0;
+fail:
+    ssh_state_free(&s);
+    return ret;
+}
+
+static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
+{
+    BlockdevCreateOptions *create_options;
+    BlockdevCreateOptionsSsh *ssh_opts;
+    int ret;
+    QDict *uri_options = NULL;
+
+    create_options = g_new0(BlockdevCreateOptions, 1);
+    create_options->driver = BLOCKDEV_DRIVER_SSH;
+    ssh_opts = &create_options->u.ssh;
+
     /* Get desired file size. */
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
-    DPRINTF("total_size=%" PRIi64, total_size);
+    ssh_opts->size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                              BDRV_SECTOR_SIZE);
+    DPRINTF("total_size=%" PRIi64, ssh_opts->size);
 
     uri_options = qdict_new();
-    r = parse_uri(filename, uri_options, errp);
-    if (r < 0) {
-        ret = r;
+    ret = parse_uri(filename, uri_options, errp);
+    if (ret < 0) {
         goto out;
     }
 
-    ssh_opts = ssh_parse_options(uri_options, errp);
-    if (ssh_opts == NULL) {
+    ssh_opts->location = ssh_parse_options(uri_options, errp);
+    if (ssh_opts->location == NULL) {
         ret = -EINVAL;
         goto out;
     }
 
-    r = connect_to_ssh(&s, ssh_opts,
-                       LIBSSH2_FXF_READ|LIBSSH2_FXF_WRITE|
-                       LIBSSH2_FXF_CREAT|LIBSSH2_FXF_TRUNC,
-                       0644, errp);
-    if (r < 0) {
-        ret = r;
-        goto out;
-    }
-
-    if (total_size > 0) {
-        libssh2_sftp_seek64(s.sftp_handle, total_size-1);
-        r2 = libssh2_sftp_write(s.sftp_handle, c, 1);
-        if (r2 < 0) {
-            sftp_error_setg(errp, &s, "truncate failed");
-            ret = -EINVAL;
-            goto out;
-        }
-        s.attrs.filesize = total_size;
-    }
-
-    ret = 0;
+    ret = ssh_co_create(create_options, errp);
 
  out:
-    ssh_state_free(&s);
-    if (uri_options != NULL) {
-        QDECREF(uri_options);
-    }
-    qapi_free_BlockdevOptionsSsh(ssh_opts);
+    QDECREF(uri_options);
+    qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
 
@@ -1223,6 +1234,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_parse_filename          = ssh_parse_filename,
     .bdrv_file_open               = ssh_file_open,
     .bdrv_create                  = ssh_create,
+    .bdrv_co_create               = ssh_co_create,
     .bdrv_close                   = ssh_close,
     .bdrv_has_zero_init           = ssh_has_zero_init,
     .bdrv_co_readv                = ssh_co_readv,
-- 
2.13.6
