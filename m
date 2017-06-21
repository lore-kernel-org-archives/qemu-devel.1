Received: from eggs.gnu.org ([2001:4830:134:3::10]:34545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf7D-0008WM-LV
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf7B-0005YS-Ak
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:52:11 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:43 +0200
Message-Id: <20170621125047.30294-22-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 21/25] block: Purify .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

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
BlockDriver.bdrv_refresh_filename(); also, add a comment on this
function's purpose in block/block_int.h while touching its interface.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |   6 +-
 block.c                   | 145 +++++++---------------------------------------
 block/blkdebug.c          |  52 ++++++-----------
 block/blkverify.c         |  16 +----
 block/commit.c            |   2 +-
 block/mirror.c            |   2 +-
 block/nbd.c               |  23 +-------
 block/nfs.c               |  36 +-----------
 block/null.c              |  23 +++++---
 block/quorum.c            |  30 ----------
 10 files changed, 63 insertions(+), 272 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ec37ab3..5283509 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -129,7 +129,11 @@ struct BlockDriver {
     int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
-    void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
+    /*
+     * Refreshes the bs->exact_filename field. If that is impossible,
+     * bs->exact_filename has to be left empty.
+     */
+    void (*bdrv_refresh_filename)(BlockDriverState *bs);
 
     /*
      * Gathers the open options for all children into @target. A simple format
diff --git a/block.c b/block.c
index af5d1ef..e22771b 100644
--- a/block.c
+++ b/block.c
@@ -4859,47 +4859,6 @@ static bool append_significant_runtime_options(QDict *d, BlockDriverState *bs)
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
@@ -4917,6 +4876,8 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     BlockDriver *drv = bs->drv;
     BdrvChild *child;
     QDict *opts;
+    bool generate_json_filename; /* Whether our default implementation should
+                                    fill exact_filename (false) or not (true) */
 
     if (!drv) {
         return;
@@ -4932,90 +4893,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
-            qdict_put_str(opts, "driver", drv->format_name);
-            QINCREF(bs->file->bs->full_open_options);
-            qdict_put(opts, "file", bs->file->bs->full_open_options);
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
-        qdict_put_str(opts, "driver", drv->format_name);
-
-        if (bs->exact_filename[0]) {
-            /* This may not work for all block protocol drivers (some may
-             * require this filename to be parsed), but we have to find some
-             * default solution here, so just include it. If some block driver
-             * does not support pure options without any filename at all or
-             * needs some special format of the options QDict, it needs to
-             * implement the driver-specific bdrv_refresh_filename() function.
-             */
-            qdict_put_str(opts, "filename", bs->exact_filename);
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
@@ -5041,6 +4922,24 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
index 06c7924..14b21d3 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -817,52 +817,34 @@ static int blkdebug_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     return bdrv_truncate(bs->file, offset, errp);
 }
 
-static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
+static void blkdebug_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
-    QDict *opts;
     const QDictEntry *e;
-    bool force_json = false;
-
-    for (e = qdict_first(options); e; e = qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "config") &&
-            strcmp(qdict_entry_key(e), "x-image"))
-        {
-            force_json = true;
-            break;
-        }
-    }
+    int ret;
 
-    if (force_json && !bs->file->bs->full_open_options) {
-        /* The config file cannot be recreated, so creating a plain filename
-         * is impossible */
+    if (!bs->file->bs->exact_filename[0]) {
         return;
     }
 
-    if (!force_json && bs->file->bs->exact_filename[0]) {
-        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                           "blkdebug:%s:%s", s->config_file ?: "",
-                           bs->file->bs->exact_filename);
-        if (ret >= sizeof(bs->exact_filename)) {
-            /* An overflow makes the filename unusable, so do not report any */
-            bs->exact_filename[0] = 0;
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
 
-    opts = qdict_new();
-    qdict_put_str(opts, "driver", "blkdebug");
-
-    QINCREF(bs->file->bs->full_open_options);
-    qdict_put(opts, "image", bs->file->bs->full_open_options);
-
-    for (e = qdict_first(options); e; e = qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "x-image")) {
-            qobject_incref(qdict_entry_value(e));
-            qdict_put_obj(opts, qdict_entry_key(e), qdict_entry_value(e));
-        }
+    ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                   "blkdebug:%s:%s",
+                   s->config_file ?: "", bs->file->bs->exact_filename);
+    if (ret >= sizeof(bs->exact_filename)) {
+        /* An overflow makes the filename unusable, so do not report any */
+        bs->exact_filename[0] = 0;
     }
-
-    bs->full_open_options = opts;
 }
 
 static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
diff --git a/block/blkverify.c b/block/blkverify.c
index d5233ee..7da2e08 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -277,24 +277,10 @@ static bool blkverify_recurse_is_first_non_filter(BlockDriverState *bs,
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
-        qdict_put_str(opts, "driver", "blkverify");
-
-        QINCREF(bs->file->bs->full_open_options);
-        qdict_put(opts, "raw", bs->file->bs->full_open_options);
-        QINCREF(s->test_file->bs->full_open_options);
-        qdict_put(opts, "test", s->test_file->bs->full_open_options);
-
-        bs->full_open_options = opts;
-    }
-
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
diff --git a/block/commit.c b/block/commit.c
index 7146e48..c621c06 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -257,7 +257,7 @@ static int64_t coroutine_fn bdrv_commit_top_get_block_status(
            (sector_num << BDRV_SECTOR_BITS);
 }
 
-static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
diff --git a/block/mirror.c b/block/mirror.c
index 6ac3956..4bde18f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1072,7 +1072,7 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
 }
 
-static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
diff --git a/block/nbd.c b/block/nbd.c
index 7c10ede..8312aac 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -507,12 +507,9 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
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
 
     if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
@@ -525,8 +522,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
         path = s->saddr->u.q_unix.path;
     } /* else can't represent as pseudo-filename */
 
-    qdict_put_str(opts, "driver", "nbd");
-
     if (path && s->export) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd+unix:///%s?socket=%s", s->export, path);
@@ -540,22 +535,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd://%s:%s", host, port);
     }
-
-    ov = qobject_output_visitor_new(&saddr_qdict);
-    visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
-    visit_complete(ov, &saddr_qdict);
-    visit_free(ov);
-    qdict_put_obj(opts, "server", saddr_qdict);
-
-    if (s->export) {
-        qdict_put_str(opts, "export", s->export);
-    }
-    if (s->tlscredsid) {
-        qdict_put_str(opts, "tls-creds", s->tlscredsid);
-    }
-
-    qdict_flatten(opts);
-    bs->full_open_options = opts;
 }
 
 static char *nbd_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/nfs.c b/block/nfs.c
index b7fa1a3..ad49fe2 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -806,14 +806,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
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
-    qdict_put_str(opts, "driver", "nfs");
 
     if (client->uid && !client->gid) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
@@ -831,35 +826,6 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nfs://%s%s", client->server->host, client->path);
     }
-
-    ov = qobject_output_visitor_new(&server_qdict);
-    visit_type_NFSServer(ov, NULL, &client->server, &error_abort);
-    visit_complete(ov, &server_qdict);
-    qdict_put_obj(opts, "server", server_qdict);
-    qdict_put_str(opts, "path", client->path);
-
-    if (client->uid) {
-        qdict_put_int(opts, "user", client->uid);
-    }
-    if (client->gid) {
-        qdict_put_int(opts, "group", client->gid);
-    }
-    if (client->tcp_syncnt) {
-        qdict_put_int(opts, "tcp-syn-cnt", client->tcp_syncnt);
-    }
-    if (client->readahead) {
-        qdict_put_int(opts, "readahead-size", client->readahead);
-    }
-    if (client->pagecache) {
-        qdict_put_int(opts, "page-cache-size", client->pagecache);
-    }
-    if (client->debug) {
-        qdict_put_int(opts, "debug", client->debug);
-    }
-
-    visit_free(ov);
-    qdict_flatten(opts);
-    bs->full_open_options = opts;
 }
 
 static char *nfs_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/null.c b/block/null.c
index 7d99552..fb03fb9 100644
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
 
-    qdict_put_str(opts, "driver", bs->drv->format_name);
-    bs->full_open_options = opts;
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+             bs->drv->format_name);
 }
 
 static const char *const null_sgfnt_runtime_opts[] = {
diff --git a/block/quorum.c b/block/quorum.c
index a2d6c32..430d89d 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1079,35 +1079,6 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
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
-        qlist_append(children, s->children[i]->bs->full_open_options);
-    }
-
-    opts = qdict_new();
-    qdict_put_str(opts, "driver", "quorum");
-    qdict_put_int(opts, QUORUM_OPT_VOTE_THRESHOLD, s->threshold);
-    qdict_put_bool(opts, QUORUM_OPT_BLKVERIFY, s->is_blkverify);
-    qdict_put_bool(opts, QUORUM_OPT_REWRITE, s->rewrite_corrupted);
-    qdict_put(opts, "children", children);
-
-    bs->full_open_options = opts;
-}
-
 static void quorum_gather_child_options(BlockDriverState *bs, QDict *target)
 {
     BDRVQuorumState *s = bs->opaque;
@@ -1155,7 +1126,6 @@ static BlockDriver bdrv_quorum = {
 
     .bdrv_file_open                     = quorum_open,
     .bdrv_close                         = quorum_close,
-    .bdrv_refresh_filename              = quorum_refresh_filename,
     .bdrv_gather_child_options          = quorum_gather_child_options,
     .bdrv_dirname                       = quorum_dirname,
 
-- 
2.9.4
