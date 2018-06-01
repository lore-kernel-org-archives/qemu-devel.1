Received: from eggs.gnu.org ([2001:4830:134:3::10]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOj8E-0004Cw-I4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOj8C-0003Ng-OG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:26:10 -0400
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
Date: Fri, 1 Jun 2018 07:26:03 -0500
MIME-Version: 1.0
In-Reply-To: <1527801443-30620-1-git-send-email-ari@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>

On 05/31/2018 04:17 PM, Ari Sundholm wrote:
> From: Aapo Vienamo <aapo@tuxera.com>
> 
> Implements a block device write logging system, similar to Linux kernel

[meta-comment]

Your patch threading is awkward - you forgot a cover letter, and then 
you did deep threading (every message in-reply-to the previous) instead 
of shallow threading (all messages in-reply-to only the 0/5 cover 
letter).  This makes it harder for automated tooling to recognize your 
series properly.

More patch submission hints at:
http://wiki.qemu.org/Contribute/SubmitAPatch

> device mapper dm-log-writes. The write operations that are performed
> on a block device are logged to a file or another block device. The
> write log format is identical to the dm-log-writes format. Currently,
> log markers are not supported.
> 
> This functionality can be used for fail-safe and fs consistency
> testing. By implementing it in qemu, tests utilizing write logs can be
> be used to test non-Linux drivers and older kernels.
> 
> The implementation is based on the blkverify and blkdebug block drivers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>   block.c               |   6 -
>   block/Makefile.objs   |   1 +
>   block/blklogwrites.c  | 441 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/block/block.h |   7 +
>   4 files changed, 449 insertions(+), 6 deletions(-)
>   create mode 100644 block/blklogwrites.c

Without a cover letter, I'll have to read the entire series to see if 
there is something obviously missing.  For example, I don't yet know if 
a later patch adds to qapi/block-core.json to allow creation of this new 
block device from QMP.

> 
> diff --git a/block.c b/block.c
> index 501b64c..c8cffe1 100644
> --- a/block.c
> +++ b/block.c
> @@ -1914,12 +1914,6 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
>       return 0;
>   }
>   
> -#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
> -                                 | BLK_PERM_WRITE \
> -                                 | BLK_PERM_WRITE_UNCHANGED \
> -                                 | BLK_PERM_RESIZE)
> -#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH)
> -

Your commit message didn't mention why this code motion was necessary; 
in fact, if it IS necessary, it might be better to split it off into a 
separate patch.

> +++ b/block/blklogwrites.c
> @@ -0,0 +1,441 @@
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

Your copyright claims GPLv2+; but drivers/md/dm-log-writes.c states only 
"* This file is released under the GPL." - I guess that means you're 
okay (parts of Linux are GPLv2-only, which we can't copy into a GPLv2+ 
file).

> +
> +/* Valid blk_log_writes filenames look like:
> + *      blk_log_writes:path/to/raw_image:path/to/logfile */
> +static void blk_log_writes_parse_filename(const char *filename, QDict *options,
> +                                          Error **errp)

Do we still want to support yet another legacy syntax addition?  I'd 
rather just require the user to pass in a valid --blockdev specification 
(which implies that you MUST support a QMP description), and skip the 
legacy syntax altogether.

> +
> +static QemuOptsList runtime_opts = {
> +    .name = "blk_log_writes",
> +    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> +    .desc = {
> +        {
> +            .name = "x-raw",
> +            .type = QEMU_OPT_STRING,
> +            .help = "[internal use only, will be removed]",
> +        },
> +        {
> +            .name = "x-log",
> +            .type = QEMU_OPT_STRING,
> +            .help = "[internal use only, will be removed]",

And the fact that you are adding internal options from the getgo points 
to the fact that we really want a QMP interface.


> +static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    if (bs->bl.request_alignment < BDRV_SECTOR_SIZE) {

Why do you need sector alignment?  And in what cases would 
bs->bl.request_alignment be larger than sector alignment (does the block 
layer take into account if your log file and/or child BDS already have a 
larger alignment?)

> +        bs->bl.request_alignment = BDRV_SECTOR_SIZE;
> +
> +        if (bs->bl.pdiscard_alignment &&
> +                bs->bl.pdiscard_alignment < bs->bl.request_alignment)
> +            bs->bl.pdiscard_alignment = bs->bl.request_alignment;

Every 'if' MUST use {}.  scripts/checkpatch.pl should have flagged this.

> +static void coroutine_fn blk_log_writes_co_do_log(void *opaque)
> +{

> +
> +    lr->r->done++;
> +    qemu_coroutine_enter_if_inactive(lr->r->co);
> +}
> +
> +static void blk_log_writes_co_do_file(void *opaque)
> +{
> +    BlkLogWritesFileReq *fr = opaque;
> +
> +    fr->file_ret = fr->func(fr);
> +
> +    fr->r->done++;

Two non-atomic increments...

> +    qemu_coroutine_enter_if_inactive(fr->r->co);
> +}
> +
> +static int coroutine_fn
> +blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +                      QEMUIOVector *qiov, int flags,
> +                      int (*file_func)(BlkLogWritesFileReq *r),
> +                      uint64_t entry_flags)
> +{

> +    qemu_coroutine_enter(co_file);
> +    qemu_coroutine_enter(co_log);
> +
> +    while (r.done < 2) {
> +        qemu_coroutine_yield();
> +    }

...used as the condition for waiting.  Since the point of coroutines is 
to allow (restricted) parallel operation, there's a chance that the 
coroutine implementation can be utilizing parallel threads; if that's 
the case, then on the rare race when both threads try to increment at 
near the same time, they can both read 0 and write 1, at which point 
this wait loop would be an infinite loop.  You're probably better off 
using atomics (even if I'm wrong about coroutines being able to race 
each other on the increment, as the other point of coroutines is that 
they provide restricted parallelism where you can also implement them in 
only a single thread because of well-defined yield points).


> +static BlockDriver bdrv_blk_log_writes = {
> +    .format_name            = "blk_log_writes",
> +    .protocol_name          = "blk_log_writes",
> +    .instance_size          = sizeof(BDRVBlkLogWritesState),
> +
> +    .bdrv_parse_filename    = blk_log_writes_parse_filename,
> +    .bdrv_file_open         = blk_log_writes_open,
> +    .bdrv_close             = blk_log_writes_close,
> +    .bdrv_getlength         = blk_log_writes_getlength,
> +    .bdrv_refresh_filename  = blk_log_writes_refresh_filename,
> +    .bdrv_child_perm        = blk_log_writes_child_perm,
> +    .bdrv_refresh_limits    = blk_log_writes_refresh_limits,
> +
> +    .bdrv_co_preadv         = blk_log_writes_co_preadv,
> +    .bdrv_co_pwritev        = blk_log_writes_co_pwritev,
> +    .bdrv_co_flush_to_disk  = blk_log_writes_co_flush_to_disk,
> +    .bdrv_co_pdiscard       = blk_log_writes_co_pdiscard,
> +
> +    .is_filter              = true,
> +};

No .bdrv_co_pwrite_zeroes support?  While the block layer will emulate 
zero support on top of .bdrv_co_pwritev, that is probably a performance 
killer compared to you implementing it directly.

Also, you probably want .bdrv_co_block_status = 
bdrv_co_block_status_from_file, so that the block layer sees the 
underlying device's block status rather than treating the entire device 
as non-sparse.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
