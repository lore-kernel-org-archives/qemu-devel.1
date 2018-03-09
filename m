Received: from eggs.gnu.org ([2001:4830:134:3::10]:33911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlA-0001Jn-CW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl7-0007Bf-Vt
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:13 +0100
Message-Id: <20180309161933.8168-37-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 36/56] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
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

With the conversion to a QAPI options object, the function is now
prepared to be used in a .bdrv_co_create implementation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/rbd.c | 115 +++++++++++++++++++++++++++++-------------------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a979107f65..999fea105f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -24,6 +24,8 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 
 /*
  * When specifying the image filename use:
@@ -484,98 +486,71 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     qemu_aio_unref(acb);
 }
 
-static char *qemu_rbd_mon_host(QDict *options, Error **errp)
+static char *qemu_rbd_mon_host(BlockdevOptionsRbd *opts, Error **errp)
 {
-    const char **vals = g_new(const char *, qdict_size(options) + 1);
-    char keybuf[32];
+    const char **vals;
     const char *host, *port;
     char *rados_str;
-    int i;
-
-    for (i = 0;; i++) {
-        sprintf(keybuf, "server.%d.host", i);
-        host = qdict_get_try_str(options, keybuf);
-        qdict_del(options, keybuf);
-        sprintf(keybuf, "server.%d.port", i);
-        port = qdict_get_try_str(options, keybuf);
-        qdict_del(options, keybuf);
-        if (!host && !port) {
-            break;
-        }
-        if (!host) {
-            error_setg(errp, "Parameter server.%d.host is missing", i);
-            rados_str = NULL;
-            goto out;
-        }
+    InetSocketAddressBaseList *p;
+    int i, cnt;
+
+    if (!opts->has_server) {
+        return NULL;
+    }
+
+    for (cnt = 0, p = opts->server; p; p = p->next) {
+        cnt++;
+    }
+
+    vals = g_new(const char *, cnt + 1);
+
+    for (i = 0, p = opts->server; p; p = p->next, i++) {
+        host = p->value->host;
+        port = p->value->port;
 
         if (strchr(host, ':')) {
-            vals[i] = port ? g_strdup_printf("[%s]:%s", host, port)
-                : g_strdup_printf("[%s]", host);
+            vals[i] = g_strdup_printf("[%s]:%s", host, port);
         } else {
-            vals[i] = port ? g_strdup_printf("%s:%s", host, port)
-                : g_strdup(host);
+            vals[i] = g_strdup_printf("%s:%s", host, port);
         }
     }
     vals[i] = NULL;
 
     rados_str = i ? g_strjoinv(";", (char **)vals) : NULL;
-out:
     g_strfreev((char **)vals);
     return rados_str;
 }
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
                             char **s_snap, char **s_image_name,
-                            QDict *options, bool cache,
+                            BlockdevOptionsRbd *opts, bool cache,
                             const char *keypairs, const char *secretid,
                             Error **errp)
 {
-    QemuOpts *opts;
     char *mon_host = NULL;
-    const char *pool, *snap, *conf, *user, *image_name;
     Error *local_err = NULL;
     int r;
 
-    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        r = -EINVAL;
-        goto failed_opts;
-    }
-
-    mon_host = qemu_rbd_mon_host(options, &local_err);
+    mon_host = qemu_rbd_mon_host(opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         r = -EINVAL;
         goto failed_opts;
     }
 
-    pool           = qemu_opt_get(opts, "pool");
-    conf           = qemu_opt_get(opts, "conf");
-    snap           = qemu_opt_get(opts, "snapshot");
-    user           = qemu_opt_get(opts, "user");
-    image_name     = qemu_opt_get(opts, "image");
-
-    if (!pool || !image_name) {
-        error_setg(errp, "Parameters 'pool' and 'image' are required");
-        r = -EINVAL;
-        goto failed_opts;
-    }
-
-    r = rados_create(cluster, user);
+    r = rados_create(cluster, opts->user);
     if (r < 0) {
         error_setg_errno(errp, -r, "error initializing");
         goto failed_opts;
     }
 
-    *s_snap = g_strdup(snap);
-    *s_image_name = g_strdup(image_name);
+    *s_snap = g_strdup(opts->snapshot);
+    *s_image_name = g_strdup(opts->image);
 
     /* try default location when conf=NULL, but ignore failure */
-    r = rados_conf_read_file(*cluster, conf);
-    if (conf && r < 0) {
-        error_setg_errno(errp, -r, "error reading conf file %s", conf);
+    r = rados_conf_read_file(*cluster, opts->conf);
+    if (opts->has_conf && r < 0) {
+        error_setg_errno(errp, -r, "error reading conf file %s", opts->conf);
         goto failed_shutdown;
     }
 
@@ -615,13 +590,12 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
         goto failed_shutdown;
     }
 
-    r = rados_ioctx_create(*cluster, pool, io_ctx);
+    r = rados_ioctx_create(*cluster, opts->pool, io_ctx);
     if (r < 0) {
-        error_setg_errno(errp, -r, "error opening pool %s", pool);
+        error_setg_errno(errp, -r, "error opening pool %s", opts->pool);
         goto failed_shutdown;
     }
 
-    qemu_opts_del(opts);
     return 0;
 
 failed_shutdown:
@@ -629,7 +603,6 @@ failed_shutdown:
     g_free(*s_snap);
     g_free(*s_image_name);
 failed_opts:
-    qemu_opts_del(opts);
     g_free(mon_host);
     return r;
 }
@@ -638,6 +611,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
+    BlockdevOptionsRbd *opts = NULL;
+    Visitor *v;
+    QObject *crumpled = NULL;
     Error *local_err = NULL;
     const char *filename;
     char *keypairs, *secretid;
@@ -668,8 +644,26 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         qdict_del(options, "password-secret");
     }
 
+    /* Convert the remaining options into a QAPI object */
+    crumpled = qdict_crumple(options, errp);
+    if (crumpled == NULL) {
+        r = -EINVAL;
+        goto out;
+    }
+
+    v = qobject_input_visitor_new_keyval(crumpled);
+    visit_type_BlockdevOptionsRbd(v, NULL, &opts, &local_err);
+    visit_free(v);
+    qobject_decref(crumpled);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        r = -EINVAL;
+        goto out;
+    }
+
     r = qemu_rbd_connect(&s->cluster, &s->io_ctx, &s->snap, &s->image_name,
-                         options, !(flags & BDRV_O_NOCACHE), keypairs, secretid,
+                         opts, !(flags & BDRV_O_NOCACHE), keypairs, secretid,
                          errp);
     if (r < 0) {
         goto out;
@@ -708,6 +702,7 @@ failed_open:
     g_free(s->image_name);
     rados_shutdown(s->cluster);
 out:
+    qapi_free_BlockdevOptionsRbd(opts);
     g_free(keypairs);
     g_free(secretid);
     return r;
-- 
2.13.6
