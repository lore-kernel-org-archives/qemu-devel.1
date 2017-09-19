Received: from eggs.gnu.org ([2001:4830:134:3::10]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duJsu-0006cv-JJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duJsr-0004dq-7V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:52:24 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:34007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duJsr-0004d6-1A
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:52:21 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 686A7159359
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:52:19 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-6-clg@kaod.org> <20170919024544.GK27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f4c2ca7a-0757-f847-7a3e-4907d9b6582d@kaod.org>
Date: Tue, 19 Sep 2017 16:52:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170919024544.GK27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/21] ppc/xive: allocate IRQ
 numbers for the IPIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/19/2017 04:45 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:19PM +0200, C=E9dric Le Goater wrote:
>> The number of IPIs is deduced from the max number of CPUs the guest
>> supports and the IRQ numbers for the IPIs are allocated from the top
>> of the IRQ number space to reduce conflict with other IRQ numbers
>> allocated by the devices.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This is more ick associated with implementing XIVE in terms of XICS.
> We shouldn't need to "allocate" IRQs for the IPIs - they should just
> be a fixed set. =20

They are allocated at the right beginning so we can consider them
fixed I suppose.=20

> And we certainly shouldn't need to set the XICS irq type for XIVE irqs.

This is because, in this patchset, XIVE and XICS use the same IRQ=20
allocator which happens to be the ICSIRQState array of XICS. yes,=20
this is ugly but we are identifying the different constraints.=20

We should be doing the same with a common interrupt source, that is
to allocate some IRQ numbers for the IPIs.=20

C.


>> ---
>>  hw/intc/spapr_xive.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 1681affb0848..52c32f588d6d 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -58,6 +58,7 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
>>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>>      Object *obj;
>>      Error *err =3D NULL;
>> +    int i;
>> =20
>>      if (!xive->nr_targets) {
>>          error_setg(errp, "Number of interrupt targets needs to be gre=
ater 0");
>> @@ -80,6 +81,11 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
>> =20
>>      xive->ics =3D ICS_BASE(obj);
>> =20
>> +    /* Allocate the last IRQ numbers for the IPIs */
>> +    for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i=
++) {
>> +        ics_set_irq_type(xive->ics, i, false);
>> +    }
>> +
>>      /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte=
 */
>>      xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>>      xive->sbe =3D g_malloc0(xive->sbe_size);
>=20
