Received: from eggs.gnu.org ([2001:4830:134:3::10]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNIHm-0003sA-8r
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNIHj-00012z-65
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:34:06 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:48742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNIHj-00010h-0D
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:34:03 -0400
Received: from player738.ha.ovh.net (unknown [10.109.122.23])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2E8B117957D
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 15:33:47 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
	<a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
	<8d7552ef-a0b2-621e-8d56-edb128874a6e@redhat.com>
	<a51f298d-d199-ca41-7059-f00a3538ba61@kaod.org>
	<20180528140904.7f673c63@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <188b391f-0058-9481-5cb7-3acf23d3ae91@kaod.org>
Date: Mon, 28 May 2018 15:33:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180528140904.7f673c63@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: remove irq_hint
 parameter from spapr_irq_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 05/28/2018 02:09 PM, Greg Kurz wrote:
> On Mon, 28 May 2018 11:20:36 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 05/28/2018 09:18 AM, Thomas Huth wrote:
>>> On 28.05.2018 09:06, C=C3=A9dric Le Goater wrote: =20
>>>> On 05/28/2018 08:17 AM, Thomas Huth wrote: =20
>>>>> On 25.05.2018 16:02, Greg Kurz wrote: =20
>>>>>> On Fri, 18 May 2018 18:44:02 +0200
>>>>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>>>> =20
>>>>>>> This IRQ number hint can possibly be used by the VIO devices if t=
he
>>>>>>> "irq" property is defined on the command line but it seems it is =
never
>>>>>>> the case. It is not used in libvirt for instance. So, let's remov=
e it
>>>>>>> to simplify future changes.
>>>>>>> =20
>>>>>>
>>>>>> Setting an irq manually looks a bit anachronistic. I doubt anyone =
would
>>>>>> do that nowadays, and the patch does a nice cleanup. So this looks=
 like
>>>>>> a good idea. =20
>>>>> [...] =20
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
>>>>>>> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err); =20
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
>>>>>> Cc'ing Thomas, our Chief Deprecation Officer, for insights :) =20
>>>>>
>>>>> The property is a public interface. Just because it's not used by
>>>>> libvirt does not mean that nobody is using it. So yes, please follo=
w the
>>>>> rules and mark it as deprecated first for two release, before you r=
eally
>>>>> remove it. =20
>>>>
>>>> This "irq" property is a problem to introduce a new static layout of=
 IRQ=20
>>>> numbers. It is in complete opposition.=20
>>>>
>>>> Can we keep it as it is for old pseries machine (settable) and ignor=
e it=20
>>>> for newer ? Would that be fine ? =20
>>>
>>> I think that would be fine, too. You likely need to keep the settable
>>> IRQs around for the old machines anyway, to make sure that migration =
of
>>> the old machine types still works, right? =20
>>
>> Yes, that is the goal of patch 3. It introduces a common sPAPR IRQ fro=
ntend,
>> the first backend being the current one.
>>
>=20
> If we keep "irq" but we ignore it with newer machine types, we should a=
t
> least print a warning then IMHO.

May be we can deprecate at the same time. I will take a look.

Thanks,

C.
