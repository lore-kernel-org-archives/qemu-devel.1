Received: from eggs.gnu.org ([2001:4830:134:3::10]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzI-0000tO-OT
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIzH-0004bg-DV
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:27 +0100
Message-Id: <20180223192549.26666-15-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-1-kwolf@redhat.com>
References: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/36] block: x-blockdev-create QMP command
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

This adds a synchronous x-blockdev-create QMP command that can create
qcow2 images on a given node name.

We don't want to block while creating an image, so this is not the final
interface in all aspects, but BlockdevCreateOptionsQcow2 and
.bdrv_co_create() are what they actually might look like in the end. In
any case, this should be good enough to test whether we interpret
BlockdevCreateOptions as we should.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json      | 12 ++++++++
 include/block/block_int.h |  2 ++
 block/create.c            | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c             |  3 +-
 block/Makefile.objs       |  2 +-
 5 files changed, 93 insertions(+), 2 deletions(-)
 create mode 100644 block/create.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 74b864d64e..359195a1a3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3464,6 +3464,18 @@
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
index 5ae7738cf8..0b43fae782 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -128,6 +128,8 @@ struct BlockDriver {
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
+    int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
+                                       Error **errp);
     int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **errp);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
diff --git a/block/create.c b/block/create.c
new file mode 100644
index 0000000000..dfd31eca37
--- /dev/null
+++ b/block/create.c
@@ -0,0 +1,76 @@
+/*
+ * Block layer code related to image creation
+ *
+ * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+#include "qmp-commands.h"
+#include "qapi/error.h"
+
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
+    BlockDriver *drv = bdrv_find_format(fmt);
+    Coroutine *co;
+    BlockdevCreateCo cco;
+
+    /* If the driver is in the schema, we know that it exists. But it may not
+     * be whitelisted. */
+    assert(drv);
+    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
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
+        .ret = -EINPROGRESS,
+        .errp = errp,
+    };
+
+    co = qemu_coroutine_create(bdrv_co_create_co_entry, &cco);
+    qemu_coroutine_enter(co);
+    while (cco.ret == -EINPROGRESS) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 58737d0833..8acb36b0af 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4463,7 +4463,8 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_reopen_abort    = qcow2_reopen_abort,
     .bdrv_join_options    = qcow2_join_options,
     .bdrv_child_perm      = bdrv_format_default_perms,
-    .bdrv_create        = qcow2_create,
+    .bdrv_create          = qcow2_create,
+    .bdrv_co_create       = qcow2_create2,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_block_status = qcow2_co_block_status,
 
diff --git a/block/Makefile.objs b/block/Makefile.objs
index aede94f105..d644bac60a 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -9,7 +9,7 @@ block-obj-y += block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) += file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
-block-obj-y += null.o mirror.o commit.o io.o
+block-obj-y += null.o mirror.o commit.o io.o create.o
 block-obj-y += throttle-groups.o
 block-obj-$(CONFIG_LINUX) += nvme.o
 
-- 
2.13.6
