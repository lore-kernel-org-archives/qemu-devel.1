Received: from eggs.gnu.org ([2001:4830:134:3::10]:35720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSzoe-0007rd-Ds
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSzoa-00013t-C9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:03:36 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:47250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSzoa-000135-2c
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:03:32 -0400
Received: from player731.ha.ovh.net (unknown [10.109.108.13])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D60341A4F2
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:03:29 +0200 (CEST)
References: <20180530100754.15833-1-clg@kaod.org>
	<20180606063910.GK17757@umbus.fritz.box>
	<326e1949-28d0-941d-54f7-dbba6825388d@kaod.org>
	<20180612055855.GE30690@umbus.fritz.box>
	<87436236-09f6-9ee0-dbe6-00f0147050dc@kaod.org>
	<20180613004752.GN30690@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <aa7ef7f9-f387-c99f-7d58-5048f81d4ab0@kaod.org>
Date: Wed, 13 Jun 2018 09:03:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180613004752.GN30690@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] pnv: add a physical mapping array
 describing MMIO ranges in each chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/13/2018 02:47 AM, David Gibson wrote:
> On Tue, Jun 12, 2018 at 08:13:49AM +0200, C=E9dric Le Goater wrote:
>> On 06/12/2018 07:58 AM, David Gibson wrote:
>>> On Wed, Jun 06, 2018 at 09:04:10AM +0200, C=E9dric Le Goater wrote:
>>>> On 06/06/2018 08:39 AM, David Gibson wrote:
>>>>> On Wed, May 30, 2018 at 12:07:54PM +0200, C=E9dric Le Goater wrote:
>>>>>> Based on previous work done in skiboot, the physical mapping array
>>>>>> helps in calculating the MMIO ranges of each controller depending =
on
>>>>>> the chip id and the chip type. This is will be particularly useful=
 for
>>>>>> the P9 models which use less the XSCOM bus and rely more on MMIOs.
>>>>>>
>>>>>> A link on the chip is now necessary to calculate MMIO BARs and
>>>>>> sizes. This is why such a link is introduced in the PSIHB model.
>>>>>
>>>>> I think this message needs some work.  This says what it's for, but
>>>>> what actually *is* this array, and how does it work?
>>>>
>>>> OK. It is relatively simple: each controller has an entry defining i=
ts=20
>>>> MMIO range.=20
>>>>
>>>>> The outside-core differences between POWER8 and POWER9 are substant=
ial
>>>>> enough that I'm wondering if pnvP8 and pnvP9 would be better off as
>>>>> different machine types (sharing some routines, of course).
>>>>
>>>> yes and no. I have survived using a common PnvChip framework but
>>>> it is true that I had to add P9 classes for each: LPC, PSI, OCC=20
>>>> They are very similar but not enough. P9 uses much more MMIOs than=20
>>>> P8 which still uses a lot of XSCOM. I haven't looked at PHB4.=20
>>>
>>> Well, it's certainly *possible* to use the same machine type, I'm jus=
t
>>> not convinced it's a good idea.  It seems kind of dodgy to me that so
>>> many peripherals on the system change as a side-effect of setting the
>>> cpu.  Compare to how x86 works where cpu really does change the CPU,
>>> plugging it into the same virtual "chipset".  Different chipsets *are=
*
>>> different machine types there (pc vs. q35).
>>
>> OK, I agree, and we can use a set of common routines to instantiate th=
e=20
>> different chipset models.=20
>>
>> So we would have a common pnv_init() routine to initialize the differe=
nt=20
>> 'powernv8' and 'powernv9' machines and the PnvChip typename would be a=
=20
>> machine class attribute ?
>=20
> Well.. that's one option.  Usually for these things, it works out
> better to instead of parameterizing big high-level routines like
> pnv_init(), you have separate versions of those calling a combination
> of case-specific and common routines as necessary.
>=20
> Mostly it just comes down to what is simplest to implement for you, tho=
ugh.

I am introducing a powernv8 machine, the machine init routine is still
generic and did not change much. But I have deepen the PnvChip class
inheritance hierarchy with an intermediate class taking care of the
Chip sub controllers, which gives us something like :

  pnv_init()
    . skiboot
    . kernel
    . initrd
    . chips creation
    . platform bus/device :
       isa bus
       pci layout
       bmc handling.

  p8 chip hierarchy:
=20
   power8_v2.0-pnv-chip (gives the cpu type)
   pnv8-chip   : creates the devices only      =20
   pnv-chip    : creates xscom and the cores=20

The powervn9 machine has this hierarchy :

   power9_v2.0-pnv-chip
   pnv9-chip
   pnv-chip

I had to introduce these new PnvChipClass ops :=20

    void (*realize)(PnvChip *chip, Error **errp);
    Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
    ISABus *(*isa_create)(PnvChip *chip);

Overall, it's looking fine and it should remove most of these tests :

	 pnv_chip_is_power9(chip)

If not, it means we are missing a PnvChipClass ops anyway.

I will send a patchset this week, the final one will shuffle quite a
bit of code and the resulting diff will be a bit fuzy. You will have
to trust me on this one.

=20
>> Nevertheless we would still need to introduce "a physical mapping arra=
y=20
>> describing MMIO ranges" but we can start by differentiating the chipse=
ts=20
>> first.
>=20
> Well, maybe.  I'm wondering if you can more easily encapsulate the
> information in that array in a top-level init routine, that calls
> common helpers with different addresses / device types / whatever.

Hmm, I think I understand but could you give me a prototype example.=20
Please. To make sure.

I would like to keep the array somewhere because, in a quick look,=20
it gives you an overview of the POWER Processor address space.=20

Thanks,

C.
=20
