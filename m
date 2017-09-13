Received: from eggs.gnu.org ([2001:4830:134:3::10]:44077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dsAn9-0007vV-Bp
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <awolfegordon@digitalocean.com>) id 1dsAn6-0004qZ-5s
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:35 -0400
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:49059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <awolfegordon@digitalocean.com>)
	id 1dsAn6-0004pO-0c
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:32 -0400
Received: by mail-it0-x234.google.com with SMTP id c195so4453717itb.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:45:30 -0700 (PDT)
From: Adam Wolfe Gordon <awg@digitalocean.com>
Date: Wed, 13 Sep 2017 10:44:24 -0600
Message-Id: <20170913164424.32129-1-awg@digitalocean.com>
Subject: [Qemu-devel] [PATCH] rbd: Detect rbd image resizes and propagate
 them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Adam Wolfe Gordon <awg@digitalocean.com>, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Register a watcher with rbd so that we get notified when an image is
resized. Propagate resizes to parent block devices so that guest devices
get resized without user intervention.

Signed-off-by: Adam Wolfe Gordon <awg@digitalocean.com>
---
Hello!

We are using this patch in production at DigitalOcean and have tested it fairly
extensively. However, we use the same block device configuration everywhere, so
I'd be interested to get an answer to the question I've left in the code:

> /* NOTE: This assumes there's only one layer between us and the
>    block-backend. Is this always true? */

If that isn't true, this patch will need a bit of work to traverse up the block
device tree and find the block-backend.

Of course, any other feedback would be welcome too - this is my first foray into
the qemu code.

Regards,
Adam

 block/rbd.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 144f350e1f..1c9fcbec1f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -96,6 +96,8 @@ typedef struct BDRVRBDState {
     rbd_image_t image;
     char *image_name;
     char *snap;
+    uint64_t watcher_handle;
+    uint64_t size_bytes;
 } BDRVRBDState;
 
 static char *qemu_rbd_next_tok(char *src, char delim, char **p)
@@ -540,6 +542,67 @@ out:
     return rados_str;
 }
 
+/* BH for when rbd notifies us of an update. */
+static void qemu_rbd_update_bh(void *arg)
+{
+    BlockDriverState *parent, *bs = arg;
+    BDRVRBDState *s = bs->opaque;
+    bool was_variable_length;
+    uint64_t new_size_bytes;
+    int64_t new_parent_len;
+    BdrvChild *c;
+    int r;
+
+    r = rbd_get_size(s->image, &new_size_bytes);
+    if (r < 0) {
+        error_report("error reading size for %s: %s", s->name, strerror(-r));
+        return;
+    }
+
+    /* Avoid no-op resizes on non-resize notifications. */
+    if (new_size_bytes == s->size_bytes) {
+        error_printf("skipping non-resize rbd cb\n");
+        return;
+    }
+
+    /* NOTE: This assumes there's only one layer between us and the
+       block-backend. Is this always true? */
+    parent = bs->inherits_from;
+    if (parent == NULL) {
+        error_report("bs %s does not have parent", bdrv_get_device_or_node_name(bs));
+        return;
+    }
+
+    /* Force parents to re-read our size. */
+    was_variable_length = bs->drv->has_variable_length;
+    bs->drv->has_variable_length = true;
+    new_parent_len = bdrv_getlength(parent);
+    if (new_parent_len < 0) {
+        error_report("getlength failed on parent %s", bdrv_get_device_or_node_name(parent));
+        bs->drv->has_variable_length = was_variable_length;
+        return;
+    }
+    bs->drv->has_variable_length = was_variable_length;
+
+    /* Notify block backends that that we have resized.
+       Copied from bdrv_parent_cb_resize. */
+    QLIST_FOREACH(c, &parent->parents, next_parent) {
+        if (c->role->resize) {
+            c->role->resize(c);
+        }
+    }
+
+    s->size_bytes = new_size_bytes;
+}
+
+/* Called from non-qemu thread - careful! */
+static void qemu_rbd_update_cb(void *arg)
+{
+    BlockDriverState *bs = arg;
+
+    aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), qemu_rbd_update_bh, bs);
+}
+
 static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
@@ -672,9 +735,25 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    r = rbd_update_watch(s->image, &s->watcher_handle, qemu_rbd_update_cb, bs);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "error registering watcher on %s", s->name);
+        goto failed_watch;
+    }
+
+    r = rbd_get_size(s->image, &s->size_bytes);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "error reading size for %s", s->name);
+        goto failed_sz;
+    }
+
     qemu_opts_del(opts);
     return 0;
 
+failed_sz:
+    rbd_update_unwatch(s->image, s->watcher_handle);
+failed_watch:
+    rbd_close(s->image);
 failed_open:
     rados_ioctx_destroy(s->io_ctx);
 failed_shutdown:
@@ -712,6 +791,7 @@ static void qemu_rbd_close(BlockDriverState *bs)
 {
     BDRVRBDState *s = bs->opaque;
 
+    rbd_update_unwatch(s->image, s->watcher_handle);
     rbd_close(s->image);
     rados_ioctx_destroy(s->io_ctx);
     g_free(s->snap);
-- 
2.14.1
