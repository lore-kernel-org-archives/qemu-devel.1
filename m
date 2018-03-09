Received: from eggs.gnu.org ([2001:4830:134:3::10]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlE-0001OV-Du
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlC-0007IG-MY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:48 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:17 +0100
Message-Id: <20180309161933.8168-41-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 40/56] nfs: Use QAPI options in nfs_client_open()
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

Using the QAPI visitor to turn all options into QAPI BlockdevOptionsNfs
simplifies the code a lot. It will also be useful for implementing the
QAPI based .bdrv_co_create callback.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 176 ++++++++++++++++++------------------------------------------
 1 file changed, 53 insertions(+), 123 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 7433d25856..e402d643fe 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -367,49 +367,6 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
     return task.ret;
 }
 
-static QemuOptsList runtime_opts = {
-    .name = "nfs",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
-    .desc = {
-        {
-            .name = "path",
-            .type = QEMU_OPT_STRING,
-            .help = "Path of the image on the host",
-        },
-        {
-            .name = "user",
-            .type = QEMU_OPT_NUMBER,
-            .help = "UID value to use when talking to the server",
-        },
-        {
-            .name = "group",
-            .type = QEMU_OPT_NUMBER,
-            .help = "GID value to use when talking to the server",
-        },
-        {
-            .name = "tcp-syn-count",
-            .type = QEMU_OPT_NUMBER,
-            .help = "Number of SYNs to send during the session establish",
-        },
-        {
-            .name = "readahead-size",
-            .type = QEMU_OPT_NUMBER,
-            .help = "Set the readahead size in bytes",
-        },
-        {
-            .name = "page-cache-size",
-            .type = QEMU_OPT_NUMBER,
-            .help = "Set the pagecache size in bytes",
-        },
-        {
-            .name = "debug",
-            .type = QEMU_OPT_NUMBER,
-            .help = "Set the NFS debug level (max 2)",
-        },
-        { /* end of list */ }
-    },
-};
-
 static void nfs_detach_aio_context(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
@@ -452,71 +409,16 @@ static void nfs_file_close(BlockDriverState *bs)
     nfs_client_close(client);
 }
 
-static NFSServer *nfs_config(QDict *options, Error **errp)
-{
-    NFSServer *server = NULL;
-    QDict *addr = NULL;
-    QObject *crumpled_addr = NULL;
-    Visitor *iv = NULL;
-    Error *local_error = NULL;
-
-    qdict_extract_subqdict(options, &addr, "server.");
-    if (!qdict_size(addr)) {
-        error_setg(errp, "NFS server address missing");
-        goto out;
-    }
-
-    crumpled_addr = qdict_crumple(addr, errp);
-    if (!crumpled_addr) {
-        goto out;
-    }
-
-    /*
-     * Caution: this works only because all scalar members of
-     * NFSServer are QString in @crumpled_addr.  The visitor expects
-     * @crumpled_addr to be typed according to the QAPI schema.  It
-     * is when @options come from -blockdev or blockdev_add.  But when
-     * they come from -drive, they're all QString.
-     */
-    iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_NFSServer(iv, NULL, &server, &local_error);
-    if (local_error) {
-        error_propagate(errp, local_error);
-        goto out;
-    }
-
-out:
-    QDECREF(addr);
-    qobject_decref(crumpled_addr);
-    visit_free(iv);
-    return server;
-}
-
-
-static int64_t nfs_client_open(NFSClient *client, QDict *options,
+static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
                                int flags, int open_flags, Error **errp)
 {
     int64_t ret = -EINVAL;
-    QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     struct stat st;
     char *file = NULL, *strp = NULL;
 
     qemu_mutex_init(&client->mutex);
-    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto fail;
-    }
 
-    client->path = g_strdup(qemu_opt_get(opts, "path"));
-    if (!client->path) {
-        ret = -EINVAL;
-        error_setg(errp, "No path was specified");
-        goto fail;
-    }
+    client->path = g_strdup(opts->path);
 
     strp = strrchr(client->path, '/');
     if (strp == NULL) {
@@ -526,12 +428,10 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
     file = g_strdup(strp);
     *strp = 0;
 
-    /* Pop the config into our state object, Exit if invalid */
-    client->server = nfs_config(options, errp);
-    if (!client->server) {
-        ret = -EINVAL;
-        goto fail;
-    }
+    /* Steal the NFSServer object from opts; set the original pointer to NULL
+     * to avoid use after free and double free. */
+    client->server = opts->server;
+    opts->server = NULL;
 
     client->context = nfs_init_context();
     if (client->context == NULL) {
@@ -539,29 +439,29 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
         goto fail;
     }
 
-    if (qemu_opt_get(opts, "user")) {
-        client->uid = qemu_opt_get_number(opts, "user", 0);
+    if (opts->has_user) {
+        client->uid = opts->user;
         nfs_set_uid(client->context, client->uid);
     }
 
-    if (qemu_opt_get(opts, "group")) {
-        client->gid = qemu_opt_get_number(opts, "group", 0);
+    if (opts->has_group) {
+        client->gid = opts->group;
         nfs_set_gid(client->context, client->gid);
     }
 
-    if (qemu_opt_get(opts, "tcp-syn-count")) {
-        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syn-count", 0);
+    if (opts->has_tcp_syn_count) {
+        client->tcp_syncnt = opts->tcp_syn_count;
         nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
     }
 
 #ifdef LIBNFS_FEATURE_READAHEAD
-    if (qemu_opt_get(opts, "readahead-size")) {
+    if (opts->has_readahead_size) {
         if (open_flags & BDRV_O_NOCACHE) {
             error_setg(errp, "Cannot enable NFS readahead "
                              "if cache.direct = on");
             goto fail;
         }
-        client->readahead = qemu_opt_get_number(opts, "readahead-size", 0);
+        client->readahead = opts->readahead_size;
         if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
             warn_report("Truncating NFS readahead size to %d",
                         QEMU_NFS_MAX_READAHEAD_SIZE);
@@ -576,13 +476,13 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
 #endif
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
-    if (qemu_opt_get(opts, "page-cache-size")) {
+    if (opts->has_page_cache_size) {
         if (open_flags & BDRV_O_NOCACHE) {
             error_setg(errp, "Cannot enable NFS pagecache "
                              "if cache.direct = on");
             goto fail;
         }
-        client->pagecache = qemu_opt_get_number(opts, "page-cache-size", 0);
+        client->pagecache = opts->page_cache_size;
         if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
             warn_report("Truncating NFS pagecache size to %d pages",
                         QEMU_NFS_MAX_PAGECACHE_SIZE);
@@ -595,8 +495,8 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
 #endif
 
 #ifdef LIBNFS_FEATURE_DEBUG
-    if (qemu_opt_get(opts, "debug")) {
-        client->debug = qemu_opt_get_number(opts, "debug", 0);
+    if (opts->has_debug) {
+        client->debug = opts->debug;
         /* limit the maximum debug level to avoid potential flooding
          * of our log files. */
         if (client->debug > QEMU_NFS_MAX_DEBUG_LEVEL) {
@@ -647,11 +547,41 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
 fail:
     nfs_client_close(client);
 out:
-    qemu_opts_del(opts);
     g_free(file);
     return ret;
 }
 
+static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,
+                                     int flags, int open_flags, Error **errp)
+{
+    BlockdevOptionsNfs *opts = NULL;
+    QObject *crumpled = NULL;
+    Visitor *v;
+    Error *local_err = NULL;
+    int ret;
+
+    crumpled = qdict_crumple(options, errp);
+    if (crumpled == NULL) {
+        return -EINVAL;
+    }
+
+    v = qobject_input_visitor_new_keyval(crumpled);
+    visit_type_BlockdevOptionsNfs(v, NULL, &opts, &local_err);
+    visit_free(v);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    ret = nfs_client_open(client, opts, flags, open_flags, errp);
+fail:
+    qobject_decref(crumpled);
+    qapi_free_BlockdevOptionsNfs(opts);
+    return ret;
+}
+
 static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp) {
     NFSClient *client = bs->opaque;
@@ -659,9 +589,9 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
 
     client->aio_context = bdrv_get_aio_context(bs);
 
-    ret = nfs_client_open(client, options,
-                          (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,
-                          bs->open_flags, errp);
+    ret = nfs_client_open_qdict(client, options,
+                                (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,
+                                bs->open_flags, errp);
     if (ret < 0) {
         return ret;
     }
@@ -703,7 +633,7 @@ static int coroutine_fn nfs_file_co_create_opts(const char *url, QemuOpts *opts,
         goto out;
     }
 
-    ret = nfs_client_open(client, options, O_CREAT, 0, errp);
+    ret = nfs_client_open_qdict(client, options, O_CREAT, 0, errp);
     if (ret < 0) {
         goto out;
     }
-- 
2.13.6
