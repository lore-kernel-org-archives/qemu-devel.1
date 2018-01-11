Received: from eggs.gnu.org ([2001:4830:134:3::10]:58412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZivE-0005z9-9r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZivD-00015a-7f
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:25 +0100
Message-Id: <20180111195225.4226-11-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 10/10] block: x-blockdev-create QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This adds a synchronous x-blockdev-create QMP command that can create
qcow2 images on a given node name.

We don't want to block while creating an image, so this is not the final
interface in all aspects, but BlockdevCreateOptionsQcow2 and
.bdrv_co_create() are what they actually might look like in the end. In
any case, this should be good enough to test whether we interpret
BlockdevCreateOptions as we should.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json      | 12 ++++++++++++
 include/block/block_int.h |  2 ++
 block.c                   | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c             |  3 ++-
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9341f6708d..93357a4d5d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3415,6 +3415,18 @@
   } }
 
 ##
+# @x-blockdev-create:
+#
+# Create an image format on a given node.
+# TODO Replace with something asynchronous (block job?)
+#
+# Since: 2.12
+##
+{ 'command': 'x-blockdev-create',
+  'data': 'BlockdevCreateOptions',
+  'boxed': true }
+
+##
 # @blockdev-open-tray:
 #
 # Opens a block device's tray. If there is a block driver state tree inserted as
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4236..a9f144d7bd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -130,6 +130,8 @@ struct BlockDriver {
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
+    int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
+                                       Error **errp);
     int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **errp);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
diff --git a/block.c b/block.c
index c9b0e1d6d3..7521884de8 100644
--- a/block.c
+++ b/block.c
@@ -485,6 +485,54 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+typedef struct BlockdevCreateCo {
+    BlockDriver *drv;
+    BlockdevCreateOptions *opts;
+    int ret;
+    Error **errp;
+} BlockdevCreateCo;
+
+static void coroutine_fn bdrv_co_create_co_entry(void *opaque)
+{
+    BlockdevCreateCo *cco = opaque;
+    cco->ret = cco->drv->bdrv_co_create(cco->opts, cco->errp);
+}
+
+void qmp_x_blockdev_create(BlockdevCreateOptions *options, Error **errp)
+{
+    const char *fmt = BlockdevDriver_str(options->driver);
+    BlockDriver* drv = bdrv_find_format(fmt);
+    Coroutine *co;
+    BlockdevCreateCo cco;
+
+    /* If the driver is in the schema, we know that it exists. But it may not
+     * be whitelisted. */
+    assert(drv);
+    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, true)) {
+        error_setg(errp, "Driver is not whitelisted");
+        return;
+    }
+
+    /* Call callback if it exists */
+    if (!drv->bdrv_co_create) {
+        error_setg(errp, "Driver does not support blockdev-create");
+        return;
+    }
+
+    cco = (BlockdevCreateCo) {
+        .drv = drv,
+        .opts = options,
+        .ret = NOT_DONE,
+        .errp = errp,
+    };
+
+    co = qemu_coroutine_create(bdrv_co_create_co_entry, &cco);
+    qemu_coroutine_enter(co);
+    while (cco.ret == NOT_DONE) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/block/qcow2.c b/block/qcow2.c
index 4031a18a77..5c5386e0b6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4436,7 +4436,8 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_reopen_abort    = qcow2_reopen_abort,
     .bdrv_join_options    = qcow2_join_options,
     .bdrv_child_perm      = bdrv_format_default_perms,
-    .bdrv_create        = qcow2_create,
+    .bdrv_create          = qcow2_create,
+    .bdrv_co_create       = qcow2_create2,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = qcow2_co_get_block_status,
 
-- 
2.13.6
