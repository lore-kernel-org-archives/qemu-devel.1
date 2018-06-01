Received: from eggs.gnu.org ([2001:4830:134:3::10]:55086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOk9r-0001Fq-3q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fOk9p-0000s5-7n
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:31:55 -0400
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <8ccfcf94-2282-b56b-4b79-41c05551d26d@tuxera.com>
Date: Fri, 1 Jun 2018 16:31:43 +0300
MIME-Version: 1.0
In-Reply-To: <e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>

On 06/01/2018 03:26 PM, Eric Blake wrote:
> On 05/31/2018 04:17 PM, Ari Sundholm wrote:
>> From: Aapo Vienamo <aapo@tuxera.com>
>>
>> Implements a block device write logging system, similar to Linux kerne=
l
>=20
> [meta-comment]
>=20
> Your patch threading is awkward - you forgot a cover letter, and then=20
> you did deep threading (every message in-reply-to the previous) instead=
=20
> of shallow threading (all messages in-reply-to only the 0/5 cover=20
> letter).=C2=A0 This makes it harder for automated tooling to recognize =
your=20
> series properly.
>=20
> More patch submission hints at:
> http://wiki.qemu.org/Contribute/SubmitAPatch
>=20

Thank you, I will improve this in the next version. I was not aware that=20
the threading choice breaks the tooling. I should definitely have=20
included a cover letter and perhaps moved some of the comment in the=20
first patch there, with more explanation about some of the choices made.

>> device mapper dm-log-writes. The write operations that are performed
>> on a block device are logged to a file or another block device. The
>> write log format is identical to the dm-log-writes format. Currently,
>> log markers are not supported.
>>
>> This functionality can be used for fail-safe and fs consistency
>> testing. By implementing it in qemu, tests utilizing write logs can be
>> be used to test non-Linux drivers and older kernels.
>>
>> The implementation is based on the blkverify and blkdebug block driver=
s.
>>
>> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>> ---
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 -
>> =C2=A0 block/Makefile.objs=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 block/blklogwrites.c=C2=A0 | 441=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 include/block/block.h |=C2=A0=C2=A0 7 +
>> =C2=A0 4 files changed, 449 insertions(+), 6 deletions(-)
>> =C2=A0 create mode 100644 block/blklogwrites.c
>=20
> Without a cover letter, I'll have to read the entire series to see if=20
> there is something obviously missing.=C2=A0 For example, I don't yet kn=
ow if=20
> a later patch adds to qapi/block-core.json to allow creation of this ne=
w=20
> block device from QMP.
>=20
>>
>> diff --git a/block.c b/block.c
>> index 501b64c..c8cffe1 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1914,12 +1914,6 @@ int bdrv_child_try_set_perm(BdrvChild *c,=20
>> uint64_t perm, uint64_t shared,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> -#define DEFAULT_PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BLK_PERM_WRITE \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BLK_PERM_WRITE_UNCHANG=
ED \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BLK_PERM_RESIZE)
>> -#define DEFAULT_PERM_UNCHANGED (BLK_PERM_ALL &=20
>> ~DEFAULT_PERM_PASSTHROUGH)
>> -
>=20
> Your commit message didn't mention why this code motion was necessary;=20
> in fact, if it IS necessary, it might be better to split it off into a=20
> separate patch.
>=20

This was just to allow using these constants outside of block.c. Will=20
split this off into a separate patch, as requested.

>> +++ b/block/blklogwrites.c
>> @@ -0,0 +1,441 @@
>> +/*
>> + * Write logging blk driver based on blkverify and blkdebug.
>> + *
>> + * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
>> + * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
>> + * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
=20
>> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/sockets.h" /* for EINPROGRESS on Windows */
>> +#include "block/block_int.h"
>> +#include "qapi/qmp/qdict.h"
>> +#include "qapi/qmp/qstring.h"
>> +#include "qemu/cutils.h"
>> +#include "qemu/option.h"
>> +
>> +/* Disk format stuff - taken from Linux drivers/md/dm-log-writes.c */
>=20
> Your copyright claims GPLv2+; but drivers/md/dm-log-writes.c states onl=
y=20
> "* This file is released under the GPL." - I guess that means you're=20
> okay (parts of Linux are GPLv2-only, which we can't copy into a GPLv2+=20
> file).
>=20

I consulted legal counsel on this part, and it is our opinion that the=20
constants and structs taken from the Linux kernel are insignificant and=20
required for compatibility, so it should be OK to license the file as=20
GPLv2+ in any case. Just to confirm, do you see this differently?

>> +
>> +/* Valid blk_log_writes filenames look like:
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_log_writes:path/to/raw_image:pat=
h/to/logfile */
>> +static void blk_log_writes_parse_filename(const char *filename, QDict=
=20
>> *options,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>=20
> Do we still want to support yet another legacy syntax addition?=C2=A0 I=
'd=20
> rather just require the user to pass in a valid --blockdev specificatio=
n=20
> (which implies that you MUST support a QMP description), and skip the=20
> legacy syntax altogether.
>=20

I believe this was inherited from blkverify, which was used as a basis.=20
I will have to do some research into how to do this properly for this=20
kind of a driver which requires multiple filenames. Any pointers would=20
be appreciated.

>> +
>> +static QemuOptsList runtime_opts =3D {
>> +=C2=A0=C2=A0=C2=A0 .name =3D "blk_log_writes",
>> +=C2=A0=C2=A0=C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.hea=
d),
>> +=C2=A0=C2=A0=C2=A0 .desc =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "x-raw",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_STRING,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .h=
elp =3D "[internal use only, will be removed]",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n=
ame =3D "x-log",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .t=
ype =3D QEMU_OPT_STRING,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .h=
elp =3D "[internal use only, will be removed]",
>=20
> And the fact that you are adding internal options from the getgo points=
=20
> to the fact that we really want a QMP interface.
>=20

Will try to find out how to do this properly.

>=20
>> +static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error=
=20
>> **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (bs->bl.request_alignment < BDRV_SECTOR_SIZE) {
>=20
> Why do you need sector alignment?=C2=A0 And in what cases would=20
> bs->bl.request_alignment be larger than sector alignment (does the bloc=
k=20
> layer take into account if your log file and/or child BDS already have =
a=20
> larger alignment?)
>=20

Sector alignment is needed because the write logging takes place at=20
sector granularity. Each write log entry contains the sector offset and=20
the number of sectors the write spanned. I'll try to make this clearer=20
in the next version.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.request_alignment =3D=
 BDRV_SECTOR_SIZE;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->bl.pdiscard_alignm=
ent &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bs->bl.pdiscard_alignment < bs->bl.request_alignmen=
t)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs=
->bl.pdiscard_alignment =3D bs->bl.request_alignment;
>=20
> Every 'if' MUST use {}.=C2=A0 scripts/checkpatch.pl should have flagged=
 this.
>=20

Thanks, will fix this and other instances.

>> +static void coroutine_fn blk_log_writes_co_do_log(void *opaque)
>> +{
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 lr->r->done++;
>> +=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter_if_inactive(lr->r->co);
>> +}
>> +
>> +static void blk_log_writes_co_do_file(void *opaque)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BlkLogWritesFileReq *fr =3D opaque;
>> +
>> +=C2=A0=C2=A0=C2=A0 fr->file_ret =3D fr->func(fr);
>> +
>> +=C2=A0=C2=A0=C2=A0 fr->r->done++;
>=20
> Two non-atomic increments...
>=20
>> +=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter_if_inactive(fr->r->co);
>> +}
>> +
>> +static int coroutine_fn
>> +blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t=
=20
>> bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *q=
iov, int flags,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*file_func=
)(BlkLogWritesFileReq *r),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t entry_=
flags)
>> +{
>=20
>> +=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter(co_file);
>> +=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter(co_log);
>> +
>> +=C2=A0=C2=A0=C2=A0 while (r.done < 2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_yield();
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> ...used as the condition for waiting.=C2=A0 Since the point of coroutin=
es is=20
> to allow (restricted) parallel operation, there's a chance that the=20
> coroutine implementation can be utilizing parallel threads; if that's=20
> the case, then on the rare race when both threads try to increment at=20
> near the same time, they can both read 0 and write 1, at which point=20
> this wait loop would be an infinite loop.=C2=A0 You're probably better =
off=20
> using atomics (even if I'm wrong about coroutines being able to race=20
> each other on the increment, as the other point of coroutines is that=20
> they provide restricted parallelism where you can also implement them i=
n=20
> only a single thread because of well-defined yield points).
>=20

Inherited from blkverify, I believe. Will fix.

>=20
>> +static BlockDriver bdrv_blk_log_writes =3D {
>> +=C2=A0=C2=A0=C2=A0 .format_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "blk_log_writes",
>> +=C2=A0=C2=A0=C2=A0 .protocol_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D "blk_log_writes",
>> +=C2=A0=C2=A0=C2=A0 .instance_size=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D sizeof(BDRVBlkLogWritesState),
>> +
>> +=C2=A0=C2=A0=C2=A0 .bdrv_parse_filename=C2=A0=C2=A0=C2=A0 =3D blk_log=
_writes_parse_filename,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_file_open=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D blk_log_writes_open,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_close=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D blk_log_writes_close,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_getlength=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D blk_log_writes_getlength,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_refresh_filename=C2=A0 =3D blk_log_writes_re=
fresh_filename,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_child_perm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D blk_log_writes_child_perm,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_refresh_limits=C2=A0=C2=A0=C2=A0 =3D blk_log=
_writes_refresh_limits,
>> +
>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_preadv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D blk_log_writes_co_preadv,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_pwritev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D blk_log_writes_co_pwritev,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_flush_to_disk=C2=A0 =3D blk_log_writes_co=
_flush_to_disk,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_pdiscard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D blk_log_writes_co_pdiscard,
>> +
>> +=C2=A0=C2=A0=C2=A0 .is_filter=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D true,
>> +};
>=20
> No .bdrv_co_pwrite_zeroes support?=C2=A0 While the block layer will emu=
late=20
> zero support on top of .bdrv_co_pwritev, that is probably a performance=
=20
> killer compared to you implementing it directly.
>=20

I see. I'll have to consider the implications with regard to accurate=20
write logging to see if this is feasible and desirable.

> Also, you probably want .bdrv_co_block_status =3D=20
> bdrv_co_block_status_from_file, so that the block layer sees the=20
> underlying device's block status rather than treating the entire device=
=20
> as non-sparse.
>=20

Thank you, will look into this.

Best regards,
Ari Sundholm
ari@tuxera.com
