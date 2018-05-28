Received: from eggs.gnu.org ([2001:4830:134:3::10]:35322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNCQi-0008M2-H4
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNCQf-0002rI-7V
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:18:56 -0400
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
	<a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8d7552ef-a0b2-621e-8d56-edb128874a6e@redhat.com>
Date: Mon, 28 May 2018 09:18:49 +0200
MIME-Version: 1.0
In-Reply-To: <a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
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
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 28.05.2018 09:06, C=C3=A9dric Le Goater wrote:
> On 05/28/2018 08:17 AM, Thomas Huth wrote:
>> On 25.05.2018 16:02, Greg Kurz wrote:
>>> On Fri, 18 May 2018 18:44:02 +0200
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> This IRQ number hint can possibly be used by the VIO devices if the
>>>> "irq" property is defined on the command line but it seems it is nev=
er
>>>> the case. It is not used in libvirt for instance. So, let's remove i=
t
>>>> to simplify future changes.
>>>>
>>>
>>> Setting an irq manually looks a bit anachronistic. I doubt anyone wou=
ld
>>> do that nowadays, and the patch does a nice cleanup. So this looks li=
ke
>>> a good idea.
>> [...]
>>>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>>>> index 472dd6f33a96..cc064f64fccf 100644
>>>> --- a/hw/ppc/spapr_vio.c
>>>> +++ b/hw/ppc/spapr_vio.c
>>>> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceState=
 *qdev, Error **errp)
>>>>          dev->qdev.id =3D id;
>>>>      }
>>>> =20
>>>> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err=
);
>>>> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
>>>
>>> Silently breaking "irq" like this looks wrong. I'd rather officially =
remove
>>> it first (ie, kill spapr_vio_props, -5 lines in spapr_vio.c).
>>>
>>> Of course, this raises the question of interface deprecation, and it =
should
>>> theoretically follow the process described at:
>>>
>>> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_in=
terface
>>>
>>> Cc'ing Thomas, our Chief Deprecation Officer, for insights :)
>>
>> The property is a public interface. Just because it's not used by
>> libvirt does not mean that nobody is using it. So yes, please follow t=
he
>> rules and mark it as deprecated first for two release, before you real=
ly
>> remove it.
>=20
> This "irq" property is a problem to introduce a new static layout of IR=
Q=20
> numbers. It is in complete opposition.=20
>=20
> Can we keep it as it is for old pseries machine (settable) and ignore i=
t=20
> for newer ? Would that be fine ?

I think that would be fine, too. You likely need to keep the settable
IRQs around for the old machines anyway, to make sure that migration of
the old machine types still works, right?

 Thomas
