Received: from eggs.gnu.org ([209.51.188.92]:47885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXi-0007QW-6s
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXc-0003Tm-P5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:32:01 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:28 +0100
Message-Id: <20190201192935.18394-25-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 24/31] block: Purify
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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
 include/block/block_int.h  |   6 +-
 block.c                    | 131 +++++++------------------------------
 block/blkdebug.c           |  54 ++++++---------
 block/blklogwrites.c       |  22 -------
 block/blkverify.c          |  16 +----
 block/commit.c             |   2 +-
 block/mirror.c             |   2 +-
 block/nbd.c                |  23 +------
 block/nfs.c                |  36 +---------
 block/null.c               |  22 ++++---
 block/nvme.c               |  22 ++++---
 block/quorum.c             |  30 ---------
 tests/qemu-iotests/228     |   4 --
 tests/qemu-iotests/228.out |   2 +-
 14 files changed, 81 insertions(+), 291 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8df23ab79c..620581d236 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -139,7 +139,11 @@ struct BlockDriver {
                                             Error **errp);
     int (*bdrv_make_empty)(BlockDriverState *bs);
=20
-    void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
+    /*
+     * Refreshes the bs->exact_filename field. If that is impossible,
+     * bs->exact_filename has to be left empty.
+     */
+    void (*bdrv_refresh_filename)(BlockDriverState *bs);
=20
     /*
      * Gathers the open options for all children into @target.
diff --git a/block.c b/block.c
index f7a0c78697..7ddf8e3685 100644
--- a/block.c
+++ b/block.c
@@ -5560,33 +5560,6 @@ static bool append_strong_runtime_options(QDict *d=
, BlockDriverState *bs)
     return found_any;
 }
=20
-static bool append_open_options(QDict *d, BlockDriverState *bs)
-{
-    const QDictEntry *entry;
-    QemuOptDesc *desc;
-    bool found_any =3D false;
-
-    for (entry =3D qdict_first(bs->options); entry;
-         entry =3D qdict_next(bs->options, entry))
-    {
-        /* Exclude all non-driver-specific options */
-        for (desc =3D bdrv_runtime_opts.desc; desc->name; desc++) {
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
-        found_any =3D true;
-    }
-
-    return found_any;
-}
-
 /* Note: This function may return false positives; it may return true
  * even if opening the backing file specified by bs's image header
  * would result in exactly bs->backing. */
@@ -5620,6 +5593,8 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     BdrvChild *child;
     QDict *opts;
     bool backing_overridden;
+    bool generate_json_filename; /* Whether our default implementation s=
hould
+                                    fill exact_filename (false) or not (=
true) */
=20
     if (!drv) {
         return;
@@ -5655,90 +5630,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         backing_overridden =3D false;
     }
=20
-    if (drv->bdrv_refresh_filename) {
-        /* Obsolete information is of no use here, so drop the old file =
name
-         * information before refreshing it */
-        bs->exact_filename[0] =3D '\0';
-        if (bs->full_open_options) {
-            qobject_unref(bs->full_open_options);
-            bs->full_open_options =3D NULL;
-        }
-
-        opts =3D qdict_new();
-        append_open_options(opts, bs);
-        drv->bdrv_refresh_filename(bs, opts);
-        qobject_unref(opts);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file=
 */
-        bool has_open_options;
-
-        bs->exact_filename[0] =3D '\0';
-        if (bs->full_open_options) {
-            qobject_unref(bs->full_open_options);
-            bs->full_open_options =3D NULL;
-        }
-
-        opts =3D qdict_new();
-        has_open_options =3D append_open_options(opts, bs);
-        has_open_options |=3D backing_overridden;
-
-        /* If no specific options have been given for this BDS, the file=
name of
-         * the underlying file should suffice for this one as well */
-        if (bs->file->bs->exact_filename[0] && !has_open_options) {
-            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
-        }
-        /* Reconstructing the full options QDict is simple for most form=
at block
-         * drivers, as long as the full options are known for the underl=
ying
-         * file BDS. The full options QDict of that file BDS should some=
how
-         * contain a representation of the filename, therefore the follo=
wing
-         * suffices without querying the (exact_)filename of this BDS. *=
/
-        if (bs->file->bs->full_open_options &&
-            (!bs->backing || bs->backing->bs->full_open_options))
-        {
-            qdict_put_str(opts, "driver", drv->format_name);
-            qdict_put(opts, "file",
-                      qobject_ref(bs->file->bs->full_open_options));
-
-            if (bs->backing) {
-                qdict_put(opts, "backing",
-                          qobject_ref(bs->backing->bs->full_open_options=
));
-            } else if (backing_overridden) {
-                qdict_put_null(opts, "backing");
-            }
-
-            bs->full_open_options =3D opts;
-        } else {
-            qobject_unref(opts);
-        }
-    } else if (!bs->full_open_options && qdict_size(bs->options)) {
-        /* There is no underlying file BDS (at least referenced by BDS.f=
ile),
-         * so the full options QDict should be equal to the options give=
n
-         * specifically for this block device when it was opened (plus t=
he
-         * driver specification).
-         * Because those options don't change, there is no need to updat=
e
-         * full_open_options when it's already set. */
-
-        opts =3D qdict_new();
-        append_open_options(opts, bs);
-        qdict_put_str(opts, "driver", drv->format_name);
-
-        if (bs->exact_filename[0]) {
-            /* This may not work for all block protocol drivers (some ma=
y
-             * require this filename to be parsed), but we have to find =
some
-             * default solution here, so just include it. If some block =
driver
-             * does not support pure options without any filename at all=
 or
-             * needs some special format of the options QDict, it needs =
to
-             * implement the driver-specific bdrv_refresh_filename() fun=
ction.
-             */
-            qdict_put_str(opts, "filename", bs->exact_filename);
-        }
-
-        bs->full_open_options =3D opts;
-    }
-
     /* Gather the options QDict */
     opts =3D qdict_new();
-    append_strong_runtime_options(opts, bs);
+    generate_json_filename =3D append_strong_runtime_options(opts, bs);
+    generate_json_filename |=3D backing_overridden;
=20
     if (drv->bdrv_gather_child_options) {
         /* Some block drivers may not want to present all of their child=
ren's
@@ -5764,6 +5659,24 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     qobject_unref(bs->full_open_options);
     bs->full_open_options =3D opts;
=20
+    if (drv->bdrv_refresh_filename) {
+        /* Obsolete information is of no use here, so drop the old file =
name
+         * information before refreshing it */
+        bs->exact_filename[0] =3D '\0';
+
+        drv->bdrv_refresh_filename(bs);
+    } else if (bs->file) {
+        /* Try to reconstruct valid information from the underlying file=
 */
+
+        bs->exact_filename[0] =3D '\0';
+
+        /* If no specific options have been given for this BDS, the file=
name of
+         * the underlying file should suffice for this one as well */
+        if (bs->file->bs->exact_filename[0] && !generate_json_filename) =
{
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
@@ -811,51 +811,37 @@ static int64_t blkdebug_getlength(BlockDriverState =
*bs)
     return bdrv_getlength(bs->file->bs);
 }
=20
-static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *optio=
ns)
+static void blkdebug_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s =3D bs->opaque;
-    QDict *opts;
     const QDictEntry *e;
-    bool force_json =3D false;
-
-    for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "config") &&
-            strcmp(qdict_entry_key(e), "x-image"))
-        {
-            force_json =3D true;
-            break;
-        }
-    }
+    int ret;
=20
-    if (force_json && !bs->file->bs->full_open_options) {
-        /* The config file cannot be recreated, so creating a plain file=
name
-         * is impossible */
+    if (!bs->file->bs->exact_filename[0]) {
         return;
     }
=20
-    if (!force_json && bs->file->bs->exact_filename[0]) {
-        int ret =3D snprintf(bs->exact_filename, sizeof(bs->exact_filena=
me),
-                           "blkdebug:%s:%s", s->config_file ?: "",
-                           bs->file->bs->exact_filename);
-        if (ret >=3D sizeof(bs->exact_filename)) {
-            /* An overflow makes the filename unusable, so do not report=
 any */
-            bs->exact_filename[0] =3D 0;
+    for (e =3D qdict_first(bs->full_open_options); e;
+         e =3D qdict_next(bs->full_open_options, e))
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
=20
-    opts =3D qdict_new();
-    qdict_put_str(opts, "driver", "blkdebug");
-
-    qdict_put(opts, "image", qobject_ref(bs->file->bs->full_open_options=
));
-
-    for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)) {
-        if (strcmp(qdict_entry_key(e), "x-image")) {
-            qdict_put_obj(opts, qdict_entry_key(e),
-                          qobject_ref(qdict_entry_value(e)));
-        }
+    ret =3D snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                   "blkdebug:%s:%s",
+                   s->config_file ?: "", bs->file->bs->exact_filename);
+    if (ret >=3D sizeof(bs->exact_filename)) {
+        /* An overflow makes the filename unusable, so do not report any=
 */
+        bs->exact_filename[0] =3D 0;
     }
-
-    bs->full_open_options =3D opts;
 }
=20
 static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 5da5df112d..eb2b4901a5 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -280,27 +280,6 @@ static int64_t blk_log_writes_getlength(BlockDriverS=
tate *bs)
     return bdrv_getlength(bs->file->bs);
 }
=20
-static void blk_log_writes_refresh_filename(BlockDriverState *bs,
-                                            QDict *options)
-{
-    BDRVBlkLogWritesState *s =3D bs->opaque;
-
-    if (bs->file->bs->full_open_options
-        && s->log_file->bs->full_open_options)
-    {
-        QDict *opts =3D qdict_new();
-        qdict_put_str(opts, "driver", "blklogwrites");
-
-        qobject_ref(bs->file->bs->full_open_options);
-        qdict_put(opts, "file", bs->file->bs->full_open_options);
-        qobject_ref(s->log_file->bs->full_open_options);
-        qdict_put(opts, "log", s->log_file->bs->full_open_options);
-        qdict_put_int(opts, "log-sector-size", s->sectorsize);
-
-        bs->full_open_options =3D opts;
-    }
-}
-
 static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c=
,
                                       const BdrvChildRole *role,
                                       BlockReopenQueue *ro_q,
@@ -531,7 +510,6 @@ static BlockDriver bdrv_blk_log_writes =3D {
     .bdrv_open              =3D blk_log_writes_open,
     .bdrv_close             =3D blk_log_writes_close,
     .bdrv_getlength         =3D blk_log_writes_getlength,
-    .bdrv_refresh_filename  =3D blk_log_writes_refresh_filename,
     .bdrv_child_perm        =3D blk_log_writes_child_perm,
     .bdrv_refresh_limits    =3D blk_log_writes_refresh_limits,
=20
diff --git a/block/blkverify.c b/block/blkverify.c
index 3c7d4c8729..3ff77ff49a 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -281,24 +281,10 @@ static bool blkverify_recurse_is_first_non_filter(B=
lockDriverState *bs,
     return bdrv_recurse_is_first_non_filter(s->test_file->bs, candidate)=
;
 }
=20
-static void blkverify_refresh_filename(BlockDriverState *bs, QDict *opti=
ons)
+static void blkverify_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s =3D bs->opaque;
=20
-    if (bs->file->bs->full_open_options
-        && s->test_file->bs->full_open_options)
-    {
-        QDict *opts =3D qdict_new();
-        qdict_put_str(opts, "driver", "blkverify");
-
-        qdict_put(opts, "raw",
-                  qobject_ref(bs->file->bs->full_open_options));
-        qdict_put(opts, "test",
-                  qobject_ref(s->test_file->bs->full_open_options));
-
-        bs->full_open_options =3D opts;
-    }
-
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
diff --git a/block/commit.c b/block/commit.c
index 093b1505de..2b876bf6e9 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -230,7 +230,7 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockD=
riverState *bs,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
=20
-static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict=
 *opts)
+static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
diff --git a/block/mirror.c b/block/mirror.c
index 031c1aeaeb..726d3c27fb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1431,7 +1431,7 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(Bl=
ockDriverState *bs,
                                     NULL, 0);
 }
=20
-static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict=
 *opts)
+static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 {
     if (bs->backing =3D=3D NULL) {
         /* we can be here after failed bdrv_attach_child in
diff --git a/block/nbd.c b/block/nbd.c
index 5b4e4cf1db..fcc9e897e5 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -513,12 +513,9 @@ static void nbd_attach_aio_context(BlockDriverState =
*bs,
     nbd_client_attach_aio_context(bs, new_context);
 }
=20
-static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
+static void nbd_refresh_filename(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D bs->opaque;
-    QDict *opts =3D qdict_new();
-    QObject *saddr_qdict;
-    Visitor *ov;
     const char *host =3D NULL, *port =3D NULL, *path =3D NULL;
=20
     if (s->saddr->type =3D=3D SOCKET_ADDRESS_TYPE_INET) {
@@ -531,8 +528,6 @@ static void nbd_refresh_filename(BlockDriverState *bs=
, QDict *options)
         path =3D s->saddr->u.q_unix.path;
     } /* else can't represent as pseudo-filename */
=20
-    qdict_put_str(opts, "driver", "nbd");
-
     if (path && s->export) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd+unix:///%s?socket=3D%s", s->export, path);
@@ -546,22 +541,6 @@ static void nbd_refresh_filename(BlockDriverState *b=
s, QDict *options)
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nbd://%s:%s", host, port);
     }
-
-    ov =3D qobject_output_visitor_new(&saddr_qdict);
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
-    bs->full_open_options =3D opts;
 }
=20
 static char *nbd_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/nfs.c b/block/nfs.c
index 6985a44b89..531903610b 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -799,14 +799,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state=
,
     return 0;
 }
=20
-static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
+static void nfs_refresh_filename(BlockDriverState *bs)
 {
     NFSClient *client =3D bs->opaque;
-    QDict *opts =3D qdict_new();
-    QObject *server_qdict;
-    Visitor *ov;
-
-    qdict_put_str(opts, "driver", "nfs");
=20
     if (client->uid && !client->gid) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
@@ -824,35 +819,6 @@ static void nfs_refresh_filename(BlockDriverState *b=
s, QDict *options)
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                  "nfs://%s%s", client->server->host, client->path);
     }
-
-    ov =3D qobject_output_visitor_new(&server_qdict);
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
-    bs->full_open_options =3D opts;
 }
=20
 static char *nfs_dirname(BlockDriverState *bs, Error **errp)
diff --git a/block/null.c b/block/null.c
index 858892f0c4..1c56a0ef01 100644
--- a/block/null.c
+++ b/block/null.c
@@ -239,17 +239,23 @@ static int coroutine_fn null_co_block_status(BlockD=
riverState *bs,
     return ret;
 }
=20
-static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void null_refresh_filename(BlockDriverState *bs)
 {
-    qdict_del(opts, "filename");
-
-    if (!qdict_size(opts)) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://"=
,
-                 bs->drv->format_name);
+    const QDictEntry *e;
+
+    for (e =3D qdict_first(bs->full_open_options); e;
+         e =3D qdict_next(bs->full_open_options, e))
+    {
+        /* These options can be ignored */
+        if (strcmp(qdict_entry_key(e), "filename") &&
+            strcmp(qdict_entry_key(e), "driver"))
+        {
+            return;
+        }
     }
=20
-    qdict_put_str(opts, "driver", bs->drv->format_name);
-    bs->full_open_options =3D qobject_ref(opts);
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+             bs->drv->format_name);
 }
=20
 static const char *const null_strong_runtime_opts[] =3D {
diff --git a/block/nvme.c b/block/nvme.c
index 2d5acfdccf..88c24399ab 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1053,17 +1053,23 @@ static int nvme_reopen_prepare(BDRVReopenState *r=
eopen_state,
     return 0;
 }
=20
-static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
+static void nvme_refresh_filename(BlockDriverState *bs)
 {
-    qdict_del(opts, "filename");
-
-    if (!qdict_size(opts)) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://"=
,
-                 bs->drv->format_name);
+    const QDictEntry *e;
+
+    for (e =3D qdict_first(bs->full_open_options); e;
+         e =3D qdict_next(bs->full_open_options, e))
+    {
+        /* These options can be ignored */
+        if (strcmp(qdict_entry_key(e), "filename") &&
+            strcmp(qdict_entry_key(e), "driver"))
+        {
+            return;
+        }
     }
=20
-    qdict_put_str(opts, "driver", bs->drv->format_name);
-    bs->full_open_options =3D qobject_ref(opts);
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+             bs->drv->format_name);
 }
=20
 static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
diff --git a/block/quorum.c b/block/quorum.c
index 3984f0aa4f..352f729136 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1065,35 +1065,6 @@ static void quorum_del_child(BlockDriverState *bs,=
 BdrvChild *child,
     bdrv_drained_end(bs);
 }
=20
-static void quorum_refresh_filename(BlockDriverState *bs, QDict *options=
)
-{
-    BDRVQuorumState *s =3D bs->opaque;
-    QDict *opts;
-    QList *children;
-    int i;
-
-    for (i =3D 0; i < s->num_children; i++) {
-        if (!s->children[i]->bs->full_open_options) {
-            return;
-        }
-    }
-
-    children =3D qlist_new();
-    for (i =3D 0; i < s->num_children; i++) {
-        qlist_append(children,
-                     qobject_ref(s->children[i]->bs->full_open_options))=
;
-    }
-
-    opts =3D qdict_new();
-    qdict_put_str(opts, "driver", "quorum");
-    qdict_put_int(opts, QUORUM_OPT_VOTE_THRESHOLD, s->threshold);
-    qdict_put_bool(opts, QUORUM_OPT_BLKVERIFY, s->is_blkverify);
-    qdict_put_bool(opts, QUORUM_OPT_REWRITE, s->rewrite_corrupted);
-    qdict_put(opts, "children", children);
-
-    bs->full_open_options =3D opts;
-}
-
 static void quorum_gather_child_options(BlockDriverState *bs, QDict *tar=
get,
                                         bool backing_overridden)
 {
@@ -1159,7 +1130,6 @@ static BlockDriver bdrv_quorum =3D {
=20
     .bdrv_open                          =3D quorum_open,
     .bdrv_close                         =3D quorum_close,
-    .bdrv_refresh_filename              =3D quorum_refresh_filename,
     .bdrv_gather_child_options          =3D quorum_gather_child_options,
     .bdrv_dirname                       =3D quorum_dirname,
=20
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 7a57c41e29..9a50afd205 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -230,10 +230,6 @@ with iotests.FilePath('base.img') as base_img_path, =
\
                overlay=3D'node0')
=20
     # This should give us the original plain result
-    # FIXME: Currently, it yields a json:{} filename even though it
-    #        only contains a @driver and a @file entry, so a plain
-    #        filename would obviously suffice.  This is fixed by a
-    #        future patch.
=20
     log_node_info(vm.node_info('node0'))
=20
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
index 393ab09164..4217df24fe 100644
--- a/tests/qemu-iotests/228.out
+++ b/tests/qemu-iotests/228.out
@@ -74,7 +74,7 @@ bs->backing: (none)
 {"execute": "blockdev-snapshot", "arguments": {"node": "original-backing=
", "overlay": "node0"}}
 {"return": {}}
=20
-bs->filename: json:{"driver": "IMGFMT", "file": {"driver": "file", "file=
name": "TEST_DIR/PID-top.img"}}
+bs->filename: TEST_DIR/PID-top.img
 bs->backing_file: TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
=20
--=20
2.20.1
