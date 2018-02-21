Received: from eggs.gnu.org ([2001:4830:134:3::10]:38399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrj-0001Go-Mf
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUri-00031a-Hv
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:55:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:52 +0100
Message-Id: <20180221135404.27598-25-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-1-kwolf@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/36] rbd: Use qemu_rbd_connect() in
 qemu_rbd_do_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is almost exactly the same code. The differences are that
qemu_rbd_connect() supports BlockdevOptionsRbd.server and that the cache
mode is set explicitly.

Supporting 'server' is a welcome new feature for image creation.
Caching is disabled by default, so leave it that way.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 54 ++++++++++--------------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a34bf0be46..af8e186106 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -103,6 +103,11 @@ typedef struct BDRVRBDState {
     char *snap;
 } BDRVRBDState;
 
+static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
+                            BlockdevOptionsRbd *opts, bool cache,
+                            const char *keypairs, const char *secretid,
+                            Error **errp);
+
 static char *qemu_rbd_next_tok(char *src, char delim, char **p)
 {
     char *end;
@@ -351,12 +356,6 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
         return -EINVAL;
     }
 
-    /* TODO Remove the limitation */
-    if (opts->location->has_server) {
-        error_setg(errp, "Can't specify server for image creation");
-        return -EINVAL;
-    }
-
     if (opts->has_cluster_size) {
         int64_t objsize = opts->cluster_size;
         if ((objsize - 1) & objsize) {    /* not a power of 2? */
@@ -370,54 +369,21 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
         obj_order = ctz32(objsize);
     }
 
-    ret = rados_create(&cluster, opts->location->user);
+    ret = qemu_rbd_connect(&cluster, &io_ctx, opts->location, false, keypairs,
+                           NULL, errp);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "error initializing");
         return ret;
     }
 
-    /* try default location when conf=NULL, but ignore failure */
-    ret = rados_conf_read_file(cluster, opts->location->conf);
-    if (opts->location->conf && ret < 0) {
-        error_setg_errno(errp, -ret, "error reading conf file %s",
-                         opts->location->conf);
-        ret = -EIO;
-        goto shutdown;
-    }
-
-    ret = qemu_rbd_set_keypairs(cluster, keypairs, errp);
-    if (ret < 0) {
-        ret = -EIO;
-        goto shutdown;
-    }
-
-    if (qemu_rbd_set_auth(cluster, password_secret, errp) < 0) {
-        ret = -EIO;
-        goto shutdown;
-    }
-
-    ret = rados_connect(cluster);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "error connecting");
-        goto shutdown;
-    }
-
-    ret = rados_ioctx_create(cluster, opts->location->pool, &io_ctx);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "error opening pool %s",
-                         opts->location->pool);
-        goto shutdown;
-    }
-
     ret = rbd_create(io_ctx, opts->location->image, opts->size, &obj_order);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error rbd create");
+        goto out;
     }
 
-    rados_ioctx_destroy(io_ctx);
-
     ret = 0;
-shutdown:
+out:
+    rados_ioctx_destroy(io_ctx);
     rados_shutdown(cluster);
     return ret;
 }
-- 
2.13.6
