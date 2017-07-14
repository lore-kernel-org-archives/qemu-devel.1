Received: from eggs.gnu.org ([2001:4830:134:3::10]:35205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxB8-0003Bs-8j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVxB6-0002uM-6B
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:46:30 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 14 Jul 2017 12:45:19 +0300
Message-Id: <20170714094521.4909-6-el13635@mail.ntua.gr>
In-Reply-To: <20170714094521.4909-1-el13635@mail.ntua.gr>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 5/7] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

block/throttle.c uses existing I/O throttle infrastructure inside a
block filter driver. I/O operations are intercepted in the filter's
read/write coroutines, and referred to block/throttle-groups.c

The driver can be used with the syntax
-drive driver=throttle,file.filename=foo.qcow2, \
        limits.iops-total=...,throttling-group=bar

The configuration flags and their semantics are identical to the
hardcoded throttling ones.

A node can be created referring to an existing group, and will overwrite
its limits if any are specified, otherwise they are retained.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/Makefile.objs             |   1 +
 block/throttle.c                | 345 ++++++++++++++++++++++++++++++++++++++++
 include/qemu/throttle-options.h |   1 +
 3 files changed, 347 insertions(+)
 create mode 100644 block/throttle.c

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
 
diff --git a/block/throttle.c b/block/throttle.c
new file mode 100644
index 0000000000..5665ccd8b5
--- /dev/null
+++ b/block/throttle.c
@@ -0,0 +1,345 @@
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
+#undef THROTTLE_OPT_PREFIX
+#define THROTTLE_OPT_PREFIX "limits."
+static QemuOptsList throttle_opts = {
+    .name = "throttle",
+    .head = QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
+    .desc = {
+        THROTTLE_OPTS,
+        {
+            .name = QEMU_OPT_THROTTLE_GROUP_NAME,
+            .type = QEMU_OPT_STRING,
+            .help = "throttle group name",
+        },
+        { /* end of list */ }
+    },
+};
+
+/* Extract ThrottleConfig options. Assumes cfg is initialized and will be
+ * checked for validity.
+ */
+static void throttle_extract_options(QemuOpts *opts, ThrottleConfig *cfg)
+{
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL)) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].avg =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,
+                                0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ)) {
+        cfg->buckets[THROTTLE_BPS_READ].avg  =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,
+                                0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE)) {
+        cfg->buckets[THROTTLE_BPS_WRITE].avg =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,
+                                0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL)) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].avg =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,
+                                0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ)) {
+        cfg->buckets[THROTTLE_OPS_READ].avg =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,
+                                0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE)) {
+        cfg->buckets[THROTTLE_OPS_WRITE].avg =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,
+                                0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX)) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].max =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_BPS_TOTAL_MAX, 0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX)) {
+        cfg->buckets[THROTTLE_BPS_READ].max  =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_BPS_READ_MAX, 0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX)) {
+        cfg->buckets[THROTTLE_BPS_WRITE].max =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_BPS_WRITE_MAX, 0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX)) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].max =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_IOPS_TOTAL_MAX, 0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX)) {
+        cfg->buckets[THROTTLE_OPS_READ].max =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_IOPS_READ_MAX, 0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX)) {
+        cfg->buckets[THROTTLE_OPS_WRITE].max =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_IOPS_WRITE_MAX, 0);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_BPS_READ].burst_length  =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_OPS_READ].burst_length =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX
+                                QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE)) {
+        cfg->op_size =
+            qemu_opt_get_number(opts, THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,
+                                0);
+    }
+}
+
+static int throttle_configure_tgm(BlockDriverState *bs,
+                                  ThrottleGroupMember *tgm,
+                                  QDict *options, Error **errp)
+{
+    int ret;
+    ThrottleConfig cfg;
+    const char *group_name = NULL;
+    Error *local_err = NULL;
+    QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto err;
+    }
+
+    /* If no name is specified, an anonymous group will be created */
+    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
+
+    /* Register membership to group with name group_name */
+    throttle_group_register_tgm(tgm, group_name, bdrv_get_aio_context(bs));
+
+    /* Copy previous configuration */
+    throttle_group_get_config(tgm, &cfg);
+
+    /* Change limits if user has specified them */
+    throttle_extract_options(opts, &cfg);
+    if (!throttle_is_valid(&cfg, errp)) {
+        throttle_group_unregister_tgm(tgm);
+        goto err;
+    }
+    /* Update group configuration */
+    throttle_group_config(tgm, &cfg);
+
+    ret = 0;
+    goto fin;
+
+err:
+    ret = -EINVAL;
+fin:
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static int throttle_open(BlockDriverState *bs, QDict *options,
+                            int flags, Error **errp)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+
+    bs->file = bdrv_open_child(NULL, options, "file",
+                                    bs, &child_file, false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
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
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
+}
+
+static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
+        int64_t offset, int bytes)
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
+                                    AioContext *new_context)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_attach_aio_context(tgm, new_context);
+}
+
+static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
+                                      BlockReopenQueue *queue, Error **errp)
+{
+    ThrottleGroupMember *tgm = NULL;
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
+static void throttle_reopen_commit(BDRVReopenState *state)
+{
+    ThrottleGroupMember *tgm = state->bs->opaque;
+
+    throttle_group_unregister_tgm(tgm);
+    g_free(state->bs->opaque);
+    state->bs->opaque = state->opaque;
+    state->opaque = NULL;
+}
+
+static void throttle_reopen_abort(BDRVReopenState *state)
+{
+    ThrottleGroupMember *tgm = state->opaque;
+
+    throttle_group_unregister_tgm(tgm);
+    g_free(state->opaque);
+    state->opaque = NULL;
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
+    .bdrv_recurse_is_first_non_filter   =   bdrv_recurse_is_first_non_filter,
+
+    .bdrv_attach_aio_context            =   throttle_attach_aio_context,
+    .bdrv_detach_aio_context            =   throttle_detach_aio_context,
+
+    .bdrv_reopen_prepare                =   throttle_reopen_prepare,
+    .bdrv_reopen_commit                 =   throttle_reopen_commit,
+    .bdrv_reopen_abort                  =   throttle_reopen_abort,
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
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
index 182b7896e1..508ee72625 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -29,6 +29,7 @@
 #define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
 #define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
 #define QEMU_OPT_IOPS_SIZE "iops-size"
+#define QEMU_OPT_THROTTLE_GROUP_NAME "throttling-group"
 
 #define THROTTLE_OPT_PREFIX "throttling."
 #define THROTTLE_OPTS \
-- 
2.11.0
