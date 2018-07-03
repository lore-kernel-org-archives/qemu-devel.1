Received: from eggs.gnu.org ([2001:4830:134:3::10]:54728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faL0f-0006o6-Go
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faL0a-0001ht-Nw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:06:21 -0400
Date: Tue, 3 Jul 2018 15:06:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180703130604.GE3812@localhost.localdomain>
References: <1530305259-19184-1-git-send-email-ari@tuxera.com>
	<1530305259-19184-3-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530305259-19184-3-git-send-email-ari@tuxera.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 29.06.2018 um 22:47 hat Ari Sundholm geschrieben:
> From: Aapo Vienamo <aapo@tuxera.com>
> 
> Implements a block device write logging system, similar to Linux kernel
> device mapper dm-log-writes. The write operations that are performed
> on a block device are logged to a file or another block device. The
> write log format is identical to the dm-log-writes format. Currently,
> log markers are not supported.
> 
> This functionality can be used for crash consistency and fs consistency
> testing. By implementing it in qemu, tests utilizing write logs can be
> be used to test non-Linux drivers and older kernels.
> 
> The driver accepts an optional parameter to set the sector size used
> for logging. This makes the driver require all requests to be aligned
> to this sector size and also makes offsets and sizes of writes in the
> log metadata to be expressed in terms of this value (the log format has
> a granularity of one sector for offsets and sizes). This allows
> accurate logging of writes to guest block devices that have unusual
> sector sizes.
> 
> The implementation is based on the blkverify and blkdebug block
> drivers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  MAINTAINERS          |   6 +
>  block/Makefile.objs  |   1 +
>  block/blklogwrites.c | 392 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json |  33 ++++-
>  4 files changed, 426 insertions(+), 6 deletions(-)
>  create mode 100644 block/blklogwrites.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42a1892..5af89e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2051,6 +2051,12 @@ S: Supported
>  F: block/quorum.c
>  L: qemu-block@nongnu.org
>  
> +blklogwrites
> +M: Ari Sundholm <ari@tuxera.com>
> +L: qemu-block@nongnu.org
> +S: Supported
> +F: block/blklogwrites.c
> +
>  blkverify
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  L: qemu-block@nongnu.org
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 899bfb5..c8337bf 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -5,6 +5,7 @@ block-obj-y += qed-check.o
>  block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
>  block-obj-y += quorum.o
>  block-obj-y += parallels.o blkdebug.o blkverify.o blkreplay.o
> +block-obj-y += blklogwrites.o
>  block-obj-y += block-backend.o snapshot.o qapi.o
>  block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
>  block-obj-$(CONFIG_POSIX) += file-posix.o
> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> new file mode 100644
> index 0000000..0748b56
> --- /dev/null
> +++ b/block/blklogwrites.c
> @@ -0,0 +1,392 @@
> +/*
> + * Write logging blk driver based on blkverify and blkdebug.
> + *
> + * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
> + * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
> + * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/sockets.h" /* for EINPROGRESS on Windows */
> +#include "block/block_int.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qemu/cutils.h"
> +#include "qemu/option.h"
> +
> +/* Disk format stuff - taken from Linux drivers/md/dm-log-writes.c */
> +
> +#define LOG_FLUSH_FLAG   (1 << 0)
> +#define LOG_FUA_FLAG     (1 << 1)
> +#define LOG_DISCARD_FLAG (1 << 2)
> +#define LOG_MARK_FLAG    (1 << 3)
> +
> +#define WRITE_LOG_VERSION 1ULL
> +#define WRITE_LOG_MAGIC 0x6a736677736872ULL
> +
> +/* All fields are little-endian. */
> +struct log_write_super {
> +    uint64_t magic;
> +    uint64_t version;
> +    uint64_t nr_entries;
> +    uint32_t sectorsize;
> +} QEMU_PACKED;
> +
> +struct log_write_entry {
> +    uint64_t sector;
> +    uint64_t nr_sectors;
> +    uint64_t flags;
> +    uint64_t data_len;
> +} QEMU_PACKED;
> +
> +/* End of disk format structures. */
> +
> +typedef struct {
> +    BdrvChild *log_file;
> +    uint32_t sectorsize;
> +    uint32_t sectorbits;
> +    uint64_t cur_log_sector;
> +    uint64_t nr_entries;
> +} BDRVBlkLogWritesState;
> +
> +static inline uint32_t blk_log_writes_log2(uint32_t value)
> +{
> +    assert(value > 0);
> +    return 31 - clz32(value);
> +}
> +
> +static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
> +                               Error **errp)
> +{
> +    BDRVBlkLogWritesState *s = bs->opaque;
> +    Error *local_err = NULL;
> +    int ret;
> +    int64_t log_sector_size = BDRV_SECTOR_SIZE;
> +
> +    /* Open the file */
> +    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
> +                               &local_err);
> +    if (local_err) {
> +        ret = -EINVAL;
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    if (qdict_haskey(options, "log-sector-size")) {
> +        log_sector_size = qdict_get_int(options, "log-sector-size");

This works with -blockdev and QMP blockdev-add, but not with -drive. The
problem is that the options QDict may contain the option in the proper
data type as specified in the QAPI schema, but it may also contain it as
a string in other code paths.

Other block drivers solve this by using QemuOpts for the driver options,
which can accept both types.

As an example for the failure, this command line segfaults for me:

$ x86_64-softmmu/qemu-system-x86_64 -drive driver=blklogwrites,file.filename=/home/kwolf/images/hd.img,log.filename=/tmp/test.log,log-sector-size=512

> +        qdict_del(options, "log-sector-size");
> +    }
> +
> +    if (log_sector_size < 0 || log_sector_size >= (1ull << 32) ||

Maybe we should set a lower, more reasonable limit even if the log file
format would allow more.

If you allow a 2 GB sector size, QEMU will have to allocate a 2 GB
bounce buffer for every write request, which is just insane and might
easily DoS the VM because a memory allocation failure could bring QEMU
down.

> +        !is_power_of_2(log_sector_size))
> +    {
> +        ret = -EINVAL;
> +        error_setg(errp, "Invalid log sector size %"PRId64, log_sector_size);
> +        goto fail;
> +    }
> +
> +    s->sectorsize = log_sector_size;
> +    s->sectorbits = blk_log_writes_log2(log_sector_size);
> +    s->cur_log_sector = 1;
> +    s->nr_entries = 0;
> +
> +    /* Open the log file */
> +    s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_file, false,
> +                                  &local_err);
> +    if (local_err) {
> +        ret = -EINVAL;
> +        error_propagate(errp, local_err);
> +        goto fail;
> +    }
> +
> +    ret = 0;
> +fail:
> +    if (ret < 0) {
> +        bdrv_unref_child(bs, bs->file);
> +        bs->file = NULL;
> +    }
> +    return ret;
> +}
> +
> +static void blk_log_writes_close(BlockDriverState *bs)
> +{
> +    BDRVBlkLogWritesState *s = bs->opaque;
> +
> +    bdrv_unref_child(bs, s->log_file);
> +    s->log_file = NULL;
> +}
> +
> +static int64_t blk_log_writes_getlength(BlockDriverState *bs)
> +{
> +    return bdrv_getlength(bs->file->bs);
> +}
> +
> +static void blk_log_writes_refresh_filename(BlockDriverState *bs,
> +                                            QDict *options)
> +{
> +    BDRVBlkLogWritesState *s = bs->opaque;
> +
> +    /* bs->file->bs has already been refreshed */
> +    bdrv_refresh_filename(s->log_file->bs);
> +
> +    if (bs->file->bs->full_open_options
> +        && s->log_file->bs->full_open_options)
> +    {
> +        QDict *opts = qdict_new();
> +        qdict_put_str(opts, "driver", "blklogwrites");
> +
> +        qobject_ref(bs->file->bs->full_open_options);
> +        qdict_put_obj(opts, "file", QOBJECT(bs->file->bs->full_open_options));
> +        qobject_ref(s->log_file->bs->full_open_options);
> +        qdict_put_obj(opts, "log",
> +                      QOBJECT(s->log_file->bs->full_open_options));

log_sector_size is missing here.

> +        bs->full_open_options = opts;
> +    }
> +}
> +
> +static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                                      const BdrvChildRole *role,
> +                                      BlockReopenQueue *ro_q,
> +                                      uint64_t perm, uint64_t shrd,
> +                                      uint64_t *nperm, uint64_t *nshrd)
> +{
> +    if (!c) {
> +        *nperm = perm & DEFAULT_PERM_PASSTHROUGH;
> +        *nshrd = (shrd & DEFAULT_PERM_PASSTHROUGH) | DEFAULT_PERM_UNCHANGED;
> +        return;
> +    }
> +
> +    if (!strcmp(c->name, "log")) {
> +        bdrv_format_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
> +    } else {
> +        bdrv_filter_default_perms(bs, c, role, ro_q, perm, shrd, nperm, nshrd);
> +    }
> +}
> +
> +static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    BDRVBlkLogWritesState *s = bs->opaque;
> +    bs->bl.request_alignment = s->sectorsize;
> +}
> +
> +static int coroutine_fn
> +blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +                         QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +}
> +
> +typedef struct BlkLogWritesFileReq {
> +    BlockDriverState *bs;
> +    uint64_t offset;
> +    uint64_t bytes;
> +    int file_flags;
> +    QEMUIOVector *qiov;
> +    int (*func)(struct BlkLogWritesFileReq *r);
> +    int file_ret;
> +} BlkLogWritesFileReq;
> +
> +typedef struct {
> +    BlockDriverState *bs;
> +    QEMUIOVector *qiov;
> +    struct log_write_entry entry;
> +    uint64_t zero_size;
> +    int log_ret;
> +} BlkLogWritesLogReq;
> +
> +static void coroutine_fn blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
> +{
> +    BDRVBlkLogWritesState *s = lr->bs->opaque;
> +    uint64_t cur_log_offset = s->cur_log_sector << s->sectorbits;
> +
> +    s->nr_entries++;
> +    s->cur_log_sector +=
> +            ROUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;

Calculations like this could be simplified with DIV_ROUND_UP().

The rest looks good to me. If you can send a new version quickly, I can
still include it in my last pull request before the freeze in an hour or
two. Otherwise, I think I can merge it and we'll fix the problems during
the RC phase.

Kevin
