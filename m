Received: from eggs.gnu.org ([209.51.188.92]:60988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1HEq-0000sO-Tu
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1HEp-0002e0-Gl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:04:36 -0500
References: <20190227111347.15063-1-alex.bennee@linaro.org>
	<87r2bl5oah.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1a4d4fa0-3fd5-32ae-fcc3-dcd0376d0c28@redhat.com>
Date: Tue, 5 Mar 2019 22:04:10 +0100
MIME-Version: 1.0
In-Reply-To: <87r2bl5oah.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 03/05/19 16:33, Markus Armbruster wrote:
> You neglected to cc: the maintainers of hw/block, I fixed that for you.
>=20
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>=20
>> It looks like there was going to be code to check we had some sort of
>> alignment so lets replace it with an actual check. This is a bit more
>> useful than the enigmatic "failed to read the initial flash content"
>> when we attempt to read the number of bytes the device should have.
>>
>> This is a potential confusing stumbling block when you move from using
>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly fo=
r
>> loading your firmware code. To mitigate that we automatically pad in
>> the read-only case and warn the user when we have performed magic to
>> enable things to Just Work (tm).
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>=20
> Philippe and I talked about various pflash issues last night.  He
> explained to me how physical flash memory works and is used.  This
> brought back my doubts on the wisdom of automatic padding.
>=20
> Errors in my recounting of his explanations are almost certainly
> entirely mine.  Please correct them.
>=20
> We're talking about NOR flash.  NAND flash works differently.
>=20
> You can:
>=20
> * Read a cell.
>=20
> * Write a cell: change it from 1 to 0.
>=20
> * Erase a whole sector (block): change all cells to 1.  This is slow,
>   burns power, and you can do it only so often before the flash wears
>   out
>=20
> Say your physical machine has 1 MiB of NOR flash in 16 sectors of 64 Ki=
B
> each (unrealistic, as Philippe has pointed out elsewhere, but it'll do
> here).  You compile your firmware, and the build process spits out a
> flat image of 200000 bytes.  Here are a few distinct ways to deploy it
> to your freshly erased flash memory:
>=20
> (1) You write your image to the flash.  Everything after byte 200000
> remains writable.  This is nice for development.  With a bit of
> ingenuity, you can come up with a patching scheme that lets you avoid
> rewriting the whole flash for every little fix, saving flash wear.
>=20
> (2) You zero-pad your image to the full flash size, and write that to
> the flash.  Everything after byte 200000 becomes unwritable.  You can't
> erase the first 4 blocks (they hold your firmware), but you can still
> erase the remaining 12.
>=20
> (3) You zero-pad your image to the next sector boundary, and write that
> to the flash.  The remainder of block 4 becomes unwritable (and you
> can't erase the block without destroying your firmware).  The remaining
> 12 blocks remain writable.  This is commonly done for production,
> because it reduces the ways a sector holding code can be corrupted,
> making its checksum invalid.
>=20
> My point is: in the physical world, there is no single true way to pad.
>=20
> Back to your patch.  I think it conflates three changes:
>=20
> * We reject an undersized image with a sub-optimal error message.
>   Improve that message.
>=20
> * We silently ignore an oversized image's tail.  Warn instead.
>=20
> * As a convenience feature, don't reject undersized read-only image, bu=
t
>   pad it with 0xff instead, to simulate (1) above.
>=20
> Squashing the first two under a "better reporting on pflash backing fil=
e
> mismatch" heading seems fine to me.  The last one is not about "better
> reporting", and should therefore be a separate patch.
>=20
> I'm willing to do the split in the respin of my pflash fixes series.
>=20
> For the record, I'd summarily reject oversized images,

Rejection is not a bad idea IMO; I don't remember any use case where the
user benefits from the acceptance of an oversized image (with or without
warning).

> and I'd drop the
> convenience feature, but I'm not the maintainer here.  It's up to Kevin
> and Max.

Auto-padding can save some space wherever a raw image is provided, even
when QEMU is used through libvirt. It's not hugely important IMO but
nice to have. (Especially if we decide *not* to describe pflash block
count and size traits in the firmware descriptor files.)

Thanks
Laszlo

>=20
>> ---
>> v3
>>   - tweak commit title/commentary
>>   - use total_len instead of device_len for checks
>>   - if the device is read-only do the padding for them
>>   - accept baking_len > total_len (how to warn_report with NULL *errp?=
)
>> v4
>>   - error check blk_getlength
>>   - optimise memset and use NOR erase pattern
>>   - restore singular device (overly confusing)
>>   - add warn_report for when we do magic
>> v5
>>   - remove mention of null padding
>>   - use %zu for size_t fmt string
>>   - add Laszlo r-b
>> ---
>>  hw/block/pflash_cfi01.c | 40 +++++++++++++++++++++++++++++++++-------
>>  1 file changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 9d1c356eb6..d8cfa4789a 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -45,6 +45,7 @@
>>  #include "qemu/bitops.h"
>>  #include "qemu/host-utils.h"
>>  #include "qemu/log.h"
>> +#include "qemu/error-report.h"
>>  #include "hw/sysbus.h"
>>  #include "sysemu/sysemu.h"
>>  #include "trace.h"
>> @@ -730,13 +731,6 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>      }
>>      device_len =3D sector_len_per_device * blocks_per_device;
>> =20
>> -    /* XXX: to be fixed */
>> -#if 0
>> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024=
 * 1024) &&
>> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 102=
4 * 1024))
>> -        return NULL;
>> -#endif
>> -
>>      memory_region_init_rom_device(
>>          &pfl->mem, OBJECT(dev),
>>          &pflash_cfi01_ops,
>> @@ -763,6 +757,38 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>      }
>> =20
>>      if (pfl->blk) {
>> +        /*
>> +         * Validate the backing store is the right size for pflash
>> +         * devices. It should be padded to a multiple of the flash
>> +         * block size. If the device is read-only we can elide the
>> +         * check and just pad the region first. If the user supplies =
a
>> +         * larger file we ignore the tail.
>> +         */
>> +        int64_t backing_len =3D blk_getlength(pfl->blk);
>> +        if (backing_len < 0) {
>> +            error_setg(errp, "unable to check size of backing file");
>> +            return;
>> +        }
>> +
>> +        if (backing_len < total_len) {
>> +            if (pfl->ro) {
>> +                size_t pad_bytes =3D total_len - backing_len;
>> +                /* pad with NOR erase pattern */
>> +                memset((uint8_t*)pfl->storage + backing_len, 0xff, pa=
d_bytes);
>=20
> If I add this patch to my series, I can fix up the white-space to make
> checkpatch happy.
>=20
>> +                warn_report("device needs %" PRIu64
>> +                            " bytes, padded with %zu 0xff bytes",
>> +                            total_len, pad_bytes);
>> +                total_len =3D backing_len;
>> +            } else {
>> +                error_setg(errp, "device needs %" PRIu64 " bytes, "
>> +                           "backing file provides only %" PRIu64 " by=
tes",
>> +                           total_len, backing_len);
>> +                return;
>> +            }
>> +        } else if (backing_len > total_len) {
>> +            warn_report("device needs %" PRIu64 " bytes, rest ignored=
", total_len);
>=20
> Likewise, I can break this line.
>=20
>> +        }
>> +
>>          /* read the initial flash content */
>>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
