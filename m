Received: from eggs.gnu.org ([209.51.188.92]:39161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5qd-000829-Tt
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gx5qc-0002x7-Qe
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gx5qc-0002nU-Gy
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:06:18 -0500
References: <20190221184857.22434-1-alex.bennee@linaro.org>
	<3ba41c9b-05a0-acfe-e621-10f43048c874@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1a4231ba-7cad-5f87-66d0-2f2e0f78c454@redhat.com>
Date: Fri, 22 Feb 2019 09:06:00 +0100
MIME-Version: 1.0
In-Reply-To: <3ba41c9b-05a0-acfe-e621-10f43048c874@redhat.com>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: stappers@stappers.nl, armbru@redhat.com

On 02/21/19 21:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Alex,
>=20
> On 2/21/19 7:48 PM, Alex Benn=C3=A9e wrote:
>> It looks like there was going to be code to check we had some sort of
>> alignment so lets replace it with an actual check. This is a bit more
>> useful than the enigmatic "failed to read the initial flash content"
>> when we attempt to read the number of bytes the device should have.
>>
>> This is a potential confusing stumbling block when you move from using
>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly fo=
r
>> loading your firmware code. To mitigate that we automatically pad in
>> the read-only case.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v3
>>   - tweak commit title/commentary
>>   - use total_len instead of device_len for checks
>>   - if the device is read-only do the padding for them
>>   - accept baking_len > total_len (how to warn_report with NULL *errp?=
)
>> ---
>>  hw/block/pflash_cfi01.c | 28 +++++++++++++++++++++-------
>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 00c2efd0d7..37d7513c45 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -714,13 +714,6 @@ static void pflash_cfi01_realize(DeviceState *dev=
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
>> @@ -747,6 +740,27 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>      }
>> =20
>>      if (pfl->blk) {
>> +        /*
>> +         * Validate the backing store is the right size for pflash
>> +         * devices. It should be padded to a multiple of the flash
>> +         * block size. If the device is read-only we can elide the
>> +         * check and just null pad the region first. If the user
>> +         * supplies a larger file we silently accept it.
>> +         */
>> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
>> +
>> +        if (backing_len < total_len) {
>> +            if (pfl->ro) {
>> +                memset(pfl->storage, 0, total_len);
>=20
> When you erasing a NOR flash sector, all bits are set to 1.
> Then you can program a word by setting its bits to 0.
> It is not possible to set bits from 0 to 1 on a word boundary,
> it is only possible to set bits to 1 by erasing a whole sector (sector
> boundary).
>=20
> The pflash QEMU models are of NOR type (is different for other flash
> technologies).
> If we want to set the padded area to the fabric blank state, we should
> use the NOR flash erased value of 0xff.

Good point, thank you! This polarity is what the firmware assumes as well=
.
Laszlo

>> +                total_len =3D backing_len;
>> +            } else {
>> +                error_setg(errp, "device(s) needs %" PRIu64 " bytes, =
"
>> +                           "backing file provides only %" PRIu64 " by=
tes",
>> +                           total_len, backing_len);
>> +                return;
>> +            }
>> +        }
>> +
>>          /* read the initial flash content */
>>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
>> =20
>>
