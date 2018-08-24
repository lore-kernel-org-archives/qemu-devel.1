Received: from eggs.gnu.org ([2001:4830:134:3::10]:51627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ftE2m-0004i0-KL
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ftE2j-0007Bs-Ed
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:30:36 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:54549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ftE2j-000752-8a
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:30:33 -0400
Received: from player688.ha.ovh.net (unknown [10.109.143.249])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9C6C429B7F
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 17:30:22 +0200 (CEST)
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
	<20180821043343.7514-26-david@gibson.dropbear.id.au>
	<CAFEAcA8k7u6HoAuS3v-FUzDA37-1a9Sy=QrqXvJVEKjRtCWsAA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7a3389a5-ffc5-58d9-659d-fbc46e88ca24@kaod.org>
Date: Fri, 24 Aug 2018 17:30:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8k7u6HoAuS3v-FUzDA37-1a9Sy=QrqXvJVEKjRtCWsAA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On 08/24/2018 05:09 PM, Peter Maydell wrote:
> On 21 August 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au> =
wrote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> It should save us some CPU cycles as these routines perform a lot of
>> checks.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/spapr_pci.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> Hi; Coverity points out in CID 1395183 that there's a bug in
> this part of this patch:
>=20
>> @@ -1558,6 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
>>      sPAPRMachineState *spapr =3D
>>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
>>                                                    TYPE_SPAPR_MACHINE)=
;
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>=20
> This has moved the call to SPAPR_MACHINE_GET_CLASS() above
> the check for "is spapr NULL", which is wrong, because it
> will unconditionally dereference the pointer you pass to it.

I see. This is a simple fix but the root reason for this check is=20
commit f7d6bfcdc0fe ("spapr_pci: fail gracefully with non-pseries=20
machine types").=20

Is there a way to specify which device type can or can not be=20
plugged on a machine ?=20

I suppose we cannot use :=20

	machine_class_allow_dynamic_sysbus_dev()=20

for cold plugged devices. Or can we ? That would be better.

Thanks,

C.
