Received: from eggs.gnu.org ([2001:4830:134:3::10]:33975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlC-0001Mj-M5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlA-0007FN-GG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:14 +0100
Message-Id: <20180309161933.8168-38-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 37/56] rbd: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to rbd, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  19 ++++++-
 block/rbd.c          | 150 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 118 insertions(+), 51 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9170fbf6e6..d4351877fc 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3436,6 +3436,23 @@
             '*refcount-bits':   'int' } }
 
 ##
+# @BlockdevCreateOptionsRbd:
+#
+# Driver specific image creation options for rbd/Ceph.
+#
+# @location         Where to store the new image file. This location cannot
+#                   point to a snapshot.
+# @size             Size of the virtual disk in bytes
+# @cluster-size     RBD object size
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsRbd',
+  'data': { 'location':         'BlockdevOptionsRbd',
+            'size':             'size',
+            '*cluster-size' :   'size' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3484,7 +3501,7 @@
       'qed':            'BlockdevCreateNotSupported',
       'quorum':         'BlockdevCreateNotSupported',
       'raw':            'BlockdevCreateNotSupported',
-      'rbd':            'BlockdevCreateNotSupported',
+      'rbd':            'BlockdevCreateOptionsRbd',
       'replication':    'BlockdevCreateNotSupported',
       'sheepdog':       'BlockdevCreateNotSupported',
       'ssh':            'BlockdevCreateNotSupported',
diff --git a/block/rbd.c b/block/rbd.c
index 999fea105f..1cd526bcea 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -332,71 +332,55 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
-                                                QemuOpts *opts,
-                                                Error **errp)
+/* FIXME Deprecate and remove keypairs or make it available in QMP.
+ * password_secret should eventually be configurable in opts->location. Support
+ * for it in .bdrv_open will make it work here as well. */
+static int qemu_rbd_do_create(BlockdevCreateOptions *options,
+                              const char *keypairs, const char *password_secret,
+                              Error **errp)
 {
-    Error *local_err = NULL;
-    int64_t bytes = 0;
-    int64_t objsize;
-    int obj_order = 0;
-    const char *pool, *image_name, *conf, *user, *keypairs;
-    const char *secretid;
+    BlockdevCreateOptionsRbd *opts = &options->u.rbd;
     rados_t cluster;
     rados_ioctx_t io_ctx;
-    QDict *options = NULL;
-    int ret = 0;
+    int obj_order = 0;
+    int ret;
+
+    assert(options->driver == BLOCKDEV_DRIVER_RBD);
+    if (opts->location->has_snapshot) {
+        error_setg(errp, "Can't use snapshot name for image creation");
+        return -EINVAL;
+    }
 
-    secretid = qemu_opt_get(opts, "password-secret");
+    /* TODO Remove the limitation */
+    if (opts->location->has_server) {
+        error_setg(errp, "Can't specify server for image creation");
+        return -EINVAL;
+    }
 
-    /* Read out options */
-    bytes = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                     BDRV_SECTOR_SIZE);
-    objsize = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE, 0);
-    if (objsize) {
+    if (opts->has_cluster_size) {
+        int64_t objsize = opts->cluster_size;
         if ((objsize - 1) & objsize) {    /* not a power of 2? */
             error_setg(errp, "obj size needs to be power of 2");
-            ret = -EINVAL;
-            goto exit;
+            return -EINVAL;
         }
         if (objsize < 4096) {
             error_setg(errp, "obj size too small");
-            ret = -EINVAL;
-            goto exit;
+            return -EINVAL;
         }
         obj_order = ctz32(objsize);
     }
 
-    options = qdict_new();
-    qemu_rbd_parse_filename(filename, options, &local_err);
-    if (local_err) {
-        ret = -EINVAL;
-        error_propagate(errp, local_err);
-        goto exit;
-    }
-
-    /*
-     * Caution: while qdict_get_try_str() is fine, getting non-string
-     * types would require more care.  When @options come from -blockdev
-     * or blockdev_add, its members are typed according to the QAPI
-     * schema, but when they come from -drive, they're all QString.
-     */
-    pool       = qdict_get_try_str(options, "pool");
-    conf       = qdict_get_try_str(options, "conf");
-    user       = qdict_get_try_str(options, "user");
-    image_name = qdict_get_try_str(options, "image");
-    keypairs   = qdict_get_try_str(options, "=keyvalue-pairs");
-
-    ret = rados_create(&cluster, user);
+    ret = rados_create(&cluster, opts->location->user);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error initializing");
-        goto exit;
+        return ret;
     }
 
     /* try default location when conf=NULL, but ignore failure */
-    ret = rados_conf_read_file(cluster, conf);
-    if (conf && ret < 0) {
-        error_setg_errno(errp, -ret, "error reading conf file %s", conf);
+    ret = rados_conf_read_file(cluster, opts->location->conf);
+    if (opts->location->conf && ret < 0) {
+        error_setg_errno(errp, -ret, "error reading conf file %s",
+                         opts->location->conf);
         ret = -EIO;
         goto shutdown;
     }
@@ -407,7 +391,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
         goto shutdown;
     }
 
-    if (qemu_rbd_set_auth(cluster, secretid, errp) < 0) {
+    if (qemu_rbd_set_auth(cluster, password_secret, errp) < 0) {
         ret = -EIO;
         goto shutdown;
     }
@@ -418,24 +402,89 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
         goto shutdown;
     }
 
-    ret = rados_ioctx_create(cluster, pool, &io_ctx);
+    ret = rados_ioctx_create(cluster, opts->location->pool, &io_ctx);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "error opening pool %s", pool);
+        error_setg_errno(errp, -ret, "error opening pool %s",
+                         opts->location->pool);
         goto shutdown;
     }
 
-    ret = rbd_create(io_ctx, image_name, bytes, &obj_order);
+    ret = rbd_create(io_ctx, opts->location->image, opts->size, &obj_order);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error rbd create");
     }
 
     rados_ioctx_destroy(io_ctx);
 
+    ret = 0;
 shutdown:
     rados_shutdown(cluster);
+    return ret;
+}
+
+static int qemu_rbd_co_create(BlockdevCreateOptions *options, Error **errp)
+{
+    return qemu_rbd_do_create(options, NULL, NULL, errp);
+}
+
+static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
+                                                QemuOpts *opts,
+                                                Error **errp)
+{
+    BlockdevCreateOptions *create_options;
+    BlockdevCreateOptionsRbd *rbd_opts;
+    BlockdevOptionsRbd *loc;
+    Error *local_err = NULL;
+    const char *keypairs, *password_secret;
+    QDict *options = NULL;
+    int ret = 0;
+
+    create_options = g_new0(BlockdevCreateOptions, 1);
+    create_options->driver = BLOCKDEV_DRIVER_RBD;
+    rbd_opts = &create_options->u.rbd;
+
+    rbd_opts->location = g_new0(BlockdevOptionsRbd, 1);
+
+    password_secret = qemu_opt_get(opts, "password-secret");
+
+    /* Read out options */
+    rbd_opts->size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                              BDRV_SECTOR_SIZE);
+    rbd_opts->cluster_size = qemu_opt_get_size_del(opts,
+                                                   BLOCK_OPT_CLUSTER_SIZE, 0);
+    rbd_opts->has_cluster_size = (rbd_opts->cluster_size != 0);
+
+    options = qdict_new();
+    qemu_rbd_parse_filename(filename, options, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto exit;
+    }
+
+    /*
+     * Caution: while qdict_get_try_str() is fine, getting non-string
+     * types would require more care.  When @options come from -blockdev
+     * or blockdev_add, its members are typed according to the QAPI
+     * schema, but when they come from -drive, they're all QString.
+     */
+    loc = rbd_opts->location;
+    loc->pool     = g_strdup(qdict_get_try_str(options, "pool"));
+    loc->conf     = g_strdup(qdict_get_try_str(options, "conf"));
+    loc->has_conf = !!loc->conf;
+    loc->user     = g_strdup(qdict_get_try_str(options, "user"));
+    loc->has_user = !!loc->user;
+    loc->image    = g_strdup(qdict_get_try_str(options, "image"));
+    keypairs      = qdict_get_try_str(options, "=keyvalue-pairs");
+
+    ret = qemu_rbd_do_create(create_options, keypairs, password_secret, errp);
+    if (ret < 0) {
+        goto exit;
+    }
 
 exit:
     QDECREF(options);
+    qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
 
@@ -1143,6 +1192,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_file_open         = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
     .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
+    .bdrv_co_create         = qemu_rbd_co_create,
     .bdrv_co_create_opts    = qemu_rbd_co_create_opts,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .bdrv_get_info          = qemu_rbd_getinfo,
-- 
2.13.6
