Received: from eggs.gnu.org ([2001:4830:134:3::10]:46440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ftFOy-0007X0-QT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ftFBn-0001Ml-LZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:44:02 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ftFBn-0001Ko-8n
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:43:59 -0400
Received: from player786.ha.ovh.net (unknown [10.109.146.168])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 94F2DC1A20
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 18:43:57 +0200 (CEST)
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
	<20180821043343.7514-26-david@gibson.dropbear.id.au>
	<CAFEAcA8k7u6HoAuS3v-FUzDA37-1a9Sy=QrqXvJVEKjRtCWsAA@mail.gmail.com>
	<7a3389a5-ffc5-58d9-659d-fbc46e88ca24@kaod.org>
	<20180824173839.03f8c29b@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7e4d61cc-1da4-ecb8-8dd3-f3e51b20861a@kaod.org>
Date: Fri, 24 Aug 2018 18:43:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180824173839.03f8c29b@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 25/26] spapr_pci: factorize the use of
 SPAPR_MACHINE_GET_CLASS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On 08/24/2018 05:38 PM, Greg Kurz wrote:
> On Fri, 24 Aug 2018 17:30:12 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 08/24/2018 05:09 PM, Peter Maydell wrote:
>>> On 21 August 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au=
> wrote: =20
>>>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>
>>>> It should save us some CPU cycles as these routines perform a lot of
>>>> checks.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>> ---
>>>>  hw/ppc/spapr_pci.c | 11 ++++++-----
>>>>  1 file changed, 6 insertions(+), 5 deletions(-) =20
>>>
>>> Hi; Coverity points out in CID 1395183 that there's a bug in
>>> this part of this patch:
>>>  =20
>>>> @@ -1558,6 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
>>>>      sPAPRMachineState *spapr =3D
>>>>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(=
),
>>>>                                                    TYPE_SPAPR_MACHIN=
E);
>>>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr); =20
>>>
>>> This has moved the call to SPAPR_MACHINE_GET_CLASS() above
>>> the check for "is spapr NULL", which is wrong, because it
>>> will unconditionally dereference the pointer you pass to it. =20
>>
>=20
> I've sent a trivial patch to fix this.

yes. Looks good. But,

>=20
>> I see. This is a simple fix but the root reason for this check is=20
>> commit f7d6bfcdc0fe ("spapr_pci: fail gracefully with non-pseries=20
>> machine types").=20
>>
>=20
> Yeah, we also have one in spapr_cpu_core_realize() for the very
> same reason.
>
>> Is there a way to specify which device type can or can not be=20
>> plugged on a machine ?=20
>>
>> I suppose we cannot use :=20
>>
>> 	machine_class_allow_dynamic_sysbus_dev()=20
>>
>> for cold plugged devices. Or can we ? That would be better.
>>
>=20
> Hmm... not sure this would help. The root problem is that many
> places in spapr_pci and spapr_cpu_core assume the machine is
> sPAPR.

which is a perfectly legitimate assumption for a sPAPR only device,
same for spapr_cpu_core. I would think. Shouldn't we enforce=20
the restriction at the machine level instead and not at the device
level ?=20

I thought that was the purpose of commit 0bd1909da606 ("machine:=20
Replace has_dynamic_sysbus with list of allowed devices"), to=20
make sure machines had a predefined list of user-creatable devices.

I might be missing something.

Thanks,

C.
