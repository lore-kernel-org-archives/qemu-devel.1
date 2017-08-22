Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dk6GJ-0000bp-CS
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dk6GH-0003Xc-Fw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:18:19 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 22 Aug 2017 13:15:34 +0300
Message-Id: <20170822101535.4695-6-el13635@mail.ntua.gr>
In-Reply-To: <20170822101535.4695-1-el13635@mail.ntua.gr>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v7 5/6] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

block/throttle.c uses existing I/O throttle infrastructure inside a
block filter driver. I/O operations are intercepted in the filter's
read/write coroutines, and referred to block/throttle-groups.c

The driver can be used with the syntax
-drive driver=throttle,file.filename=foo.qcow2,throttle-group=bar

which registers the throttle filter node with the ThrottleGroup 'bar'. The
given group must be created beforehand with object-add or -object.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 qapi/block-core.json            |  18 ++-
 include/block/throttle-groups.h |   1 +
 include/qemu/throttle-options.h |   1 +
 block/throttle-groups.c         |   7 +-
 block/throttle.c                | 250 ++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs             |   1 +
 6 files changed, 276 insertions(+), 2 deletions(-)
 create mode 100644 block/throttle.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0bdc69aa5f..405c181954 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2222,6 +2222,7 @@
 # Drivers that are supported in block device operations.
 #
 # @vxhs: Since 2.10
+# @throttle: Since 2.11
 #
 # Since: 2.9
 ##
@@ -2231,7 +2232,7 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3095,6 +3096,20 @@
             '*tls-creds': 'str' } }
 
 ##
+# @BlockdevOptionsThrottle:
+#
+# Driver specific block device options for the throttle driver
+#
+# @throttle-group:   the name of the throttle-group object to use. It
+#                    must already exist.
+# @file:             reference to or definition of the data source block device
+# Since: 2.11
+##
+{ 'struct': 'BlockdevOptionsThrottle',
+  'data': { '*throttle-group': 'str',
+            'file' : 'BlockdevRef'
+             } }
+##
 # @BlockdevOptions:
 #
 # Options for creating a block device.  Many options are available for all
@@ -3155,6 +3170,7 @@
       'replication':'BlockdevOptionsReplication',
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
+      'throttle':   'BlockdevOptionsThrottle',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 82f030523f..ec969e84fe 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -76,5 +76,6 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
 void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
                                        AioContext *new_context);
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
+bool throttle_group_exists(const char *name);
 
 #endif
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 182b7896e1..3528a8f4a2 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -29,6 +29,7 @@
 #define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
 #define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
 #define QEMU_OPT_IOPS_SIZE "iops-size"
+#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"
 
 #define THROTTLE_OPT_PREFIX "throttling."
 #define THROTTLE_OPTS \
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a4268a954e..4b483a16d4 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -101,7 +101,7 @@ static ThrottleGroup *throttle_group_by_name(const char *name)
     return NULL;
 }
 
-static bool throttle_group_exists(const char *name)
+bool throttle_group_exists(const char *name)
 {
     return throttle_group_by_name(name) ? true : false;
 }
@@ -548,6 +548,11 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
     ThrottleGroupMember *token;
     int i;
 
+    if (!ts) {
+        /* Discard uninitialized tgm */
+        return;
+    }
+
     assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
     assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
     assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
diff --git a/block/throttle.c b/block/throttle.c
new file mode 100644
index 0000000000..910de27dcd
--- /dev/null
+++ b/block/throttle.c
@@ -0,0 +1,250 @@
+/*
+ * QEMU block throttling filter driver infrastructure
+ *
+ * Copyright (c) 2017 Manos Pitsidianakis
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
+#include "block/throttle-groups.h"
+#include "qemu/throttle-options.h"
+#include "qapi/error.h"
+
+static QemuOptsList throttle_opts = {
+    .name = "throttle",
+    .head = QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
+    .desc = {
+        {
+            .name = QEMU_OPT_THROTTLE_GROUP_NAME,
+            .type = QEMU_OPT_STRING,
+            .help = "Name of the throttle group",
+        },
+        { /* end of list */ }
+    },
+};
+
+static int throttle_configure_tgm(BlockDriverState *bs,
+                                  ThrottleGroupMember *tgm,
+                                  QDict *options, Error **errp)
+{
+    int ret;
+    const char *group_name;
+    Error *local_err = NULL;
+    QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &error_abort);
+
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fin;
+    }
+
+    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
+    if (!group_name) {
+        error_setg(errp, "Please specify a throttle group.");
+        ret = EINVAL;
+        goto fin;
+    } else if (!throttle_group_exists(group_name)) {
+        error_setg(errp, "Throttle group '%s' does not exist.", group_name);
+        ret = EINVAL;
+        goto fin;
+    }
+
+    /* Register membership to group with name group_name */
+    throttle_group_register_tgm(tgm, group_name, bdrv_get_aio_context(bs));
+    ret = 0;
+fin:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static int throttle_open(BlockDriverState *bs, QDict *options,
+                         int flags, Error **errp)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+
+    bs->file = bdrv_open_child(NULL, options, "file",
+                               bs, &child_file, false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+    bs->supported_write_flags = bs->file->bs->supported_write_flags;
+    bs->supported_zero_flags = bs->file->bs->supported_zero_flags;
+
+    return throttle_configure_tgm(bs, tgm, options, errp);
+}
+
+static void throttle_close(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_unregister_tgm(tgm);
+}
+
+
+static int64_t throttle_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
+                                           uint64_t offset, uint64_t bytes,
+                                           QEMUIOVector *qiov, int flags)
+{
+
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, false);
+
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
+                                            uint64_t offset, uint64_t bytes,
+                                            QEMUIOVector *qiov, int flags)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
+                                                  int64_t offset, int bytes,
+                                                  BdrvRequestFlags flags)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
+                                             int64_t offset, int bytes)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+}
+
+static int throttle_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static void throttle_detach_aio_context(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_detach_aio_context(tgm);
+}
+
+static void throttle_attach_aio_context(BlockDriverState *bs,
+                                        AioContext *new_context)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_attach_aio_context(tgm, new_context);
+}
+
+static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
+                                   BlockReopenQueue *queue, Error **errp)
+{
+    ThrottleGroupMember *tgm;
+
+    assert(reopen_state != NULL);
+    assert(reopen_state->bs != NULL);
+
+    reopen_state->opaque = g_new0(ThrottleGroupMember, 1);
+    tgm = reopen_state->opaque;
+
+    return throttle_configure_tgm(reopen_state->bs, tgm, reopen_state->options,
+            errp);
+}
+
+static void throttle_reopen_commit(BDRVReopenState *reopen_state)
+{
+    ThrottleGroupMember *old_tgm = reopen_state->bs->opaque;
+    ThrottleGroupMember *new_tgm = reopen_state->opaque;
+
+    throttle_group_unregister_tgm(old_tgm);
+    g_free(old_tgm);
+    reopen_state->bs->opaque = new_tgm;
+    reopen_state->opaque = NULL;
+}
+
+static void throttle_reopen_abort(BDRVReopenState *reopen_state)
+{
+    ThrottleGroupMember *tgm = reopen_state->opaque;
+
+    throttle_group_unregister_tgm(tgm);
+    g_free(tgm);
+    reopen_state->opaque = NULL;
+}
+
+static bool throttle_recurse_is_first_non_filter(BlockDriverState *bs,
+                                                 BlockDriverState *candidate)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+static int64_t coroutine_fn throttle_co_get_block_status(BlockDriverState *bs,
+                                                         int64_t sector_num,
+                                                         int nb_sectors,
+                                                         int *pnum,
+                                                         BlockDriverState **file)
+{
+    assert(bs->file && bs->file->bs);
+    *pnum = nb_sectors;
+    *file = bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
+static BlockDriver bdrv_throttle = {
+    .format_name                        =   "throttle",
+    .protocol_name                      =   "throttle",
+    .instance_size                      =   sizeof(ThrottleGroupMember),
+
+    .bdrv_file_open                     =   throttle_open,
+    .bdrv_close                         =   throttle_close,
+    .bdrv_co_flush                      =   throttle_co_flush,
+
+    .bdrv_child_perm                    =   bdrv_filter_default_perms,
+
+    .bdrv_getlength                     =   throttle_getlength,
+
+    .bdrv_co_preadv                     =   throttle_co_preadv,
+    .bdrv_co_pwritev                    =   throttle_co_pwritev,
+
+    .bdrv_co_pwrite_zeroes              =   throttle_co_pwrite_zeroes,
+    .bdrv_co_pdiscard                   =   throttle_co_pdiscard,
+
+    .bdrv_recurse_is_first_non_filter   =   throttle_recurse_is_first_non_filter,
+
+    .bdrv_attach_aio_context            =   throttle_attach_aio_context,
+    .bdrv_detach_aio_context            =   throttle_detach_aio_context,
+
+    .bdrv_reopen_prepare                =   throttle_reopen_prepare,
+    .bdrv_reopen_commit                 =   throttle_reopen_commit,
+    .bdrv_reopen_abort                  =   throttle_reopen_abort,
+    .bdrv_co_get_block_status           =   throttle_co_get_block_status,
+
+    .is_filter                          =   true,
+};
+
+static void bdrv_throttle_init(void)
+{
+    bdrv_register(&bdrv_throttle);
+}
+
+block_init(bdrv_throttle_init);
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 2aaede4ae1..6eaf78a046 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -25,6 +25,7 @@ block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
 block-obj-y += backup.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
+block-obj-y += throttle.o
 
 block-obj-y += crypto.o
 
-- 
2.11.0
