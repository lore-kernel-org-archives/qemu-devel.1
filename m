Received: from eggs.gnu.org ([2001:4830:134:3::10]:34139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlJ-0001VP-C8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlG-0007MG-I4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:24 +0100
Message-Id: <20180309161933.8168-48-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 47/56] ssh: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to ssh, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 16 +++++++++-
 block/ssh.c          | 83 ++++++++++++++++++++++++++++++----------------------
 2 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4814bb7db7..524d51567a 100644
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
index 80f59055cc..ab3acf0c22 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -854,59 +854,71 @@ static QemuOptsList ssh_create_opts = {
     }
 };
 
+static int ssh_co_create(BlockdevCreateOptions *options, Error **errp)
+{
+    BlockdevCreateOptionsSsh *opts = &options->u.ssh;
+    BDRVSSHState s;
+    int ret;
+
+    assert(options->driver == BLOCKDEV_DRIVER_SSH);
+
+    ssh_state_init(&s);
+
+    ret = connect_to_ssh(&s, opts->location,
+                         LIBSSH2_FXF_READ|LIBSSH2_FXF_WRITE|
+                         LIBSSH2_FXF_CREAT|LIBSSH2_FXF_TRUNC,
+                         0644, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    if (opts->size > 0) {
+        ret = ssh_grow_file(&s, opts->size, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    ret = 0;
+fail:
+    ssh_state_free(&s);
+    return ret;
+}
+
 static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
                                            Error **errp)
 {
-    int r, ret;
-    int64_t total_size = 0;
+    BlockdevCreateOptions *create_options;
+    BlockdevCreateOptionsSsh *ssh_opts;
+    int ret;
     QDict *uri_options = NULL;
-    BlockdevOptionsSsh *ssh_opts = NULL;
-    BDRVSSHState s;
 
-    ssh_state_init(&s);
+    create_options = g_new0(BlockdevCreateOptions, 1);
+    create_options->driver = BLOCKDEV_DRIVER_SSH;
+    ssh_opts = &create_options->u.ssh;
 
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
-        ret = ssh_grow_file(&s, total_size, errp);
-        if (ret < 0) {
-            goto out;
-        }
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
 
@@ -1268,6 +1280,7 @@ static BlockDriver bdrv_ssh = {
     .instance_size                = sizeof(BDRVSSHState),
     .bdrv_parse_filename          = ssh_parse_filename,
     .bdrv_file_open               = ssh_file_open,
+    .bdrv_co_create               = ssh_co_create,
     .bdrv_co_create_opts          = ssh_co_create_opts,
     .bdrv_close                   = ssh_close,
     .bdrv_has_zero_init           = ssh_has_zero_init,
-- 
2.13.6
