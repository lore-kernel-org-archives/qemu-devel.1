Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvP-0004iH-AB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvM-0005it-4j
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:59 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 19 Jun 2018 16:43:40 +0300
Message-ID: <1529415820-7750-9-git-send-email-ari@tuxera.com>
In-Reply-To: <1529415820-7750-1-git-send-email-ari@tuxera.com>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 8/8] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aapo Vienamo <aapo@tuxera.com>, Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "open list:Block layer
	core" <qemu-block@nongnu.org>

From: Aapo Vienamo <aapo@tuxera.com>

Implements a block device write logging system, similar to Linux kernel
device mapper dm-log-writes. The write operations that are performed
on a block device are logged to a file or another block device. The
write log format is identical to the dm-log-writes format. Currently,
log markers are not supported.

This functionality can be used for crash consistency and fs consistency
testing. By implementing it in qemu, tests utilizing write logs can be
be used to test non-Linux drivers and older kernels.

The driver requires all requests to be aligned to the logical sector
size of the block backend of the guest block device being logged. This
is important because the dm-log-writes log format has a granularity of
one sector for both the offset and the size of each write. Also, using
the logical sector size as a basis for logging allows for faithful
logging of writes when testing drivers with block devices that have
unusual sector sizes.

The implementation is based on the blkverify and blkdebug block
drivers.

Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 MAINTAINERS          |   6 +
 block/Makefile.objs  |   1 +
 block/blklogwrites.c | 426 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json |  30 +++-
 4 files changed, 457 insertions(+), 6 deletions(-)
 create mode 100644 block/blklogwrites.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fb5f38..f824d2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2021,6 +2021,12 @@ S: Supported
 F: block/quorum.c
 L: qemu-block@nongnu.org
 
+blklogwrites
+M: Ari Sundholm <ari@tuxera.com>
+L: qemu-block@nongnu.org
+S: Supported
+F: block/blklogwrites.c
+
 blkverify
 M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
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
index 0000000..decf5e5
--- /dev/null
+++ b/block/blklogwrites.c
@@ -0,0 +1,426 @@
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
+    uint32_t sectorsize;
+    uint32_t sectorbits;
+    uint64_t cur_log_sector;
+    uint64_t nr_entries;
+} BDRVBlkLogWritesState;
+
+static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
+                               Error **errp)
+{
+    BDRVBlkLogWritesState *s = bs->opaque;
+    Error *local_err = NULL;
+    int ret;
+
+    /* Open the raw file */
+    bs->file = bdrv_open_child(NULL, options, "raw", bs, &child_file, false,
+                               &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+
+    s->sectorsize = BDRV_SECTOR_SIZE; /* May be updated later */
+    s->sectorbits = BDRV_SECTOR_BITS;
+    s->cur_log_sector = 1;
+    s->nr_entries = 0;
+
+    /* Open the log file */
+    s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_file, false,
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
+                      QOBJECT(qstring_from_str("blklogwrites")));
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
+        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                           "blklogwrites:%s:%s",
+                           bs->file->bs->exact_filename,
+                           s->log_file->bs->exact_filename);
+
+        if (ret >= sizeof(bs->exact_filename)) {
+            /* An overflow makes the filename unusable, so do not report any */
+            bs->exact_filename[0] = '\0';
+        }
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
+    if (!strcmp(c->name, "log")) {
+        bdrv_format_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
+    } else {
+        bdrv_filter_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
+    }
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
+static inline uint32_t blk_log_writes_log2(uint32_t value)
+{
+    assert(value > 0);
+    return 31 - clz32(value);
+}
+
+static void blk_log_writes_apply_blkconf(BlockDriverState *bs, BlockConf *conf)
+{
+    BDRVBlkLogWritesState *s = bs->opaque;
+    assert(bs && conf && conf->blk && s);
+
+    s->sectorsize = conf->logical_block_size;
+    s->sectorbits = blk_log_writes_log2(s->sectorsize);
+    bs->bl.request_alignment = s->sectorsize;
+    if (conf->discard_granularity != (uint32_t)-1) {
+        bs->bl.pdiscard_alignment = conf->discard_granularity;
+    }
+
+    if (bs->bl.pdiscard_alignment &&
+            bs->bl.pdiscard_alignment < bs->bl.request_alignment) {
+        bs->bl.pdiscard_alignment = bs->bl.request_alignment;
+    }
+    if (bs->bl.pwrite_zeroes_alignment &&
+            bs->bl.pwrite_zeroes_alignment < bs->bl.request_alignment) {
+        bs->bl.pwrite_zeroes_alignment = bs->bl.request_alignment;
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
+typedef struct BlkLogWritesFileReq {
+    BlockDriverState *bs;
+    uint64_t offset;
+    uint64_t bytes;
+    int file_flags;
+    QEMUIOVector *qiov;
+    int (*func)(struct BlkLogWritesFileReq *r);
+    int file_ret;
+} BlkLogWritesFileReq;
+
+typedef struct {
+    BlockDriverState *bs;
+    QEMUIOVector *qiov;
+    struct log_write_entry entry;
+    uint64_t zero_size;
+    int log_ret;
+} BlkLogWritesLogReq;
+
+static void coroutine_fn blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
+{
+    BDRVBlkLogWritesState *s = lr->bs->opaque;
+    uint64_t cur_log_offset = s->cur_log_sector << s->sectorbits;
+
+    s->nr_entries++;
+    s->cur_log_sector +=
+            ROUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;
+
+    lr->log_ret = bdrv_co_pwritev(s->log_file, cur_log_offset, lr->qiov->size,
+                                  lr->qiov, 0);
+
+    /* Logging for the "write zeroes" operation */
+    if (lr->log_ret == 0 && lr->zero_size) {
+        cur_log_offset = s->cur_log_sector << s->sectorbits;
+        s->cur_log_sector +=
+                ROUND_UP(lr->zero_size, s->sectorsize) >> s->sectorbits;
+
+        lr->log_ret = bdrv_co_pwrite_zeroes(s->log_file, cur_log_offset,
+                                            lr->zero_size, 0);
+    }
+
+    /* Update super block on flush */
+    if (lr->log_ret == 0 && lr->entry.flags & LOG_FLUSH_FLAG) {
+        struct log_write_super super = {
+            .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
+            .version    = cpu_to_le64(WRITE_LOG_VERSION),
+            .nr_entries = cpu_to_le64(s->nr_entries),
+            .sectorsize = cpu_to_le32(s->sectorsize),
+        };
+        void *zeroes = g_malloc0(s->sectorsize - sizeof(super));
+        QEMUIOVector qiov;
+
+        qemu_iovec_init(&qiov, 2);
+        qemu_iovec_add(&qiov, &super, sizeof(super));
+        qemu_iovec_add(&qiov, zeroes, s->sectorsize - sizeof(super));
+
+        lr->log_ret =
+            bdrv_co_pwritev(s->log_file, 0, s->sectorsize, &qiov, 0);
+        if (lr->log_ret == 0) {
+            lr->log_ret = bdrv_co_flush(s->log_file->bs);
+        }
+        qemu_iovec_destroy(&qiov);
+        g_free(zeroes);
+    }
+}
+
+static void coroutine_fn blk_log_writes_co_do_file(BlkLogWritesFileReq *fr)
+{
+    fr->file_ret = fr->func(fr);
+}
+
+static int coroutine_fn
+blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                      QEMUIOVector *qiov, int flags,
+                      int (*file_func)(BlkLogWritesFileReq *r),
+                      uint64_t entry_flags, bool is_zero_write)
+{
+    QEMUIOVector log_qiov;
+    size_t niov = qiov ? qiov->niov : 0;
+    size_t i;
+    BDRVBlkLogWritesState *s = bs->opaque;
+    BlkLogWritesFileReq fr = {
+        .bs     = bs,
+        .offset = offset,
+        .bytes  = bytes,
+        .file_flags = flags,
+        .qiov   = qiov,
+        .func   = file_func,
+    };
+    BlkLogWritesLogReq lr = {
+        .bs             = bs,
+        .qiov           = &log_qiov,
+        .entry = {
+            .sector     = cpu_to_le64(offset >> s->sectorbits),
+            .nr_sectors = cpu_to_le64(bytes >> s->sectorbits),
+            .flags      = cpu_to_le64(entry_flags),
+            .data_len   = 0,
+        },
+        .zero_size = is_zero_write ? bytes : 0,
+    };
+    void *zeroes = g_malloc0(s->sectorsize - sizeof(lr.entry));
+
+    assert((1 << s->sectorbits) == s->sectorsize);
+    assert(bs->bl.request_alignment == s->sectorsize);
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+
+    qemu_iovec_init(&log_qiov, niov + 2);
+    qemu_iovec_add(&log_qiov, &lr.entry, sizeof(lr.entry));
+    qemu_iovec_add(&log_qiov, zeroes, s->sectorsize - sizeof(lr.entry));
+    for (i = 0; i < niov; ++i) {
+        qemu_iovec_add(&log_qiov, qiov->iov[i].iov_base, qiov->iov[i].iov_len);
+    }
+
+    blk_log_writes_co_do_file(&fr);
+    blk_log_writes_co_do_log(&lr);
+
+    qemu_iovec_destroy(&log_qiov);
+    g_free(zeroes);
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
+    return bdrv_co_pwritev(fr->bs->file, fr->offset, fr->bytes,
+                           fr->qiov, fr->file_flags);
+}
+
+static int coroutine_fn
+blk_log_writes_co_do_file_pwrite_zeroes(BlkLogWritesFileReq *fr)
+{
+    return bdrv_co_pwrite_zeroes(fr->bs->file, fr->offset, fr->bytes,
+                                 fr->file_flags);
+}
+
+static int coroutine_fn blk_log_writes_co_do_file_flush(BlkLogWritesFileReq *fr)
+{
+    return bdrv_co_flush(fr->bs->file->bs);
+}
+
+static int coroutine_fn
+blk_log_writes_co_do_file_pdiscard(BlkLogWritesFileReq *fr)
+{
+    return bdrv_co_pdiscard(fr->bs->file->bs, fr->offset, fr->bytes);
+}
+
+static int coroutine_fn
+blk_log_writes_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                          QEMUIOVector *qiov, int flags)
+{
+    return blk_log_writes_co_log(bs, offset, bytes, qiov, flags,
+                                 blk_log_writes_co_do_file_pwritev, 0, false);
+}
+
+static int coroutine_fn
+blk_log_writes_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
+                                BdrvRequestFlags flags)
+{
+    return blk_log_writes_co_log(bs, offset, bytes, NULL, flags,
+                                 blk_log_writes_co_do_file_pwrite_zeroes, 0,
+                                 true);
+}
+
+static int coroutine_fn blk_log_writes_co_flush_to_disk(BlockDriverState *bs)
+{
+    return blk_log_writes_co_log(bs, 0, 0, NULL, 0,
+                                 blk_log_writes_co_do_file_flush,
+                                 LOG_FLUSH_FLAG, false);
+}
+
+static int coroutine_fn
+blk_log_writes_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
+{
+    return blk_log_writes_co_log(bs, offset, count, NULL, 0,
+                                 blk_log_writes_co_do_file_pdiscard,
+                                 LOG_DISCARD_FLAG, false);
+}
+
+static BlockDriver bdrv_blk_log_writes = {
+    .format_name            = "blklogwrites",
+    .protocol_name          = "blklogwrites",
+    .instance_size          = sizeof(BDRVBlkLogWritesState),
+
+    .bdrv_file_open         = blk_log_writes_open,
+    .bdrv_close             = blk_log_writes_close,
+    .bdrv_getlength         = blk_log_writes_getlength,
+    .bdrv_refresh_filename  = blk_log_writes_refresh_filename,
+    .bdrv_child_perm        = blk_log_writes_child_perm,
+    .bdrv_refresh_limits    = blk_log_writes_refresh_limits,
+    .bdrv_apply_blkconf     = blk_log_writes_apply_blkconf,
+
+    .bdrv_co_preadv         = blk_log_writes_co_preadv,
+    .bdrv_co_pwritev        = blk_log_writes_co_pwritev,
+    .bdrv_co_pwrite_zeroes  = blk_log_writes_co_pwrite_zeroes,
+    .bdrv_co_flush_to_disk  = blk_log_writes_co_flush_to_disk,
+    .bdrv_co_pdiscard       = blk_log_writes_co_pdiscard,
+    .bdrv_co_block_status   = bdrv_co_block_status_from_file,
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
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab629d1..b4255d2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2509,16 +2509,17 @@
 # @throttle: Since 2.11
 # @nvme: Since 2.12
 # @copy-on-read: Since 3.0
+# @blklogwrites: Since 3.0
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'copy-on-read',
-            'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
-            'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
-            'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
-            'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+  'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
+            'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
+            'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
+            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
+            'qcow2', 'qed', 'quorum', 'raw', 'rbd', 'replication', 'sheepdog',
+            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3033,6 +3034,21 @@
             '*set-state': ['BlkdebugSetStateOptions'] } }
 
 ##
+# @BlockdevOptionsBlklogwrites:
+#
+# Driver specific block device options for blklogwrites.
+#
+# @raw:     block device
+#
+# @log:     block device used to log writes on @raw
+#
+# Since: 3.0
+##
+{ 'struct': 'BlockdevOptionsBlklogwrites',
+  'data': { 'raw': 'BlockdevRef',
+            'log': 'BlockdevRef' } }
+
+##
 # @BlockdevOptionsBlkverify:
 #
 # Driver specific block device options for blkverify.
@@ -3546,6 +3562,7 @@
   'discriminator': 'driver',
   'data': {
       'blkdebug':   'BlockdevOptionsBlkdebug',
+      'blklogwrites': 'BlockdevOptionsBlklogwrites',
       'blkverify':  'BlockdevOptionsBlkverify',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
@@ -4074,6 +4091,7 @@
   'discriminator': 'driver',
   'data': {
       'blkdebug':       'BlockdevCreateNotSupported',
+      'blklogwrites':   'BlockdevCreateNotSupported',
       'blkverify':      'BlockdevCreateNotSupported',
       'bochs':          'BlockdevCreateNotSupported',
       'cloop':          'BlockdevCreateNotSupported',
-- 
2.7.4
