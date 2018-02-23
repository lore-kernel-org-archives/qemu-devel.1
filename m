Received: from eggs.gnu.org ([2001:4830:134:3::10]:50327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzU-000142-LM
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzT-0004wo-QF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:36 +0100
Message-Id: <20180223192549.26666-24-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-1-kwolf@redhat.com>
References: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 23/36] rbd: Assign s->snap/image_name in
 qemu_rbd_open()
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

Now that the options are already available in qemu_rbd_open() and not
only parsed in qemu_rbd_connect(), we can assign s->snap and
s->image_name there instead of passing the fields by reference to
qemu_rbd_connect().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/rbd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ee71dc8941..300a304ec3 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -571,7 +571,6 @@ static char *qemu_rbd_mon_host(BlockdevOptionsRbd *opts, Error **errp)
 }
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
-                            char **s_snap, char **s_image_name,
                             BlockdevOptionsRbd *opts, bool cache,
                             const char *keypairs, const char *secretid,
                             Error **errp)
@@ -593,9 +592,6 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
         goto failed_opts;
     }
 
-    *s_snap = g_strdup(opts->snapshot);
-    *s_image_name = g_strdup(opts->image);
-
     /* try default location when conf=NULL, but ignore failure */
     r = rados_conf_read_file(*cluster, opts->conf);
     if (opts->has_conf && r < 0) {
@@ -649,8 +645,6 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
 
 failed_shutdown:
     rados_shutdown(*cluster);
-    g_free(*s_snap);
-    g_free(*s_image_name);
 failed_opts:
     g_free(mon_host);
     return r;
@@ -711,13 +705,15 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    r = qemu_rbd_connect(&s->cluster, &s->io_ctx, &s->snap, &s->image_name,
-                         opts, !(flags & BDRV_O_NOCACHE), keypairs, secretid,
-                         errp);
+    r = qemu_rbd_connect(&s->cluster, &s->io_ctx, opts,
+                         !(flags & BDRV_O_NOCACHE), keypairs, secretid, errp);
     if (r < 0) {
         goto out;
     }
 
+    s->snap = g_strdup(opts->snapshot);
+    s->image_name = g_strdup(opts->image);
+
     /* rbd_open is always r/w */
     r = rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
     if (r < 0) {
-- 
2.13.6
