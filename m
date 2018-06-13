Received: from eggs.gnu.org ([2001:4830:134:3::10]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0Aq-0008Ib-A9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0An-00004q-4Z
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:26:32 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:46155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT0Am-0008Vh-Qn
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:26:29 -0400
Received: from player795.ha.ovh.net (unknown [10.109.108.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id A29FBC5681
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:26:27 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-3-clg@kaod.org>
	<20180526114023.49ee54e9@bahia.lan>
	<20180605034418.GV5140@umbus.fritz.box>
	<e9631178-7bd1-170a-ff28-f1ab717cb8bf@kaod.org>
	<20180613042726.GU30690@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <820b2f7b-170b-3038-2eef-253b916c586c@kaod.org>
Date: Wed, 13 Jun 2018 09:26:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180613042726.GU30690@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] sparp_pci: simplify how the PCI LSIs
 are allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 06/13/2018 06:27 AM, David Gibson wrote:
> On Tue, Jun 05, 2018 at 08:31:49AM +0200, C=E9dric Le Goater wrote:
>> On 06/05/2018 05:44 AM, David Gibson wrote:
>>> On Sat, May 26, 2018 at 11:40:23AM +0200, Greg Kurz wrote:
>>>> On Fri, 18 May 2018 18:44:03 +0200
>>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>>
>>>>> PCI LSIs are today allocated one by one using the IRQ alloc_block
>>>>> routine. Change the code sequence to first allocate a PCI_NUM_PINS
>>>>> block. It will help us providing a generic IRQ framework to the
>>>>> machine.
>>>>>
>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>> ---
>>>>>  hw/ppc/spapr_pci.c | 21 ++++++++++-----------
>>>>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>>>> index 39a14980d397..4fd97ffe4c6e 100644
>>>>> --- a/hw/ppc/spapr_pci.c
>>>>> +++ b/hw/ppc/spapr_pci.c
>>>>> @@ -1546,6 +1546,8 @@ static void spapr_phb_realize(DeviceState *de=
v, Error **errp)
>>>>>      sPAPRTCETable *tcet;
>>>>>      const unsigned windows_supported =3D
>>>>>          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
>>>>> +    uint32_t irq;
>>>>> +    Error *local_err =3D NULL;
>>>>> =20
>>>>>      if (!spapr) {
>>>>>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pser=
ies machine");
>>>>> @@ -1694,18 +1696,15 @@ static void spapr_phb_realize(DeviceState *=
dev, Error **errp)
>>>>>      QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
>>>>> =20
>>>>>      /* Initialize the LSI table */
>>>>> -    for (i =3D 0; i < PCI_NUM_PINS; i++) {
>>>>> -        uint32_t irq;
>>>>> -        Error *local_err =3D NULL;
>>>>> -
>>>>> -        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &loca=
l_err);
>>>>> -        if (local_err) {
>>>>> -            error_propagate(errp, local_err);
>>>>> -            error_prepend(errp, "can't allocate LSIs: ");
>>>>> -            return;
>>>>> -        }
>>>>> +    irq =3D spapr_irq_alloc_block(spapr, PCI_NUM_PINS, true, false=
, &local_err);
>>>>> +    if (local_err) {
>>>>> +        error_propagate(errp, local_err);
>>>>> +        error_prepend(errp, "can't allocate LSIs: ");
>>>>> +        return;
>>>>> +    }
>>>>> =20
>>>>
>>>> It isn't strictly equivalent. The current code would be happy with
>>>> sparse IRQ numbers, while the proposed one wouldn't... Anyway, this
>>>> cannot happen since we don't have PHB hotplug.
>>>
>>> This makes me pretty nervous, because it's not obvious it will come u=
p
>>> with the same numbers in all circumstances, which we have to do for
>>> existing machine types.
>>
>> Given that :=20
>>
>>  - irq_hint is "unused"
>>  - all IRQs are allocated sequentially at machine init, =20
>>  - spapr_pci is the only model using the block allocation for MSIs,=20
>>    potentially fragmenting more the IRQ number space but done at=20
>>    guest runtime.=20
>>  - the PHB LSI are the allocated at realize time doing the loop above,=
=20
>>  - we don't support PHB hotplug=20
>>  - we do support PHB coldplug but then the IRQ allocation is done
>>    at machine time,
>>
>> it seems highly improbable that the IRQ number space is fragmented
>> to a point which would not allow the loop above to return four=20
>> contiguous IRQ numbers, always.
>=20
> Well, assuming irq_hint really is unused, that's right.  But we can't
> assume that - that's the whole point of the deprecation thing.
>=20
> Given that, AIUI, just one vio device with irq=3D set to a value that
> would be within an LSI block allocated under the old scheme would
> result in the new scheme returning a non-contiguous set of LSIs -
> i.e. a different result from what we used to have.
>=20
>> That is why I felt confident changing the loop to a single block=20
>> allocation.=20
>>
>>> It's also not obvious to me why it's useful
>>> to go via this step before going straight to static allocation of the
>>> irq numbers.
>>
>> It pollutes the new sPAPR IRQ interface API with an extra parameter=20
>> to support both underlying backend and it complexifies the code=20
>> to handle block allocation of a single IRQ (like above) within an=20
>> IRQ range (the PCI LSIs).
>>
>> So you end up having a family, a device index, a count, an alignment,
>> and an index within the range. pffut.
>>
>> Also, could we kill the alignment ?
>=20
> Since we sometimes pass 'true', no, we can't, without changing the
> existing pattern of allocations, which we can't do.

To be honest, this is very much discouraging.=20

C.=20
