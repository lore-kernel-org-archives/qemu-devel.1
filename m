Received: from eggs.gnu.org ([2001:4830:134:3::10]:34199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlL-0001XR-3V
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlG-0007Lg-1p
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:20 +0100
Message-Id: <20180309161933.8168-44-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 43/56] sheepdog: Support .bdrv_co_create
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

This adds the .bdrv_co_create driver callback to sheepdog, which enables
image creation over QMP.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  24 ++++-
 block/sheepdog.c     | 243 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 192 insertions(+), 75 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e590ab6c71..fd444421fc 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3512,6 +3512,28 @@
             'erasure-coded': 'SheepdogRedundancyErasureCoded' } }
 
 ##
+# @BlockdevCreateOptionsSheepdog:
+#
+# Driver specific image creation options for Sheepdog.
+#
+# @location         Where to store the new image file
+# @size             Size of the virtual disk in bytes
+# @backing-file     File name of a base image
+# @preallocation    Preallocation mode (allowed values: off, full)
+# @redundancy       Redundancy of the image
+# @object-size      Object size of the image
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsSheepdog',
+  'data': { 'location':         'BlockdevOptionsSheepdog',
+            'size':             'size',
+            '*backing-file':    'str',
+            '*preallocation':   'PreallocMode',
+            '*redundancy':      'SheepdogRedundancy',
+            '*object-size':     'size' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3562,7 +3584,7 @@
       'raw':            'BlockdevCreateNotSupported',
       'rbd':            'BlockdevCreateOptionsRbd',
       'replication':    'BlockdevCreateNotSupported',
-      'sheepdog':       'BlockdevCreateNotSupported',
+      'sheepdog':       'BlockdevCreateOptionsSheepdog',
       'ssh':            'BlockdevCreateNotSupported',
       'throttle':       'BlockdevCreateNotSupported',
       'vdi':            'BlockdevCreateNotSupported',
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 3966cd229a..8680b2926f 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -15,8 +15,10 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -533,23 +535,6 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
     qemu_co_mutex_unlock(&s->queue_lock);
 }
 
-static SocketAddress *sd_socket_address(const char *path,
-                                        const char *host, const char *port)
-{
-    SocketAddress *addr = g_new0(SocketAddress, 1);
-
-    if (path) {
-        addr->type = SOCKET_ADDRESS_TYPE_UNIX;
-        addr->u.q_unix.path = g_strdup(path);
-    } else {
-        addr->type = SOCKET_ADDRESS_TYPE_INET;
-        addr->u.inet.host = g_strdup(host ?: SD_DEFAULT_ADDR);
-        addr->u.inet.port = g_strdup(port ?: stringify(SD_DEFAULT_PORT));
-    }
-
-    return addr;
-}
-
 static SocketAddress *sd_server_config(QDict *options, Error **errp)
 {
     QDict *server = NULL;
@@ -1882,6 +1867,44 @@ out_with_err_set:
     return ret;
 }
 
+static int sd_create_prealloc(BlockdevOptionsSheepdog *location, int64_t size,
+                              Error **errp)
+{
+    BlockDriverState *bs;
+    Visitor *v;
+    QObject *obj = NULL;
+    QDict *qdict;
+    Error *local_err = NULL;
+    int ret;
+
+    v = qobject_output_visitor_new(&obj);
+    visit_type_BlockdevOptionsSheepdog(v, NULL, &location, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        qobject_decref(obj);
+        return -EINVAL;
+    }
+
+    qdict = qobject_to_qdict(obj);
+    qdict_flatten(qdict);
+
+    qdict_put_str(qdict, "driver", "sheepdog");
+
+    bs = bdrv_open(NULL, NULL, qdict, BDRV_O_PROTOCOL | BDRV_O_RDWR, errp);
+    if (bs == NULL) {
+        ret = -EIO;
+        goto fail;
+    }
+
+    ret = sd_prealloc(bs, 0, size, errp);
+fail:
+    bdrv_unref(bs);
+    QDECREF(qdict);
+    return ret;
+}
+
 static int parse_redundancy(BDRVSheepdogState *s, SheepdogRedundancy *opt)
 {
     struct SheepdogInode *inode = &s->inode;
@@ -1934,9 +1957,9 @@ static int parse_redundancy(BDRVSheepdogState *s, SheepdogRedundancy *opt)
  * # create a erasure coded vdi with x data strips and y parity strips
  * -o redundancy=x:y (x must be one of {2,4,8,16} and 1 <= y < SD_EC_MAX_STRIP)
  */
-static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
+static SheepdogRedundancy *parse_redundancy_str(const char *opt)
 {
-    struct SheepdogRedundancy redundancy;
+    SheepdogRedundancy *redundancy;
     const char *n1, *n2;
     long copy, parity;
     char p[10];
@@ -1947,26 +1970,27 @@ static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
     n2 = strtok(NULL, ":");
 
     if (!n1) {
-        return -EINVAL;
+        return NULL;
     }
 
     ret = qemu_strtol(n1, NULL, 10, &copy);
     if (ret < 0) {
-        return ret;
+        return NULL;
     }
 
+    redundancy = g_new0(SheepdogRedundancy, 1);
     if (!n2) {
-        redundancy = (SheepdogRedundancy) {
+        *redundancy = (SheepdogRedundancy) {
             .type               = SHEEPDOG_REDUNDANCY_TYPE_FULL,
             .u.full.copies      = copy,
         };
     } else {
         ret = qemu_strtol(n2, NULL, 10, &parity);
         if (ret < 0) {
-            return ret;
+            return NULL;
         }
 
-        redundancy = (SheepdogRedundancy) {
+        *redundancy = (SheepdogRedundancy) {
             .type               = SHEEPDOG_REDUNDANCY_TYPE_ERASURE_CODED,
             .u.erasure_coded    = {
                 .data_strips    = copy,
@@ -1975,17 +1999,19 @@ static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
         };
     }
 
-    return parse_redundancy(s, &redundancy);
+    return redundancy;
 }
 
-static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
+static int parse_block_size_shift(BDRVSheepdogState *s,
+                                  BlockdevCreateOptionsSheepdog *opts)
 {
     struct SheepdogInode *inode = &s->inode;
     uint64_t object_size;
     int obj_order;
 
-    object_size = qemu_opt_get_size_del(opt, BLOCK_OPT_OBJECT_SIZE, 0);
-    if (object_size) {
+    if (opts->has_object_size) {
+        object_size = opts->object_size;
+
         if ((object_size - 1) & object_size) {    /* not a power of 2? */
             return -EINVAL;
         }
@@ -1999,57 +2025,55 @@ static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
     return 0;
 }
 
-static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
-                                          Error **errp)
+static int sd_co_create(BlockdevCreateOptions *options, Error **errp)
 {
-    Error *err = NULL;
+    BlockdevCreateOptionsSheepdog *opts = &options->u.sheepdog;
     int ret = 0;
     uint32_t vid = 0;
     char *backing_file = NULL;
     char *buf = NULL;
     BDRVSheepdogState *s;
-    SheepdogConfig cfg;
     uint64_t max_vdi_size;
     bool prealloc = false;
 
+    assert(options->driver == BLOCKDEV_DRIVER_SHEEPDOG);
+
     s = g_new0(BDRVSheepdogState, 1);
 
-    if (strstr(filename, "://")) {
-        sd_parse_uri(&cfg, filename, &err);
-    } else {
-        parse_vdiname(&cfg, filename, &err);
-    }
-    if (err) {
-        error_propagate(errp, err);
+    /* Steal SocketAddress from QAPI, set NULL to prevent double free */
+    s->addr = opts->location->server;
+    opts->location->server = NULL;
+
+    if (strlen(opts->location->vdi) >= sizeof(s->name)) {
+        error_setg(errp, "'vdi' string too long");
+        ret = -EINVAL;
         goto out;
     }
+    pstrcpy(s->name, sizeof(s->name), opts->location->vdi);
 
-    buf = cfg.port ? g_strdup_printf("%d", cfg.port) : NULL;
-    s->addr = sd_socket_address(cfg.path, cfg.host, buf);
-    g_free(buf);
-    strcpy(s->name, cfg.vdi);
-    sd_config_done(&cfg);
+    s->inode.vdi_size = opts->size;
+    backing_file = opts->backing_file;
 
-    s->inode.vdi_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                                 BDRV_SECTOR_SIZE);
-    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
-    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    if (!buf || !strcmp(buf, "off")) {
+    if (!opts->has_preallocation) {
+        opts->preallocation = PREALLOC_MODE_OFF;
+    }
+    switch (opts->preallocation) {
+    case PREALLOC_MODE_OFF:
         prealloc = false;
-    } else if (!strcmp(buf, "full")) {
+        break;
+    case PREALLOC_MODE_FULL:
         prealloc = true;
-    } else {
-        error_setg(errp, "Invalid preallocation mode: '%s'", buf);
+        break;
+    default:
+        error_setg(errp, "Preallocation mode not supported for Sheepdog");
         ret = -EINVAL;
         goto out;
     }
 
-    g_free(buf);
-    buf = qemu_opt_get_del(opts, BLOCK_OPT_REDUNDANCY);
-    if (buf) {
-        ret = parse_redundancy_str(s, buf);
+    if (opts->has_redundancy) {
+        ret = parse_redundancy(s, opts->redundancy);
         if (ret < 0) {
-            error_setg(errp, "Invalid redundancy mode: '%s'", buf);
+            error_setg(errp, "Invalid redundancy mode");
             goto out;
         }
     }
@@ -2061,20 +2085,20 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
         goto out;
     }
 
-    if (backing_file) {
+    if (opts->has_backing_file) {
         BlockBackend *blk;
         BDRVSheepdogState *base;
         BlockDriver *drv;
 
         /* Currently, only Sheepdog backing image is supported. */
-        drv = bdrv_find_protocol(backing_file, true, NULL);
+        drv = bdrv_find_protocol(opts->backing_file, true, NULL);
         if (!drv || strcmp(drv->protocol_name, "sheepdog") != 0) {
             error_setg(errp, "backing_file must be a sheepdog image");
             ret = -EINVAL;
             goto out;
         }
 
-        blk = blk_new_open(backing_file, NULL, NULL,
+        blk = blk_new_open(opts->backing_file, NULL, NULL,
                            BDRV_O_PROTOCOL, errp);
         if (blk == NULL) {
             ret = -EIO;
@@ -2142,28 +2166,96 @@ static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
     }
 
     if (prealloc) {
-        BlockDriverState *bs;
-        QDict *opts;
-
-        opts = qdict_new();
-        qdict_put_str(opts, "driver", "sheepdog");
-        bs = bdrv_open(filename, NULL, opts, BDRV_O_PROTOCOL | BDRV_O_RDWR,
-                       errp);
-        if (!bs) {
-            goto out;
-        }
-
-        ret = sd_prealloc(bs, 0, s->inode.vdi_size, errp);
-
-        bdrv_unref(bs);
+        ret = sd_create_prealloc(opts->location, opts->size, errp);
     }
 out:
     g_free(backing_file);
     g_free(buf);
+    g_free(s->addr);
     g_free(s);
     return ret;
 }
 
+static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
+                                          Error **errp)
+{
+    BlockdevCreateOptions *create_options = NULL;
+    QDict *qdict, *location_qdict;
+    QObject *crumpled;
+    Visitor *v;
+    const char *redundancy;
+    Error *local_err = NULL;
+    int ret;
+
+    redundancy = qemu_opt_get_del(opts, BLOCK_OPT_REDUNDANCY);
+
+    qdict = qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(qdict, "driver", "sheepdog");
+
+    location_qdict = qdict_new();
+    qdict_put(qdict, "location", location_qdict);
+
+    sd_parse_filename(filename, location_qdict, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    qdict_flatten(qdict);
+
+    /* Change legacy command line options into QMP ones */
+    static const QDictRenames opt_renames[] = {
+        { BLOCK_OPT_BACKING_FILE,       "backing-file" },
+        { BLOCK_OPT_OBJECT_SIZE,        "object-size" },
+        { NULL, NULL },
+    };
+
+    if (!qdict_rename_keys(qdict, opt_renames, errp)) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Get the QAPI object */
+    crumpled = qdict_crumple(qdict, errp);
+    if (crumpled == NULL) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    v = qobject_input_visitor_new_keyval(crumpled);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_free(v);
+    qobject_decref(crumpled);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    assert(create_options->driver == BLOCKDEV_DRIVER_SHEEPDOG);
+    create_options->u.sheepdog.size =
+        ROUND_UP(create_options->u.sheepdog.size, BDRV_SECTOR_SIZE);
+
+    if (redundancy) {
+        create_options->u.sheepdog.has_redundancy = true;
+        create_options->u.sheepdog.redundancy =
+            parse_redundancy_str(redundancy);
+        if (create_options->u.sheepdog.redundancy == NULL) {
+            error_setg(errp, "Invalid redundancy mode");
+            ret = -EINVAL;
+            goto fail;
+        }
+    }
+
+    ret = sd_co_create(create_options, errp);
+fail:
+    qapi_free_BlockdevCreateOptions(create_options);
+    QDECREF(qdict);
+    return ret;
+}
+
 static void sd_close(BlockDriverState *bs)
 {
     Error *local_err = NULL;
@@ -3143,6 +3235,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_reopen_commit           = sd_reopen_commit,
     .bdrv_reopen_abort            = sd_reopen_abort,
     .bdrv_close                   = sd_close,
+    .bdrv_co_create               = sd_co_create,
     .bdrv_co_create_opts          = sd_co_create_opts,
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
@@ -3179,6 +3272,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_reopen_commit           = sd_reopen_commit,
     .bdrv_reopen_abort            = sd_reopen_abort,
     .bdrv_close                   = sd_close,
+    .bdrv_co_create               = sd_co_create,
     .bdrv_co_create_opts          = sd_co_create_opts,
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
@@ -3215,6 +3309,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_reopen_commit           = sd_reopen_commit,
     .bdrv_reopen_abort            = sd_reopen_abort,
     .bdrv_close                   = sd_close,
+    .bdrv_co_create               = sd_co_create,
     .bdrv_co_create_opts          = sd_co_create_opts,
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
-- 
2.13.6
