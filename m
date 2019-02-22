Received: from eggs.gnu.org ([209.51.188.92]:41230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5uL-0002RX-RW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5uK-0005P1-FL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:10:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gx5uK-0005KM-4H
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:10:08 -0500
References: <20190221184857.22434-1-alex.bennee@linaro.org>
	<e080ce0b-5b14-ae9c-28c7-8254db3b648a@redhat.com>
	<87wols3nxl.fsf@zen.linaroharston>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5e9e1a86-ab39-dfcb-9562-54eaf38a6deb@redhat.com>
Date: Fri, 22 Feb 2019 09:09:56 +0100
MIME-Version: 1.0
In-Reply-To: <87wols3nxl.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stappers@stappers.nl

On 02/21/19 21:07, Alex Benn=C3=A9e wrote:
>=20
> Laszlo Ersek <lersek@redhat.com> writes:
>=20
>> On 02/21/19 19:48, Alex Benn=C3=A9e wrote:
>>> It looks like there was going to be code to check we had some sort of
>>> alignment so lets replace it with an actual check. This is a bit more
>>> useful than the enigmatic "failed to read the initial flash content"
>>> when we attempt to read the number of bytes the device should have.
>>>
>>> This is a potential confusing stumbling block when you move from usin=
g
>>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly f=
or
>>> loading your firmware code. To mitigate that we automatically pad in
>>> the read-only case.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> ---
>>> v3
>>>   - tweak commit title/commentary
>>>   - use total_len instead of device_len for checks
>>>   - if the device is read-only do the padding for them
>>>   - accept baking_len > total_len (how to warn_report with NULL *errp=
?)
>>> ---
>>>  hw/block/pflash_cfi01.c | 28 +++++++++++++++++++++-------
>>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>> index 00c2efd0d7..37d7513c45 100644
>>> --- a/hw/block/pflash_cfi01.c
>>> +++ b/hw/block/pflash_cfi01.c
>>> @@ -714,13 +714,6 @@ static void pflash_cfi01_realize(DeviceState *de=
v, Error **errp)
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
>>> -
>>>      memory_region_init_rom_device(
>>>          &pfl->mem, OBJECT(dev),
>>>          &pflash_cfi01_ops,
>>> @@ -747,6 +740,27 @@ static void pflash_cfi01_realize(DeviceState *de=
v, Error **errp)
>>>      }
>>>
>>>      if (pfl->blk) {
>>> +        /*
>>> +         * Validate the backing store is the right size for pflash
>>> +         * devices. It should be padded to a multiple of the flash
>>> +         * block size. If the device is read-only we can elide the
>>> +         * check and just null pad the region first. If the user
>>> +         * supplies a larger file we silently accept it.
>>
>> (1) I recommend adding "and ignore the tail".
>>
>>> +         */
>>> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
>>
>> (2) Didn't we intend to check for blk_getlength() errors (or assert th=
at
>> there would be none)?
>=20
> Oops, yes I'll fix that.
>=20
>>
>>> +
>>> +        if (backing_len < total_len) {
>>> +            if (pfl->ro) {
>>> +                memset(pfl->storage, 0, total_len);
>>
>> (3) Should we "optimize" (well, okay, de-pessimize) this to:
>>
>>   memset((uint8_t*)pfl->storage + backing_len, 0,
>>          total_len - backing_len);
>>
>> ?
>=20
> I mean in the grand scheme of things it's unlikely to show up in any
> benchmarks so I went for simple and easy to get right.

OK.

>=20
>>
>>> +                total_len =3D backing_len;
>>> +            } else {
>>> +                error_setg(errp, "device(s) needs %" PRIu64 " bytes,=
 "
>>
>> (4) not too important, I'm just curious: why the optional plural?
>=20
> I discovered the difference between device_len and total_len and found
> (for some reason) the efivars came out as multiple devices.

It is true that the executable code is in one chip, and the UEFI
varstore in another (in the most common & most recommended setup
anyway); however, the varstore itself doesn't need multiple chips, and
more importantly, I think the realize function of any given single chip
should only report errors about that one chip. (Unless we have some
higher level invariant binding the chips together, but I'm unaware of
any such in this case.)

If I understand correctly, when we set the error here, QEMU will produce
an error report that is tied to the specific pflash chip / command line
option that triggered the error. That looks like the right thing to me.

Again I don't really insist on plural vs. singular here, I just wanted
to understand your train of thought.

Thanks!
Laszlo

>=20
>>
>>> +                           "backing file provides only %" PRIu64 " b=
ytes",
>>> +                           total_len, backing_len);
>>> +                return;
>>> +            }
>>> +        }
>>> +
>>>          /* read the initial flash content */
>>>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
>>>
>>>
>>
>> I don't feel too strongly about these, so if you disagree, I won't pus=
h.
>>
>> Thanks!
>> Laszlo
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
