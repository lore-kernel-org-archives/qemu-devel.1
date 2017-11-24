Received: from eggs.gnu.org ([2001:4830:134:3::10]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI9Pk-0005VM-Hp
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI9Ph-0008Kf-AW
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:32:48 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:59017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI9Ph-0008Jj-5A
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:32:45 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7A4E611FCCF
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 09:32:43 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-6-clg@kaod.org>
	<20171124031659.GD28000@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3fa0d8b4-ca31-86c4-101b-9a2eb5823686@kaod.org>
Date: Fri, 24 Nov 2017 09:32:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171124031659.GD28000@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/25] spapr: introduce a spapr_irq_set()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/24/2017 04:16 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:35PM +0100, C=E9dric Le Goater wrote:
>> It will make synchronisation easier with the XIVE interrupt mode when
>> available. The 'irq' parameter refers to the global IRQ number space.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> s/spapr_irq_set/spapr_irq_set_lsi/
>=20
> otherwise the name doesn't tell you what it sets.

That is when it gets confusing. This routine does two things :

 - it allocates the IRQ number=20
 - it sets the type of the allocated IRQ number, LSI or MSI.=20

because both information are held under the same flag :=20

  ics->irqs[srcno].flags

But the main purpose of this routine is to do the allocation,=20
so that is why I changed the name.=20

Now that you have the explanations and that you rather still=20
have the prefix '_lsi', please tell me. In any case, I will add
a comment on what the routine is doing.

Thanks,

C.   =20
=20
=20
> With that change,
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>> ---
>>  hw/ppc/spapr.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 7ae84d40bdb4..79f38a9ff4e1 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3594,6 +3594,11 @@ static int ics_find_free_block(ICSState *ics, i=
nt num, int alignnum)
>>      return -1;
>>  }
>> =20
>> +static void spapr_irq_set(sPAPRMachineState *spapr, int irq, bool lsi=
)
>> +{
>> +    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
>> +}
>> +
>>  int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
>>                      Error **errp)
>>  {
>> @@ -3618,7 +3623,7 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, in=
t irq_hint, bool lsi,
>>          irq +=3D ics->offset;
>>      }
>> =20
>> -    ics_set_irq_type(ics, irq - ics->offset, lsi);
>> +    spapr_irq_set(spapr, irq, lsi);
>>      trace_spapr_irq_alloc(irq);
>> =20
>>      return irq;
>> @@ -3657,10 +3662,10 @@ int spapr_irq_alloc_block(sPAPRMachineState *s=
papr, int num, bool lsi,
>>          return -1;
>>      }
>> =20
>> +    first +=3D ics->offset;
>>      for (i =3D first; i < first + num; ++i) {
>> -        ics_set_irq_type(ics, i, lsi);
>> +        spapr_irq_set(spapr, i, lsi);
>>      }
>> -    first +=3D ics->offset;
>> =20
>>      trace_spapr_irq_alloc_block(first, num, lsi, align);
>> =20
>=20
