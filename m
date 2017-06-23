Received: from eggs.gnu.org ([2001:4830:134:3::10]:60139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0r-0001lO-Pu
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dOO0p-0004Ur-81
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:48:37 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Fri, 23 Jun 2017 15:46:55 +0300
Message-Id: <20170623124700.1389-4-el13635@mail.ntua.gr>
In-Reply-To: <20170623124700.1389-1-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH RFC v3 3/8] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

block/throttle.c uses existing I/O throttle infrastructure inside a
block filter driver. I/O operations are intercepted in the filter's
read/write coroutines, and referred to block/throttle-groups.c

The driver can be used with the command
-drive driver=throttle,file.filename=foo.qcow2,iops-total=...
The configuration flags and semantics are identical to the hardcoded
throttling ones.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/Makefile.objs             |   1 +
 block/throttle.c                | 427 ++++++++++++++++++++++++++++++++++++++++
 include/qemu/throttle-options.h |  60 ++++--
 3 files changed, 469 insertions(+), 19 deletions(-)
 create mode 100644 block/throttle.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index ea955302c8..bb811a4d01 100644
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
index 0000000000..0c17051161
--- /dev/null
+++ b/block/throttle.c
@@ -0,0 +1,427 @@
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
+
+static QemuOptsList throttle_opts = {
+    .name = "throttle",
+    .head = QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
+    .desc = {
+        {
+            .name = QEMU_OPT_IOPS_TOTAL,
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit total I/O operations per second",
+        },{
+            .name = QEMU_OPT_IOPS_READ,
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit read operations per second",
+        },{
+            .name = QEMU_OPT_IOPS_WRITE,
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit write operations per second",
+        },{
+            .name = QEMU_OPT_BPS_TOTAL,
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit total bytes per second",
+        },{
+            .name = QEMU_OPT_BPS_READ,
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit read bytes per second",
+        },{
+            .name = QEMU_OPT_BPS_WRITE,
+            .type = QEMU_OPT_NUMBER,
+            .help = "limit write bytes per second",
+        },{
+            .name = QEMU_OPT_IOPS_TOTAL_MAX,
+            .type = QEMU_OPT_NUMBER,
+            .help = "I/O operations burst",
+        },{
+            .name = QEMU_OPT_IOPS_READ_MAX,
+            .type = QEMU_OPT_NUMBER,
+            .help = "I/O operations read burst",
+        },{
+            .name = QEMU_OPT_IOPS_WRITE_MAX,
+            .type = QEMU_OPT_NUMBER,
+            .help = "I/O operations write burst",
+        },{
+            .name = QEMU_OPT_BPS_TOTAL_MAX,
+            .type = QEMU_OPT_NUMBER,
+            .help = "total bytes burst",
+        },{
+            .name = QEMU_OPT_BPS_READ_MAX,
+            .type = QEMU_OPT_NUMBER,
+            .help = "total bytes read burst",
+        },{
+            .name = QEMU_OPT_BPS_WRITE_MAX,
+            .type = QEMU_OPT_NUMBER,
+            .help = "total bytes write burst",
+        },{
+            .name = QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the iopstotalmax burst period, in seconds",
+        },{
+            .name = QEMU_OPT_IOPS_READ_MAX_LENGTH,
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the iopsreadmax burst period, in seconds",
+        },{
+            .name = QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the iopswritemax burst period, in seconds",
+        },{
+            .name = QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the bpstotalmax burst period, in seconds",
+        },{
+            .name = QEMU_OPT_BPS_READ_MAX_LENGTH,
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the bpsreadmax burst period, in seconds",
+        },{
+            .name = QEMU_OPT_BPS_WRITE_MAX_LENGTH,
+            .type = QEMU_OPT_NUMBER,
+            .help = "length of the bpswritemax burst period, in seconds",
+        },{
+            .name = QEMU_OPT_IOPS_SIZE,
+            .type = QEMU_OPT_NUMBER,
+            .help = "when limiting by iops max size of an I/O in bytes",
+        },
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
+
+static void throttle_extract_options(QemuOpts *opts, ThrottleConfig *cfg)
+{
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL)) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].avg =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ)) {
+        cfg->buckets[THROTTLE_BPS_READ].avg  =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE)) {
+        cfg->buckets[THROTTLE_BPS_WRITE].avg =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL)) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].avg =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ)) {
+        cfg->buckets[THROTTLE_OPS_READ].avg =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE)) {
+        cfg->buckets[THROTTLE_OPS_WRITE].avg =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX)) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].max =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX)) {
+        cfg->buckets[THROTTLE_BPS_READ].max  =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX)) {
+        cfg->buckets[THROTTLE_BPS_WRITE].max =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX)) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].max =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX)) {
+        cfg->buckets[THROTTLE_OPS_READ].max =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX)) {
+        cfg->buckets[THROTTLE_OPS_WRITE].max =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX, 0);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_BPS_READ].burst_length  =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
+            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_OPS_READ].burst_length =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH)) {
+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
+    }
+    if (qemu_opt_get(opts, QEMU_OPT_IOPS_SIZE)) {
+        cfg->op_size =
+            qemu_opt_get_number(opts, QEMU_OPT_IOPS_SIZE, 0);
+    }
+}
+
+static int throttle_configure_tgm(BlockDriverState *bs, ThrottleGroupMember *tgm,
+                                                    QDict *options, Error **errp)
+{
+    int ret = 0;
+    ThrottleState *ts;
+    ThrottleTimers *tt;
+    ThrottleConfig cfg;
+    QemuOpts *opts = NULL;
+    const char *group_name = NULL;
+    Error *local_err = NULL;
+
+    opts = qemu_opts_create(&throttle_opts, NULL, 0, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        goto err;
+    }
+
+    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
+    if (!group_name) {
+        group_name = bdrv_get_device_or_node_name(bs);
+        if (!strlen(group_name)) {
+            error_setg(&local_err,
+                       "A group name must be specified for this device.");
+            goto err;
+        }
+    }
+
+    tgm->aio_context = bdrv_get_aio_context(bs);
+    /* Register membership to group with name group_name */
+    throttle_group_register_tgm(tgm, group_name);
+
+    ts = tgm->throttle_state;
+    /* Copy previous configuration */
+    throttle_get_config(ts, &cfg);
+
+    /* Change limits if user has specified them */
+    throttle_extract_options(opts, &cfg);
+    if (!throttle_is_valid(&cfg, &local_err)) {
+        throttle_group_unregister_tgm(tgm);
+        goto err;
+    }
+    tt = &tgm->throttle_timers;
+    /* Update group configuration */
+    throttle_config(ts, tt, &cfg);
+
+    qemu_co_queue_init(&tgm->throttled_reqs[0]);
+    qemu_co_queue_init(&tgm->throttled_reqs[1]);
+
+    goto fin;
+
+err:
+    error_propagate(errp, local_err);
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
+    Error *local_err = NULL;
+
+    bs->open_flags = flags;
+    bs->file = bdrv_open_child(NULL, options, "file",
+                                    bs, &child_file, false, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    qdict_flatten(options);
+    return throttle_configure_tgm(bs, tgm, options, errp);
+}
+
+static void throttle_close(BlockDriverState *bs)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    bdrv_drained_begin(bs);
+    throttle_group_unregister_tgm(tgm);
+    bdrv_drained_end(bs);
+    return;
+}
+
+
+static int64_t throttle_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+
+static int coroutine_fn throttle_co_preadv(BlockDriverState *bs, uint64_t offset,
+                                            uint64_t bytes, QEMUIOVector *qiov,
+                                            int flags)
+{
+
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_group_co_io_limits_intercept(tgm, bytes, false);
+
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs, uint64_t offset,
+                                            uint64_t bytes, QEMUIOVector *qiov,
+                                            int flags)
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
+    throttle_timers_detach_aio_context(&tgm->throttle_timers);
+}
+
+static void throttle_attach_aio_context(BlockDriverState *bs,
+                                    AioContext *new_context)
+{
+    ThrottleGroupMember *tgm = bs->opaque;
+    throttle_timers_attach_aio_context(&tgm->throttle_timers, new_context);
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
+    BlockDriverState *bs = state->bs;
+
+    bdrv_drained_begin(bs);
+    throttle_group_unregister_tgm(tgm);
+    g_free(state->bs->opaque);
+    state->bs->opaque = state->opaque;
+    bdrv_drained_end(bs);
+
+    state->opaque = NULL;
+}
+
+static void throttle_reopen_abort(BDRVReopenState *state)
+{
+    ThrottleGroupMember *tgm = state->opaque;
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
index 3133d1ca40..508ee72625 100644
--- a/include/qemu/throttle-options.h
+++ b/include/qemu/throttle-options.h
@@ -10,81 +10,103 @@
 #ifndef THROTTLE_OPTIONS_H
 #define THROTTLE_OPTIONS_H
 
+#define QEMU_OPT_IOPS_TOTAL "iops-total"
+#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
+#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
+#define QEMU_OPT_IOPS_READ "iops-read"
+#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
+#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
+#define QEMU_OPT_IOPS_WRITE "iops-write"
+#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
+#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
+#define QEMU_OPT_BPS_TOTAL "bps-total"
+#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
+#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
+#define QEMU_OPT_BPS_READ "bps-read"
+#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
+#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
+#define QEMU_OPT_BPS_WRITE "bps-write"
+#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
+#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
+#define QEMU_OPT_IOPS_SIZE "iops-size"
+#define QEMU_OPT_THROTTLE_GROUP_NAME "throttling-group"
+
+#define THROTTLE_OPT_PREFIX "throttling."
 #define THROTTLE_OPTS \
           { \
-            .name = "throttling.iops-total",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL,\
             .type = QEMU_OPT_NUMBER,\
             .help = "limit total I/O operations per second",\
         },{ \
-            .name = "throttling.iops-read",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ,\
             .type = QEMU_OPT_NUMBER,\
             .help = "limit read operations per second",\
         },{ \
-            .name = "throttling.iops-write",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE,\
             .type = QEMU_OPT_NUMBER,\
             .help = "limit write operations per second",\
         },{ \
-            .name = "throttling.bps-total",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL,\
             .type = QEMU_OPT_NUMBER,\
             .help = "limit total bytes per second",\
         },{ \
-            .name = "throttling.bps-read",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ,\
             .type = QEMU_OPT_NUMBER,\
             .help = "limit read bytes per second",\
         },{ \
-            .name = "throttling.bps-write",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE,\
             .type = QEMU_OPT_NUMBER,\
             .help = "limit write bytes per second",\
         },{ \
-            .name = "throttling.iops-total-max",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX,\
             .type = QEMU_OPT_NUMBER,\
             .help = "I/O operations burst",\
         },{ \
-            .name = "throttling.iops-read-max",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX,\
             .type = QEMU_OPT_NUMBER,\
             .help = "I/O operations read burst",\
         },{ \
-            .name = "throttling.iops-write-max",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX,\
             .type = QEMU_OPT_NUMBER,\
             .help = "I/O operations write burst",\
         },{ \
-            .name = "throttling.bps-total-max",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX,\
             .type = QEMU_OPT_NUMBER,\
             .help = "total bytes burst",\
         },{ \
-            .name = "throttling.bps-read-max",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX,\
             .type = QEMU_OPT_NUMBER,\
             .help = "total bytes read burst",\
         },{ \
-            .name = "throttling.bps-write-max",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX,\
             .type = QEMU_OPT_NUMBER,\
             .help = "total bytes write burst",\
         },{ \
-            .name = "throttling.iops-total-max-length",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,\
             .type = QEMU_OPT_NUMBER,\
             .help = "length of the iops-total-max burst period, in seconds",\
         },{ \
-            .name = "throttling.iops-read-max-length",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX_LENGTH,\
             .type = QEMU_OPT_NUMBER,\
             .help = "length of the iops-read-max burst period, in seconds",\
         },{ \
-            .name = "throttling.iops-write-max-length",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX_LENGTH,\
             .type = QEMU_OPT_NUMBER,\
             .help = "length of the iops-write-max burst period, in seconds",\
         },{ \
-            .name = "throttling.bps-total-max-length",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX_LENGTH,\
             .type = QEMU_OPT_NUMBER,\
             .help = "length of the bps-total-max burst period, in seconds",\
         },{ \
-            .name = "throttling.bps-read-max-length",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX_LENGTH,\
             .type = QEMU_OPT_NUMBER,\
             .help = "length of the bps-read-max burst period, in seconds",\
         },{ \
-            .name = "throttling.bps-write-max-length",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX_LENGTH,\
             .type = QEMU_OPT_NUMBER,\
             .help = "length of the bps-write-max burst period, in seconds",\
         },{ \
-            .name = "throttling.iops-size",\
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE,\
             .type = QEMU_OPT_NUMBER,\
             .help = "when limiting by iops max size of an I/O in bytes",\
         }
-- 
2.11.0
