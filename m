Received: from eggs.gnu.org ([2001:4830:134:3::10]:60489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87T8-0007SS-LB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f87T7-0003FJ-5h
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:59:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Apr 2018 18:58:41 +0200
Message-Id: <20180416165849.28864-2-mreitz@redhat.com>
In-Reply-To: <20180416165849.28864-1-mreitz@redhat.com>
References: <20180416165849.28864-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This adds a simple copy-on-read filter driver.  It relies on the already
existing COR functionality in the central block layer code, which may be
moved here once we no longer need it there.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs  |   2 +-
 qapi/block-core.json |   5 +-
 block/cor.c          | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 block/cor.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index d644bac60a..6fdf786c04 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -26,7 +26,7 @@ block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
 block-obj-y += backup.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
-block-obj-y += throttle.o
+block-obj-y += throttle.o cor.o
 
 block-obj-y += crypto.o
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517bff3..3abbf4fcf1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2506,11 +2506,12 @@
 # @vxhs: Since 2.10
 # @throttle: Since 2.11
 # @nvme: Since 2.12
+# @cor: Since 2.13
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
+  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'cor',
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
@@ -3522,6 +3523,7 @@
       'blkverify':  'BlockdevOptionsBlkverify',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
+      'cor':        'BlockdevOptionsGenericFormat',
       'dmg':        'BlockdevOptionsGenericFormat',
       'file':       'BlockdevOptionsFile',
       'ftp':        'BlockdevOptionsCurlFtp',
@@ -4049,6 +4051,7 @@
       'blkverify':      'BlockdevCreateNotSupported',
       'bochs':          'BlockdevCreateNotSupported',
       'cloop':          'BlockdevCreateNotSupported',
+      'cor':            'BlockdevCreateNotSupported',
       'dmg':            'BlockdevCreateNotSupported',
       'file':           'BlockdevCreateOptionsFile',
       'ftp':            'BlockdevCreateNotSupported',
diff --git a/block/cor.c b/block/cor.c
new file mode 100644
index 0000000000..a4cb4e2b84
--- /dev/null
+++ b/block/cor.c
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
+BlockDriver bdrv_cor = {
+    .format_name                        = "cor",
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
+static void bdrv_cor_init(void)
+{
+    bdrv_register(&bdrv_cor);
+}
+
+block_init(bdrv_cor_init);
-- 
2.14.3
