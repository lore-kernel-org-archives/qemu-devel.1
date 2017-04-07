Received: from eggs.gnu.org ([2001:4830:134:3::10]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavP-0006FP-6I
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cwavK-0003Wn-BL
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 16:56:07 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri,  7 Apr 2017 16:55:31 -0400
Message-Id: <b7ec1fb2e1cf36f9b6911631447a5b0422590b7d.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
In-Reply-To: <cover.1491597120.git.jcody@redhat.com>
References: <cover.1491597120.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 7/8] block/rbd - update variable
 names to more apt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, eblake@redhat.com

Update 'clientname' to be 'user', which tracks better with both
the QAPI and rados variable naming.

Update 'name' to be 'image_name', as it indicates the rbd image.
Naming it 'image' would have been ideal, but we are using that for
the rados_image_t value returned by rbd_open().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 1c43171..35853c9 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -94,7 +94,7 @@ typedef struct BDRVRBDState {
     rados_t cluster;
     rados_ioctx_t io_ctx;
     rbd_image_t image;
-    char *name;
+    char *image_name;
     char *snap;
 } BDRVRBDState;
 
@@ -350,7 +350,7 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     int64_t bytes = 0;
     int64_t objsize;
     int obj_order = 0;
-    const char *pool, *name, *conf, *clientname, *keypairs;
+    const char *pool, *image_name, *conf, *user, *keypairs;
     const char *secretid;
     rados_t cluster;
     rados_ioctx_t io_ctx;
@@ -393,11 +393,11 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
      */
     pool       = qdict_get_try_str(options, "pool");
     conf       = qdict_get_try_str(options, "conf");
-    clientname = qdict_get_try_str(options, "user");
-    name       = qdict_get_try_str(options, "image");
+    user       = qdict_get_try_str(options, "user");
+    image_name = qdict_get_try_str(options, "image");
     keypairs   = qdict_get_try_str(options, "=keyvalue-pairs");
 
-    ret = rados_create(&cluster, clientname);
+    ret = rados_create(&cluster, user);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error initializing");
         goto exit;
@@ -434,7 +434,7 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
         goto shutdown;
     }
 
-    ret = rbd_create(io_ctx, name, bytes, &obj_order);
+    ret = rbd_create(io_ctx, image_name, bytes, &obj_order);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error rbd create");
     }
@@ -540,7 +540,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
-    const char *pool, *snap, *conf, *clientname, *name, *keypairs;
+    const char *pool, *snap, *conf, *user, *image_name, *keypairs;
     const char *secretid;
     QemuOpts *opts;
     Error *local_err = NULL;
@@ -567,24 +567,24 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     pool           = qemu_opt_get(opts, "pool");
     conf           = qemu_opt_get(opts, "conf");
     snap           = qemu_opt_get(opts, "snapshot");
-    clientname     = qemu_opt_get(opts, "user");
-    name           = qemu_opt_get(opts, "image");
+    user           = qemu_opt_get(opts, "user");
+    image_name     = qemu_opt_get(opts, "image");
     keypairs       = qemu_opt_get(opts, "=keyvalue-pairs");
 
-    if (!pool || !name) {
+    if (!pool || !image_name) {
         error_setg(errp, "Parameters 'pool' and 'image' are required");
         r = -EINVAL;
         goto failed_opts;
     }
 
-    r = rados_create(&s->cluster, clientname);
+    r = rados_create(&s->cluster, user);
     if (r < 0) {
         error_setg_errno(errp, -r, "error initializing");
         goto failed_opts;
     }
 
     s->snap = g_strdup(snap);
-    s->name = g_strdup(name);
+    s->image_name = g_strdup(image_name);
 
     /* try default location when conf=NULL, but ignore failure */
     r = rados_conf_read_file(s->cluster, conf);
@@ -636,9 +636,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* rbd_open is always r/w */
-    r = rbd_open(s->io_ctx, s->name, &s->image, s->snap);
+    r = rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
     if (r < 0) {
-        error_setg_errno(errp, -r, "error reading header from %s", s->name);
+        error_setg_errno(errp, -r, "error reading header from %s",
+                         s->image_name);
         goto failed_open;
     }
 
@@ -660,7 +661,7 @@ failed_open:
 failed_shutdown:
     rados_shutdown(s->cluster);
     g_free(s->snap);
-    g_free(s->name);
+    g_free(s->image_name);
 failed_opts:
     qemu_opts_del(opts);
     g_free(mon_host);
@@ -674,7 +675,7 @@ static void qemu_rbd_close(BlockDriverState *bs)
     rbd_close(s->image);
     rados_ioctx_destroy(s->io_ctx);
     g_free(s->snap);
-    g_free(s->name);
+    g_free(s->image_name);
     rados_shutdown(s->cluster);
 }
 
-- 
2.9.3
