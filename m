Received: from eggs.gnu.org ([2001:4830:134:3::10]:43185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbg-00033z-86
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbb-00009Z-FK
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:32 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:21 +0200
Message-Id: <20180809213528.14738-25-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 24/31] block: Purify
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

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

This completely obsoletes blklogwrite's implementation of
.bdrv_refresh_filename().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |   6 +-
 block.c                   | 145 ++++++--------------------------------
 block/blkdebug.c          |  54 ++++++--------
 block/blklogwrites.c      |  23 ------
 block/blkverify.c         |  16 +----
 block/commit.c            |   2 +-
 block/mirror.c            |   2 +-
 block/nbd.c               |  23 +-----
 block/nfs.c               |  36 +---------
 block/null.c              |  22 +++---
 block/nvme.c              |  22 +++---
 block/quorum.c            |  30 --------
 12 files changed, 80 insertions(+), 301 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index adaaf2572c..90217512b5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -139,7 +139,11 @@ struct BlockDriver {
                                             Error **errp);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
-    void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
+    /*
+     * Refreshes the bs->exact_filename field. If that is impossible,
+     * bs->exact_filename has to be left empty.
+     */
+    void (*bdrv_refresh_filename)(BlockDriverState *bs);
 
     /*
      * Gathers the open options for all children into @target.
diff --git a/block.c b/block.c
index 0821efbb2c..2d3e07b7a7 100644
--- a/block.c
+++ b/block.c
@@ -5245,47 +5245,6 @@ static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs)
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
-        qdict_put_obj(d, qdict_entry_key(entry),
-                      qobject_ref(qdict_entry_value(entry)));
-        found_any = true;
-    }
-
-    return found_any;
-}
-
 /* Note: This function may return false positives; it may return true
  * even if opening the backing file specified by bs's image header
  * would result in exactly bs->backing. */
@@ -5319,6 +5278,8 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     BdrvChild *child;
     QDict *opts;
     bool backing_overridden;
+    bool generate_json_filename; /* Whether our default implementation should
+                                    fill exact_filename (false) or not (true) */
 
     if (!drv) {
         return;
@@ -5354,90 +5315,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         backing_overridden = false;
     }
 
-    if (drv->bdrv_refresh_filename) {
-        /* Obsolete information is of no use here, so drop the old file name
-         * information before refreshing it */
-        bs->exact_filename[0] = '\0';
-        if (bs->full_open_options) {
-            qobject_unref(bs->full_open_options);
-            bs->full_open_options = NULL;
-        }
-
-        opts = qdict_new();
-        append_open_options(opts, bs);
-        drv->bdrv_refresh_filename(bs, opts);
-        qobject_unref(opts);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file */
-        bool has_open_options;
-
-        bs->exact_filename[0] = '\0';
-        if (bs->full_open_options) {
-            qobject_unref(bs->full_open_options);
-            bs->full_open_options = NULL;
-        }
-
-        opts = qdict_new();
-        has_open_options = append_open_options(opts, bs);
-        has_open_options |= backing_overridden;
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
-            qdict_put(opts, "file",
-                      qobject_ref(bs->file->bs->full_open_options));
-
-            if (bs->backing) {
-                qdict_put(opts, "backing",
-                          qobject_ref(bs->backing->bs->full_open_options));
-            } else if (backing_overridden) {
-                qdict_put_null(opts, "backing");
-            }
-
-            bs->full_open_options = opts;
-        } else {
-            qobject_unref(opts);
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
-    append_strong_runtime_options(opts, bs);
+    generate_json_filename = append_strong_runtime_options(opts, bs);
+    generate_json_filename |= backing_overridden;
 
     if (drv->bdrv_gather_child_options) {
         /* Some block drivers may not want to present all of their children's
@@ -5463,6 +5344,24 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     qobject_unref(bs->full_open_options);
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
index 71b4275b98..1ea835c2b9 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -811,51 +811,37 @@ static int64_t blkdebug_getlength(BlockDriverState *bs)
     return bdrv_getlength(bs->file->bs);
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
+        /* Real child options are under "image", but "x-image" may
+         * contain a filename */
+        if (strcmp(qdict_entry_key(e), "config") &&
+            strcmp(qdict_entry_key(e), "image") &&
+            strcmp(qdict_entry_key(e), "x-image") &&
+            strcmp(qdict_entry_key(e), "driver"))
+        {
+            return;
         }
     }
 
-    opts = qdict_new();
-    qdict_put_str(opts, "driver", "blkdebug");
-
-    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_options));
-
-    for (e = qdict_first(options); e; e = qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "x-image")) {
-            qdict_put_obj(opts, qdict_entry_key(e),
-                          qobject_ref(qdict_entry_value(e)));
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
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 1c8e200326..eb2b4901a5 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -280,28 +280,6 @@ static int64_t blk_log_writes_getlength(BlockDriverState *bs)
     return bdrv_getlength(bs->file->bs);
 }
 
-static void blk_log_writes_refresh_filename(BlockDriverState *bs,
-                                            QDict *options)
-{
-    BDRVBlkLogWritesState *s = bs->opaque;
-
-    if (bs->file->bs->full_open_options
-        && s->log_file->bs->full_open_options)
-    {
-        QDict *opts = qdict_new();
-        qdict_put_str(opts, "driver", "blklogwrites");
-
-        qobject_ref(bs->file->bs->full_open_options);
-        qdict_put_obj(opts, "file", QOBJECT(bs->file->bs->full_open_options));
-        qobject_ref(s->log_file->bs->full_open_options);
-        qdict_put_obj(opts, "log",
-                      QOBJECT(s->log_file->bs->full_open_options));
-        qdict_put_int(opts, "log-sector-size", s->sectorsize);
-
-        bs->full_open_options = opts;
-    }
-}
-
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
                                       const BdrvChildRole *role,
                                       BlockReopenQueue *ro_q,
@@ -532,7 +510,6 @@ static BlockDriver bdrv_blk_log_writes = {
     .bdrv_open              = blk_log_writes_open,
     .bdrv_close             = blk_log_writes_close,
     .bdrv_getlength         = blk_log_writes_getlength,
-    .bdrv_refresh_filename  = blk_log_writes_refresh_filename,
     .bdrv_child_perm        = blk_log_writes_child_perm,
     .bdrv_refresh_limits    = blk_log_writes_refresh_limits,
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 3c7d4c8729..3ff77ff49a 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -281,24 +281,10 @@ static bool blkverify_recurse_is_first_non_filter(BlockDriverState *bs,
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
-        qdict_put(opts, "raw",
-                  qobject_ref(bs->file->bs->full_open_options));
-        qdict_put(opts, "test",
-                  qobject_ref(s->test_file->bs->full_open_options));
-
-        bs->full_open_options = opts;
-    }
-
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
diff --git a/block/commit.c b/block/commit.c
index 26db55d800..14788b0708 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -232,7 +232,7 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
 
-static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
diff --git a/block/mirror.c b/block/mirror.c
index e473c434ad..b4287a1e2b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1414,7 +1414,7 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
                                     NULL, 0);
 }
 
-static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 {
     if (bs->backing == NULL) {
         /* we can be here after failed bdrv_attach_child in
diff --git a/block/nbd.c b/block/nbd.c
index 5b4e4cf1db..fcc9e897e5 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -513,12 +513,9 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
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
@@ -531,8 +528,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
         path = s->saddr->u.q_unix.path;
     } /* else can't represent as pseudo-filename */
 
-    qdict_put_str(opts, "driver", "nbd");
-
     if (path && s->export) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd+unix:///%s?socket=%s", s->export, path);
@@ -546,22 +541,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
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
index 6985a44b89..531903610b 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -799,14 +799,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
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
@@ -824,35 +819,6 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
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
index 07acb4f732..c681e7e20b 100644
--- a/block/null.c
+++ b/block/null.c
@@ -243,17 +243,23 @@ static int coroutine_fn null_co_block_status(BlockDriverState *bs,
     return ret;
 }
 
-static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void null_refresh_filename(BlockDriverState *bs)
 {
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
-    bs->full_open_options = qobject_ref(opts);
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+             bs->drv->format_name);
 }
 
 static const char *const null_strong_runtime_opts[] = {
diff --git a/block/nvme.c b/block/nvme.c
index b0548e4e37..9e893ab5fa 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1071,17 +1071,23 @@ static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
     return 0;
 }
 
-static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void nvme_refresh_filename(BlockDriverState *bs)
 {
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
-    bs->full_open_options = qobject_ref(opts);
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+             bs->drv->format_name);
 }
 
 static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
diff --git a/block/quorum.c b/block/quorum.c
index f464260044..9f60b60a56 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1072,35 +1072,6 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
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
-        qlist_append(children,
-                     qobject_ref(s->children[i]->bs->full_open_options));
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
 static void quorum_gather_child_options(BlockDriverState *bs, QDict *target,
                                         bool backing_overridden)
 {
@@ -1166,7 +1137,6 @@ static BlockDriver bdrv_quorum = {
 
     .bdrv_open                          = quorum_open,
     .bdrv_close                         = quorum_close,
-    .bdrv_refresh_filename              = quorum_refresh_filename,
     .bdrv_gather_child_options          = quorum_gather_child_options,
     .bdrv_dirname                       = quorum_dirname,
 
-- 
2.17.1
