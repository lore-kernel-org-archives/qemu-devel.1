Received: from eggs.gnu.org ([2001:4830:134:3::10]:39179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4k-00073O-6z
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4h-0001pr-CS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:20 +0200
Message-Id: <20180515154033.19899-25-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/37] block: Add COR filter driver
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

From: Max Reitz <mreitz@redhat.com>

This adds a simple copy-on-read filter driver.  It relies on the already
existing COR functionality in the central block layer code, which may be
moved here once we no longer need it there.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180421132929.21610-2-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |   5 +-
 block/copy-on-read.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs  |   2 +-
 3 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 block/copy-on-read.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 17ffd44cce..55728cb823 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2510,11 +2510,12 @@
 # @vxhs: Since 2.10
 # @throttle: Since 2.11
 # @nvme: Since 2.12
+# @copy-on-read: Since 2.13
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
+  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'copy-on-read',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
@@ -3531,6 +3532,7 @@
       'blkverify':  'BlockdevOptionsBlkverify',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
+      'copy-on-read':'BlockdevOptionsGenericFormat',
       'dmg':        'BlockdevOptionsGenericFormat',
       'file':       'BlockdevOptionsFile',
       'ftp':        'BlockdevOptionsCurlFtp',
@@ -4058,6 +4060,7 @@
       'blkverify':      'BlockdevCreateNotSupported',
       'bochs':          'BlockdevCreateNotSupported',
       'cloop':          'BlockdevCreateNotSupported',
+      'copy-on-read':   'BlockdevCreateNotSupported',
       'dmg':            'BlockdevCreateNotSupported',
       'file':           'BlockdevCreateOptionsFile',
       'ftp':            'BlockdevCreateNotSupported',
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
new file mode 100644
index 0000000000..823ec751c4
--- /dev/null
+++ b/block/copy-on-read.c
@@ -0,0 +1,171 @@
+/*
+ * Copy-on-read filter block driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Author:
+ *   Max Reitz <mreitz@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+
+
+static int cor_open(BlockDriverState *bs, QDict *options, int flags,
+                    Error **errp)
+{
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
+                               errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    bs->supported_write_flags = BDRV_REQ_FUA &
+                                    bs->file->bs->supported_write_flags;
+
+    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
+                                    bs->file->bs->supported_zero_flags;
+
+    return 0;
+}
+
+
+static void cor_close(BlockDriverState *bs)
+{
+}
+
+
+#define PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
+                          | BLK_PERM_WRITE \
+                          | BLK_PERM_RESIZE)
+#define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
+
+static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
+                           const BdrvChildRole *role,
+                           BlockReopenQueue *reopen_queue,
+                           uint64_t perm, uint64_t shared,
+                           uint64_t *nperm, uint64_t *nshared)
+{
+    if (c == NULL) {
+        *nperm = (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANGED;
+        *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
+        return;
+    }
+
+    *nperm = (perm & PERM_PASSTHROUGH) |
+             (c->perm & PERM_UNCHANGED);
+    *nshared = (shared & PERM_PASSTHROUGH) |
+               (c->shared_perm & PERM_UNCHANGED);
+}
+
+
+static int64_t cor_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+
+static int cor_truncate(BlockDriverState *bs, int64_t offset,
+                        PreallocMode prealloc, Error **errp)
+{
+    return bdrv_truncate(bs->file, offset, prealloc, errp);
+}
+
+
+static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
+                                      uint64_t offset, uint64_t bytes,
+                                      QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov,
+                          flags | BDRV_REQ_COPY_ON_READ);
+}
+
+
+static int coroutine_fn cor_co_pwritev(BlockDriverState *bs,
+                                       uint64_t offset, uint64_t bytes,
+                                       QEMUIOVector *qiov, int flags)
+{
+
+    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+}
+
+
+static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
+                                             int64_t offset, int bytes,
+                                             BdrvRequestFlags flags)
+{
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+
+static int coroutine_fn cor_co_pdiscard(BlockDriverState *bs,
+                                        int64_t offset, int bytes)
+{
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+}
+
+
+static void cor_eject(BlockDriverState *bs, bool eject_flag)
+{
+    bdrv_eject(bs->file->bs, eject_flag);
+}
+
+
+static void cor_lock_medium(BlockDriverState *bs, bool locked)
+{
+    bdrv_lock_medium(bs->file->bs, locked);
+}
+
+
+static bool cor_recurse_is_first_non_filter(BlockDriverState *bs,
+                                            BlockDriverState *candidate)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+
+BlockDriver bdrv_copy_on_read = {
+    .format_name                        = "copy-on-read",
+
+    .bdrv_open                          = cor_open,
+    .bdrv_close                         = cor_close,
+    .bdrv_child_perm                    = cor_child_perm,
+
+    .bdrv_getlength                     = cor_getlength,
+    .bdrv_truncate                      = cor_truncate,
+
+    .bdrv_co_preadv                     = cor_co_preadv,
+    .bdrv_co_pwritev                    = cor_co_pwritev,
+    .bdrv_co_pwrite_zeroes              = cor_co_pwrite_zeroes,
+    .bdrv_co_pdiscard                   = cor_co_pdiscard,
+
+    .bdrv_eject                         = cor_eject,
+    .bdrv_lock_medium                   = cor_lock_medium,
+
+    .bdrv_co_block_status               = bdrv_co_block_status_from_file,
+
+    .bdrv_recurse_is_first_non_filter   = cor_recurse_is_first_non_filter,
+
+    .has_variable_length                = true,
+    .is_filter                          = true,
+};
+
+static void bdrv_copy_on_read_init(void)
+{
+    bdrv_register(&bdrv_copy_on_read);
+}
+
+block_init(bdrv_copy_on_read_init);
diff --git a/block/Makefile.objs b/block/Makefile.objs
index d644bac60a..899bfb5e2c 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -26,7 +26,7 @@ block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
 block-obj-y += backup.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
-block-obj-y += throttle.o
+block-obj-y += throttle.o copy-on-read.o
 
 block-obj-y += crypto.o
 
-- 
2.13.6
