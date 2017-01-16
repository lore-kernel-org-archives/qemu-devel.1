Received: from eggs.gnu.org ([2001:4830:134:3::10]:46595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEG9-0003J2-22
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEG6-0004QF-TJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:52:09 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:51:52 +0100
Message-Id: <20170116205156.32513-1-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 21/25] block: Purify .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Currently, BlockDriver.bdrv_refresh_filename() is supposed to both
refresh the filename (BDS.exact_filename) and set BDS.full_open_options.
Now that we have generic code in the central bdrv_refresh_filename() for
creating BDS.full_open_options, we can drop the latter part from all
BlockDriver.bdrv_refresh_filename() implementations.

This also means that we can drop all of the existing default code for
this from the global bdrv_refresh_filename() itself.

Furthermore, we now have to call BlockDriver.bdrv_refresh_filename()
after having set BDS.full_open_options, because the block driver's
implementation should now be allowed to depend on BDS.full_open_options
being set correctly.

Finally, with this patch we can drop the @options parameter from
BlockDriver.bdrv_refresh_filename().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |   2 +-
 block.c                   | 149 +++++++---------------------------------------
 block/blkdebug.c          |  44 ++++----------
 block/blkverify.c         |  17 +-----
 block/nbd.c               |  25 +-------
 block/nfs.c               |  41 +------------
 block/null.c              |  23 ++++---
 block/quorum.c            |  34 -----------
 8 files changed, 52 insertions(+), 283 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 77f4121358..eba463b99b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -129,7 +129,7 @@ struct BlockDriver {
     int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
-    void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
+    void (*bdrv_refresh_filename)(BlockDriverState *bs);
     void (*bdrv_gather_child_options)(BlockDriverState *bs, QDict *target);
     char *(*bdrv_dirname)(BlockDriverState *bs, Error **errp);
 
diff --git a/block.c b/block.c
index a87eb631bc..be811457ed 100644
--- a/block.c
+++ b/block.c
@@ -4021,47 +4021,6 @@ static bool append_significant_runtime_options(QDict *d, BlockDriverState *bs)
     return found_any;
 }
 
-static bool append_open_options(QDict *d, BlockDriverState *bs)
-{
-    const QDictEntry *entry;
-    QemuOptDesc *desc;
-    BdrvChild *child;
-    bool found_any = false;
-    const char *p;
-
-    for (entry = qdict_first(bs->options); entry;
-         entry = qdict_next(bs->options, entry))
-    {
-        /* Exclude options for children */
-        QLIST_FOREACH(child, &bs->children, next) {
-            if (strstart(qdict_entry_key(entry), child->name, &p)
-                && (!*p || *p == '.'))
-            {
-                break;
-            }
-        }
-        if (child) {
-            continue;
-        }
-
-        /* And exclude all non-driver-specific options */
-        for (desc = bdrv_runtime_opts.desc; desc->name; desc++) {
-            if (!strcmp(qdict_entry_key(entry), desc->name)) {
-                break;
-            }
-        }
-        if (desc->name) {
-            continue;
-        }
-
-        qobject_incref(qdict_entry_value(entry));
-        qdict_put_obj(d, qdict_entry_key(entry), qdict_entry_value(entry));
-        found_any = true;
-    }
-
-    return found_any;
-}
-
 /* Updates the following BDS fields:
  *  - exact_filename: A filename which may be used for opening a block device
  *                    which (mostly) equals the given BDS (even without any
@@ -4079,6 +4038,8 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     BlockDriver *drv = bs->drv;
     BdrvChild *child;
     QDict *opts;
+    bool generate_json_filename; /* Whether our default implementation should
+                                    fill exact_filename (false) or not (true) */
 
     if (!drv) {
         return;
@@ -4094,94 +4055,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         }
     }
 
-    if (drv->bdrv_refresh_filename) {
-        /* Obsolete information is of no use here, so drop the old file name
-         * information before refreshing it */
-        bs->exact_filename[0] = '\0';
-        if (bs->full_open_options) {
-            QDECREF(bs->full_open_options);
-            bs->full_open_options = NULL;
-        }
-
-        opts = qdict_new();
-        append_open_options(opts, bs);
-        drv->bdrv_refresh_filename(bs, opts);
-        QDECREF(opts);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file */
-        bool has_open_options;
-
-        bs->exact_filename[0] = '\0';
-        if (bs->full_open_options) {
-            QDECREF(bs->full_open_options);
-            bs->full_open_options = NULL;
-        }
-
-        opts = qdict_new();
-        has_open_options = append_open_options(opts, bs);
-        has_open_options |= bs->backing_overridden;
-
-        /* If no specific options have been given for this BDS, the filename of
-         * the underlying file should suffice for this one as well */
-        if (bs->file->bs->exact_filename[0] && !has_open_options) {
-            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
-        }
-        /* Reconstructing the full options QDict is simple for most format block
-         * drivers, as long as the full options are known for the underlying
-         * file BDS. The full options QDict of that file BDS should somehow
-         * contain a representation of the filename, therefore the following
-         * suffices without querying the (exact_)filename of this BDS. */
-        if (bs->file->bs->full_open_options &&
-            (!bs->backing || bs->backing->bs->full_open_options))
-        {
-            qdict_put_obj(opts, "driver",
-                          QOBJECT(qstring_from_str(drv->format_name)));
-            QINCREF(bs->file->bs->full_open_options);
-            qdict_put_obj(opts, "file",
-                          QOBJECT(bs->file->bs->full_open_options));
-
-            if (bs->backing) {
-                QINCREF(bs->backing->bs->full_open_options);
-                qdict_put(opts, "backing", bs->backing->bs->full_open_options);
-            } else if (bs->backing_overridden && !bs->backing) {
-                qdict_put(opts, "backing", qstring_new());
-            }
-
-            bs->full_open_options = opts;
-        } else {
-            QDECREF(opts);
-        }
-    } else if (!bs->full_open_options && qdict_size(bs->options)) {
-        /* There is no underlying file BDS (at least referenced by BDS.file),
-         * so the full options QDict should be equal to the options given
-         * specifically for this block device when it was opened (plus the
-         * driver specification).
-         * Because those options don't change, there is no need to update
-         * full_open_options when it's already set. */
-
-        opts = qdict_new();
-        append_open_options(opts, bs);
-        qdict_put_obj(opts, "driver",
-                      QOBJECT(qstring_from_str(drv->format_name)));
-
-        if (bs->exact_filename[0]) {
-            /* This may not work for all block protocol drivers (some may
-             * require this filename to be parsed), but we have to find some
-             * default solution here, so just include it. If some block driver
-             * does not support pure options without any filename at all or
-             * needs some special format of the options QDict, it needs to
-             * implement the driver-specific bdrv_refresh_filename() function.
-             */
-            qdict_put_obj(opts, "filename",
-                          QOBJECT(qstring_from_str(bs->exact_filename)));
-        }
-
-        bs->full_open_options = opts;
-    }
-
     /* Gather the options QDict */
     opts = qdict_new();
-    append_significant_runtime_options(opts, bs);
+    generate_json_filename = append_significant_runtime_options(opts, bs);
+    generate_json_filename |= bs->backing_overridden;
 
     if (drv->bdrv_gather_child_options) {
         /* Some block drivers may not want to present all of their children's
@@ -4207,6 +4084,24 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     QDECREF(bs->full_open_options);
     bs->full_open_options = opts;
 
+    if (drv->bdrv_refresh_filename) {
+        /* Obsolete information is of no use here, so drop the old file name
+         * information before refreshing it */
+        bs->exact_filename[0] = '\0';
+
+        drv->bdrv_refresh_filename(bs);
+    } else if (bs->file) {
+        /* Try to reconstruct valid information from the underlying file */
+
+        bs->exact_filename[0] = '\0';
+
+        /* If no specific options have been given for this BDS, the filename of
+         * the underlying file should suffice for this one as well */
+        if (bs->file->bs->exact_filename[0] && !generate_json_filename) {
+            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
+        }
+    }
+
     if (bs->exact_filename[0]) {
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
     } else {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 1551b2099a..6b33f316f9 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -673,48 +673,28 @@ static int blkdebug_truncate(BlockDriverState *bs, int64_t offset)
     return bdrv_truncate(bs->file->bs, offset);
 }
 
-static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
+static void blkdebug_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
-    QDict *opts;
     const QDictEntry *e;
-    bool force_json = false;
 
-    for (e = qdict_first(options); e; e = qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "config") &&
-            strcmp(qdict_entry_key(e), "x-image"))
-        {
-            force_json = true;
-            break;
-        }
-    }
-
-    if (force_json && !bs->file->bs->full_open_options) {
-        /* The config file cannot be recreated, so creating a plain filename
-         * is impossible */
+    if (!bs->file->bs->exact_filename[0]) {
         return;
     }
 
-    if (!force_json && bs->file->bs->exact_filename[0]) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "blkdebug:%s:%s", s->config_file ?: "",
-                 bs->file->bs->exact_filename);
-    }
-
-    opts = qdict_new();
-    qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("blkdebug")));
-
-    QINCREF(bs->file->bs->full_open_options);
-    qdict_put_obj(opts, "image", QOBJECT(bs->file->bs->full_open_options));
-
-    for (e = qdict_first(options); e; e = qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "x-image")) {
-            qobject_incref(qdict_entry_value(e));
-            qdict_put_obj(opts, qdict_entry_key(e), qdict_entry_value(e));
+    for (e = qdict_first(bs->full_open_options); e;
+         e = qdict_next(bs->full_open_options, e))
+    {
+        if (strcmp(qdict_entry_key(e), "config") &&
+            strcmp(qdict_entry_key(e), "image") &&
+            strcmp(qdict_entry_key(e), "driver"))
+        {
+            return;
         }
     }
 
-    bs->full_open_options = opts;
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "blkdebug:%s:%s",
+             s->config_file ?: "", bs->file->bs->exact_filename);
 }
 
 static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
diff --git a/block/blkverify.c b/block/blkverify.c
index c72a1fba64..9c58758740 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -280,25 +280,10 @@ static bool blkverify_recurse_is_first_non_filter(BlockDriverState *bs,
     return bdrv_recurse_is_first_non_filter(s->test_file->bs, candidate);
 }
 
-static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
+static void blkverify_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
-    if (bs->file->bs->full_open_options
-        && s->test_file->bs->full_open_options)
-    {
-        QDict *opts = qdict_new();
-        qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("blkverify")));
-
-        QINCREF(bs->file->bs->full_open_options);
-        qdict_put_obj(opts, "raw", QOBJECT(bs->file->bs->full_open_options));
-        QINCREF(s->test_file->bs->full_open_options);
-        qdict_put_obj(opts, "test",
-                      QOBJECT(s->test_file->bs->full_open_options));
-
-        bs->full_open_options = opts;
-    }
-
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
diff --git a/block/nbd.c b/block/nbd.c
index 130798903f..ea5d7a819e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -499,12 +499,9 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
     nbd_client_attach_aio_context(bs, new_context);
 }
 
-static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
+static void nbd_refresh_filename(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
-    QDict *opts = qdict_new();
-    QObject *saddr_qdict;
-    Visitor *ov;
     const char *host = NULL, *port = NULL, *path = NULL;
 
     if (s->saddr->type == SOCKET_ADDRESS_KIND_INET) {
@@ -517,8 +514,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
         path = s->saddr->u.q_unix.data->path;
     }
 
-    qdict_put(opts, "driver", qstring_from_str("nbd"));
-
     if (path && s->export) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd+unix:///%s?socket=%s", s->export, path);
@@ -532,24 +527,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd://%s:%s", host, port);
     }
-
-    ov = qobject_output_visitor_new(&saddr_qdict);
-    visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
-    visit_complete(ov, &saddr_qdict);
-    visit_free(ov);
-    assert(qobject_type(saddr_qdict) == QTYPE_QDICT);
-
-    qdict_put_obj(opts, "server", saddr_qdict);
-
-    if (s->export) {
-        qdict_put(opts, "export", qstring_from_str(s->export));
-    }
-    if (s->tlscredsid) {
-        qdict_put(opts, "tls-creds", qstring_from_str(s->tlscredsid));
-    }
-
-    qdict_flatten(opts);
-    bs->full_open_options = opts;
 }
 
 static char *nbd_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/nfs.c b/block/nfs.c
index d4ca2757a1..6e68c27437 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -768,14 +768,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
     return 0;
 }
 
-static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
+static void nfs_refresh_filename(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
-    QDict *opts = qdict_new();
-    QObject *server_qdict;
-    Visitor *ov;
-
-    qdict_put(opts, "driver", qstring_from_str("nfs"));
 
     if (client->uid && !client->gid) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
@@ -793,40 +788,6 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nfs://%s%s", client->server->host, client->path);
     }
-
-    ov = qobject_output_visitor_new(&server_qdict);
-    visit_type_NFSServer(ov, NULL, &client->server, &error_abort);
-    visit_complete(ov, &server_qdict);
-    assert(qobject_type(server_qdict) == QTYPE_QDICT);
-
-    qdict_put_obj(opts, "server", server_qdict);
-    qdict_put(opts, "path", qstring_from_str(client->path));
-
-    if (client->uid) {
-        qdict_put(opts, "uid", qint_from_int(client->uid));
-    }
-    if (client->gid) {
-        qdict_put(opts, "gid", qint_from_int(client->gid));
-    }
-    if (client->tcp_syncnt) {
-        qdict_put(opts, "tcp-syncnt",
-                      qint_from_int(client->tcp_syncnt));
-    }
-    if (client->readahead) {
-        qdict_put(opts, "readahead",
-                      qint_from_int(client->readahead));
-    }
-    if (client->pagecache) {
-        qdict_put(opts, "pagecache",
-                      qint_from_int(client->pagecache));
-    }
-    if (client->debug) {
-        qdict_put(opts, "debug", qint_from_int(client->debug));
-    }
-
-    visit_free(ov);
-    qdict_flatten(opts);
-    bs->full_open_options = opts;
 }
 
 static char *nfs_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/null.c b/block/null.c
index 16ef8b2a09..fb03fb95c0 100644
--- a/block/null.c
+++ b/block/null.c
@@ -222,18 +222,23 @@ static int64_t coroutine_fn null_co_get_block_status(BlockDriverState *bs,
     }
 }
 
-static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void null_refresh_filename(BlockDriverState *bs)
 {
-    QINCREF(opts);
-    qdict_del(opts, "filename");
-
-    if (!qdict_size(opts)) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
-                 bs->drv->format_name);
+    const QDictEntry *e;
+
+    for (e = qdict_first(bs->full_open_options); e;
+         e = qdict_next(bs->full_open_options, e))
+    {
+        /* These options can be ignored */
+        if (strcmp(qdict_entry_key(e), "filename") &&
+            strcmp(qdict_entry_key(e), "driver"))
+        {
+            return;
+        }
     }
 
-    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
-    bs->full_open_options = opts;
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+             bs->drv->format_name);
 }
 
 static const char *const null_sgfnt_runtime_opts[] = {
diff --git a/block/quorum.c b/block/quorum.c
index 0a77ed44fd..422185b845 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1072,39 +1072,6 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
     bdrv_drained_end(bs);
 }
 
-static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
-{
-    BDRVQuorumState *s = bs->opaque;
-    QDict *opts;
-    QList *children;
-    int i;
-
-    for (i = 0; i < s->num_children; i++) {
-        if (!s->children[i]->bs->full_open_options) {
-            return;
-        }
-    }
-
-    children = qlist_new();
-    for (i = 0; i < s->num_children; i++) {
-        QINCREF(s->children[i]->bs->full_open_options);
-        qlist_append_obj(children,
-                         QOBJECT(s->children[i]->bs->full_open_options));
-    }
-
-    opts = qdict_new();
-    qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("quorum")));
-    qdict_put_obj(opts, QUORUM_OPT_VOTE_THRESHOLD,
-                  QOBJECT(qint_from_int(s->threshold)));
-    qdict_put_obj(opts, QUORUM_OPT_BLKVERIFY,
-                  QOBJECT(qbool_from_bool(s->is_blkverify)));
-    qdict_put_obj(opts, QUORUM_OPT_REWRITE,
-                  QOBJECT(qbool_from_bool(s->rewrite_corrupted)));
-    qdict_put_obj(opts, "children", QOBJECT(children));
-
-    bs->full_open_options = opts;
-}
-
 static void quorum_gather_child_options(BlockDriverState *bs, QDict *target)
 {
     BDRVQuorumState *s = bs->opaque;
@@ -1152,7 +1119,6 @@ static BlockDriver bdrv_quorum = {
 
     .bdrv_file_open                     = quorum_open,
     .bdrv_close                         = quorum_close,
-    .bdrv_refresh_filename              = quorum_refresh_filename,
     .bdrv_gather_child_options          = quorum_gather_child_options,
     .bdrv_dirname                       = quorum_dirname,
 
-- 
2.11.0
