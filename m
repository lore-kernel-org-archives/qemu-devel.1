Received: from eggs.gnu.org ([209.51.188.92]:52218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gudzN-0006h9-66
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gudzM-0006lM-BX
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:57:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gudzM-0006jY-3Q
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:57:12 -0500
References: <20190214155714.8779-1-alex.bennee@linaro.org>
	<bbefd980-c740-cb8f-a648-a6f51772d63d@redhat.com>
	<8736oqhu6s.fsf@zen.linaroharston>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bd9f7c1b-897b-4b53-5ded-38e097ce74ff@redhat.com>
Date: Fri, 15 Feb 2019 14:57:08 +0100
MIME-Version: 1.0
In-Reply-To: <8736oqhu6s.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pkg-qemu-devel@lists.alioth.debian.org, ard.biesheuvel@linaro.org

On 02/14/19 23:38, Alex Benn=C3=A9e wrote:
>=20
> Laszlo Ersek <lersek@redhat.com> writes:
>=20
>> On 02/14/19 16:57, Alex Benn=C3=A9e wrote:
>>> It looks like there was going to be code to check we had some sort of
>>> alignment so lets replace it with an actual check. This is a bit more
>>> useful than the enigmatic "failed to read the initial flash content"
>>> when we attempt to read the number of bytes the device should have.
>>>
>>> This is a potential confusing stumbling block when you move from usin=
g
>>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly f=
or
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
>>> @@ -722,12 +722,19 @@ static void pflash_cfi01_realize(DeviceState *d=
ev, Error **errp)
>>>      }
>>>      device_len =3D sector_len_per_device * blocks_per_device;
>>>
>>> -    /* XXX: to be fixed */
>>> -#if 0
>>> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 102=
4 * 1024) &&
>>> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 10=
24 * 1024))
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
>>> +                       "(%" PRId64 " !=3D %" PRId64")", backing_len,=
 device_len);
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
>=20
> blk_getlength actually returns int64_t for some reason (do signed
> lengths even make sense? maybe it's for error handling?).

Ah, sorry, I didn't realize. I guess we should cover negative values
then explicitly? Not sure.

> But sure I can
> make it PRIu64
>=20
>> - from a user POV, I find it more useful if the error message also sho=
ws
>>   which quantity is which, not just two inequal numbers.
>=20
> How about:
>=20
>   "backing file size (%) not enough for whole device (%)"

"not enough" means "<", but the C expression uses "!=3D". How about
"backing file size (...) does not match device size (...)"?

Or "does not equal", whichever sounds more palatable.

Thanks!
Laszlo
