Received: from eggs.gnu.org ([2001:4830:134:3::10]:33915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlA-0001Ju-Eo
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl7-0007Aj-9n
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:12 +0100
Message-Id: <20180309161933.8168-36-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 35/56] rbd: Remove non-schema options from
 runtime_opts
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

Instead of the QemuOpts in qemu_rbd_connect(), we want to use QAPI
objects. As a preparation, fetch those options directly from the QDict
that .bdrv_open() supports in the rbd driver and that are not in the
schema.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/rbd.c | 55 ++++++++++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 99fcc7ecdf..a979107f65 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -326,28 +326,6 @@ static QemuOptsList runtime_opts = {
         /*
          * server.* extracted manually, see qemu_rbd_mon_host()
          */
-        {
-            .name = "password-secret",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of secret providing the password",
-        },
-
-        /*
-         * Keys for qemu_rbd_parse_filename(), not in the QAPI schema
-         */
-        {
-            /*
-             * HACK: name starts with '=' so that qemu_opts_parse()
-             * can't set it
-             */
-            .name = "=keyvalue-pairs",
-            .type = QEMU_OPT_STRING,
-            .help = "Legacy rados key/value option parameters",
-        },
-        {
-            .name = "filename",
-            .type = QEMU_OPT_STRING,
-        },
         { /* end of list */ }
     },
 };
@@ -548,12 +526,13 @@ out:
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
                             char **s_snap, char **s_image_name,
-                            QDict *options, bool cache, Error **errp)
+                            QDict *options, bool cache,
+                            const char *keypairs, const char *secretid,
+                            Error **errp)
 {
     QemuOpts *opts;
     char *mon_host = NULL;
-    const char *pool, *snap, *conf, *user, *image_name, *keypairs;
-    const char *secretid;
+    const char *pool, *snap, *conf, *user, *image_name;
     Error *local_err = NULL;
     int r;
 
@@ -572,14 +551,11 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
         goto failed_opts;
     }
 
-    secretid = qemu_opt_get(opts, "password-secret");
-
     pool           = qemu_opt_get(opts, "pool");
     conf           = qemu_opt_get(opts, "conf");
     snap           = qemu_opt_get(opts, "snapshot");
     user           = qemu_opt_get(opts, "user");
     image_name     = qemu_opt_get(opts, "image");
-    keypairs       = qemu_opt_get(opts, "=keyvalue-pairs");
 
     if (!pool || !image_name) {
         error_setg(errp, "Parameters 'pool' and 'image' are required");
@@ -664,6 +640,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRBDState *s = bs->opaque;
     Error *local_err = NULL;
     const char *filename;
+    char *keypairs, *secretid;
     int r;
 
     /* If we are given a filename, parse the filename, with precedence given to
@@ -674,16 +651,28 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                     "This is an unsupported option, and may be deprecated "
                     "in the future");
         qemu_rbd_parse_filename(filename, options, &local_err);
+        qdict_del(options, "filename");
         if (local_err) {
             error_propagate(errp, local_err);
             return -EINVAL;
         }
     }
 
+    keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
+    if (keypairs) {
+        qdict_del(options, "=keyvalue-pairs");
+    }
+
+    secretid = g_strdup(qdict_get_try_str(options, "password-secret"));
+    if (secretid) {
+        qdict_del(options, "password-secret");
+    }
+
     r = qemu_rbd_connect(&s->cluster, &s->io_ctx, &s->snap, &s->image_name,
-                         options, !(flags & BDRV_O_NOCACHE), errp);
+                         options, !(flags & BDRV_O_NOCACHE), keypairs, secretid,
+                         errp);
     if (r < 0) {
-        return r;
+        goto out;
     }
 
     /* rbd_open is always r/w */
@@ -710,13 +699,17 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    return 0;
+    r = 0;
+    goto out;
 
 failed_open:
     rados_ioctx_destroy(s->io_ctx);
     g_free(s->snap);
     g_free(s->image_name);
     rados_shutdown(s->cluster);
+out:
+    g_free(keypairs);
+    g_free(secretid);
     return r;
 }
 
-- 
2.13.6
