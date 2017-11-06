Received: from eggs.gnu.org ([2001:4830:134:3::10]:41742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBjxL-0007ts-5q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBjxG-0002n8-2H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:08:59 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:38369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBjxF-0002m8-Sn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:08:53 -0500
References: <20171031152443.3670-1-michael.nawrocki@gtri.gatech.edu>
	<8dbe8e3a-f8d4-3fb0-2ac8-e200ebde3dcb@redhat.com>
	<0e24381c-3621-1dcb-02fb-1dc4f15358b2@amsat.org>
	<655342677.16706255.1509653087535.JavaMail.zimbra@redhat.com>
From: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>
Message-ID: <531c5d81-3403-f10e-cfda-765f2f172c7a@gtri.gatech.edu>
Date: Mon, 6 Nov 2017 11:08:51 -0500
MIME-Version: 1.0
In-Reply-To: <655342677.16706255.1509653087535.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Enable 8-byte wide MMIO for 16550 serial
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Avi Kivity <avi@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Konrad Frederic <fred.konrad@greensocs.com>, qemu-devel@nongnu.org, mst@redhat.com

On 11/02/2017 04:04 PM, Paolo Bonzini wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
>> To: "Paolo Bonzini" <pbonzini@redhat.com>, "Mike Nawrocki" <michael.na=
wrocki@gtri.gatech.edu>, "Avi Kivity"
>> <avi@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, "Konrad =
Frederic" <fred.konrad@greensocs.com>
>> Cc: qemu-devel@nongnu.org, mst@redhat.com
>> Sent: Thursday, November 2, 2017 8:28:09 PM
>> Subject: Re: [Qemu-devel] [PATCH] Enable 8-byte wide MMIO for 16550 se=
rial devices
>>
>> Hi Mike, Paolo.
>>
>>>> diff --git a/hw/char/serial.c b/hw/char/serial.c
>>>> index 376bd2f240..c16c19a406 100644
>>>> --- a/hw/char/serial.c
>>>> +++ b/hw/char/serial.c
>>>> @@ -1005,7 +1005,7 @@ static void serial_mm_write(void *opaque, hwad=
dr
>>>> addr,
>>>>                               uint64_t value, unsigned size)
>>>>   {
>>>>       SerialState *s =3D opaque;
>>>> -    value &=3D ~0u >> (32 - (size * 8));
>>>> +    value &=3D ~((uint64_t)0) >> (64 - (size * 8));
>>>>       serial_ioport_write(s, addr >> s->it_shift, value, 1);
>>>>   }
>>>
>>> Couldn't this be simply "value &=3D 255"?  Otherwise looks good.
>>
>> This is not incorrect, but I don't think this is the correct fix.
>> Isn't it what memory::access_with_adjusted_size() is supposed to do wi=
th
>> .impl.max_access_size =3D 1?
>=20
> The mm version doesn't have .impl.max_access_size=3D1.
>=20
> Thanks,
>=20
> Paolo
>=20

Sorry for the late reply on this. I implemented it with the shifting=20
mask initially to mirror the original code, but it should definitely=20
work with "value &=3D 255". Looking at serial_ioport_write, I think this=20
might also fix a potential issue where the upper bits of the divider=20
variable could be set if any bits 8-15 of "val" are set (and addr =3D 0).

I'll go ahead and push up a v2 patch with this fix.

Thanks,
Mike

>> This looks like the same issue I tried to fix here:
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02255.html
>>
>> I'll try to find some time to respin the full series with tests.
>>
>>>> @@ -1014,16 +1014,22 @@ static const MemoryRegionOps serial_mm_ops[3=
] =3D {
>>>>           .read =3D serial_mm_read,
>>>>           .write =3D serial_mm_write,
>>>>           .endianness =3D DEVICE_NATIVE_ENDIAN,
>>>> +        .valid.max_access_size =3D 8,
>>>> +        .impl.max_access_size =3D 8,
>>>>       },
>>>>       [DEVICE_LITTLE_ENDIAN] =3D {
>>>>           .read =3D serial_mm_read,
>>>>           .write =3D serial_mm_write,
>>>>           .endianness =3D DEVICE_LITTLE_ENDIAN,
>>>> +        .valid.max_access_size =3D 8,
>>>> +        .impl.max_access_size =3D 8,
>>>>       },
>>>>       [DEVICE_BIG_ENDIAN] =3D {
>>>>           .read =3D serial_mm_read,
>>>>           .write =3D serial_mm_write,
>>>>           .endianness =3D DEVICE_BIG_ENDIAN,
>>>> +        .valid.max_access_size =3D 8,
>>>> +        .impl.max_access_size =3D 8,
>>
