Received: from eggs.gnu.org ([2001:4830:134:3::10]:43718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fP2h8-00078s-V5
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fP2h3-0001G8-W3
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:19:30 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:47674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fP2h3-00017X-Nw
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:19:25 -0400
Received: from player687.ha.ovh.net (unknown [10.109.105.117])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 693F3165AB
	for <qemu-devel@nongnu.org>; Sat,  2 Jun 2018 11:19:23 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <683ccfbd-ef6f-4ce1-b53a-8f01919ec5c5@kaod.org>
Date: Sat, 2 Jun 2018 11:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 05/28/2018 08:17 AM, Thomas Huth wrote:
> On 25.05.2018 16:02, Greg Kurz wrote:
>> On Fri, 18 May 2018 18:44:02 +0200
>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>
>>> This IRQ number hint can possibly be used by the VIO devices if the
>>> "irq" property is defined on the command line but it seems it is neve=
r
>>> the case. It is not used in libvirt for instance. So, let's remove it
>>> to simplify future changes.
>>>
>>
>> Setting an irq manually looks a bit anachronistic. I doubt anyone woul=
d
>> do that nowadays, and the patch does a nice cleanup. So this looks lik=
e
>> a good idea.
> [...]
>>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>>> index 472dd6f33a96..cc064f64fccf 100644
>>> --- a/hw/ppc/spapr_vio.c
>>> +++ b/hw/ppc/spapr_vio.c
>>> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceState =
*qdev, Error **errp)
>>>          dev->qdev.id =3D id;
>>>      }
>>> =20
>>> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err)=
;
>>> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
>>
>> Silently breaking "irq" like this looks wrong. I'd rather officially r=
emove
>> it first (ie, kill spapr_vio_props, -5 lines in spapr_vio.c).
>>
>> Of course, this raises the question of interface deprecation, and it s=
hould
>> theoretically follow the process described at:
>>
>> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_int=
erface
>>
>> Cc'ing Thomas, our Chief Deprecation Officer, for insights :)
>=20
> The property is a public interface. Just because it's not used by
> libvirt does not mean that nobody is using it. So yes, please follow th=
e
> rules and mark it as deprecated first for two release, before you reall=
y
> remove it.

I don't see a section for 'Deprecated' properties in the qemu-doc files.=20

C.
