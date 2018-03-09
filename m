Received: from eggs.gnu.org ([2001:4830:134:3::10]:34129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlJ-0001Ux-2r
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlC-0007IA-Nh
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:18 +0100
Message-Id: <20180309161933.8168-42-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 41/56] nfs: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to nfs, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 16 ++++++++++-
 block/nfs.c          | 76 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4351877fc..39e53c7791 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3393,6 +3393,20 @@
             '*preallocation':   'PreallocMode' } }
 
 ##
+# @BlockdevCreateOptionsNfs:
+#
+# Driver specific image creation options for NFS.
+#
+# @location         Where to store the new image file
+# @size             Size of the virtual disk in bytes
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsNfs',
+  'data': { 'location':         'BlockdevOptionsNfs',
+            'size':             'size' } }
+
+##
 # @BlockdevQcow2Version:
 #
 # @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
@@ -3491,7 +3505,7 @@
       'iscsi':          'BlockdevCreateNotSupported',
       'luks':           'BlockdevCreateNotSupported',
       'nbd':            'BlockdevCreateNotSupported',
-      'nfs':            'BlockdevCreateNotSupported',
+      'nfs':            'BlockdevCreateOptionsNfs',
       'null-aio':       'BlockdevCreateNotSupported',
       'null-co':        'BlockdevCreateNotSupported',
       'nvme':           'BlockdevCreateNotSupported',
diff --git a/block/nfs.c b/block/nfs.c
index e402d643fe..2577df4b26 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -551,33 +551,45 @@ out:
     return ret;
 }
 
-static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,
-                                     int flags, int open_flags, Error **errp)
+static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
+                                                     Error **errp)
 {
     BlockdevOptionsNfs *opts = NULL;
     QObject *crumpled = NULL;
     Visitor *v;
     Error *local_err = NULL;
-    int ret;
 
     crumpled = qdict_crumple(options, errp);
     if (crumpled == NULL) {
-        return -EINVAL;
+        return NULL;
     }
 
     v = qobject_input_visitor_new_keyval(crumpled);
     visit_type_BlockdevOptionsNfs(v, NULL, &opts, &local_err);
     visit_free(v);
+    qobject_decref(crumpled);
 
     if (local_err) {
-        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return opts;
+}
+
+static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,
+                                     int flags, int open_flags, Error **errp)
+{
+    BlockdevOptionsNfs *opts;
+    int ret;
+
+    opts = nfs_options_qdict_to_qapi(options, errp);
+    if (opts == NULL) {
         ret = -EINVAL;
         goto fail;
     }
 
     ret = nfs_client_open(client, opts, flags, open_flags, errp);
 fail:
-    qobject_decref(crumpled);
     qapi_free_BlockdevOptionsNfs(opts);
     return ret;
 }
@@ -614,18 +626,43 @@ static QemuOptsList nfs_create_opts = {
     }
 };
 
-static int coroutine_fn nfs_file_co_create_opts(const char *url, QemuOpts *opts,
-                                                Error **errp)
+static int nfs_file_co_create(BlockdevCreateOptions *options, Error **errp)
 {
-    int64_t ret, total_size;
+    BlockdevCreateOptionsNfs *opts = &options->u.nfs;
     NFSClient *client = g_new0(NFSClient, 1);
-    QDict *options = NULL;
+    int ret;
+
+    assert(options->driver == BLOCKDEV_DRIVER_NFS);
 
     client->aio_context = qemu_get_aio_context();
 
+    ret = nfs_client_open(client, opts->location, O_CREAT, 0, errp);
+    if (ret < 0) {
+        goto out;
+    }
+    ret = nfs_ftruncate(client->context, client->fh, opts->size);
+    nfs_client_close(client);
+
+out:
+    g_free(client);
+    return ret;
+}
+
+static int coroutine_fn nfs_file_co_create_opts(const char *url, QemuOpts *opts,
+                                                Error **errp)
+{
+    BlockdevCreateOptions *create_options;
+    BlockdevCreateOptionsNfs *nfs_opts;
+    QDict *options;
+    int ret;
+
+    create_options = g_new0(BlockdevCreateOptions, 1);
+    create_options->driver = BLOCKDEV_DRIVER_NFS;
+    nfs_opts = &create_options->u.nfs;
+
     /* Read out options */
-    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                          BDRV_SECTOR_SIZE);
+    nfs_opts->size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                              BDRV_SECTOR_SIZE);
 
     options = qdict_new();
     ret = nfs_parse_uri(url, options, errp);
@@ -633,15 +670,21 @@ static int coroutine_fn nfs_file_co_create_opts(const char *url, QemuOpts *opts,
         goto out;
     }
 
-    ret = nfs_client_open_qdict(client, options, O_CREAT, 0, errp);
+    nfs_opts->location = nfs_options_qdict_to_qapi(options, errp);
+    if (nfs_opts->location == NULL) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    ret = nfs_file_co_create(create_options, errp);
     if (ret < 0) {
         goto out;
     }
-    ret = nfs_ftruncate(client->context, client->fh, total_size);
-    nfs_client_close(client);
+
+    ret = 0;
 out:
     QDECREF(options);
-    g_free(client);
+    qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
 
@@ -828,6 +871,7 @@ static BlockDriver bdrv_nfs = {
 
     .bdrv_file_open                 = nfs_file_open,
     .bdrv_close                     = nfs_file_close,
+    .bdrv_co_create                 = nfs_file_co_create,
     .bdrv_co_create_opts            = nfs_file_co_create_opts,
     .bdrv_reopen_prepare            = nfs_reopen_prepare,
 
-- 
2.13.6
