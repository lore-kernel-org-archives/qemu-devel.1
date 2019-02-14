Received: from eggs.gnu.org ([209.51.188.92]:44485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guPeT-00076Q-VQ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 17:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guPeT-0007rH-1v
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 17:38:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1guPeS-0007pd-P4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 17:38:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id w17so8254414wrn.12
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 14:38:38 -0800 (PST)
References: <20190214155714.8779-1-alex.bennee@linaro.org>
	<bbefd980-c740-cb8f-a648-a6f51772d63d@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <bbefd980-c740-cb8f-a648-a6f51772d63d@redhat.com>
Date: Thu, 14 Feb 2019 22:38:35 +0000
Message-ID: <8736oqhu6s.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/block: report when pflash backing file
 isn't aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, pkg-qemu-devel@lists.alioth.debian.org, ard.biesheuvel@linaro.org


Laszlo Ersek <lersek@redhat.com> writes:

> On 02/14/19 16:57, Alex Benn=C3=A9e wrote:
>> It looks like there was going to be code to check we had some sort of
>> alignment so lets replace it with an actual check. This is a bit more
>> useful than the enigmatic "failed to read the initial flash content"
>> when we attempt to read the number of bytes the device should have.
>>
>> This is a potential confusing stumbling block when you move from using
>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
>> loading your firmware code.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hw/block/pflash_cfi01.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index bffb4c40e7..f3251b236c 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -722,12 +722,19 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>>      }
>>      device_len =3D sector_len_per_device * blocks_per_device;
>>
>> -    /* XXX: to be fixed */
>> -#if 0
>> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 *=
 1024) &&
>> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024 =
* 1024))
>> -        return NULL;
>> -#endif
>> +    /*
>> +     * Validate the backing store is the right size for pflash
>> +     * devices. It has to be padded to a multiple of the flash block
>> +     * size.
>> +     */
>> +    if (pfl->blk) {
>> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
>> +        if (device_len !=3D backing_len) {
>> +            error_setg(errp, "backing file wrong size "
>> +                       "(%" PRId64 " !=3D %" PRId64")", backing_len, de=
vice_len);
>> +            return;
>> +        }
>> +    }
>>
>>      memory_region_init_rom_device(
>>          &pfl->mem, OBJECT(dev),
>>
>
> I have two suggestions:
> - backing_len and device_len are both uint64_t; we should print them
>   with PRIu64

blk_getlength actually returns int64_t for some reason (do signed
lengths even make sense? maybe it's for error handling?). But sure I can
make it PRIu64

> - from a user POV, I find it more useful if the error message also shows
>   which quantity is which, not just two inequal numbers.

How about:

  "backing file size (%) not enough for whole device (%)"

?

>
> I don't feel too strongly about this, so up to you.
>
> Thanks,
> Laszlo


--
Alex Benn=C3=A9e
