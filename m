Received: from eggs.gnu.org ([2001:4830:134:3::10]:52579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOUxH-0004t3-94
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOUxF-0008EA-6M
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:17:55 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 1 Jun 2018 00:17:19 +0300
Message-ID: <1527801443-30620-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>, Ari Sundholm <ari@tuxera.com>

From: Aapo Vienamo <aapo@tuxera.com>

Implements a block device write logging system, similar to Linux kernel
device mapper dm-log-writes. The write operations that are performed
on a block device are logged to a file or another block device. The
write log format is identical to the dm-log-writes format. Currently,
log markers are not supported.

This functionality can be used for fail-safe and fs consistency
testing. By implementing it in qemu, tests utilizing write logs can be
be used to test non-Linux drivers and older kernels.

The implementation is based on the blkverify and blkdebug block drivers.

Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block.c               |   6 -
 block/Makefile.objs   |   1 +
 block/blklogwrites.c  | 441 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |   7 +
 4 files changed, 449 insertions(+), 6 deletions(-)
 create mode 100644 block/blklogwrites.c

diff --git a/block.c b/block.c
index 501b64c..c8cffe1 100644
--- a/block.c
+++ b/block.c
@@ -1914,12 +1914,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
     return 0;
 }
 
-#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
-                                 | BLK_PERM_WRITE \
-                                 | BLK_PERM_WRITE_UNCHANGED \
-                                 | BLK_PERM_RESIZE)
-#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
-
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
                                BlockReopenQueue *reopen_queue,
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 899bfb5..c8337bf 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -5,6 +5,7 @@ block-obj-y += qed-check.o
 block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
 block-obj-y += quorum.o
 block-obj-y += parallels.o blkdebug.o blkverify.o blkreplay.o
+block-obj-y += blklogwrites.o
 block-obj-y += block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
 block-obj-$(CONFIG_POSIX) += file-posix.o
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
new file mode 100644
index 0000000..78835bf
--- /dev/null
+++ b/block/blklogwrites.c
@@ -0,0 +1,441 @@
+/*
+ * Write logging blk driver based on blkverify and blkdebug.
+ *
+ * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
+ * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
+ * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/sockets.h" /* for EINPROGRESS on Windows */
+#include "block/block_int.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/cutils.h"
+#include "qemu/option.h"
+
+/* Disk format stuff - taken from Linux drivers/md/dm-log-writes.c */
+
+#define LOG_FLUSH_FLAG (1 << 0)
+#define LOG_FUA_FLAG (1 << 1)
+#define LOG_DISCARD_FLAG (1 << 2)
+#define LOG_MARK_FLAG (1 << 3)
+
+#define WRITE_LOG_VERSION 1ULL
+#define WRITE_LOG_MAGIC 0x6a736677736872ULL
+
+/* All fields are little-endian. */
+struct log_write_super {
+    uint64_t magic;
+    uint64_t version;
+    uint64_t nr_entries;
+    uint32_t sectorsize;
+};
+
+struct log_write_entry {
+    uint64_t sector;
+    uint64_t nr_sectors;
+    uint64_t flags;
+    uint64_t data_len;
+};
+
+/* End of disk format structures. */
+
+typedef struct {
+    BdrvChild *log_file;
+    uint64_t cur_log_sector;
+    uint64_t nr_entries;
+} BDRVBlkLogWritesState;
+
+/* Valid blk_log_writes filenames look like:
+ *      blk_log_writes:path/to/raw_image:path/to/logfile */
+static void blk_log_writes_parse_filename(const char *filename, QDict *options,
+                                          Error **errp)
+{
+    const char *c;
+    QString *raw_path;
+
+    /* Parse the blk_log_writes: prefix */
+    if (!strstart(filename, "blk_log_writes:", &filename)) {
+        /* There was no prefix; therefore, all options have to be already
+         * present in the QDict (except for the filename) */
+        qdict_put(options, "x-log", qstring_from_str(filename));
+        return;
+    }
+
+    /* Parse the raw image filename */
+    c = strchr(filename, ':');
+    if (c == NULL) {
+        error_setg(errp,
+                   "blk_log_writes requires paths to both image and log");
+        return;
+    }
+
+    raw_path = qstring_from_substr(filename, 0, c - filename - 1);
+    qdict_put(options, "x-raw", raw_path);
+
+    filename = c + 1;
+    qdict_put(options, "x-log", qstring_from_str(filename));
+}
+
+static QemuOptsList runtime_opts = {
+    .name = "blk_log_writes",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = "x-raw",
+            .type = QEMU_OPT_STRING,
+            .help = "[internal use only, will be removed]",
+        },
+        {
+            .name = "x-log",
+            .type = QEMU_OPT_STRING,
+            .help = "[internal use only, will be removed]",
+        },
+        { /* end of list */ }
+    },
+};
+
+static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
+                               Error **errp)
+{
+    BDRVBlkLogWritesState *s = bs->opaque;
+    QemuOpts *opts;
+    Error *local_err = NULL;
+    int ret;
+
+    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    /* Open the raw file */
+    bs->file = bdrv_open_child(qemu_opt_get(opts, "x-raw"), options, "raw",
+                               bs, &child_file, false, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    s->cur_log_sector = 1;
+    s->nr_entries = 0;
+    qdict_put_str(options, "log.driver", "raw");
+    qdict_put_str(options, "log.read-only", "off");
+
+    /* Open the log file */
+    s->log_file = bdrv_open_child(qemu_opt_get(opts, "x-log"), options,
+                                  "log", bs, &child_file, false,
+                                  &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    ret = 0;
+fail:
+    if (ret < 0) {
+        bdrv_unref_child(bs, bs->file);
+        bs->file = NULL;
+    }
+    qemu_opts_del(opts);
+    return ret;
+}
+
+static void blk_log_writes_close(BlockDriverState *bs)
+{
+    BDRVBlkLogWritesState *s = bs->opaque;
+
+    bdrv_unref_child(bs, s->log_file);
+    s->log_file = NULL;
+}
+
+static int64_t blk_log_writes_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+static void blk_log_writes_refresh_filename(BlockDriverState *bs,
+                                            QDict *options)
+{
+    BDRVBlkLogWritesState *s = bs->opaque;
+
+    /* bs->file->bs has already been refreshed */
+    bdrv_refresh_filename(s->log_file->bs);
+
+    if (bs->file->bs->full_open_options
+        && s->log_file->bs->full_open_options)
+    {
+        QDict *opts = qdict_new();
+        qdict_put_obj(opts, "driver",
+                      QOBJECT(qstring_from_str("blk_log_writes")));
+
+        qobject_ref(bs->file->bs->full_open_options);
+        qdict_put_obj(opts, "raw", QOBJECT(bs->file->bs->full_open_options));
+        qobject_ref(s->log_file->bs->full_open_options);
+        qdict_put_obj(opts, "log",
+                      QOBJECT(s->log_file->bs->full_open_options));
+
+        bs->full_open_options = opts;
+    }
+
+    if (bs->file->bs->exact_filename[0]
+        && s->log_file->bs->exact_filename[0])
+    {
+        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                 "blk_log_writes:%s:%s",
+                 bs->file->bs->exact_filename,
+                 s->log_file->bs->exact_filename);
+    }
+}
+
+static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                      const BdrvChildRole *role,
+                                      BlockReopenQueue *ro_q,
+                                      uint64_t perm, uint64_t shrd,
+                                      uint64_t *nperm, uint64_t *nshrd)
+{
+    if (!c) {
+        *nperm = perm & DEFAULT_PERM_PASSTHROUGH;
+        *nshrd = (shrd & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHANGED;
+        return;
+    }
+
+    if (!strcmp(c->name, "log"))
+        bdrv_format_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
+    else
+        bdrv_filter_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
+}
+
+static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    if (bs->bl.request_alignment < BDRV_SECTOR_SIZE) {
+        bs->bl.request_alignment = BDRV_SECTOR_SIZE;
+
+        if (bs->bl.pdiscard_alignment &&
+                bs->bl.pdiscard_alignment < bs->bl.request_alignment)
+            bs->bl.pdiscard_alignment = bs->bl.request_alignment;
+        if (bs->bl.pwrite_zeroes_alignment &&
+                bs->bl.pwrite_zeroes_alignment < bs->bl.request_alignment)
+            bs->bl.pwrite_zeroes_alignment = bs->bl.request_alignment;
+    }
+}
+
+static int coroutine_fn
+blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                         QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+typedef struct BlkLogWritesReq {
+    Coroutine *co;
+    BlockDriverState *bs;
+    unsigned done;
+} BlkLogWritesReq;
+
+typedef struct BlkLogWritesFileReq {
+    BlkLogWritesReq *r;
+    uint64_t offset;
+    uint64_t bytes;
+    int file_flags;
+    QEMUIOVector *qiov;
+    int (*func)(struct BlkLogWritesFileReq *r);
+    int file_ret;
+} BlkLogWritesFileReq;
+
+typedef struct {
+    BlkLogWritesReq *r;
+    QEMUIOVector *qiov;
+    struct log_write_entry entry;
+    int log_ret;
+} BlkLogWritesLogReq;
+
+static void coroutine_fn blk_log_writes_co_do_log(void *opaque)
+{
+    BlkLogWritesLogReq *lr = opaque;
+    BDRVBlkLogWritesState *s = lr->r->bs->opaque;
+    uint64_t cur_log_offset = s->cur_log_sector * BDRV_SECTOR_SIZE;
+
+    s->nr_entries++;
+    s->cur_log_sector +=
+            ROUND_UP(lr->qiov->size, BDRV_SECTOR_SIZE) >> BDRV_SECTOR_BITS;
+
+    lr->log_ret = bdrv_co_pwritev(s->log_file, cur_log_offset, lr->qiov->size,
+                                  lr->qiov, 0);
+
+    /* Update super block on flush */
+    if (lr->log_ret == 0 && lr->entry.flags & LOG_FLUSH_FLAG) {
+        struct log_write_super super = {
+            .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
+            .version    = cpu_to_le64(WRITE_LOG_VERSION),
+            .nr_entries = cpu_to_le64(s->nr_entries),
+            .sectorsize = cpu_to_le32(1 << BDRV_SECTOR_BITS),
+        };
+        static const char zeroes[BDRV_SECTOR_SIZE - sizeof(super)] = { '\0' };
+        QEMUIOVector qiov;
+
+        qemu_iovec_init(&qiov, 2);
+        qemu_iovec_add(&qiov, &super, sizeof(super));
+        qemu_iovec_add(&qiov, (void *)zeroes, sizeof(zeroes));
+
+        lr->log_ret =
+            bdrv_co_pwritev(s->log_file, 0, BDRV_SECTOR_SIZE, &qiov, 0);
+        if (lr->log_ret == 0)
+            lr->log_ret = bdrv_co_flush(s->log_file->bs);
+        qemu_iovec_destroy(&qiov);
+    }
+
+    lr->r->done++;
+    qemu_coroutine_enter_if_inactive(lr->r->co);
+}
+
+static void blk_log_writes_co_do_file(void *opaque)
+{
+    BlkLogWritesFileReq *fr = opaque;
+
+    fr->file_ret = fr->func(fr);
+
+    fr->r->done++;
+    qemu_coroutine_enter_if_inactive(fr->r->co);
+}
+
+static int coroutine_fn
+blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                      QEMUIOVector *qiov, int flags,
+                      int (*file_func)(BlkLogWritesFileReq *r),
+                      uint64_t entry_flags)
+{
+    QEMUIOVector log_qiov;
+    size_t niov = qiov ? qiov->niov : 0;
+    Coroutine *co_log, *co_file;
+    BlkLogWritesReq r = {
+        .co     = qemu_coroutine_self(),
+        .bs     = bs,
+        .done   = 0,
+    };
+    BlkLogWritesFileReq fr = {
+        .r      = &r,
+        .offset = offset,
+        .bytes  = bytes,
+        .qiov   = qiov,
+        .func   = file_func,
+    };
+    BlkLogWritesLogReq lr = {
+        .r              = &r,
+        .qiov           = &log_qiov,
+        .entry = {
+            .sector     = cpu_to_le64(offset >> BDRV_SECTOR_BITS),
+            .nr_sectors = cpu_to_le64(bytes >> BDRV_SECTOR_BITS),
+            .flags      = cpu_to_le64(entry_flags),
+            .data_len   = 0,
+        },
+    };
+    static const char zeroes[BDRV_SECTOR_SIZE - sizeof(struct log_write_entry)]
+        = { '\0' };
+
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+
+    qemu_iovec_init(&log_qiov, niov + 2);
+    qemu_iovec_add(&log_qiov, &lr.entry, sizeof(lr.entry));
+    qemu_iovec_add(&log_qiov, (void *)zeroes, sizeof(zeroes));
+    for (size_t i = 0; i < niov; ++i) {
+        qemu_iovec_add(&log_qiov, qiov->iov[i].iov_base, qiov->iov[i].iov_len);
+    }
+
+    co_log = qemu_coroutine_create(blk_log_writes_co_do_log, &lr);
+    co_file = qemu_coroutine_create(blk_log_writes_co_do_file, &fr);
+
+    qemu_coroutine_enter(co_file);
+    qemu_coroutine_enter(co_log);
+
+    while (r.done < 2) {
+        qemu_coroutine_yield();
+    }
+
+    qemu_iovec_destroy(&log_qiov);
+
+    if (lr.log_ret < 0) {
+        return lr.log_ret;
+    }
+
+    return fr.file_ret;
+}
+
+static int coroutine_fn
+blk_log_writes_co_do_file_pwritev(BlkLogWritesFileReq *fr)
+{
+    return bdrv_co_pwritev(fr->r->bs->file, fr->offset, fr->bytes,
+                           fr->qiov, fr->file_flags);
+}
+
+static int coroutine_fn blk_log_writes_co_do_file_flush(BlkLogWritesFileReq *fr)
+{
+    return bdrv_co_flush(fr->r->bs->file->bs);
+}
+
+static int coroutine_fn
+blk_log_writes_co_do_file_pdiscard(BlkLogWritesFileReq *fr)
+{
+    return bdrv_co_pdiscard(fr->r->bs->file->bs, fr->offset, fr->bytes);
+}
+
+static int coroutine_fn
+blk_log_writes_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                          QEMUIOVector *qiov, int flags)
+{
+    return blk_log_writes_co_log(bs, offset, bytes, qiov, flags,
+                                 blk_log_writes_co_do_file_pwritev, 0);
+}
+
+static int coroutine_fn blk_log_writes_co_flush_to_disk(BlockDriverState *bs)
+{
+    return blk_log_writes_co_log(bs, 0, 0, NULL, 0,
+                                 blk_log_writes_co_do_file_flush,
+                                 LOG_FLUSH_FLAG);
+}
+
+static int coroutine_fn
+blk_log_writes_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
+{
+    return blk_log_writes_co_log(bs, offset, count, NULL, 0,
+                                 blk_log_writes_co_do_file_pdiscard,
+                                 LOG_DISCARD_FLAG);
+}
+
+static BlockDriver bdrv_blk_log_writes = {
+    .format_name            = "blk_log_writes",
+    .protocol_name          = "blk_log_writes",
+    .instance_size          = sizeof(BDRVBlkLogWritesState),
+
+    .bdrv_parse_filename    = blk_log_writes_parse_filename,
+    .bdrv_file_open         = blk_log_writes_open,
+    .bdrv_close             = blk_log_writes_close,
+    .bdrv_getlength         = blk_log_writes_getlength,
+    .bdrv_refresh_filename  = blk_log_writes_refresh_filename,
+    .bdrv_child_perm        = blk_log_writes_child_perm,
+    .bdrv_refresh_limits    = blk_log_writes_refresh_limits,
+
+    .bdrv_co_preadv         = blk_log_writes_co_preadv,
+    .bdrv_co_pwritev        = blk_log_writes_co_pwritev,
+    .bdrv_co_flush_to_disk  = blk_log_writes_co_flush_to_disk,
+    .bdrv_co_pdiscard       = blk_log_writes_co_pdiscard,
+
+    .is_filter              = true,
+};
+
+static void bdrv_blk_log_writes_init(void)
+{
+    bdrv_register(&bdrv_blk_log_writes);
+}
+
+block_init(bdrv_blk_log_writes_init);
diff --git a/include/block/block.h b/include/block/block.h
index 3894edd..fb7d379 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -225,6 +225,13 @@ enum {
     BLK_PERM_GRAPH_MOD          = 0x10,
 
     BLK_PERM_ALL                = 0x1f,
+
+    DEFAULT_PERM_PASSTHROUGH    = BLK_PERM_CONSISTENT_READ
+                                 | BLK_PERM_WRITE
+                                 | BLK_PERM_WRITE_UNCHANGED
+                                 | BLK_PERM_RESIZE,
+
+    DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
 };
 
 char *bdrv_perm_names(uint64_t perm);
-- 
2.7.4
