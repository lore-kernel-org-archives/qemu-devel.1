Received: from eggs.gnu.org ([2001:4830:134:3::10]:50359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQE92-0000ya-Cz
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQE90-0007PB-Gd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:40:40 -0400
Date: Wed, 28 Jun 2017 16:40:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628144012.GH5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC v3 3/8] block: add throttle block
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
> block/throttle.c uses existing I/O throttle infrastructure inside a
> block filter driver. I/O operations are intercepted in the filter's
> read/write coroutines, and referred to block/throttle-groups.c
> 
> The driver can be used with the command
> -drive driver=throttle,file.filename=foo.qcow2,iops-total=...
> The configuration flags and semantics are identical to the hardcoded
> throttling ones.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/Makefile.objs             |   1 +
>  block/throttle.c                | 427 ++++++++++++++++++++++++++++++++++++++++
>  include/qemu/throttle-options.h |  60 ++++--
>  3 files changed, 469 insertions(+), 19 deletions(-)
>  create mode 100644 block/throttle.c
> 
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index ea955302c8..bb811a4d01 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -25,6 +25,7 @@ block-obj-y += accounting.o dirty-bitmap.o
>  block-obj-y += write-threshold.o
>  block-obj-y += backup.o
>  block-obj-$(CONFIG_REPLICATION) += replication.o
> +block-obj-y += throttle.o
>  
>  block-obj-y += crypto.o
>  
> diff --git a/block/throttle.c b/block/throttle.c
> new file mode 100644
> index 0000000000..0c17051161
> --- /dev/null
> +++ b/block/throttle.c
> @@ -0,0 +1,427 @@
> +/*
> + * QEMU block throttling filter driver infrastructure
> + *
> + * Copyright (c) 2017 Manos Pitsidianakis
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Please consider using the LGPL. We're still hoping to turn the block
layer into a library one day, and almost all code in it is licensed
liberally (MIT or LGPL).

> +#include "qemu/osdep.h"
> +#include "block/throttle-groups.h"
> +#include "qemu/throttle-options.h"
> +#include "qapi/error.h"
> +
> +
> +static QemuOptsList throttle_opts = {
> +    .name = "throttle",
> +    .head = QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
> +    .desc = {
> +        {
> +            .name = QEMU_OPT_IOPS_TOTAL,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "limit total I/O operations per second",
> +        },{
> +            .name = QEMU_OPT_IOPS_READ,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "limit read operations per second",
> +        },{
> +            .name = QEMU_OPT_IOPS_WRITE,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "limit write operations per second",
> +        },{
> +            .name = QEMU_OPT_BPS_TOTAL,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "limit total bytes per second",
> +        },{
> +            .name = QEMU_OPT_BPS_READ,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "limit read bytes per second",
> +        },{
> +            .name = QEMU_OPT_BPS_WRITE,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "limit write bytes per second",
> +        },{
> +            .name = QEMU_OPT_IOPS_TOTAL_MAX,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "I/O operations burst",
> +        },{
> +            .name = QEMU_OPT_IOPS_READ_MAX,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "I/O operations read burst",
> +        },{
> +            .name = QEMU_OPT_IOPS_WRITE_MAX,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "I/O operations write burst",
> +        },{
> +            .name = QEMU_OPT_BPS_TOTAL_MAX,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "total bytes burst",
> +        },{
> +            .name = QEMU_OPT_BPS_READ_MAX,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "total bytes read burst",
> +        },{
> +            .name = QEMU_OPT_BPS_WRITE_MAX,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "total bytes write burst",
> +        },{
> +            .name = QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "length of the iopstotalmax burst period, in seconds",
> +        },{
> +            .name = QEMU_OPT_IOPS_READ_MAX_LENGTH,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "length of the iopsreadmax burst period, in seconds",
> +        },{
> +            .name = QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "length of the iopswritemax burst period, in seconds",
> +        },{
> +            .name = QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "length of the bpstotalmax burst period, in seconds",
> +        },{
> +            .name = QEMU_OPT_BPS_READ_MAX_LENGTH,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "length of the bpsreadmax burst period, in seconds",
> +        },{
> +            .name = QEMU_OPT_BPS_WRITE_MAX_LENGTH,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "length of the bpswritemax burst period, in seconds",
> +        },{
> +            .name = QEMU_OPT_IOPS_SIZE,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "when limiting by iops max size of an I/O in bytes",
> +        },
> +        {
> +            .name = QEMU_OPT_THROTTLE_GROUP_NAME,
> +            .type = QEMU_OPT_STRING,
> +            .help = "throttle group name",
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +/* Extract ThrottleConfig options. Assumes cfg is initialized and will be
> + * checked for validity.
> + */
> +
> +static void throttle_extract_options(QemuOpts *opts, ThrottleConfig *cfg)
> +{
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL)) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ)) {
> +        cfg->buckets[THROTTLE_BPS_READ].avg  =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE)) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].avg =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL)) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].avg =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ)) {
> +        cfg->buckets[THROTTLE_OPS_READ].avg =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE)) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].avg =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX)) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX)) {
> +        cfg->buckets[THROTTLE_BPS_READ].max  =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX)) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].max =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX)) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX)) {
> +        cfg->buckets[THROTTLE_OPS_READ].max =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX)) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].max =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX, 0);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH)) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX_LENGTH)) {
> +        cfg->buckets[THROTTLE_BPS_READ].burst_length  =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH)) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =
> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH)) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH)) {
> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH)) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1);
> +    }
> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_SIZE)) {
> +        cfg->op_size =
> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_SIZE, 0);
> +    }
> +}
> +
> +static int throttle_configure_tgm(BlockDriverState *bs, ThrottleGroupMember *tgm,
> +                                                    QDict *options, Error **errp)

Both lines exceed 80 characters. The indentation is off, too: QDict on
the second line should be aligned with BlockDriverState on the first
one.

> +{
> +    int ret = 0;
> +    ThrottleState *ts;
> +    ThrottleTimers *tt;
> +    ThrottleConfig cfg;
> +    QemuOpts *opts = NULL;
> +    const char *group_name = NULL;
> +    Error *local_err = NULL;
> +
> +    opts = qemu_opts_create(&throttle_opts, NULL, 0, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +    qemu_opts_absorb_qdict(opts, options, &local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    group_name = qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
> +    if (!group_name) {
> +        group_name = bdrv_get_device_or_node_name(bs);

This is a legacy function, we should avoid adding new callers.

Worse yet, if the group isn't specified, we want to create a new
group internally just for this throttle node. But nothing stops the user
from creating a group that is named like the device or node name of
another throttle node, so we might end up attaching to an existing
throttle group instead!

I think throttle groups should be anonymous rather than having a default
name if they are created implicitly.

> +        if (!strlen(group_name)) {

More efficiently written as if (!*group_name), but it should go away
anyway when you address the above comment.

> +            error_setg(&local_err,
> +                       "A group name must be specified for this device.");

You can directly set errp and avoid the error_propagate() later.

> +            goto err;
> +        }
> +    }
> +
> +    tgm->aio_context = bdrv_get_aio_context(bs);
> +    /* Register membership to group with name group_name */
> +    throttle_group_register_tgm(tgm, group_name);
> +
> +    ts = tgm->throttle_state;
> +    /* Copy previous configuration */
> +    throttle_get_config(ts, &cfg);
> +
> +    /* Change limits if user has specified them */
> +    throttle_extract_options(opts, &cfg);
> +    if (!throttle_is_valid(&cfg, &local_err)) {

Here errp can directly be used, too.

You only need the &local_err idiom if you want to check whether an error
was set (because the caller might pass errp == NULL and then you can't
tell whether an error occurred or not).

> +        throttle_group_unregister_tgm(tgm);
> +        goto err;
> +    }
> +    tt = &tgm->throttle_timers;
> +    /* Update group configuration */
> +    throttle_config(ts, tt, &cfg);
> +
> +    qemu_co_queue_init(&tgm->throttled_reqs[0]);
> +    qemu_co_queue_init(&tgm->throttled_reqs[1]);
> +
> +    goto fin;

I prefer an explicit ret = 0 right here because ret tends to be used to
store the return value for all kinds of functions. In this specific
case, it's still 0 from the initialisation, but that's easy to break
accidentally in a future patch.

> +
> +err:
> +    error_propagate(errp, local_err);
> +    ret = -EINVAL;
> +fin:
> +    qemu_opts_del(opts);
> +    return ret;
> +}
> +
> +static int throttle_open(BlockDriverState *bs, QDict *options,
> +                            int flags, Error **errp)
> +{
> +    ThrottleGroupMember *tgm = bs->opaque;
> +    Error *local_err = NULL;
> +
> +    bs->open_flags = flags;
> +    bs->file = bdrv_open_child(NULL, options, "file",
> +                                    bs, &child_file, false, &local_err);
> +
> +    if (local_err) {

If you check bs->file == NULL instead, you can avoid local_err.

> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +
> +    qdict_flatten(options);

Why do you need this? options should already be flattened.

> +    return throttle_configure_tgm(bs, tgm, options, errp);
> +}
> +
> +static void throttle_close(BlockDriverState *bs)
> +{
> +    ThrottleGroupMember *tgm = bs->opaque;
> +    bdrv_drained_begin(bs);
> +    throttle_group_unregister_tgm(tgm);
> +    bdrv_drained_end(bs);
> +    return;

This is a useless return statement. I think I've seen compilers warn
about it (and we use -Werror, so this would be a build failure on them).

bdrv_drained_begin/end should be unnecessary in .bdrv_close
implementations, we always drain all requests before calling the
callback.

> +}
> +
> +
> +static int64_t throttle_getlength(BlockDriverState *bs)
> +{
> +    return bdrv_getlength(bs->file->bs);
> +}
> +
> +
> +static int coroutine_fn throttle_co_preadv(BlockDriverState *bs, uint64_t offset,

This line exceeds 80 characters.

> +                                            uint64_t bytes, QEMUIOVector *qiov,
> +                                            int flags)

Indentation is off by one.

> +{
> +
> +    ThrottleGroupMember *tgm = bs->opaque;
> +    throttle_group_co_io_limits_intercept(tgm, bytes, false);
> +
> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs, uint64_t offset,

Another long line.

> +                                            uint64_t bytes, QEMUIOVector *qiov,
> +                                            int flags)
> +{
> +    ThrottleGroupMember *tgm = bs->opaque;
> +    throttle_group_co_io_limits_intercept(tgm, bytes, true);
> +
> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +}

Kevin
