Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT08r-000752-4L
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT08n-0006wG-Tp
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:24:29 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:56353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT08n-0006vO-JX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:24:25 -0400
Received: from player755.ha.ovh.net (unknown [10.109.105.104])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7B4DCC2599
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:24:23 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
	<a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
	<20180605033401.GU5140@umbus.fritz.box>
	<48e319d0-2cf7-ab9a-f3d4-085880e1bda8@kaod.org>
	<20180613042217.GT30690@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <67d4e25d-0f37-1282-5a40-6bfece16d1cb@kaod.org>
Date: Wed, 13 Jun 2018 09:24:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180613042217.GT30690@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: remove irq_hint parameter from
 spapr_irq_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On 06/13/2018 06:22 AM, David Gibson wrote:
> On Tue, Jun 05, 2018 at 08:41:13AM +0200, C=E9dric Le Goater wrote:
>> On 06/05/2018 05:34 AM, David Gibson wrote:
>>> On Mon, May 28, 2018 at 09:06:12AM +0200, C=E9dric Le Goater wrote:
>>>> On 05/28/2018 08:17 AM, Thomas Huth wrote:
>>>>> On 25.05.2018 16:02, Greg Kurz wrote:
>>>>>> On Fri, 18 May 2018 18:44:02 +0200
>>>>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>>>>
>>>>>>> This IRQ number hint can possibly be used by the VIO devices if t=
he
>>>>>>> "irq" property is defined on the command line but it seems it is =
never
>>>>>>> the case. It is not used in libvirt for instance. So, let's remov=
e it
>>>>>>> to simplify future changes.
>>>>>>>
>>>>>>
>>>>>> Setting an irq manually looks a bit anachronistic. I doubt anyone =
would
>>>>>> do that nowadays, and the patch does a nice cleanup. So this looks=
 like
>>>>>> a good idea.
>>>>> [...]
>>>>>>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>>>>>>> index 472dd6f33a96..cc064f64fccf 100644
>>>>>>> --- a/hw/ppc/spapr_vio.c
>>>>>>> +++ b/hw/ppc/spapr_vio.c
>>>>>>> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceSt=
ate *qdev, Error **errp)
>>>>>>>          dev->qdev.id =3D id;
>>>>>>>      }
>>>>>>> =20
>>>>>>> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_=
err);
>>>>>>> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
>>>>>>
>>>>>> Silently breaking "irq" like this looks wrong. I'd rather official=
ly remove
>>>>>> it first (ie, kill spapr_vio_props, -5 lines in spapr_vio.c).
>>>>>>
>>>>>> Of course, this raises the question of interface deprecation, and =
it should
>>>>>> theoretically follow the process described at:
>>>>>>
>>>>>> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an=
_interface
>>>>>>
>>>>>> Cc'ing Thomas, our Chief Deprecation Officer, for insights :)
>>>>>
>>>>> The property is a public interface. Just because it's not used by
>>>>> libvirt does not mean that nobody is using it. So yes, please follo=
w the
>>>>> rules and mark it as deprecated first for two release, before you r=
eally
>>>>> remove it.
>>>>
>>>> This "irq" property is a problem to introduce a new static layout of=
 IRQ=20
>>>> numbers. It is in complete opposition.=20
>>>>
>>>> Can we keep it as it is for old pseries machine (settable) and ignor=
e it=20
>>>> for newer ? Would that be fine ?
>>>
>>> So, Thomas is right that we need to keep the interface while we go
>>> through the deprecation process, even though it's a bit of a pain
>>> (like you, I seriously doubt anyone ever used it).
>>
>> That's OK. The patch is simple. But it means that we have to keep the=20
>> irq_hint parameter for 2 QEMU versions.
>=20
> No.. the suggestion below is designed to avoid that..
>=20
>>> But, I think there's a way to avoid that getting in the way of your
>>> cleanups too much.
>>>
>>> A bunch of the current problems are caused because spapr_irq_alloc()
>>> conflates two meanings of "allocate": 1) finding a free irq to use fo=
r
>>> this device and 2) assigning that irq exclusively to this device.
>>>
>>> I think the first thing to do is to split those two parts.  (1) will
>>> never take an irq parameter, (2) will always take an irq parameter.
>>> To implement the (to be deprecated) "irq" property on vio devices you
>>> should skip (1) and just call (2) with the given irq number.
>>
>> well, we need to call both because if "irq" is zero then when we=20
>> fallback to "1) finding a free irq to use."
>=20
> No, basically in the VIO code itself you'd have:
> 	irq =3D <irq property value>;
> 	if (!irq)
> 		irq =3D find_irq()
> 	claim_irq(irq);
>
> find_irq() never takes a hint, claim_irq() always does (except it's
> not really a hint).

ok. I add something like that in mind :=20
=20
    if (dev->irq) {
        spapr_irq_assign(spapr, SPAPR_IRQ_VIO, dev->irq, &local_err);
        if (local_err) {
            error_propagate(errp, local_err);
            return;
        }
    } else {
        dev->irq =3D spapr_irq_alloc(spapr, SPAPR_IRQ_VIO, vio_index++, =20
                                   &local_err);
        if (local_err) {
            error_propagate(errp, local_err);
            return;
        }

and spapr_irq_assign() would die when the vio "irq" property does.

>> But we can move the exclusive IRQ assignment (2) under the VIO model=20
>> which is the only one using it and start deprecating the property.
>=20
> No.. the exclusive claim would be global - everything would use that.

Yes, I see the model. I am not sure it's useful to have two routines
in the long term.

>>> The point of this series is to basically get rid of (1), but this
>>> first step means we don't need to worry about the hint parameter as w=
e
>>> gradually remove it.
>>
>> OK. I think I got what you are asking for. (2) means adding an extra=20
>> handler to the sPAPR IRQ interface, which would always fail in the
>> new XICS sPAPR IRQ backend using static numbers.
>=20
> No.. (2), "claim_irq()" as I called it above, would _always_ be used.
> find_irq() would only be used to implement the legacy allocation.
> In various places we'll have code like this:
>=20
> 	if (legacy) {
> 		irq =3D find_irq();
> 	} else {
> 		irq =3D <fixed value or formula>;
> 	}
> 	claim_irq(irq);

I rather hide all this behind a class machine operation doing the=20
allocation, it will give us a clear view of the IRQ number space usage=20
instead of spreading the definitions in the code.=20

we will need something for XIVE any how.

> Where that fixed value could be something like:
> 	irq =3D PCI_LSI_BASE + phb->index*4 + pin#;
>=20

If you use a different class machine operation for allocation claim_irq()=
=20
is not needed at all. The only case to handle is the VIO "irq" property=20
which requires and extra operation.=20

C.
