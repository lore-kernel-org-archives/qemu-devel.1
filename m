Received: from eggs.gnu.org ([2001:4830:134:3::10]:49870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbLM0-0001J7-9K
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbLLx-0002d2-2e
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:40:32 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:52049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fbLLw-0002X8-S6
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:40:28 -0400
Received: from player696.ha.ovh.net (unknown [10.109.105.35])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id DCCF71C66C
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 09:40:26 +0200 (CEST)
References: <20180619140729.21949-1-clg@kaod.org>
	<20180619140729.21949-2-clg@kaod.org>
	<eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
	<bc3ec7a5-a6c5-2a0d-7ac1-6583a182807b@kaod.org>
	<dc0f292f-6f1f-791b-4073-88f347495d2c@kaod.org>
	<20180706054458.GQ3450@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d6a9a37f-4ac9-6a72-5215-8d68c70d2621@kaod.org>
Date: Fri, 6 Jul 2018 09:40:20 +0200
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
>=20
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

but a default VIO nvram device is always created by the machine. Here is=20
a typical /vdevice layout :

  drwxr-xr-x. 2 root root 0 Jul  2 04:22 /proc/device-tree/vdevice/nvram@=
71000000
  drwxr-xr-x. 2 root root 0 Jul  2 04:22 /proc/device-tree/vdevice/vty@30=
000000

which is going to have collisions.

Should we set the "register" property of the defaut nvram device to some=20
high value ? the sPAPR platform expects to always have a nvram device:

    R1=968.1=961.

      Platforms must implement at least 8 KB of Non-Volatile Memory.=20
      The actual amount is platform dependent and must allow for 4 KB=20
      for the OS. Platforms must provide an additional 4 KB for each=20
      installed OS beyond the first.

So we can not remove it.=20

The vty devices are dependent on the chardev backends. We are fine on tha=
t
side.

Thanks,

C.

> 	VIO vty devices start at reg=3D0x30000000
> 	    and increment by 0x1000 each type
>=20
> So we could go for say:
> 	irq =3D (reg & 0xf) ^ ((reg >> 12) & 0xf);
>=20
> Obviously it's easily to construct cases where that will result in
> collisions, but I don't think it'll happen for anyone not going out of
> there way to make it happen.
>=20
