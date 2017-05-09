Received: from eggs.gnu.org ([2001:4830:134:3::10]:44148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Ac-000865-3l
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AU-0007YF-RY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AU-0007Wc-AM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60143C059724
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:25 +0200
Message-Id: <1494317205-2211-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 08/28] qobject: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We now have macros in place to make it less verbose to add a scalar
to QDict and QList, so use them.

Patch created mechanically via:
  spatch --sp-file scripts/coccinelle/qobject.cocci \
    --macro-file scripts/cocci-macro-file.h --dir . --in-place
then touched up manually to fix a couple of '?:' back to original
spacing, as well as avoiding a long line in monitor.c.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-7-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                             |  45 +++++-------
 block/blkdebug.c                    |   6 +-
 block/blkverify.c                   |   6 +-
 block/curl.c                        |   2 +-
 block/file-posix.c                  |   8 +--
 block/file-win32.c                  |   4 +-
 block/nbd.c                         |  41 ++++++-----
 block/nfs.c                         |  43 +++++-------
 block/null.c                        |   2 +-
 block/qcow2.c                       |   4 +-
 block/quorum.c                      |   8 +--
 block/rbd.c                         |  16 ++---
 block/snapshot.c                    |   2 +-
 block/ssh.c                         |  16 ++---
 block/vvfat.c                       |  10 +--
 block/vxhs.c                        |   6 +-
 blockdev.c                          |  30 ++++----
 hw/block/xen_disk.c                 |   2 +-
 hw/usb/xen-usb.c                    |  12 ++--
 monitor.c                           |  23 +++----
 qapi/qmp-event.c                    |   2 +-
 qemu-img.c                          |   6 +-
 qemu-io.c                           |   2 +-
 qemu-nbd.c                          |   2 +-
 qobject/qdict.c                     |   2 +-
 target/s390x/cpu_models.c           |   4 +-
 tests/check-qdict.c                 | 134 ++++++++++++++++++------------------
 tests/check-qlist.c                 |   4 +-
 tests/device-introspect-test.c      |   4 +-
 tests/test-qemu-opts.c              |   4 +-
 tests/test-qmp-commands.c           |  24 +++----
 tests/test-qmp-event.c              |  30 ++++----
 tests/test-qobject-output-visitor.c |   6 +-
 util/qemu-option.c                  |   2 +-
 34 files changed, 244 insertions(+), 268 deletions(-)

diff --git a/block.c b/block.c
index cb5856b..aae8f7e 100644
--- a/block.c
+++ b/block.c
@@ -974,16 +974,14 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
 static void update_options_from_flags(QDict *options, int flags)
 {
     if (!qdict_haskey(options, BDRV_OPT_CACHE_DIRECT)) {
-        qdict_put(options, BDRV_OPT_CACHE_DIRECT,
-                  qbool_from_bool(flags & BDRV_O_NOCACHE));
+        qdict_put_bool(options, BDRV_OPT_CACHE_DIRECT, flags & BDRV_O_NOCACHE);
     }
     if (!qdict_haskey(options, BDRV_OPT_CACHE_NO_FLUSH)) {
-        qdict_put(options, BDRV_OPT_CACHE_NO_FLUSH,
-                  qbool_from_bool(flags & BDRV_O_NO_FLUSH));
+        qdict_put_bool(options, BDRV_OPT_CACHE_NO_FLUSH,
+                       flags & BDRV_O_NO_FLUSH);
     }
     if (!qdict_haskey(options, BDRV_OPT_READ_ONLY)) {
-        qdict_put(options, BDRV_OPT_READ_ONLY,
-                  qbool_from_bool(!(flags & BDRV_O_RDWR)));
+        qdict_put_bool(options, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDWR));
     }
 }
 
@@ -1399,7 +1397,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     /* Fetch the file name from the options QDict if necessary */
     if (protocol && filename) {
         if (!qdict_haskey(*options, "filename")) {
-            qdict_put(*options, "filename", qstring_from_str(filename));
+            qdict_put_str(*options, "filename", filename);
             parse_filename = true;
         } else {
             error_setg(errp, "Can't specify 'file' and 'filename' options at "
@@ -1420,7 +1418,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
             }
 
             drvname = drv->format_name;
-            qdict_put(*options, "driver", qstring_from_str(drvname));
+            qdict_put_str(*options, "driver", drvname);
         } else {
             error_setg(errp, "Must specify either driver or file");
             return -EINVAL;
@@ -2075,7 +2073,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
 
     if (bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
-        qdict_put(options, "driver", qstring_from_str(bs->backing_format));
+        qdict_put_str(options, "driver", bs->backing_format);
     }
 
     backing_hd = bdrv_open_inherit(*backing_filename ? backing_filename : NULL,
@@ -2230,12 +2228,9 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     }
 
     /* Prepare options QDict for the temporary file */
-    qdict_put(snapshot_options, "file.driver",
-              qstring_from_str("file"));
-    qdict_put(snapshot_options, "file.filename",
-              qstring_from_str(tmp_filename));
-    qdict_put(snapshot_options, "driver",
-              qstring_from_str("qcow2"));
+    qdict_put_str(snapshot_options, "file.driver", "file");
+    qdict_put_str(snapshot_options, "file.filename", tmp_filename);
+    qdict_put_str(snapshot_options, "driver", "qcow2");
 
     bs_snapshot = bdrv_open(NULL, NULL, snapshot_options, flags, errp);
     snapshot_options = NULL;
@@ -2410,8 +2405,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                 goto fail;
             }
 
-            qdict_put(options, "file",
-                      qstring_from_str(bdrv_get_node_name(file_bs)));
+            qdict_put_str(options, "file", bdrv_get_node_name(file_bs));
         }
     }
 
@@ -2433,8 +2427,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
          * sure to update both bs->options (which has the full effective
          * options for bs) and options (which has file.* already removed).
          */
-        qdict_put(bs->options, "driver", qstring_from_str(drv->format_name));
-        qdict_put(options, "driver", qstring_from_str(drv->format_name));
+        qdict_put_str(bs->options, "driver", drv->format_name);
+        qdict_put_str(options, "driver", drv->format_name);
     } else if (!drv) {
         error_setg(errp, "Must specify either driver or file");
         goto fail;
@@ -2810,12 +2804,12 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * that they are checked at the end of this function. */
     value = qemu_opt_get(opts, "node-name");
     if (value) {
-        qdict_put(reopen_state->options, "node-name", qstring_from_str(value));
+        qdict_put_str(reopen_state->options, "node-name", value);
     }
 
     value = qemu_opt_get(opts, "driver");
     if (value) {
-        qdict_put(reopen_state->options, "driver", qstring_from_str(value));
+        qdict_put_str(reopen_state->options, "driver", value);
     }
 
     /* If we are to stay read-only, do not allow permission change
@@ -4306,8 +4300,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
 
             if (backing_fmt) {
                 backing_options = qdict_new();
-                qdict_put(backing_options, "driver",
-                          qstring_from_str(backing_fmt));
+                qdict_put_str(backing_options, "driver", backing_fmt);
             }
 
             bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
@@ -4712,7 +4705,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          * contain a representation of the filename, therefore the following
          * suffices without querying the (exact_)filename of this BDS. */
         if (bs->file->bs->full_open_options) {
-            qdict_put(opts, "driver", qstring_from_str(drv->format_name));
+            qdict_put_str(opts, "driver", drv->format_name);
             QINCREF(bs->file->bs->full_open_options);
             qdict_put(opts, "file", bs->file->bs->full_open_options);
 
@@ -4730,7 +4723,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 
         opts = qdict_new();
         append_open_options(opts, bs);
-        qdict_put(opts, "driver", qstring_from_str(drv->format_name));
+        qdict_put_str(opts, "driver", drv->format_name);
 
         if (bs->exact_filename[0]) {
             /* This may not work for all block protocol drivers (some may
@@ -4740,7 +4733,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
              * needs some special format of the options QDict, it needs to
              * implement the driver-specific bdrv_refresh_filename() function.
              */
-            qdict_put(opts, "filename", qstring_from_str(bs->exact_filename));
+            qdict_put_str(opts, "filename", bs->exact_filename);
         }
 
         bs->full_open_options = opts;
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 16322d8..3c08893 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -301,7 +301,7 @@ static void blkdebug_parse_filename(const char *filename, QDict *options,
     if (!strstart(filename, "blkdebug:", &filename)) {
         /* There was no prefix; therefore, all options have to be already
            present in the QDict (except for the filename) */
-        qdict_put(options, "x-image", qstring_from_str(filename));
+        qdict_put_str(options, "x-image", filename);
         return;
     }
 
@@ -320,7 +320,7 @@ static void blkdebug_parse_filename(const char *filename, QDict *options,
 
     /* TODO Allow multi-level nesting and set file.filename here */
     filename = c + 1;
-    qdict_put(options, "x-image", qstring_from_str(filename));
+    qdict_put_str(options, "x-image", filename);
 }
 
 static QemuOptsList runtime_opts = {
@@ -693,7 +693,7 @@ static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     opts = qdict_new();
-    qdict_put(opts, "driver", qstring_from_str("blkdebug"));
+    qdict_put_str(opts, "driver", "blkdebug");
 
     QINCREF(bs->file->bs->full_open_options);
     qdict_put(opts, "image", bs->file->bs->full_open_options);
diff --git a/block/blkverify.c b/block/blkverify.c
index cc29cd2..6b0a603 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -67,7 +67,7 @@ static void blkverify_parse_filename(const char *filename, QDict *options,
     if (!strstart(filename, "blkverify:", &filename)) {
         /* There was no prefix; therefore, all options have to be already
            present in the QDict (except for the filename) */
-        qdict_put(options, "x-image", qstring_from_str(filename));
+        qdict_put_str(options, "x-image", filename);
         return;
     }
 
@@ -84,7 +84,7 @@ static void blkverify_parse_filename(const char *filename, QDict *options,
 
     /* TODO Allow multi-level nesting and set file.filename here */
     filename = c + 1;
-    qdict_put(options, "x-image", qstring_from_str(filename));
+    qdict_put_str(options, "x-image", filename);
 }
 
 static QemuOptsList runtime_opts = {
@@ -288,7 +288,7 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
         && s->test_file->bs->full_open_options)
     {
         QDict *opts = qdict_new();
-        qdict_put(opts, "driver", qstring_from_str("blkverify"));
+        qdict_put_str(opts, "driver", "blkverify");
 
         QINCREF(bs->file->bs->full_open_options);
         qdict_put(opts, "raw", bs->file->bs->full_open_options);
diff --git a/block/curl.c b/block/curl.c
index 2708d57..aa6e8cc 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -548,7 +548,7 @@ static void curl_clean_state(CURLState *s)
 static void curl_parse_filename(const char *filename, QDict *options,
                                 Error **errp)
 {
-    qdict_put(options, CURL_BLOCK_OPT_URL, qstring_from_str(filename));
+    qdict_put_str(options, CURL_BLOCK_OPT_URL, filename);
 }
 
 static void curl_detach_aio_context(BlockDriverState *bs)
diff --git a/block/file-posix.c b/block/file-posix.c
index fc4b052..19c48a0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -375,7 +375,7 @@ static void raw_parse_filename(const char *filename, QDict *options,
      * function call can be ignored. */
     strstart(filename, "file:", &filename);
 
-    qdict_put(options, "filename", qstring_from_str(filename));
+    qdict_put_str(options, "filename", filename);
 }
 
 static QemuOptsList raw_runtime_opts = {
@@ -2155,7 +2155,7 @@ static void hdev_parse_filename(const char *filename, QDict *options,
     /* The prefix is optional, just as for "file". */
     strstart(filename, "host_device:", &filename);
 
-    qdict_put(options, "filename", qstring_from_str(filename));
+    qdict_put_str(options, "filename", filename);
 }
 
 static bool hdev_is_sg(BlockDriverState *bs)
@@ -2244,7 +2244,7 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
             goto hdev_open_Mac_error;
         }
 
-        qdict_put(options, "filename", qstring_from_str(bsd_path));
+        qdict_put_str(options, "filename", bsd_path);
 
 hdev_open_Mac_error:
         g_free(mediaType);
@@ -2454,7 +2454,7 @@ static void cdrom_parse_filename(const char *filename, QDict *options,
     /* The prefix is optional, just as for "file". */
     strstart(filename, "host_cdrom:", &filename);
 
-    qdict_put(options, "filename", qstring_from_str(filename));
+    qdict_put_str(options, "filename", filename);
 }
 #endif
 
diff --git a/block/file-win32.c b/block/file-win32.c
index c4a6be7..d1eb0a1 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -281,7 +281,7 @@ static void raw_parse_filename(const char *filename, QDict *options,
      * function call can be ignored. */
     strstart(filename, "file:", &filename);
 
-    qdict_put(options, "filename", qstring_from_str(filename));
+    qdict_put_str(options, "filename", filename);
 }
 
 static QemuOptsList raw_runtime_opts = {
@@ -668,7 +668,7 @@ static void hdev_parse_filename(const char *filename, QDict *options,
     /* The prefix is optional, just as for "file". */
     strstart(filename, "host_device:", &filename);
 
-    qdict_put(options, "filename", qstring_from_str(filename));
+    qdict_put_str(options, "filename", filename);
 }
 
 static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/block/nbd.c b/block/nbd.c
index 814ab26d..b3545f5 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -79,7 +79,7 @@ static int nbd_parse_uri(const char *filename, QDict *options)
     p = uri->path ? uri->path : "/";
     p += strspn(p, "/");
     if (p[0]) {
-        qdict_put(options, "export", qstring_from_str(p));
+        qdict_put_str(options, "export", p);
     }
 
     qp = query_params_parse(uri->query);
@@ -94,9 +94,8 @@ static int nbd_parse_uri(const char *filename, QDict *options)
             ret = -EINVAL;
             goto out;
         }
-        qdict_put(options, "server.type", qstring_from_str("unix"));
-        qdict_put(options, "server.path",
-                  qstring_from_str(qp->p[0].value));
+        qdict_put_str(options, "server.type", "unix");
+        qdict_put_str(options, "server.path", qp->p[0].value);
     } else {
         QString *host;
         char *port_str;
@@ -115,11 +114,11 @@ static int nbd_parse_uri(const char *filename, QDict *options)
             host = qstring_from_str(uri->server);
         }
 
-        qdict_put(options, "server.type", qstring_from_str("inet"));
+        qdict_put_str(options, "server.type", "inet");
         qdict_put(options, "server.host", host);
 
         port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
-        qdict_put(options, "server.port", qstring_from_str(port_str));
+        qdict_put_str(options, "server.port", port_str);
         g_free(port_str);
     }
 
@@ -181,7 +180,7 @@ static void nbd_parse_filename(const char *filename, QDict *options,
         export_name[0] = 0; /* truncate 'file' */
         export_name += strlen(EN_OPTSTR);
 
-        qdict_put(options, "export", qstring_from_str(export_name));
+        qdict_put_str(options, "export", export_name);
     }
 
     /* extract the host_spec - fail if it's not nbd:... */
@@ -196,8 +195,8 @@ static void nbd_parse_filename(const char *filename, QDict *options,
 
     /* are we a UNIX or TCP socket? */
     if (strstart(host_spec, "unix:", &unixpath)) {
-        qdict_put(options, "server.type", qstring_from_str("unix"));
-        qdict_put(options, "server.path", qstring_from_str(unixpath));
+        qdict_put_str(options, "server.type", "unix");
+        qdict_put_str(options, "server.path", unixpath);
     } else {
         InetSocketAddress *addr = NULL;
 
@@ -206,9 +205,9 @@ static void nbd_parse_filename(const char *filename, QDict *options,
             goto out;
         }
 
-        qdict_put(options, "server.type", qstring_from_str("inet"));
-        qdict_put(options, "server.host", qstring_from_str(addr->host));
-        qdict_put(options, "server.port", qstring_from_str(addr->port));
+        qdict_put_str(options, "server.type", "inet");
+        qdict_put_str(options, "server.host", addr->host);
+        qdict_put_str(options, "server.port", addr->port);
         qapi_free_InetSocketAddress(addr);
     }
 
@@ -247,13 +246,13 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
             return false;
         }
 
-        qdict_put(output_options, "server.type", qstring_from_str("unix"));
-        qdict_put(output_options, "server.path", qstring_from_str(path));
+        qdict_put_str(output_options, "server.type", "unix");
+        qdict_put_str(output_options, "server.path", path);
     } else if (host) {
-        qdict_put(output_options, "server.type", qstring_from_str("inet"));
-        qdict_put(output_options, "server.host", qstring_from_str(host));
-        qdict_put(output_options, "server.port",
-                  qstring_from_str(port ?: stringify(NBD_DEFAULT_PORT)));
+        qdict_put_str(output_options, "server.type", "inet");
+        qdict_put_str(output_options, "server.host", host);
+        qdict_put_str(output_options, "server.port",
+                      port ?: stringify(NBD_DEFAULT_PORT));
     }
 
     return true;
@@ -528,7 +527,7 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
         path = s->saddr->u.q_unix.path;
     } /* else can't represent as pseudo-filename */
 
-    qdict_put(opts, "driver", qstring_from_str("nbd"));
+    qdict_put_str(opts, "driver", "nbd");
 
     if (path && s->export) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
@@ -551,10 +550,10 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     qdict_put_obj(opts, "server", saddr_qdict);
 
     if (s->export) {
-        qdict_put(opts, "export", qstring_from_str(s->export));
+        qdict_put_str(opts, "export", s->export);
     }
     if (s->tlscredsid) {
-        qdict_put(opts, "tls-creds", qstring_from_str(s->tlscredsid));
+        qdict_put_str(opts, "tls-creds", s->tlscredsid);
     }
 
     qdict_flatten(opts);
diff --git a/block/nfs.c b/block/nfs.c
index 76572ae..848b2c0 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -104,9 +104,9 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
         goto out;
     }
 
-    qdict_put(options, "server.host", qstring_from_str(uri->server));
-    qdict_put(options, "server.type", qstring_from_str("inet"));
-    qdict_put(options, "path", qstring_from_str(uri->path));
+    qdict_put_str(options, "server.host", uri->server);
+    qdict_put_str(options, "server.type", "inet");
+    qdict_put_str(options, "path", uri->path);
 
     for (i = 0; i < qp->n; i++) {
         unsigned long long val;
@@ -121,23 +121,17 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
             goto out;
         }
         if (!strcmp(qp->p[i].name, "uid")) {
-            qdict_put(options, "user",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "user", qp->p[i].value);
         } else if (!strcmp(qp->p[i].name, "gid")) {
-            qdict_put(options, "group",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "group", qp->p[i].value);
         } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
-            qdict_put(options, "tcp-syn-count",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
         } else if (!strcmp(qp->p[i].name, "readahead")) {
-            qdict_put(options, "readahead-size",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "readahead-size", qp->p[i].value);
         } else if (!strcmp(qp->p[i].name, "pagecache")) {
-            qdict_put(options, "page-cache-size",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "page-cache-size", qp->p[i].value);
         } else if (!strcmp(qp->p[i].name, "debug")) {
-            qdict_put(options, "debug",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "debug", qp->p[i].value);
         } else {
             error_setg(errp, "Unknown NFS parameter name: %s",
                        qp->p[i].name);
@@ -819,7 +813,7 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     QObject *server_qdict;
     Visitor *ov;
 
-    qdict_put(opts, "driver", qstring_from_str("nfs"));
+    qdict_put_str(opts, "driver", "nfs");
 
     if (client->uid && !client->gid) {
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
@@ -842,28 +836,25 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     visit_type_NFSServer(ov, NULL, &client->server, &error_abort);
     visit_complete(ov, &server_qdict);
     qdict_put_obj(opts, "server", server_qdict);
-    qdict_put(opts, "path", qstring_from_str(client->path));
+    qdict_put_str(opts, "path", client->path);
 
     if (client->uid) {
-        qdict_put(opts, "user", qint_from_int(client->uid));
+        qdict_put_int(opts, "user", client->uid);
     }
     if (client->gid) {
-        qdict_put(opts, "group", qint_from_int(client->gid));
+        qdict_put_int(opts, "group", client->gid);
     }
     if (client->tcp_syncnt) {
-        qdict_put(opts, "tcp-syn-cnt",
-                  qint_from_int(client->tcp_syncnt));
+        qdict_put_int(opts, "tcp-syn-cnt", client->tcp_syncnt);
     }
     if (client->readahead) {
-        qdict_put(opts, "readahead-size",
-                  qint_from_int(client->readahead));
+        qdict_put_int(opts, "readahead-size", client->readahead);
     }
     if (client->pagecache) {
-        qdict_put(opts, "page-cache-size",
-                  qint_from_int(client->pagecache));
+        qdict_put_int(opts, "page-cache-size", client->pagecache);
     }
     if (client->debug) {
-        qdict_put(opts, "debug", qint_from_int(client->debug));
+        qdict_put_int(opts, "debug", client->debug);
     }
 
     visit_free(ov);
diff --git a/block/null.c b/block/null.c
index b300390..876f909 100644
--- a/block/null.c
+++ b/block/null.c
@@ -232,7 +232,7 @@ static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
                  bs->drv->format_name);
     }
 
-    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
+    qdict_put_str(opts, "driver", bs->drv->format_name);
     bs->full_open_options = opts;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 5c1573c..1c26977 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2265,7 +2265,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
      * table)
      */
     options = qdict_new();
-    qdict_put(options, "driver", qstring_from_str("qcow2"));
+    qdict_put_str(options, "driver", "qcow2");
     blk = blk_new_open(filename, NULL, options,
                        BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
                        &local_err);
@@ -2327,7 +2327,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
 
     /* Reopen the image without BDRV_O_NO_FLUSH to flush it before returning */
     options = qdict_new();
-    qdict_put(options, "driver", qstring_from_str("qcow2"));
+    qdict_put_str(options, "driver", "qcow2");
     blk = blk_new_open(filename, NULL, options,
                        BDRV_O_RDWR | BDRV_O_NO_BACKING, &local_err);
     if (blk == NULL) {
diff --git a/block/quorum.c b/block/quorum.c
index f7949e2..1b2a8c3 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1100,10 +1100,10 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     opts = qdict_new();
-    qdict_put(opts, "driver", qstring_from_str("quorum"));
-    qdict_put(opts, QUORUM_OPT_VOTE_THRESHOLD, qint_from_int(s->threshold));
-    qdict_put(opts, QUORUM_OPT_BLKVERIFY, qbool_from_bool(s->is_blkverify));
-    qdict_put(opts, QUORUM_OPT_REWRITE, qbool_from_bool(s->rewrite_corrupted));
+    qdict_put_str(opts, "driver", "quorum");
+    qdict_put_int(opts, QUORUM_OPT_VOTE_THRESHOLD, s->threshold);
+    qdict_put_bool(opts, QUORUM_OPT_BLKVERIFY, s->is_blkverify);
+    qdict_put_bool(opts, QUORUM_OPT_REWRITE, s->rewrite_corrupted);
     qdict_put(opts, "children", children);
 
     bs->full_open_options = opts;
diff --git a/block/rbd.c b/block/rbd.c
index fbf3059..e551639 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -154,20 +154,20 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
         goto done;
     }
     qemu_rbd_unescape(found_str);
-    qdict_put(options, "pool", qstring_from_str(found_str));
+    qdict_put_str(options, "pool", found_str);
 
     if (strchr(p, '@')) {
         found_str = qemu_rbd_next_tok(p, '@', &p);
         qemu_rbd_unescape(found_str);
-        qdict_put(options, "image", qstring_from_str(found_str));
+        qdict_put_str(options, "image", found_str);
 
         found_str = qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(found_str);
-        qdict_put(options, "snapshot", qstring_from_str(found_str));
+        qdict_put_str(options, "snapshot", found_str);
     } else {
         found_str = qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(found_str);
-        qdict_put(options, "image", qstring_from_str(found_str));
+        qdict_put_str(options, "image", found_str);
     }
     if (!p) {
         goto done;
@@ -189,9 +189,9 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
         qemu_rbd_unescape(value);
 
         if (!strcmp(name, "conf")) {
-            qdict_put(options, "conf", qstring_from_str(value));
+            qdict_put_str(options, "conf", value);
         } else if (!strcmp(name, "id")) {
-            qdict_put(options, "user" , qstring_from_str(value));
+            qdict_put_str(options, "user", value);
         } else {
             /*
              * We pass these internally to qemu_rbd_set_keypairs(), so
@@ -204,8 +204,8 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
             if (!keypairs) {
                 keypairs = qlist_new();
             }
-            qlist_append(keypairs, qstring_from_str(name));
-            qlist_append(keypairs, qstring_from_str(value));
+            qlist_append_str(keypairs, name);
+            qlist_append_str(keypairs, value);
         }
     }
 
diff --git a/block/snapshot.c b/block/snapshot.c
index 06b1185..a46564e 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -200,7 +200,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
 
         qdict_extract_subqdict(options, &file_options, "file.");
         QDECREF(file_options);
-        qdict_put(options, "file", qstring_from_str(bdrv_get_node_name(file)));
+        qdict_put_str(options, "file", bdrv_get_node_name(file));
 
         drv->bdrv_close(bs);
         bdrv_unref_child(bs, bs->file);
diff --git a/block/ssh.c b/block/ssh.c
index df09f6c..11203fc 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -227,24 +227,23 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
     }
 
     if(uri->user && strcmp(uri->user, "") != 0) {
-        qdict_put(options, "user", qstring_from_str(uri->user));
+        qdict_put_str(options, "user", uri->user);
     }
 
-    qdict_put(options, "server.host", qstring_from_str(uri->server));
+    qdict_put_str(options, "server.host", uri->server);
 
     port_str = g_strdup_printf("%d", uri->port ?: 22);
-    qdict_put(options, "server.port", qstring_from_str(port_str));
+    qdict_put_str(options, "server.port", port_str);
     g_free(port_str);
 
-    qdict_put(options, "path", qstring_from_str(uri->path));
+    qdict_put_str(options, "path", uri->path);
 
     /* Pick out any query parameters that we understand, and ignore
      * the rest.
      */
     for (i = 0; i < qp->n; ++i) {
         if (strcmp(qp->p[i].name, "host_key_check") == 0) {
-            qdict_put(options, "host_key_check",
-                      qstring_from_str(qp->p[i].value));
+            qdict_put_str(options, "host_key_check", qp->p[i].value);
         }
     }
 
@@ -574,9 +573,8 @@ static bool ssh_process_legacy_socket_options(QDict *output_opts,
     }
 
     if (host) {
-        qdict_put(output_opts, "server.host", qstring_from_str(host));
-        qdict_put(output_opts, "server.port",
-                  qstring_from_str(port ?: stringify(22)));
+        qdict_put_str(output_opts, "server.host", host);
+        qdict_put_str(output_opts, "server.port", port ?: stringify(22));
     }
 
     return true;
diff --git a/block/vvfat.c b/block/vvfat.c
index b509d55..9c82371 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1057,10 +1057,10 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     }
 
     /* Fill in the options QDict */
-    qdict_put(options, "dir", qstring_from_str(filename));
-    qdict_put(options, "fat-type", qint_from_int(fat_type));
-    qdict_put(options, "floppy", qbool_from_bool(floppy));
-    qdict_put(options, "rw", qbool_from_bool(rw));
+    qdict_put_str(options, "dir", filename);
+    qdict_put_int(options, "fat-type", fat_type);
+    qdict_put_bool(options, "floppy", floppy);
+    qdict_put_bool(options, "rw", rw);
 }
 
 static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
@@ -3051,7 +3051,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
     }
 
     options = qdict_new();
-    qdict_put(options, "write-target.driver", qstring_from_str("qcow"));
+    qdict_put_str(options, "write-target.driver", "qcow");
     s->qcow = bdrv_open_child(s->qcow_filename, options, "write-target", bs,
                               &child_vvfat_qcow, false, errp);
     QDECREF(options);
diff --git a/block/vxhs.c b/block/vxhs.c
index 9ffe9d3..75cc6c8 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -182,15 +182,15 @@ static int vxhs_parse_uri(const char *filename, QDict *options)
         return -EINVAL;
     }
 
-    qdict_put(options, VXHS_OPT_SERVER".host", qstring_from_str(uri->server));
+    qdict_put_str(options, VXHS_OPT_SERVER ".host", uri->server);
 
     if (uri->port) {
         port = g_strdup_printf("%d", uri->port);
-        qdict_put(options, VXHS_OPT_SERVER".port", qstring_from_str(port));
+        qdict_put_str(options, VXHS_OPT_SERVER ".port", port);
         g_free(port);
     }
 
-    qdict_put(options, "vdisk-id", qstring_from_str(uri->path));
+    qdict_put_str(options, "vdisk-id", uri->path);
 
     trace_vxhs_parse_uri_hostinfo(uri->server, uri->port);
     uri_free(uri);
diff --git a/blockdev.c b/blockdev.c
index 4d8cded..0b38c3d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -527,7 +527,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
             error_setg(errp, "Cannot specify both 'driver' and 'format'");
             goto early_err;
         }
-        qdict_put(bs_opts, "driver", qstring_from_str(buf));
+        qdict_put_str(bs_opts, "driver", buf);
     }
 
     on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
@@ -903,10 +903,8 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         copy_on_read = false;
     }
 
-    qdict_put(bs_opts, BDRV_OPT_READ_ONLY,
-              qstring_from_str(read_only ? "on" : "off"));
-    qdict_put(bs_opts, "copy-on-read",
-              qstring_from_str(copy_on_read ? "on" :"off"));
+    qdict_put_str(bs_opts, BDRV_OPT_READ_ONLY, read_only ? "on" : "off");
+    qdict_put_str(bs_opts, "copy-on-read", copy_on_read ? "on" : "off");
 
     /* Controller type */
     value = qemu_opt_get(legacy_opts, "if");
@@ -1030,7 +1028,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             new_id = g_strdup_printf("%s%s%i", if_name[type],
                                      mediastr, unit_id);
         }
-        qdict_put(bs_opts, "id", qstring_from_str(new_id));
+        qdict_put_str(bs_opts, "id", new_id);
         g_free(new_id);
     }
 
@@ -1067,7 +1065,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             error_report("werror is not supported by this bus type");
             goto fail;
         }
-        qdict_put(bs_opts, "werror", qstring_from_str(werror));
+        qdict_put_str(bs_opts, "werror", werror);
     }
 
     rerror = qemu_opt_get(legacy_opts, "rerror");
@@ -1077,7 +1075,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             error_report("rerror is not supported by this bus type");
             goto fail;
         }
-        qdict_put(bs_opts, "rerror", qstring_from_str(rerror));
+        qdict_put_str(bs_opts, "rerror", rerror);
     }
 
     /* Actual block device init: Functionality shared with blockdev-add */
@@ -1737,10 +1735,9 @@ static void external_snapshot_prepare(BlkActionState *common,
 
         options = qdict_new();
         if (s->has_snapshot_node_name) {
-            qdict_put(options, "node-name",
-                      qstring_from_str(snapshot_node_name));
+            qdict_put_str(options, "node-name", snapshot_node_name);
         }
-        qdict_put(options, "driver", qstring_from_str(format));
+        qdict_put_str(options, "driver", format);
 
         flags |= BDRV_O_NO_BACKING;
     }
@@ -2579,11 +2576,10 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,
 
     options = qdict_new();
     detect_zeroes = blk_get_detect_zeroes_from_root_state(blk);
-    qdict_put(options, "detect-zeroes",
-              qstring_from_str(detect_zeroes ? "on" : "off"));
+    qdict_put_str(options, "detect-zeroes", detect_zeroes ? "on" : "off");
 
     if (has_format) {
-        qdict_put(options, "driver", qstring_from_str(format));
+        qdict_put_str(options, "driver", format);
     }
 
     medium_bs = bdrv_open(filename, NULL, options, bdrv_flags, errp);
@@ -3232,7 +3228,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
 
     if (backup->format) {
         options = qdict_new();
-        qdict_put(options, "driver", qstring_from_str(backup->format));
+        qdict_put_str(options, "driver", backup->format);
     }
 
     target_bs = bdrv_open(backup->target, NULL, options, flags, errp);
@@ -3536,10 +3532,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     options = qdict_new();
     if (arg->has_node_name) {
-        qdict_put(options, "node-name", qstring_from_str(arg->node_name));
+        qdict_put_str(options, "node-name", arg->node_name);
     }
     if (format) {
-        qdict_put(options, "driver", qstring_from_str(format));
+        qdict_put_str(options, "driver", format);
     }
 
     /* Mirroring takes care of copy-on-write using the source's backing
diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index 27df048..3a22805 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -1082,7 +1082,7 @@ static int blk_connect(struct XenDevice *xendev)
 
         if (strcmp(blkdev->fileproto, "<unset>")) {
             options = qdict_new();
-            qdict_put(options, "driver", qstring_from_str(blkdev->fileproto));
+            qdict_put_str(options, "driver", blkdev->fileproto);
         }
 
         /* setup via xenbus -> create new block driver instance */
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 370b3d9..fe62183 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -746,16 +746,16 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
     portname++;
 
     qdict = qdict_new();
-    qdict_put(qdict, "driver", qstring_from_str("usb-host"));
+    qdict_put_str(qdict, "driver", "usb-host");
     tmp = g_strdup_printf("%s.0", usbif->xendev.qdev.id);
-    qdict_put(qdict, "bus", qstring_from_str(tmp));
+    qdict_put_str(qdict, "bus", tmp);
     g_free(tmp);
     tmp = g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
-    qdict_put(qdict, "id", qstring_from_str(tmp));
+    qdict_put_str(qdict, "id", tmp);
     g_free(tmp);
-    qdict_put(qdict, "port", qint_from_int(port));
-    qdict_put(qdict, "hostbus", qint_from_int(atoi(busid)));
-    qdict_put(qdict, "hostport", qstring_from_str(portname));
+    qdict_put_int(qdict, "port", port);
+    qdict_put_int(qdict, "hostbus", atoi(busid));
+    qdict_put_str(qdict, "hostport", portname);
     opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
     if (local_err) {
         goto err;
diff --git a/monitor.c b/monitor.c
index ce11029..078cba5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2769,7 +2769,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     }
                     goto fail;
                 }
-                qdict_put(qdict, key, qstring_from_str(buf));
+                qdict_put_str(qdict, key, buf);
             }
             break;
         case 'O':
@@ -2871,9 +2871,9 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         size = -1;
                     }
                 }
-                qdict_put(qdict, "count", qint_from_int(count));
-                qdict_put(qdict, "format", qint_from_int(format));
-                qdict_put(qdict, "size", qint_from_int(size));
+                qdict_put_int(qdict, "count", count);
+                qdict_put_int(qdict, "format", format);
+                qdict_put_int(qdict, "size", size);
             }
             break;
         case 'i':
@@ -2916,7 +2916,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     }
                     val <<= 20;
                 }
-                qdict_put(qdict, key, qint_from_int(val));
+                qdict_put_int(qdict, key, val);
             }
             break;
         case 'o':
@@ -2939,7 +2939,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     monitor_printf(mon, "invalid size\n");
                     goto fail;
                 }
-                qdict_put(qdict, key, qint_from_int(val));
+                qdict_put_int(qdict, key, val);
                 p = end;
             }
             break;
@@ -2995,7 +2995,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     monitor_printf(mon, "Expected 'on' or 'off'\n");
                     goto fail;
                 }
-                qdict_put(qdict, key, qbool_from_bool(val));
+                qdict_put_bool(qdict, key, val);
             }
             break;
         case '-':
@@ -3026,7 +3026,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                     } else {
                         /* has option */
                         p++;
-                        qdict_put(qdict, key, qbool_from_bool(true));
+                        qdict_put_bool(qdict, key, true);
                     }
                 }
             }
@@ -3052,7 +3052,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                                    cmd->name);
                     goto fail;
                 }
-                qdict_put(qdict, key, qstring_from_str(p));
+                qdict_put_str(qdict, key, p);
                 p += len;
             }
             break;
@@ -3831,9 +3831,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
                     QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
             /* Provide a more useful error message */
             qdict_del(qdict, "desc");
-            qdict_put(qdict, "desc",
-                      qstring_from_str("Expecting capabilities negotiation"
-                                       " with 'qmp_capabilities'"));
+            qdict_put_str(qdict, "desc", "Expecting capabilities negotiation"
+                          " with 'qmp_capabilities'");
         }
     }
 
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 802ede4..ba3029c 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -51,7 +51,7 @@ static void timestamp_put(QDict *qdict)
 QDict *qmp_event_build_dict(const char *event_name)
 {
     QDict *dict = qdict_new();
-    qdict_put(dict, "event", qstring_from_str(event_name));
+    qdict_put_str(dict, "event", event_name);
     timestamp_put(dict);
     return dict;
 }
diff --git a/qemu-img.c b/qemu-img.c
index c719636..f3b0ab4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -313,7 +313,7 @@ static BlockBackend *img_open_file(const char *filename,
 
     if (fmt) {
         options = qdict_new();
-        qdict_put(options, "driver", qstring_from_str(fmt));
+        qdict_put_str(options, "driver", fmt);
     }
 
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
@@ -3094,7 +3094,7 @@ static int img_rebase(int argc, char **argv)
 
         if (bs->backing_format[0] != '\0') {
             options = qdict_new();
-            qdict_put(options, "driver", qstring_from_str(bs->backing_format));
+            qdict_put_str(options, "driver", bs->backing_format);
         }
 
         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
@@ -3111,7 +3111,7 @@ static int img_rebase(int argc, char **argv)
         if (out_baseimg[0]) {
             if (out_basefmt) {
                 options = qdict_new();
-                qdict_put(options, "driver", qstring_from_str(out_basefmt));
+                qdict_put_str(options, "driver", out_basefmt);
             } else {
                 options = NULL;
             }
diff --git a/qemu-io.c b/qemu-io.c
index 427cbae..ed0e2dc 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -601,7 +601,7 @@ int main(int argc, char **argv)
         } else {
             if (format) {
                 opts = qdict_new();
-                qdict_put(opts, "driver", qstring_from_str(format));
+                qdict_put_str(opts, "driver", format);
             }
             if (openfile(argv[optind], flags, writethrough, opts)) {
                 exit(1);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e080fb7..e4f00e2 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -959,7 +959,7 @@ int main(int argc, char **argv)
     } else {
         if (fmt) {
             options = qdict_new();
-            qdict_put(options, "driver", qstring_from_str(fmt));
+            qdict_put_str(options, "driver", fmt);
         }
         blk = blk_new_open(srcpath, NULL, options, flags, &local_err);
     }
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 291eef1..88e2ecd 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -463,7 +463,7 @@ void qdict_set_default_str(QDict *dst, const char *key, const char *val)
         return;
     }
 
-    qdict_put(dst, key, qstring_from_str(val));
+    qdict_put_str(dst, key, val);
 }
 
 static void qdict_flatten_qdict(QDict *qdict, QDict *target,
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ce461cc..8d27363 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
 
 static void qdict_add_disabled_feat(const char *name, void *opaque)
 {
-    qdict_put(opaque, name, qbool_from_bool(false));
+    qdict_put_bool(opaque, name, false);
 }
 
 static void qdict_add_enabled_feat(const char *name, void *opaque)
 {
-    qdict_put(opaque, name, qbool_from_bool(true));
+    qdict_put_bool(opaque, name, true);
 }
 
 /* convert S390CPUDef into a static CpuModelInfo */
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 3cb72fb..be8d81f 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -47,7 +47,7 @@ static void qdict_put_obj_test(void)
     qdict = qdict_new();
 
     // key "" will have tdb hash 12345
-    qdict_put(qdict, "", qint_from_int(num));
+    qdict_put_int(qdict, "", num);
 
     g_assert(qdict_size(qdict) == 1);
     ent = QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
@@ -66,8 +66,8 @@ static void qdict_destroy_simple_test(void)
     QDict *qdict;
 
     qdict = qdict_new();
-    qdict_put(qdict, "num", qint_from_int(0));
-    qdict_put(qdict, "str", qstring_from_str("foo"));
+    qdict_put_int(qdict, "num", 0);
+    qdict_put_str(qdict, "str", "foo");
 
     QDECREF(qdict);
 }
@@ -80,7 +80,7 @@ static void qdict_get_test(void)
     const char *key = "test";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qint_from_int(value));
+    qdict_put_int(tests_dict, key, value);
 
     obj = qdict_get(tests_dict, key);
     g_assert(obj != NULL);
@@ -98,7 +98,7 @@ static void qdict_get_int_test(void)
     const char *key = "int";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qint_from_int(value));
+    qdict_put_int(tests_dict, key, value);
 
     ret = qdict_get_int(tests_dict, key);
     g_assert(ret == value);
@@ -113,7 +113,7 @@ static void qdict_get_try_int_test(void)
     const char *key = "int";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qint_from_int(value));
+    qdict_put_int(tests_dict, key, value);
 
     ret = qdict_get_try_int(tests_dict, key, 0);
     g_assert(ret == value);
@@ -128,7 +128,7 @@ static void qdict_get_str_test(void)
     const char *str = "string";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qstring_from_str(str));
+    qdict_put_str(tests_dict, key, str);
 
     p = qdict_get_str(tests_dict, key);
     g_assert(p != NULL);
@@ -144,7 +144,7 @@ static void qdict_get_try_str_test(void)
     const char *str = "string";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qstring_from_str(str));
+    qdict_put_str(tests_dict, key, str);
 
     p = qdict_get_try_str(tests_dict, key);
     g_assert(p != NULL);
@@ -188,7 +188,7 @@ static void qdict_haskey_test(void)
     const char *key = "test";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qint_from_int(0));
+    qdict_put_int(tests_dict, key, 0);
     g_assert(qdict_haskey(tests_dict, key) == 1);
 
     QDECREF(tests_dict);
@@ -199,7 +199,7 @@ static void qdict_del_test(void)
     const char *key = "key test";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qstring_from_str("foo"));
+    qdict_put_str(tests_dict, key, "foo");
     g_assert(qdict_size(tests_dict) == 1);
 
     qdict_del(tests_dict, key);
@@ -226,9 +226,9 @@ static void qdict_iterapi_test(void)
 
     g_assert(qdict_first(tests_dict) == NULL);
 
-    qdict_put(tests_dict, "key1", qint_from_int(1));
-    qdict_put(tests_dict, "key2", qint_from_int(2));
-    qdict_put(tests_dict, "key3", qint_from_int(3));
+    qdict_put_int(tests_dict, "key1", 1);
+    qdict_put_int(tests_dict, "key2", 2);
+    qdict_put_int(tests_dict, "key3", 3);
 
     count = 0;
     for (ent = qdict_first(tests_dict); ent; ent = qdict_next(tests_dict, ent)){
@@ -294,20 +294,20 @@ static void qdict_flatten_test(void)
      * }
      */
 
-    qdict_put(dict1, "a", qint_from_int(0));
-    qdict_put(dict1, "b", qint_from_int(1));
+    qdict_put_int(dict1, "a", 0);
+    qdict_put_int(dict1, "b", 1);
 
-    qlist_append(list1, qint_from_int(23));
-    qlist_append(list1, qint_from_int(66));
+    qlist_append_int(list1, 23);
+    qlist_append_int(list1, 66);
     qlist_append(list1, dict1);
-    qlist_append(list2, qint_from_int(42));
+    qlist_append_int(list2, 42);
     qlist_append(list2, list1);
 
-    qdict_put(dict2, "c", qint_from_int(2));
-    qdict_put(dict2, "d", qint_from_int(3));
+    qdict_put_int(dict2, "c", 2);
+    qdict_put_int(dict2, "d", 3);
     qdict_put(dict3, "e", list2);
     qdict_put(dict3, "f", dict2);
-    qdict_put(dict3, "g", qint_from_int(4));
+    qdict_put_int(dict3, "g", 4);
 
     qdict_flatten(dict3);
 
@@ -369,12 +369,12 @@ static void qdict_array_split_test(void)
      * This example is given in the comment of qdict_array_split().
      */
 
-    qdict_put(test_dict, "1.x", qint_from_int(0));
-    qdict_put(test_dict, "4.y", qint_from_int(1));
-    qdict_put(test_dict, "0.a", qint_from_int(42));
-    qdict_put(test_dict, "o.o", qint_from_int(7));
-    qdict_put(test_dict, "0.b", qint_from_int(23));
-    qdict_put(test_dict, "2", qint_from_int(66));
+    qdict_put_int(test_dict, "1.x", 0);
+    qdict_put_int(test_dict, "4.y", 1);
+    qdict_put_int(test_dict, "0.a", 42);
+    qdict_put_int(test_dict, "o.o", 7);
+    qdict_put_int(test_dict, "0.b", 23);
+    qdict_put_int(test_dict, "2", 66);
 
     qdict_array_split(test_dict, &test_list);
 
@@ -441,9 +441,9 @@ static void qdict_array_split_test(void)
 
     test_dict = qdict_new();
 
-    qdict_put(test_dict, "0", qint_from_int(42));
-    qdict_put(test_dict, "1", qint_from_int(23));
-    qdict_put(test_dict, "1.x", qint_from_int(84));
+    qdict_put_int(test_dict, "0", 42);
+    qdict_put_int(test_dict, "1", 23);
+    qdict_put_int(test_dict, "1.x", 84);
 
     qdict_array_split(test_dict, &test_list);
 
@@ -472,38 +472,38 @@ static void qdict_array_entries_test(void)
 
     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 0);
 
-    qdict_put(dict, "bar", qint_from_int(0));
-    qdict_put(dict, "baz.0", qint_from_int(0));
+    qdict_put_int(dict, "bar", 0);
+    qdict_put_int(dict, "baz.0", 0);
     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 0);
 
-    qdict_put(dict, "foo.1", qint_from_int(0));
+    qdict_put_int(dict, "foo.1", 0);
     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, -EINVAL);
-    qdict_put(dict, "foo.0", qint_from_int(0));
+    qdict_put_int(dict, "foo.0", 0);
     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 2);
-    qdict_put(dict, "foo.bar", qint_from_int(0));
+    qdict_put_int(dict, "foo.bar", 0);
     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, -EINVAL);
     qdict_del(dict, "foo.bar");
 
-    qdict_put(dict, "foo.2.a", qint_from_int(0));
-    qdict_put(dict, "foo.2.b", qint_from_int(0));
-    qdict_put(dict, "foo.2.c", qint_from_int(0));
+    qdict_put_int(dict, "foo.2.a", 0);
+    qdict_put_int(dict, "foo.2.b", 0);
+    qdict_put_int(dict, "foo.2.c", 0);
     g_assert_cmpint(qdict_array_entries(dict, "foo."), ==, 3);
     g_assert_cmpint(qdict_array_entries(dict, ""), ==, -EINVAL);
 
     QDECREF(dict);
 
     dict = qdict_new();
-    qdict_put(dict, "1", qint_from_int(0));
+    qdict_put_int(dict, "1", 0);
     g_assert_cmpint(qdict_array_entries(dict, ""), ==, -EINVAL);
-    qdict_put(dict, "0", qint_from_int(0));
+    qdict_put_int(dict, "0", 0);
     g_assert_cmpint(qdict_array_entries(dict, ""), ==, 2);
-    qdict_put(dict, "bar", qint_from_int(0));
+    qdict_put_int(dict, "bar", 0);
     g_assert_cmpint(qdict_array_entries(dict, ""), ==, -EINVAL);
     qdict_del(dict, "bar");
 
-    qdict_put(dict, "2.a", qint_from_int(0));
-    qdict_put(dict, "2.b", qint_from_int(0));
-    qdict_put(dict, "2.c", qint_from_int(0));
+    qdict_put_int(dict, "2.a", 0);
+    qdict_put_int(dict, "2.b", 0);
+    qdict_put_int(dict, "2.c", 0);
     g_assert_cmpint(qdict_array_entries(dict, ""), ==, 3);
 
     QDECREF(dict);
@@ -529,7 +529,7 @@ static void qdict_join_test(void)
 
         /* First iteration: Test movement */
         /* Second iteration: Test empty source and non-empty destination */
-        qdict_put(dict2, "foo", qint_from_int(42));
+        qdict_put_int(dict2, "foo", 42);
 
         for (i = 0; i < 2; i++) {
             qdict_join(dict1, dict2, overwrite);
@@ -541,7 +541,7 @@ static void qdict_join_test(void)
         }
 
         /* Test non-empty source and destination without conflict */
-        qdict_put(dict2, "bar", qint_from_int(23));
+        qdict_put_int(dict2, "bar", 23);
 
         qdict_join(dict1, dict2, overwrite);
 
@@ -552,7 +552,7 @@ static void qdict_join_test(void)
         g_assert(qdict_get_int(dict1, "bar") == 23);
 
         /* Test conflict */
-        qdict_put(dict2, "foo", qint_from_int(84));
+        qdict_put_int(dict2, "foo", 84);
 
         qdict_join(dict1, dict2, overwrite);
 
@@ -594,15 +594,15 @@ static void qdict_crumple_test_recursive(void)
     QList *rules;
 
     src = qdict_new();
-    qdict_put(src, "vnc.listen.addr", qstring_from_str("127.0.0.1"));
-    qdict_put(src, "vnc.listen.port", qstring_from_str("5901"));
-    qdict_put(src, "vnc.acl.rules.0.match", qstring_from_str("fred"));
-    qdict_put(src, "vnc.acl.rules.0.policy", qstring_from_str("allow"));
-    qdict_put(src, "vnc.acl.rules.1.match", qstring_from_str("bob"));
-    qdict_put(src, "vnc.acl.rules.1.policy", qstring_from_str("deny"));
-    qdict_put(src, "vnc.acl.default", qstring_from_str("deny"));
-    qdict_put(src, "vnc.acl..name", qstring_from_str("acl0"));
-    qdict_put(src, "vnc.acl.rule..name", qstring_from_str("acl0"));
+    qdict_put_str(src, "vnc.listen.addr", "127.0.0.1");
+    qdict_put_str(src, "vnc.listen.port", "5901");
+    qdict_put_str(src, "vnc.acl.rules.0.match", "fred");
+    qdict_put_str(src, "vnc.acl.rules.0.policy", "allow");
+    qdict_put_str(src, "vnc.acl.rules.1.match", "bob");
+    qdict_put_str(src, "vnc.acl.rules.1.policy", "deny");
+    qdict_put_str(src, "vnc.acl.default", "deny");
+    qdict_put_str(src, "vnc.acl..name", "acl0");
+    qdict_put_str(src, "vnc.acl.rule..name", "acl0");
 
     dst = qobject_to_qdict(qdict_crumple(src, &error_abort));
     g_assert(dst);
@@ -669,8 +669,8 @@ static void qdict_crumple_test_bad_inputs(void)
 
     src = qdict_new();
     /* rule.0 can't be both a string and a dict */
-    qdict_put(src, "rule.0", qstring_from_str("fred"));
-    qdict_put(src, "rule.0.policy", qstring_from_str("allow"));
+    qdict_put_str(src, "rule.0", "fred");
+    qdict_put_str(src, "rule.0.policy", "allow");
 
     g_assert(qdict_crumple(src, &error) == NULL);
     g_assert(error != NULL);
@@ -680,8 +680,8 @@ static void qdict_crumple_test_bad_inputs(void)
 
     src = qdict_new();
     /* rule can't be both a list and a dict */
-    qdict_put(src, "rule.0", qstring_from_str("fred"));
-    qdict_put(src, "rule.a", qstring_from_str("allow"));
+    qdict_put_str(src, "rule.0", "fred");
+    qdict_put_str(src, "rule.a", "allow");
 
     g_assert(qdict_crumple(src, &error) == NULL);
     g_assert(error != NULL);
@@ -692,7 +692,7 @@ static void qdict_crumple_test_bad_inputs(void)
     src = qdict_new();
     /* The input should be flat, ie no dicts or lists */
     qdict_put(src, "rule.a", qdict_new());
-    qdict_put(src, "rule.b", qstring_from_str("allow"));
+    qdict_put_str(src, "rule.b", "allow");
 
     g_assert(qdict_crumple(src, &error) == NULL);
     g_assert(error != NULL);
@@ -702,8 +702,8 @@ static void qdict_crumple_test_bad_inputs(void)
 
     src = qdict_new();
     /* List indexes must not have gaps */
-    qdict_put(src, "rule.0", qstring_from_str("deny"));
-    qdict_put(src, "rule.3", qstring_from_str("allow"));
+    qdict_put_str(src, "rule.0", "deny");
+    qdict_put_str(src, "rule.3", "allow");
 
     g_assert(qdict_crumple(src, &error) == NULL);
     g_assert(error != NULL);
@@ -713,8 +713,8 @@ static void qdict_crumple_test_bad_inputs(void)
 
     src = qdict_new();
     /* List indexes must be in %zu format */
-    qdict_put(src, "rule.0", qstring_from_str("deny"));
-    qdict_put(src, "rule.+1", qstring_from_str("allow"));
+    qdict_put_str(src, "rule.0", "deny");
+    qdict_put_str(src, "rule.+1", "allow");
 
     g_assert(qdict_crumple(src, &error) == NULL);
     g_assert(error != NULL);
@@ -733,8 +733,8 @@ static void qdict_put_exists_test(void)
     const char *key = "exists";
     QDict *tests_dict = qdict_new();
 
-    qdict_put(tests_dict, key, qint_from_int(1));
-    qdict_put(tests_dict, key, qint_from_int(2));
+    qdict_put_int(tests_dict, key, 1);
+    qdict_put_int(tests_dict, key, 2);
 
     value = qdict_get_int(tests_dict, key);
     g_assert(value == 2);
diff --git a/tests/check-qlist.c b/tests/check-qlist.c
index e16da5e..4983867 100644
--- a/tests/check-qlist.c
+++ b/tests/check-qlist.c
@@ -74,7 +74,7 @@ static void qlist_destroy_test(void)
     qlist = qlist_new();
 
     for (i = 0; i < 42; i++)
-        qlist_append(qlist, qint_from_int(i));
+        qlist_append_int(qlist, i);
 
     QDECREF(qlist);
 }
@@ -103,7 +103,7 @@ static void qlist_iter_test(void)
     qlist = qlist_new();
 
     for (i = 0; i < iter_max; i++)
-        qlist_append(qlist, qint_from_int(i));
+        qlist_append_int(qlist, i);
 
     iter_called = 0;
     qlist_iter(qlist, iter_func, NULL);
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index c5637cc..b1abb2a 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -32,9 +32,9 @@ static QList *qom_list_types(const char *implements, bool abstract)
     QList *ret;
     QDict *args = qdict_new();
 
-    qdict_put(args, "abstract", qbool_from_bool(abstract));
+    qdict_put_bool(args, "abstract", abstract);
     if (implements) {
-        qdict_put(args, "implements", qstring_from_str(implements));
+        qdict_put_str(args, "implements", implements);
     }
     resp = qmp("{'execute': 'qom-list-types',"
                " 'arguments': %p }", args);
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 0ad74b4..cc1bb1a 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -299,7 +299,7 @@ static void test_qemu_opt_get_size(void)
     dict = qdict_new();
     g_assert(dict != NULL);
 
-    qdict_put(dict, "size1", qstring_from_str("10"));
+    qdict_put_str(dict, "size1", "10");
 
     qemu_opts_absorb_qdict(opts, dict, &error_abort);
     g_assert(error_abort == NULL);
@@ -309,7 +309,7 @@ static void test_qemu_opt_get_size(void)
     g_assert(opt == 10);
 
     /* reset value */
-    qdict_put(dict, "size1", qstring_from_str("15"));
+    qdict_put_str(dict, "size1", "15");
 
     qemu_opts_absorb_qdict(opts, dict, &error_abort);
     g_assert(error_abort == NULL);
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index ac3fd03..acdded4 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -94,7 +94,7 @@ static void test_dispatch_cmd(void)
     QDict *req = qdict_new();
     QObject *resp;
 
-    qdict_put(req, "execute", qstring_from_str("user_def_cmd"));
+    qdict_put_str(req, "execute", "user_def_cmd");
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
@@ -111,7 +111,7 @@ static void test_dispatch_cmd_failure(void)
     QDict *args = qdict_new();
     QObject *resp;
 
-    qdict_put(req, "execute", qstring_from_str("user_def_cmd2"));
+    qdict_put_str(req, "execute", "user_def_cmd2");
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
@@ -122,10 +122,10 @@ static void test_dispatch_cmd_failure(void)
 
     /* check that with extra arguments it throws an error */
     req = qdict_new();
-    qdict_put(args, "a", qint_from_int(66));
+    qdict_put_int(args, "a", 66);
     qdict_put(req, "arguments", args);
 
-    qdict_put(req, "execute", qstring_from_str("user_def_cmd"));
+    qdict_put_str(req, "execute", "user_def_cmd");
 
     resp = qmp_dispatch(&qmp_commands, QOBJECT(req));
     assert(resp != NULL);
@@ -164,14 +164,14 @@ static void test_dispatch_cmd_io(void)
     QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
     QInt *ret3;
 
-    qdict_put(ud1a, "integer", qint_from_int(42));
-    qdict_put(ud1a, "string", qstring_from_str("hello"));
-    qdict_put(ud1b, "integer", qint_from_int(422));
-    qdict_put(ud1b, "string", qstring_from_str("hello2"));
+    qdict_put_int(ud1a, "integer", 42);
+    qdict_put_str(ud1a, "string", "hello");
+    qdict_put_int(ud1b, "integer", 422);
+    qdict_put_str(ud1b, "string", "hello2");
     qdict_put(args, "ud1a", ud1a);
     qdict_put(args, "ud1b", ud1b);
     qdict_put(req, "arguments", args);
-    qdict_put(req, "execute", qstring_from_str("user_def_cmd2"));
+    qdict_put_str(req, "execute", "user_def_cmd2");
 
     ret = qobject_to_qdict(test_qmp_dispatch(req));
 
@@ -190,9 +190,9 @@ static void test_dispatch_cmd_io(void)
     assert(!strcmp(qdict_get_str(ret_dict_dict2, "string"), "blah4"));
     QDECREF(ret);
 
-    qdict_put(args3, "a", qint_from_int(66));
+    qdict_put_int(args3, "a", 66);
     qdict_put(req, "arguments", args3);
-    qdict_put(req, "execute", qstring_from_str("guest-get-time"));
+    qdict_put_str(req, "execute", "guest-get-time");
 
     ret3 = qobject_to_qint(test_qmp_dispatch(req));
     assert(qint_get_int(ret3) == 66);
@@ -244,7 +244,7 @@ static void test_dealloc_partial(void)
         Visitor *v;
 
         ud2_dict = qdict_new();
-        qdict_put(ud2_dict, "string0", qstring_from_str(text));
+        qdict_put_str(ud2_dict, "string0", text);
 
         v = qobject_input_visitor_new(QOBJECT(ud2_dict));
         visit_type_UserDefTwo(v, NULL, &ud2, &err);
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 7bb621b..4c0f096 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -153,7 +153,7 @@ static void test_event_a(TestEventData *data,
 {
     QDict *d;
     d = data->expect;
-    qdict_put(d, "event", qstring_from_str("EVENT_A"));
+    qdict_put_str(d, "event", "EVENT_A");
     qapi_event_send_event_a(&error_abort);
 }
 
@@ -162,7 +162,7 @@ static void test_event_b(TestEventData *data,
 {
     QDict *d;
     d = data->expect;
-    qdict_put(d, "event", qstring_from_str("EVENT_B"));
+    qdict_put_str(d, "event", "EVENT_B");
     qapi_event_send_event_b(&error_abort);
 }
 
@@ -177,16 +177,16 @@ static void test_event_c(TestEventData *data,
     b.has_enum1 = false;
 
     d_b = qdict_new();
-    qdict_put(d_b, "integer", qint_from_int(2));
-    qdict_put(d_b, "string", qstring_from_str("test1"));
+    qdict_put_int(d_b, "integer", 2);
+    qdict_put_str(d_b, "string", "test1");
 
     d_data = qdict_new();
-    qdict_put(d_data, "a", qint_from_int(1));
+    qdict_put_int(d_data, "a", 1);
     qdict_put(d_data, "b", d_b);
-    qdict_put(d_data, "c", qstring_from_str("test2"));
+    qdict_put_str(d_data, "c", "test2");
 
     d = data->expect;
-    qdict_put(d, "event", qstring_from_str("EVENT_C"));
+    qdict_put_str(d, "event", "EVENT_C");
     qdict_put(d, "data", d_data);
 
     qapi_event_send_event_c(true, 1, true, &b, "test2", &error_abort);
@@ -213,22 +213,22 @@ static void test_event_d(TestEventData *data,
     a.enum2 = ENUM_ONE_VALUE2;
 
     d_struct1 = qdict_new();
-    qdict_put(d_struct1, "integer", qint_from_int(2));
-    qdict_put(d_struct1, "string", qstring_from_str("test1"));
-    qdict_put(d_struct1, "enum1", qstring_from_str("value1"));
+    qdict_put_int(d_struct1, "integer", 2);
+    qdict_put_str(d_struct1, "string", "test1");
+    qdict_put_str(d_struct1, "enum1", "value1");
 
     d_a = qdict_new();
     qdict_put(d_a, "struct1", d_struct1);
-    qdict_put(d_a, "string", qstring_from_str("test2"));
-    qdict_put(d_a, "enum2", qstring_from_str("value2"));
+    qdict_put_str(d_a, "string", "test2");
+    qdict_put_str(d_a, "enum2", "value2");
 
     d_data = qdict_new();
     qdict_put(d_data, "a", d_a);
-    qdict_put(d_data, "b", qstring_from_str("test3"));
-    qdict_put(d_data, "enum3", qstring_from_str("value3"));
+    qdict_put_str(d_data, "b", "test3");
+    qdict_put_str(d_data, "enum3", "value3");
 
     d = data->expect;
-    qdict_put(d, "event", qstring_from_str("EVENT_D"));
+    qdict_put_str(d, "event", "EVENT_D");
     qdict_put(d, "data", d_data);
 
     qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE3,
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index c213fce..94b9518 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -343,9 +343,9 @@ static void test_visitor_out_any(TestOutputVisitorData *data,
 
     visitor_reset(data);
     qdict = qdict_new();
-    qdict_put(qdict, "integer", qint_from_int(-42));
-    qdict_put(qdict, "boolean", qbool_from_bool(true));
-    qdict_put(qdict, "string", qstring_from_str("foo"));
+    qdict_put_int(qdict, "integer", -42);
+    qdict_put_bool(qdict, "boolean", true);
+    qdict_put_str(qdict, "string", "foo");
     qobj = QOBJECT(qdict);
     visit_type_any(data->ov, NULL, &qobj, &error_abort);
     qobject_decref(qobj);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5ce1b5c..a36cafa 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1060,7 +1060,7 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
         qdict = qdict_new();
     }
     if (opts->id) {
-        qdict_put(qdict, "id", qstring_from_str(opts->id));
+        qdict_put_str(qdict, "id", opts->id);
     }
     QTAILQ_FOREACH(opt, &opts->head, next) {
         val = QOBJECT(qstring_from_str(opt->str));
-- 
2.7.4
