Received: from eggs.gnu.org ([2001:4830:134:3::10]:42852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF1-0002WG-Hv
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEz-0002uB-GR
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:43 +0100
Message-Id: <1488901251-16214-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/27] sheepdog: Implement bdrv_parse_filename()
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

From: Markus Armbruster <armbru@redhat.com>

This permits configuration with driver-specific options in addition to
pseudo-filename parsed as URI.  For instance,

    --drive driver=sheepdog,host=fido,vdi=dolly

instead of

    --drive driver=sheepdog,file=sheepdog://fido/dolly

It's also a first step towards supporting blockdev-add.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 230 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 174 insertions(+), 56 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 9b1e121..89e98ed 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qint.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -526,6 +528,25 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
     QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
 }
 
+static SocketAddress *sd_socket_address(const char *path,
+                                        const char *host, const char *port)
+{
+    SocketAddress *addr = g_new0(SocketAddress, 1);
+
+    if (path) {
+        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
+        addr->u.q_unix.data->path = g_strdup(path);
+    } else {
+        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->u.inet.data = g_new0(InetSocketAddress, 1);
+        addr->u.inet.data->host = g_strdup(host ?: SD_DEFAULT_ADDR);
+        addr->u.inet.data->port = g_strdup(port ?: stringify(SD_DEFAULT_PORT));
+    }
+
+    return addr;
+}
+
 /* Return -EIO in case of error, file descriptor on success */
 static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
@@ -951,17 +972,37 @@ static bool sd_parse_snapid_or_tag(const char *str,
     return true;
 }
 
-static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
-                         char *vdi, uint32_t *snapid, char *tag,
+typedef struct {
+    const char *path;           /* non-null iff transport is tcp */
+    const char *host;           /* valid when transport is tcp */
+    int port;                   /* valid when transport is tcp */
+    char vdi[SD_MAX_VDI_LEN];
+    char tag[SD_MAX_VDI_TAG_LEN];
+    uint32_t snap_id;
+    /* Remainder is only for sd_config_done() */
+    URI *uri;
+    QueryParams *qp;
+} SheepdogConfig;
+
+static void sd_config_done(SheepdogConfig *cfg)
+{
+    if (cfg->qp) {
+        query_params_free(cfg->qp);
+    }
+    uri_free(cfg->uri);
+}
+
+static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
                          Error **errp)
 {
     Error *err = NULL;
     QueryParams *qp = NULL;
-    SocketAddress *addr = NULL;
     bool is_unix;
     URI *uri;
 
-    uri = uri_parse(filename);
+    memset(cfg, 0, sizeof(*cfg));
+
+    cfg->uri = uri = uri_parse(filename);
     if (!uri) {
         error_setg(&err, "invalid URI");
         goto out;
@@ -984,13 +1025,13 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
         error_setg(&err, "missing file path in URI");
         goto out;
     }
-    if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >= SD_MAX_VDI_LEN) {
+    if (g_strlcpy(cfg->vdi, uri->path + 1, SD_MAX_VDI_LEN)
+        >= SD_MAX_VDI_LEN) {
         error_setg(&err, "VDI name is too long");
         goto out;
     }
 
-    qp = query_params_parse(uri->query);
-    addr = g_new0(SocketAddress, 1);
+    cfg->qp = qp = query_params_parse(uri->query);
 
     if (is_unix) {
         /* sheepdog+unix:///vdiname?socket=path */
@@ -1009,44 +1050,34 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
             error_setg(&err, "unexpected query parameters");
             goto out;
         }
-        addr->type = SOCKET_ADDRESS_KIND_UNIX;
-        addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-        addr->u.q_unix.data->path = g_strdup(qp->p[0].value);
+        cfg->path = qp->p[0].value;
     } else {
         /* sheepdog[+tcp]://[host:port]/vdiname */
         if (qp->n) {
             error_setg(&err, "unexpected query parameters");
             goto out;
         }
-        addr->type = SOCKET_ADDRESS_KIND_INET;
-        addr->u.inet.data = g_new0(InetSocketAddress, 1);
-        addr->u.inet.data->host = g_strdup(uri->server ?: SD_DEFAULT_ADDR);
-        addr->u.inet.data->port = g_strdup_printf("%d",
-                                        uri->port ?: SD_DEFAULT_PORT);
+        cfg->host = uri->server;
+        cfg->port = uri->port;
     }
 
     /* snapshot tag */
     if (uri->fragment) {
-        if (!sd_parse_snapid_or_tag(uri->fragment, snapid, tag)) {
+        if (!sd_parse_snapid_or_tag(uri->fragment,
+                                    &cfg->snap_id, cfg->tag)) {
             error_setg(&err, "'%s' is not a valid snapshot ID",
                        uri->fragment);
             goto out;
         }
     } else {
-        *snapid = CURRENT_VDI_ID; /* search current vdi */
+        cfg->snap_id = CURRENT_VDI_ID; /* search current vdi */
     }
 
 out:
     if (err) {
         error_propagate(errp, err);
-        qapi_free_SocketAddress(addr);
-    } else {
-        s->addr = addr;
-    }
-    if (qp) {
-        query_params_free(qp);
+        sd_config_done(cfg);
     }
-    uri_free(uri);
 }
 
 /*
@@ -1066,8 +1097,7 @@ out:
  * You can run VMs outside the Sheepdog cluster by specifying
  * `hostname' and `port' (experimental).
  */
-static void parse_vdiname(BDRVSheepdogState *s, const char *filename,
-                          char *vdi, uint32_t *snapid, char *tag,
+static void parse_vdiname(SheepdogConfig *cfg, const char *filename,
                           Error **errp)
 {
     Error *err = NULL;
@@ -1112,7 +1142,7 @@ static void parse_vdiname(BDRVSheepdogState *s, const char *filename,
      * FIXME We to escape URI meta-characters, e.g. "x?y=z"
      * produces "sheepdog://x?y=z".  Because of that ...
      */
-    sd_parse_uri(s, uri, vdi, snapid, tag, &err);
+    sd_parse_uri(cfg, uri, &err);
     if (err) {
         /*
          * ... this can fail, but the error message is misleading.
@@ -1127,6 +1157,43 @@ static void parse_vdiname(BDRVSheepdogState *s, const char *filename,
     g_free(uri);
 }
 
+static void sd_parse_filename(const char *filename, QDict *options,
+                              Error **errp)
+{
+    Error *err = NULL;
+    SheepdogConfig cfg;
+    char buf[32];
+
+    if (strstr(filename, "://")) {
+        sd_parse_uri(&cfg, filename, &err);
+    } else {
+        parse_vdiname(&cfg, filename, &err);
+    }
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    if (cfg.host) {
+        qdict_set_default_str(options, "host", cfg.host);
+    }
+    if (cfg.port) {
+        snprintf(buf, sizeof(buf), "%d", cfg.port);
+        qdict_set_default_str(options, "port", buf);
+    }
+    if (cfg.path) {
+        qdict_set_default_str(options, "path", cfg.path);
+    }
+    qdict_set_default_str(options, "vdi", cfg.vdi);
+    qdict_set_default_str(options, "tag", cfg.tag);
+    if (cfg.snap_id) {
+        snprintf(buf, sizeof(buf), "%d", cfg.snap_id);
+        qdict_set_default_str(options, "snap-id", buf);
+    }
+
+    sd_config_done(&cfg);
+}
+
 static int find_vdi_name(BDRVSheepdogState *s, const char *filename,
                          uint32_t snapid, const char *tag, uint32_t *vid,
                          bool lock, Error **errp)
@@ -1438,15 +1505,33 @@ static void sd_attach_aio_context(BlockDriverState *bs,
                        co_read_response, NULL, NULL, s);
 }
 
-/* TODO Convert to fine grained options */
 static QemuOptsList runtime_opts = {
     .name = "sheepdog",
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     .desc = {
         {
-            .name = "filename",
+            .name = "host",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "port",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "path",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "vdi",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "snap-id",
+            .type = QEMU_OPT_NUMBER,
+        },
+        {
+            .name = "tag",
             .type = QEMU_OPT_STRING,
-            .help = "URL to the sheepdog image",
         },
         { /* end of list */ }
     },
@@ -1458,12 +1543,11 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     int ret, fd;
     uint32_t vid = 0;
     BDRVSheepdogState *s = bs->opaque;
-    char vdi[SD_MAX_VDI_LEN], tag[SD_MAX_VDI_TAG_LEN];
-    uint32_t snapid;
+    const char *host, *port, *path, *vdi, *snap_id_str, *tag;
+    uint64_t snap_id;
     char *buf = NULL;
     QemuOpts *opts;
     Error *local_err = NULL;
-    const char *filename;
 
     s->bs = bs;
     s->aio_context = bdrv_get_aio_context(bs);
@@ -1476,33 +1560,63 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
         goto err_no_fd;
     }
 
-    filename = qemu_opt_get(opts, "filename");
+    host = qemu_opt_get(opts, "host");
+    port = qemu_opt_get(opts, "port");
+    path = qemu_opt_get(opts, "path");
+    vdi = qemu_opt_get(opts, "vdi");
+    snap_id_str = qemu_opt_get(opts, "snap-id");
+    snap_id = qemu_opt_get_number(opts, "snap-id", CURRENT_VDI_ID);
+    tag = qemu_opt_get(opts, "tag");
 
-    QLIST_INIT(&s->inflight_aio_head);
-    QLIST_INIT(&s->failed_aio_head);
-    QLIST_INIT(&s->inflight_aiocb_head);
-    s->fd = -1;
+    if ((host || port) && path) {
+        error_setg(errp, "can't use 'path' together with 'host' or 'port'");
+        ret = -EINVAL;
+        goto err_no_fd;
+    }
+
+    if (!vdi) {
+        error_setg(errp, "parameter 'vdi' is missing");
+        ret = -EINVAL;
+        goto err_no_fd;
+    }
+    if (strlen(vdi) >= SD_MAX_VDI_LEN) {
+        error_setg(errp, "value of parameter 'vdi' is too long");
+        ret = -EINVAL;
+        goto err_no_fd;
+    }
 
-    memset(vdi, 0, sizeof(vdi));
-    memset(tag, 0, sizeof(tag));
+    if (snap_id > UINT32_MAX) {
+        snap_id = 0;
+    }
+    if (snap_id_str && !snap_id) {
+        error_setg(errp, "'snap-id=%s' is not a valid snapshot ID",
+                   snap_id_str);
+        ret = -EINVAL;
+        goto err_no_fd;
+    }
 
-    if (strstr(filename, "://")) {
-        sd_parse_uri(s, filename, vdi, &snapid, tag, &local_err);
-    } else {
-        parse_vdiname(s, filename, vdi, &snapid, tag, &local_err);
+    if (!tag) {
+        tag = "";
     }
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (tag && strlen(tag) >= SD_MAX_VDI_TAG_LEN) {
+        error_setg(errp, "value of parameter 'tag' is too long");
         ret = -EINVAL;
         goto err_no_fd;
     }
+
+    s->addr = sd_socket_address(path, host, port);
+
+    QLIST_INIT(&s->inflight_aio_head);
+    QLIST_INIT(&s->failed_aio_head);
+    QLIST_INIT(&s->inflight_aiocb_head);
+
     s->fd = get_sheep_fd(s, errp);
     if (s->fd < 0) {
         ret = s->fd;
         goto err_no_fd;
     }
 
-    ret = find_vdi_name(s, vdi, snapid, tag, &vid, true, errp);
+    ret = find_vdi_name(s, vdi, (uint32_t)snap_id, tag, &vid, true, errp);
     if (ret) {
         goto err;
     }
@@ -1517,7 +1631,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->discard_supported = true;
 
-    if (snapid || tag[0] != '\0') {
+    if (snap_id || tag[0]) {
         DPRINTF("%" PRIx32 " snapshot inode was open.\n", vid);
         s->is_snapshot = true;
     }
@@ -1827,24 +1941,28 @@ static int sd_create(const char *filename, QemuOpts *opts,
     char *backing_file = NULL;
     char *buf = NULL;
     BDRVSheepdogState *s;
-    char tag[SD_MAX_VDI_TAG_LEN];
-    uint32_t snapid;
+    SheepdogConfig cfg;
     uint64_t max_vdi_size;
     bool prealloc = false;
 
     s = g_new0(BDRVSheepdogState, 1);
 
-    memset(tag, 0, sizeof(tag));
     if (strstr(filename, "://")) {
-        sd_parse_uri(s, filename, s->name, &snapid, tag, &err);
+        sd_parse_uri(&cfg, filename, &err);
     } else {
-        parse_vdiname(s, filename, s->name, &snapid, tag, &err);
+        parse_vdiname(&cfg, filename, &err);
     }
     if (err) {
         error_propagate(errp, err);
         goto out;
     }
 
+    buf = cfg.port ? g_strdup_printf("%d", cfg.port) : NULL;
+    s->addr = sd_socket_address(cfg.path, cfg.host, buf);
+    g_free(buf);
+    strcpy(s->name, cfg.vdi);
+    sd_config_done(&cfg);
+
     s->inode.vdi_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                                  BDRV_SECTOR_SIZE);
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
@@ -2921,7 +3039,7 @@ static BlockDriver bdrv_sheepdog = {
     .format_name    = "sheepdog",
     .protocol_name  = "sheepdog",
     .instance_size  = sizeof(BDRVSheepdogState),
-    .bdrv_needs_filename = true,
+    .bdrv_parse_filename    = sd_parse_filename,
     .bdrv_file_open = sd_open,
     .bdrv_reopen_prepare    = sd_reopen_prepare,
     .bdrv_reopen_commit     = sd_reopen_commit,
@@ -2957,7 +3075,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .format_name    = "sheepdog",
     .protocol_name  = "sheepdog+tcp",
     .instance_size  = sizeof(BDRVSheepdogState),
-    .bdrv_needs_filename = true,
+    .bdrv_parse_filename    = sd_parse_filename,
     .bdrv_file_open = sd_open,
     .bdrv_reopen_prepare    = sd_reopen_prepare,
     .bdrv_reopen_commit     = sd_reopen_commit,
@@ -2993,7 +3111,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .format_name    = "sheepdog",
     .protocol_name  = "sheepdog+unix",
     .instance_size  = sizeof(BDRVSheepdogState),
-    .bdrv_needs_filename = true,
+    .bdrv_parse_filename    = sd_parse_filename,
     .bdrv_file_open = sd_open,
     .bdrv_reopen_prepare    = sd_reopen_prepare,
     .bdrv_reopen_commit     = sd_reopen_commit,
-- 
1.8.3.1
