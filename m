Received: from eggs.gnu.org ([209.51.188.92]:48162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gufwi-0000bB-Hm
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gufwg-0000O2-PM
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:02:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gufwg-0007Pw-76
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:02:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190215122808.22301-1-alex.bennee@linaro.org>
	<60e020d0-ad5d-6b86-e492-1d3c91c48a13@redhat.com>
Date: Fri, 15 Feb 2019 17:01:18 +0100
In-Reply-To: <60e020d0-ad5d-6b86-e492-1d3c91c48a13@redhat.com> (Laszlo Ersek's
	message of "Fri, 15 Feb 2019 15:08:39 +0100")
Message-ID: <87lg2hujld.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/block: report when pflash backing
 file isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, stappers@stappers.nl, armbru@redhat.com

Laszlo Ersek <lersek@redhat.com> writes:

> On 02/15/19 13:28, Alex Benn=C3=A9e wrote:
>> It looks like there was going to be code to check we had some sort of
>> alignment so lets replace it with an actual check. This is a bit more
>> useful than the enigmatic "failed to read the initial flash content"
>> when we attempt to read the number of bytes the device should have.
>>=20
>> This is a potential confusing stumbling block when you move from using
>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
>> loading your firmware code.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>   - use PRIu64 instead of PRId64
>>   - tweaked message output
>> ---
>>  hw/block/pflash_cfi01.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index bffb4c40e7..7532c8d8e8 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -722,12 +722,20 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>>      }
>>      device_len =3D sector_len_per_device * blocks_per_device;
>>=20=20
>> -    /* XXX: to be fixed */
>> -#if 0
>> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 *=
 1024) &&
>> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024 =
* 1024))
>> -        return NULL;
>> -#endif

pflash_cfi02_realize() has the same XXX.

There's a pair of related XXXs in taihu_405ep_init().  Related because
@total_len is computed like this

    total_len =3D pfl->sector_len * pfl->nb_blocs;

and the two factors come from callers of pflash_cfi01_realize(),
pflash_cfi02_realize(), or from ve_pflash_cfi01_register(),
xtfpga_flash_init().  Aside: the latter two are slight variations of
pflash_cfi01_realize() which I'm going to clean up.  Some of these use
fixed sizes (good, real machines do that, too).  Some of them compute
them from blk_getlength(), with varying levels of care.

I'm afraid we need to take all that into account.

Let's take a step back and consider sane requirements.

The size of the flash chip is a property of the machine.  It is *fixed*.
Using whatever size the image has is sloppy modelling.

A machine may come in minor variations that aren't worth their own
machine type.  One such variation could be a different flash chip size.
Using the image size to select one from the set of fixed sizes is
tolerable.

Aside: the image size can change between the place where we get it to
pick a flash chip size and realize().  I guess that's a "don't do that
then".

If the image size matches the flash chip's size exactly, all is well.

Should we require the size to match the flash chip's size?

If we accept a smaller image, we want to pad with zeros.  What about
writes beyond the size of the image?  Discard them, or let them extend
the image file?

If we accept a larger image, we want to ignore its tail.

Sorry for turning the tiny issue your patch tries to address into a much
larger one...

>> +    /*
>> +     * Validate the backing store is the right size for pflash
>> +     * devices. It has to be padded to a multiple of the flash block
>> +     * size.
>> +     */
>> +    if (pfl->blk) {
>> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
>> +        if (device_len !=3D backing_len) {
>> +            error_setg(errp, "device needs %" PRIu64 " bytes, "
>> +                       "backing file provides only %" PRIu64 " bytes",
>> +                       device_len, backing_len);
>> +            return;
>> +        }
>> +    }
>>=20=20
>>      memory_region_init_rom_device(
>>          &pfl->mem, OBJECT(dev),
>>=20
>
> The word "only" implies that the file is too small. It could be too
> large as well (the C expression is right, but the message doesn't
> reflect it).
>
> With the word "only" dropped, I think the message looks fine.
>
>
> Also, now I've checked blk_getlength(). First, it can directly return
> (-ENOMEDIUM). Second, it delegates the job to bdrv_getlength(), which
> itself can return (-EFBIG). Third, bdrv_nb_sectors(), used internally,
> can itself return (-ENOMEDIUM).
>
> For me this is pretty much impossible to follow. Can we:
>
> - use type "int64_t" for "backing_len" in the new code, AND
>
>   - either prove (from the rest of pflash_cfi01_realize()) that
>     "backing_len" is nonnegative, and then *assert* it, plus cast
>     "backing_len" to uint64_t for the comparison;
>
>   - or check for a negative "backing_len" explicitly, and if that
>     happens, fail pflash_cfi01_realize() with an error message that
>     reports *that* failure?
>
> Sorry about the pedantry; I've got no clue what's happening in
> blk_getlength() for real.

L=C3=A1szl=C3=B3 is right, blk_getlength() *can* fail.  It doesn't fail oft=
en, so
neglecting to check for failure can go undetected for quite a while.
