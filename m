Received: from eggs.gnu.org ([2001:4830:134:3::10]:51164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1faMg2-0005vz-8M
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1faMfz-0000aq-1g
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:53:10 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:13803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ari@tuxera.com>) id 1faMfy-0000Xp-GW
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:53:06 -0400
From: Ari Sundholm <ari@tuxera.com>
References: <1530305259-19184-1-git-send-email-ari@tuxera.com>
	<1530305259-19184-3-git-send-email-ari@tuxera.com>
	<20180703130604.GE3812@localhost.localdomain>
	<0ae8ea61-be00-cb8a-d01e-27865cf116e0@tuxera.com>
Message-ID: <1ebafde1-aa54-0be7-f90d-f9b219866c34@tuxera.com>
Date: Tue, 3 Jul 2018 17:53:03 +0300
MIME-Version: 1.0
In-Reply-To: <0ae8ea61-be00-cb8a-d01e-27865cf116e0@tuxera.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6 2/2] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>, Max Reitz <mreitz@redhat.com>

On 07/03/2018 05:20 PM, Ari Sundholm wrote:
> On 07/03/2018 04:06 PM, Kevin Wolf wrote:
>> Am 29.06.2018 um 22:47 hat Ari Sundholm geschrieben:
>>> From: Aapo Vienamo <aapo@tuxera.com>
>>>
>>> Implements a block device write logging system, similar to Linux kern=
el
>>> device mapper dm-log-writes. The write operations that are performed
>>> on a block device are logged to a file or another block device. The
>>> write log format is identical to the dm-log-writes format. Currently,
>>> log markers are not supported.
>>>
>>> This functionality can be used for crash consistency and fs consisten=
cy
>>> testing. By implementing it in qemu, tests utilizing write logs can b=
e
>>> be used to test non-Linux drivers and older kernels.
>>>
>>> The driver accepts an optional parameter to set the sector size used
>>> for logging. This makes the driver require all requests to be aligned
>>> to this sector size and also makes offsets and sizes of writes in the
>>> log metadata to be expressed in terms of this value (the log format h=
as
>>> a granularity of one sector for offsets and sizes). This allows
>>> accurate logging of writes to guest block devices that have unusual
>>> sector sizes.
>>>
>>> The implementation is based on the blkverify and blkdebug block
>>> drivers.
>>>
>>> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
>>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>>> ---
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 6 +
>>> =C2=A0 block/Makefile.objs=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 block/blklogwrites.c | 392=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 qapi/block-core.json |=C2=A0 33 ++++-
>>> =C2=A0 4 files changed, 426 insertions(+), 6 deletions(-)
>>> =C2=A0 create mode 100644 block/blklogwrites.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 42a1892..5af89e7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2051,6 +2051,12 @@ S: Supported
>>> =C2=A0 F: block/quorum.c
>>> =C2=A0 L: qemu-block@nongnu.org
>>> +blklogwrites
>>> +M: Ari Sundholm <ari@tuxera.com>
>>> +L: qemu-block@nongnu.org
>>> +S: Supported
>>> +F: block/blklogwrites.c
>>> +
>>> =C2=A0 blkverify
>>> =C2=A0 M: Stefan Hajnoczi <stefanha@redhat.com>
>>> =C2=A0 L: qemu-block@nongnu.org
>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>> index 899bfb5..c8337bf 100644
>>> --- a/block/Makefile.objs
>>> +++ b/block/Makefile.objs
>>> @@ -5,6 +5,7 @@ block-obj-y +=3D qed-check.o
>>> =C2=A0 block-obj-y +=3D vhdx.o vhdx-endian.o vhdx-log.o
>>> =C2=A0 block-obj-y +=3D quorum.o
>>> =C2=A0 block-obj-y +=3D parallels.o blkdebug.o blkverify.o blkreplay.=
o
>>> +block-obj-y +=3D blklogwrites.o
>>> =C2=A0 block-obj-y +=3D block-backend.o snapshot.o qapi.o
>>> =C2=A0 block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
>>> =C2=A0 block-obj-$(CONFIG_POSIX) +=3D file-posix.o
>>> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
>>> new file mode 100644
>>> index 0000000..0748b56
>>> --- /dev/null
>>> +++ b/block/blklogwrites.c
>>> @@ -0,0 +1,392 @@
>>> +/*
>>> + * Write logging blk driver based on blkverify and blkdebug.
>>> + *
>>> + * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
>>> + * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
>>> + * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2=20
>>> or later.
>>> + * See the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "qemu/sockets.h" /* for EINPROGRESS on Windows */
>>> +#include "block/block_int.h"
>>> +#include "qapi/qmp/qdict.h"
>>> +#include "qapi/qmp/qstring.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qemu/option.h"
>>> +
>>> +/* Disk format stuff - taken from Linux drivers/md/dm-log-writes.c *=
/
>>> +
>>> +#define LOG_FLUSH_FLAG=C2=A0=C2=A0 (1 << 0)
>>> +#define LOG_FUA_FLAG=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 1)
>>> +#define LOG_DISCARD_FLAG (1 << 2)
>>> +#define LOG_MARK_FLAG=C2=A0=C2=A0=C2=A0 (1 << 3)
>>> +
>>> +#define WRITE_LOG_VERSION 1ULL
>>> +#define WRITE_LOG_MAGIC 0x6a736677736872ULL
>>> +
>>> +/* All fields are little-endian. */
>>> +struct log_write_super {
>>> +=C2=A0=C2=A0=C2=A0 uint64_t magic;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t version;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t nr_entries;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t sectorsize;
>>> +} QEMU_PACKED;
>>> +
>>> +struct log_write_entry {
>>> +=C2=A0=C2=A0=C2=A0 uint64_t sector;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t nr_sectors;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t flags;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t data_len;
>>> +} QEMU_PACKED;
>>> +
>>> +/* End of disk format structures. */
>>> +
>>> +typedef struct {
>>> +=C2=A0=C2=A0=C2=A0 BdrvChild *log_file;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t sectorsize;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t sectorbits;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t cur_log_sector;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t nr_entries;
>>> +} BDRVBlkLogWritesState;
>>> +
>>> +static inline uint32_t blk_log_writes_log2(uint32_t value)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 assert(value > 0);
>>> +=C2=A0=C2=A0=C2=A0 return 31 - clz32(value);
>>> +}
>>> +
>>> +static int blk_log_writes_open(BlockDriverState *bs, QDict *options,=
=20
>>> int flags,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVBlkLogWritesState *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 int64_t log_sector_size =3D BDRV_SECTOR_SIZE;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Open the file */
>>> +=C2=A0=C2=A0=C2=A0 bs->file =3D bdrv_open_child(NULL, options, "file=
", bs,=20
>>> &child_file, false,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (qdict_haskey(options, "log-sector-size")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_sector_size =3D qdict=
_get_int(options, "log-sector-size");
>>
>> This works with -blockdev and QMP blockdev-add, but not with -drive. T=
he
>> problem is that the options QDict may contain the option in the proper
>> data type as specified in the QAPI schema, but it may also contain it =
as
>> a string in other code paths.
>>
>> Other block drivers solve this by using QemuOpts for the driver option=
s,
>> which can accept both types.
>>
>> As an example for the failure, this command line segfaults for me:
>>
>> $ x86_64-softmmu/qemu-system-x86_64 -drive=20
>> driver=3Dblklogwrites,file.filename=3D/home/kwolf/images/hd.img,log.fi=
lename=3D/tmp/test.log,log-sector-size=3D512=20
>>
>>
>=20
> Thanks, will fix.
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_del(options, "log-s=
ector-size");
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (log_sector_size < 0 || log_sector_size >=3D (=
1ull << 32) ||
>>
>> Maybe we should set a lower, more reasonable limit even if the log fil=
e
>> format would allow more.
>>
>> If you allow a 2 GB sector size, QEMU will have to allocate a 2 GB
>> bounce buffer for every write request, which is just insane and might
>> easily DoS the VM because a memory allocation failure could bring QEMU
>> down.
>>
>=20
> I'll set the limit at a more conservative 8 MB. That's still quite a bi=
g=20
> number, but may be useful.
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !is_power_of_2(log_sector=
_size))
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Invalid=
 log sector size %"PRId64,=20
>>> log_sector_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->sectorsize =3D log_sector_size;
>>> +=C2=A0=C2=A0=C2=A0 s->sectorbits =3D blk_log_writes_log2(log_sector_=
size);
>>> +=C2=A0=C2=A0=C2=A0 s->cur_log_sector =3D 1;
>>> +=C2=A0=C2=A0=C2=A0 s->nr_entries =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Open the log file */
>>> +=C2=A0=C2=A0=C2=A0 s->log_file =3D bdrv_open_child(NULL, options, "l=
og", bs,=20
>>> &child_file, false,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>> +fail:
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unref_child(bs, bs->=
file);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->file =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +static void blk_log_writes_close(BlockDriverState *bs)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVBlkLogWritesState *s =3D bs->opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bdrv_unref_child(bs, s->log_file);
>>> +=C2=A0=C2=A0=C2=A0 s->log_file =3D NULL;
>>> +}
>>> +
>>> +static int64_t blk_log_writes_getlength(BlockDriverState *bs)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return bdrv_getlength(bs->file->bs);
>>> +}
>>> +
>>> +static void blk_log_writes_refresh_filename(BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *options)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVBlkLogWritesState *s =3D bs->opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* bs->file->bs has already been refreshed */
>>> +=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(s->log_file->bs);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bs->file->bs->full_open_options
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && s->log_file->bs->full_=
open_options)
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *opts =3D qdict_new=
();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_put_str(opts, "driv=
er", "blklogwrites");
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_ref(bs->file->bs-=
>full_open_options);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_put_obj(opts, "file=
",=20
>>> QOBJECT(bs->file->bs->full_open_options));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_ref(s->log_file->=
bs->full_open_options);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_put_obj(opts, "log"=
,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QOBJECT(s->log_=
file->bs->full_open_options));
>>
>> log_sector_size is missing here.
>>
>=20
> Oops, will fix.
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->full_open_options =3D=
 opts;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static void blk_log_writes_child_perm(BlockDriverState *bs,=20
>>> BdrvChild *c,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const BdrvChildRole *role,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BlockReopenQueue *ro_q,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t perm, uint64_t shrd,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *nperm, uint64_t *nshrd)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (!c) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *nperm =3D perm & DEFAULT=
_PERM_PASSTHROUGH;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *nshrd =3D (shrd & DEFAUL=
T_PERM_PASSTHROUGH) |=20
>>> DEFAULT_PERM_UNCHANGED;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!strcmp(c->name, "log")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_format_default_perms=
(bs, c, role, ro_q, perm, shrd,=20
>>> nperm, nshrd);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_filter_default_perms=
(bs, c, role, ro_q, perm, shrd,=20
>>> nperm, nshrd);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static void blk_log_writes_refresh_limits(BlockDriverState *bs,=20
>>> Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVBlkLogWritesState *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 bs->bl.request_alignment =3D s->sectorsize;
>>> +}
>>> +
>>> +static int coroutine_fn
>>> +blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset,=20
>>> uint64_t bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 QEMUIOVector *qiov, int flags)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return bdrv_co_preadv(bs->file, offset, bytes, qi=
ov, flags);
>>> +}
>>> +
>>> +typedef struct BlkLogWritesFileReq {
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t offset;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t bytes;
>>> +=C2=A0=C2=A0=C2=A0 int file_flags;
>>> +=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov;
>>> +=C2=A0=C2=A0=C2=A0 int (*func)(struct BlkLogWritesFileReq *r);
>>> +=C2=A0=C2=A0=C2=A0 int file_ret;
>>> +} BlkLogWritesFileReq;
>>> +
>>> +typedef struct {
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov;
>>> +=C2=A0=C2=A0=C2=A0 struct log_write_entry entry;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t zero_size;
>>> +=C2=A0=C2=A0=C2=A0 int log_ret;
>>> +} BlkLogWritesLogReq;
>>> +
>>> +static void coroutine_fn blk_log_writes_co_do_log(BlkLogWritesLogReq=
=20
>>> *lr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVBlkLogWritesState *s =3D lr->bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t cur_log_offset =3D s->cur_log_sector << =
s->sectorbits;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->nr_entries++;
>>> +=C2=A0=C2=A0=C2=A0 s->cur_log_sector +=3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R=
OUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;
>>
>> Calculations like this could be simplified with DIV_ROUND_UP().
>>
>=20
> We explicitly wanted to use shifts here, as division and multiplication=
=20
> can be slow on certain platforms and in this case can be replaced by=20
> shifts.
>=20
>> The rest looks good to me. If you can send a new version quickly, I ca=
n
>> still include it in my last pull request before the freeze in an hour =
or
>> two. Otherwise, I think I can merge it and we'll fix the problems duri=
ng
>> the RC phase.
>>
>=20
> I'll send a new version within the hour, if everything goes well with=20
> the changes I'm making based on your review.
>=20

Just a quick note off-list that I just sent v7.

> Thank you for the review,
> Ari Sundholm
> ari@tuxera.com
>=20
