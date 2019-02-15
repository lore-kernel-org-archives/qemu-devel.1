Received: from eggs.gnu.org ([209.51.188.92]:42952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guZXc-0001pT-Az
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guZXb-0005QB-9S
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:12:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guZXb-0005O5-0h
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:12:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190214155714.8779-1-alex.bennee@linaro.org>
	<bbefd980-c740-cb8f-a648-a6f51772d63d@redhat.com>
	<8736oqhu6s.fsf@zen.linaroharston>
Date: Fri, 15 Feb 2019 10:12:11 +0100
In-Reply-To: <8736oqhu6s.fsf@zen.linaroharston> ("Alex =?utf-8?Q?Benn?=
	=?utf-8?Q?=C3=A9e=22's?= message of
	"Thu, 14 Feb 2019 22:38:35 +0000")
Message-ID: <87pnrtxvo4.fsf@dusky.pond.sub.org>
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, pkg-qemu-devel@lists.alioth.debian.org, qemu-devel@nongnu.org, ard.biesheuvel@linaro.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Laszlo Ersek <lersek@redhat.com> writes:
>
>> On 02/14/19 16:57, Alex Benn=C3=A9e wrote:
>>> It looks like there was going to be code to check we had some sort of
>>> alignment so lets replace it with an actual check. This is a bit more
>>> useful than the enigmatic "failed to read the initial flash content"
>>> when we attempt to read the number of bytes the device should have.
>>>
>>> This is a potential confusing stumbling block when you move from using
>>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
>>> loading your firmware code.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  hw/block/pflash_cfi01.c | 19 +++++++++++++------
>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>> index bffb4c40e7..f3251b236c 100644
>>> --- a/hw/block/pflash_cfi01.c
>>> +++ b/hw/block/pflash_cfi01.c
>>> @@ -722,12 +722,19 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>>      }
>>>      device_len =3D sector_len_per_device * blocks_per_device;
>>>
>>> -    /* XXX: to be fixed */
>>> -#if 0
>>> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 =
* 1024) &&
>>> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024=
 * 1024))
>>> -        return NULL;
>>> -#endif
>>> +    /*
>>> +     * Validate the backing store is the right size for pflash
>>> +     * devices. It has to be padded to a multiple of the flash block
>>> +     * size.
>>> +     */
>>> +    if (pfl->blk) {
>>> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
>>> +        if (device_len !=3D backing_len) {
>>> +            error_setg(errp, "backing file wrong size "
>>> +                       "(%" PRId64 " !=3D %" PRId64")", backing_len, d=
evice_len);
>>> +            return;
>>> +        }
>>> +    }
>>>
>>>      memory_region_init_rom_device(
>>>          &pfl->mem, OBJECT(dev),
>>>
>>
>> I have two suggestions:
>> - backing_len and device_len are both uint64_t; we should print them
>>   with PRIu64
>
> blk_getlength actually returns int64_t for some reason (do signed
> lengths even make sense? maybe it's for error handling?). But sure I can
> make it PRIu64

Use of signed integers for file offsets is pervasive in the block layer.
It's convenient when we return either a non-negative offset or a
negative error code.  It's admittedly sloppy anywhere else.

>> - from a user POV, I find it more useful if the error message also shows
>>   which quantity is which, not just two inequal numbers.
>
> How about:
>
>   "backing file size (%) not enough for whole device (%)"
>
> ?

Not bad.  Another one, avoiding parentheses:

    "device needs DDD bytes, backing file provides only BBB bytes"

>
>>
>> I don't feel too strongly about this, so up to you.
