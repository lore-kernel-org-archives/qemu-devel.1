Received: from eggs.gnu.org ([2001:4830:134:3::10]:39834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbKF8-0001pg-SL
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbKF5-0003oA-Ne
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:29:22 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:51858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fbKF5-0003PR-HB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:29:19 -0400
Received: from player711.ha.ovh.net (unknown [10.109.120.54])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B734210DC84
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 08:29:10 +0200 (CEST)
References: <20180619140729.21949-1-clg@kaod.org>
	<20180619140729.21949-2-clg@kaod.org>
	<eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
	<bc3ec7a5-a6c5-2a0d-7ac1-6583a182807b@kaod.org>
	<dc0f292f-6f1f-791b-4073-88f347495d2c@kaod.org>
	<20180706054458.GQ3450@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <07d32ac8-09ad-a2c8-f6bf-4675952c2b82@kaod.org>
Date: Fri, 6 Jul 2018 08:29:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180706054458.GQ3450@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 07/06/2018 07:44 AM, David Gibson wrote:
> On Tue, Jul 03, 2018 at 05:19:56PM +0200, C=E9dric Le Goater wrote:
>> On 07/02/2018 01:11 PM, C=E9dric Le Goater wrote:
>>> On 07/02/2018 12:03 PM, C=E9dric Le Goater wrote:
>>>>> --- a/hw/ppc/spapr_vio.c
>>>>> +++ b/hw/ppc/spapr_vio.c
>>>>> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState =
*qdev)
>>>>>      }
>>>>>  }
>>>>> =20
>>>>> +/* TODO : poor VIO device indexing ... */
>>>>> +static uint32_t vio_index;
>>>>
>>>> I think we could also use (dev->reg & 0xff) as an index for=20
>>>> the VIO devices.
>>>>
>>>> The unit address of the virtual IOA is simply allocated using=20
>>>> an increment of bus->next_reg, next_reg being initialized at
>>>> 0x71000000.
>>>>
>>>> I did not see any restrictions in the PAPR specs or in QEMU=20
>>>> that would break the above.
>>>
>>> That was until I discovered this macro :=20
>>>
>>>   #define DEFINE_SPAPR_PROPERTIES(type, field)           \
>>>         DEFINE_PROP_UINT32("reg", type, field.reg, -1)
>>> =20
>>> so 'reg' could have any value. We can not use it ...
>>
>> Would moving vio_index under the bus and incrementing it each time
>> a VIO device is created be acceptable ?=20
>=20
> Not really, no.
>=20
>> It does look like an allocator but I really don't know what else to=20
>> propose :/ See below.
>=20
> Not only is it a stealth allocator, it also means we have two
> different unique ids for VIO devices - the 'reg' and this new index.
> That sounds like a recipe for confusion.

I agree.

> I think we can do better.  I had a look at how these are allocated and
> it seems to be this:
>=20
> In qemu:
> 	VIO devices start at reg=3D0x71000000, and just increment by one
> 	from there.
>=20
> In libvirt:
> 	VIO net devices start at reg=3D0x1000
> 	VIO scsi devices start at reg=3D0x2000
> 	VIO nvram devices start at reg=3D0x3000
> 	VIO vty devices start at reg=3D0x30000000
> 	    and increment by 0x1000 each type
>=20
> So we could go for say:
> 	irq =3D (reg & 0xf) ^ ((reg >> 12) & 0xf);

We should use 0xff in the formula above to cover 256 devices. So we are=20
looking for an index in the bit ranges [0-7] or [12-19]. Ok, I didn't=20
dare to do that but let's go that way. I will send a v4 before going.

> Obviously it's easily to construct cases where that will result in
> collisions, but I don't think it'll happen for anyone not going out of
> there way to make it happen.

We should also deprecate the "reg" property in 3.1.

C.
=20
