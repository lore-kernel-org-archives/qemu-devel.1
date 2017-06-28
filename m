Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQEny-0004XH-JB
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQEnw-0002gD-Hh
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:22:58 -0400
Date: Wed, 28 Jun 2017 18:22:09 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170628152209.hf6iqosa24b3nocc@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170628144012.GH5378@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xk34msqfe6mvmx2g"
Content-Disposition: inline
In-Reply-To: <20170628144012.GH5378@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--xk34msqfe6mvmx2g
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 04:40:12PM +0200, Kevin Wolf wrote:
>Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
>> block/throttle.c uses existing I/O throttle infrastructure inside a
>> block filter driver. I/O operations are intercepted in the filter's
>> read/write coroutines, and referred to block/throttle-groups.c
>>
>> The driver can be used with the command
>> -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2,iops-total=3D...
>> The configuration flags and semantics are identical to the hardcoded
>> throttling ones.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block/Makefile.objs             |   1 +
>>  block/throttle.c                | 427 +++++++++++++++++++++++++++++++++=
+++++++
>>  include/qemu/throttle-options.h |  60 ++++--
>>  3 files changed, 469 insertions(+), 19 deletions(-)
>>  create mode 100644 block/throttle.c
>>
>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>> index ea955302c8..bb811a4d01 100644
>> --- a/block/Makefile.objs
>> +++ b/block/Makefile.objs
>> @@ -25,6 +25,7 @@ block-obj-y +=3D accounting.o dirty-bitmap.o
>>  block-obj-y +=3D write-threshold.o
>>  block-obj-y +=3D backup.o
>>  block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>> +block-obj-y +=3D throttle.o
>>
>>  block-obj-y +=3D crypto.o
>>
>> diff --git a/block/throttle.c b/block/throttle.c
>> new file mode 100644
>> index 0000000000..0c17051161
>> --- /dev/null
>> +++ b/block/throttle.c
>> @@ -0,0 +1,427 @@
>> +/*
>> + * QEMU block throttling filter driver infrastructure
>> + *
>> + * Copyright (c) 2017 Manos Pitsidianakis
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 or
>> + * (at your option) version 3 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>
>Please consider using the LGPL. We're still hoping to turn the block
>layer into a library one day, and almost all code in it is licensed
>liberally (MIT or LGPL).
>
>> +#include "qemu/osdep.h"
>> +#include "block/throttle-groups.h"
>> +#include "qemu/throttle-options.h"
>> +#include "qapi/error.h"
>> +
>> +
>> +static QemuOptsList throttle_opts =3D {
>> +    .name =3D "throttle",
>> +    .head =3D QTAILQ_HEAD_INITIALIZER(throttle_opts.head),
>> +    .desc =3D {
>> +        {
>> +            .name =3D QEMU_OPT_IOPS_TOTAL,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "limit total I/O operations per second",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_READ,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "limit read operations per second",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_WRITE,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "limit write operations per second",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_TOTAL,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "limit total bytes per second",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_READ,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "limit read bytes per second",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_WRITE,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "limit write bytes per second",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_TOTAL_MAX,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "I/O operations burst",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_READ_MAX,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "I/O operations read burst",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_WRITE_MAX,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "I/O operations write burst",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_TOTAL_MAX,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "total bytes burst",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_READ_MAX,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "total bytes read burst",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_WRITE_MAX,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "total bytes write burst",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_TOTAL_MAX_LENGTH,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "length of the iopstotalmax burst period, in seco=
nds",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_READ_MAX_LENGTH,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "length of the iopsreadmax burst period, in secon=
ds",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_WRITE_MAX_LENGTH,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "length of the iopswritemax burst period, in seco=
nds",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_TOTAL_MAX_LENGTH,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "length of the bpstotalmax burst period, in secon=
ds",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_READ_MAX_LENGTH,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "length of the bpsreadmax burst period, in second=
s",
>> +        },{
>> +            .name =3D QEMU_OPT_BPS_WRITE_MAX_LENGTH,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "length of the bpswritemax burst period, in secon=
ds",
>> +        },{
>> +            .name =3D QEMU_OPT_IOPS_SIZE,
>> +            .type =3D QEMU_OPT_NUMBER,
>> +            .help =3D "when limiting by iops max size of an I/O in byte=
s",
>> +        },
>> +        {
>> +            .name =3D QEMU_OPT_THROTTLE_GROUP_NAME,
>> +            .type =3D QEMU_OPT_STRING,
>> +            .help =3D "throttle group name",
>> +        },
>> +        { /* end of list */ }
>> +    },
>> +};
>> +
>> +/* Extract ThrottleConfig options. Assumes cfg is initialized and will =
be
>> + * checked for validity.
>> + */
>> +
>> +static void throttle_extract_options(QemuOpts *opts, ThrottleConfig *cf=
g)
>> +{
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL)) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ)) {
>> +        cfg->buckets[THROTTLE_BPS_READ].avg  =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE)) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL)) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ)) {
>> +        cfg->buckets[THROTTLE_OPS_READ].avg =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE)) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX)) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX)) {
>> +        cfg->buckets[THROTTLE_BPS_READ].max  =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX)) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX)) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX)) {
>> +        cfg->buckets[THROTTLE_OPS_READ].max =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX)) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX, 0);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH)) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_TOTAL_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_READ_MAX_LENGTH)) {
>> +        cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_READ_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH)) {
>> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_BPS_WRITE_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH)) {
>> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_TOTAL_MAX_LENGTH, 1=
);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH)) {
>> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_READ_MAX_LENGTH, 1);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH)) {
>> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_WRITE_MAX_LENGTH, 1=
);
>> +    }
>> +    if (qemu_opt_get(opts, QEMU_OPT_IOPS_SIZE)) {
>> +        cfg->op_size =3D
>> +            qemu_opt_get_number(opts, QEMU_OPT_IOPS_SIZE, 0);
>> +    }
>> +}
>> +
>> +static int throttle_configure_tgm(BlockDriverState *bs, ThrottleGroupMe=
mber *tgm,
>> +                                                    QDict *options, Err=
or **errp)
>
>Both lines exceed 80 characters. The indentation is off, too: QDict on
>the second line should be aligned with BlockDriverState on the first
>one.
>
>> +{
>> +    int ret =3D 0;
>> +    ThrottleState *ts;
>> +    ThrottleTimers *tt;
>> +    ThrottleConfig cfg;
>> +    QemuOpts *opts =3D NULL;
>> +    const char *group_name =3D NULL;
>> +    Error *local_err =3D NULL;
>> +
>> +    opts =3D qemu_opts_create(&throttle_opts, NULL, 0, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return -EINVAL;
>> +    }
>> +    qemu_opts_absorb_qdict(opts, options, &local_err);
>> +    if (local_err) {
>> +        goto err;
>> +    }
>> +
>> +    group_name =3D qemu_opt_get(opts, QEMU_OPT_THROTTLE_GROUP_NAME);
>> +    if (!group_name) {
>> +        group_name =3D bdrv_get_device_or_node_name(bs);
>
>This is a legacy function, we should avoid adding new callers.
>
>Worse yet, if the group isn't specified, we want to create a new
>group internally just for this throttle node. But nothing stops the user
>from creating a group that is named like the device or node name of
>another throttle node, so we might end up attaching to an existing
>throttle group instead!
>
>I think throttle groups should be anonymous rather than having a default
>name if they are created implicitly.

Since we're moving groups to QOM we will need ids for each group. Can=20
objects be anonymous?


>
>> +        if (!strlen(group_name)) {
>
>More efficiently written as if (!*group_name), but it should go away
>anyway when you address the above comment.
>
>> +            error_setg(&local_err,
>> +                       "A group name must be specified for this device.=
");
>
>You can directly set errp and avoid the error_propagate() later.
>
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    tgm->aio_context =3D bdrv_get_aio_context(bs);
>> +    /* Register membership to group with name group_name */
>> +    throttle_group_register_tgm(tgm, group_name);
>> +
>> +    ts =3D tgm->throttle_state;
>> +    /* Copy previous configuration */
>> +    throttle_get_config(ts, &cfg);
>> +
>> +    /* Change limits if user has specified them */
>> +    throttle_extract_options(opts, &cfg);
>> +    if (!throttle_is_valid(&cfg, &local_err)) {
>
>Here errp can directly be used, too.
>
>You only need the &local_err idiom if you want to check whether an error
>was set (because the caller might pass errp =3D=3D NULL and then you can't
>tell whether an error occurred or not).
>
>> +        throttle_group_unregister_tgm(tgm);
>> +        goto err;
>> +    }
>> +    tt =3D &tgm->throttle_timers;
>> +    /* Update group configuration */
>> +    throttle_config(ts, tt, &cfg);
>> +
>> +    qemu_co_queue_init(&tgm->throttled_reqs[0]);
>> +    qemu_co_queue_init(&tgm->throttled_reqs[1]);
>> +
>> +    goto fin;
>
>I prefer an explicit ret =3D 0 right here because ret tends to be used to
>store the return value for all kinds of functions. In this specific
>case, it's still 0 from the initialisation, but that's easy to break
>accidentally in a future patch.
>
>> +
>> +err:
>> +    error_propagate(errp, local_err);
>> +    ret =3D -EINVAL;
>> +fin:
>> +    qemu_opts_del(opts);
>> +    return ret;
>> +}
>> +
>> +static int throttle_open(BlockDriverState *bs, QDict *options,
>> +                            int flags, Error **errp)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    Error *local_err =3D NULL;
>> +
>> +    bs->open_flags =3D flags;
>> +    bs->file =3D bdrv_open_child(NULL, options, "file",
>> +                                    bs, &child_file, false, &local_err);
>> +
>> +    if (local_err) {
>
>If you check bs->file =3D=3D NULL instead, you can avoid local_err.
>
>> +        error_propagate(errp, local_err);
>> +        return -EINVAL;
>> +    }
>> +
>> +    qdict_flatten(options);
>
>Why do you need this? options should already be flattened.
>
>> +    return throttle_configure_tgm(bs, tgm, options, errp);
>> +}
>> +
>> +static void throttle_close(BlockDriverState *bs)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    bdrv_drained_begin(bs);
>> +    throttle_group_unregister_tgm(tgm);
>> +    bdrv_drained_end(bs);
>> +    return;
>
>This is a useless return statement. I think I've seen compilers warn
>about it (and we use -Werror, so this would be a build failure on them).
>
>bdrv_drained_begin/end should be unnecessary in .bdrv_close
>implementations, we always drain all requests before calling the
>callback.
>
>> +}
>> +
>> +
>> +static int64_t throttle_getlength(BlockDriverState *bs)
>> +{
>> +    return bdrv_getlength(bs->file->bs);
>> +}
>> +
>> +
>> +static int coroutine_fn throttle_co_preadv(BlockDriverState *bs, uint64=
_t offset,
>
>This line exceeds 80 characters.
>
>> +                                            uint64_t bytes, QEMUIOVecto=
r *qiov,
>> +                                            int flags)
>
>Indentation is off by one.
>
>> +{
>> +
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_co_io_limits_intercept(tgm, bytes, false);
>> +
>> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +}
>> +
>> +static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs, uint6=
4_t offset,
>
>Another long line.
>
>> +                                            uint64_t bytes, QEMUIOVecto=
r *qiov,
>> +                                            int flags)
>> +{
>> +    ThrottleGroupMember *tgm =3D bs->opaque;
>> +    throttle_group_co_io_limits_intercept(tgm, bytes, true);
>> +
>> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +}
>
>Kevin

Thanks a lot for the comments. (This was one of the first things I=20
wrote, so this is why it is not very idiomatic)

--xk34msqfe6mvmx2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllTyaEACgkQc2J8L2kN
9xC1pRAAuJKHEDlsgdpgQTsGXvGV4VKvITPcSSnzuQui1Xj8vHH7e8WYwDdRRJfH
mqJNmTjiRQuukixooYIYmmts+mdiheGJ0Nb4tOhVLCnavnblXb/Fe3yNIN819JHu
xtCiSPUnWullQD2wvoEptKAnhdCW18jN+FmUxYAZMofITT471gWkiv4ugMj7k6Ov
P+GyfWo+6emV6XeSk71jBNEcBit3FleXRFGh3N861kV4Qck7Gtnm9MGWNgYRfxyj
TouGBQ72DKh/c06L7TiLBY2vGaBZpFPCvpMV5bF4Gx4Zuky5HNgCb4WvyQI9/8km
+CiGJaa0BXVfGhAYRT2R/HlyU6SKwn9zgKxkXwOu2aAiYllU5s3/SC6nyvs7Ull1
RGYB9CxX5LO5n/SHOxclNadIg1Q66kIkrgKbUM2e9+Qw+hc8Yr7V6Mq4nhGEuUra
81fQJ6bdL7cGNku2HyjhEdTEFSTxxdt6MoKK1R4U9DhdsrHWBKpQEXLG4kyQHbDv
tr7BGsBQ3OPvTEGuxCS21tAei+++AsbhckaAp5Uo7pwazWERXQdvMVbbWJ67+dWR
NhbR2jgLmYg+OrZm1HhGIQaeZ28UGVkXYamMIgXxyoqN40txq2O2QuMw27+XmbDX
HLFZLgWL1HxsxT8yL1YiRf4yTOBPRsCAWPCqSm5pq+Lr/SNtGnY=
=5hiM
-----END PGP SIGNATURE-----

--xk34msqfe6mvmx2g--
