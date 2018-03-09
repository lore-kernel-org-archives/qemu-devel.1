Received: from eggs.gnu.org ([2001:4830:134:3::10]:33865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl8-0001HW-17
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl6-00079A-7i
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:11 +0100
Message-Id: <20180309161933.8168-35-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 34/56] rbd: Factor out qemu_rbd_connect()
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

The code to establish an RBD connection is duplicated between open and
create. In order to be able to share the code, factor out the code from
qemu_rbd_open() as a first step.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/rbd.c | 100 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index c1025c8493..99fcc7ecdf 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -546,32 +546,17 @@ out:
     return rados_str;
 }
 
-static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
-                         Error **errp)
+static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
+                            char **s_snap, char **s_image_name,
+                            QDict *options, bool cache, Error **errp)
 {
-    BDRVRBDState *s = bs->opaque;
-    const char *pool, *snap, *conf, *user, *image_name, *keypairs;
-    const char *secretid, *filename;
     QemuOpts *opts;
-    Error *local_err = NULL;
     char *mon_host = NULL;
+    const char *pool, *snap, *conf, *user, *image_name, *keypairs;
+    const char *secretid;
+    Error *local_err = NULL;
     int r;
 
-    /* If we are given a filename, parse the filename, with precedence given to
-     * filename encoded options */
-    filename = qdict_get_try_str(options, "filename");
-    if (filename) {
-        warn_report("'filename' option specified. "
-                    "This is an unsupported option, and may be deprecated "
-                    "in the future");
-        qemu_rbd_parse_filename(filename, options, &local_err);
-        if (local_err) {
-            r = -EINVAL;
-            error_propagate(errp, local_err);
-            goto exit;
-        }
-    }
-
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -602,35 +587,35 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_opts;
     }
 
-    r = rados_create(&s->cluster, user);
+    r = rados_create(cluster, user);
     if (r < 0) {
         error_setg_errno(errp, -r, "error initializing");
         goto failed_opts;
     }
 
-    s->snap = g_strdup(snap);
-    s->image_name = g_strdup(image_name);
+    *s_snap = g_strdup(snap);
+    *s_image_name = g_strdup(image_name);
 
     /* try default location when conf=NULL, but ignore failure */
-    r = rados_conf_read_file(s->cluster, conf);
+    r = rados_conf_read_file(*cluster, conf);
     if (conf && r < 0) {
         error_setg_errno(errp, -r, "error reading conf file %s", conf);
         goto failed_shutdown;
     }
 
-    r = qemu_rbd_set_keypairs(s->cluster, keypairs, errp);
+    r = qemu_rbd_set_keypairs(*cluster, keypairs, errp);
     if (r < 0) {
         goto failed_shutdown;
     }
 
     if (mon_host) {
-        r = rados_conf_set(s->cluster, "mon_host", mon_host);
+        r = rados_conf_set(*cluster, "mon_host", mon_host);
         if (r < 0) {
             goto failed_shutdown;
         }
     }
 
-    if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
+    if (qemu_rbd_set_auth(*cluster, secretid, errp) < 0) {
         r = -EIO;
         goto failed_shutdown;
     }
@@ -642,24 +627,65 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
      * librbd defaults to no caching. If write through caching cannot
      * be set up, fall back to no caching.
      */
-    if (flags & BDRV_O_NOCACHE) {
-        rados_conf_set(s->cluster, "rbd_cache", "false");
+    if (cache) {
+        rados_conf_set(*cluster, "rbd_cache", "true");
     } else {
-        rados_conf_set(s->cluster, "rbd_cache", "true");
+        rados_conf_set(*cluster, "rbd_cache", "false");
     }
 
-    r = rados_connect(s->cluster);
+    r = rados_connect(*cluster);
     if (r < 0) {
         error_setg_errno(errp, -r, "error connecting");
         goto failed_shutdown;
     }
 
-    r = rados_ioctx_create(s->cluster, pool, &s->io_ctx);
+    r = rados_ioctx_create(*cluster, pool, io_ctx);
     if (r < 0) {
         error_setg_errno(errp, -r, "error opening pool %s", pool);
         goto failed_shutdown;
     }
 
+    qemu_opts_del(opts);
+    return 0;
+
+failed_shutdown:
+    rados_shutdown(*cluster);
+    g_free(*s_snap);
+    g_free(*s_image_name);
+failed_opts:
+    qemu_opts_del(opts);
+    g_free(mon_host);
+    return r;
+}
+
+static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
+                         Error **errp)
+{
+    BDRVRBDState *s = bs->opaque;
+    Error *local_err = NULL;
+    const char *filename;
+    int r;
+
+    /* If we are given a filename, parse the filename, with precedence given to
+     * filename encoded options */
+    filename = qdict_get_try_str(options, "filename");
+    if (filename) {
+        warn_report("'filename' option specified. "
+                    "This is an unsupported option, and may be deprecated "
+                    "in the future");
+        qemu_rbd_parse_filename(filename, options, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -EINVAL;
+        }
+    }
+
+    r = qemu_rbd_connect(&s->cluster, &s->io_ctx, &s->snap, &s->image_name,
+                         options, !(flags & BDRV_O_NOCACHE), errp);
+    if (r < 0) {
+        return r;
+    }
+
     /* rbd_open is always r/w */
     r = rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
     if (r < 0) {
@@ -684,19 +710,13 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    qemu_opts_del(opts);
     return 0;
 
 failed_open:
     rados_ioctx_destroy(s->io_ctx);
-failed_shutdown:
-    rados_shutdown(s->cluster);
     g_free(s->snap);
     g_free(s->image_name);
-failed_opts:
-    qemu_opts_del(opts);
-    g_free(mon_host);
-exit:
+    rados_shutdown(s->cluster);
     return r;
 }
 
-- 
2.13.6
