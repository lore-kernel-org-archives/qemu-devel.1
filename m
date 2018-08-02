Received: from eggs.gnu.org ([2001:4830:134:3::10]:60611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1flG1O-00078W-Ci
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1flG1J-00030E-Mf
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:00:14 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:45796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1flG1J-0002s9-Gl
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 12:00:09 -0400
Received: from player739.ha.ovh.net (unknown [10.109.143.72])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 10671C236A
	for <qemu-devel@nongnu.org>; Thu,  2 Aug 2018 18:00:00 +0200 (CEST)
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-5-clg@kaod.org>
	<20180802164737.674392ea@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <df45ca03-db45-e777-da2f-c46232a83215@kaod.org>
Date: Thu, 2 Aug 2018 17:59:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180802164737.674392ea@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 4/4] spapr: increase the size of the IRQ
 number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 08/02/2018 04:47 PM, Greg Kurz wrote:
> On Mon, 30 Jul 2018 16:11:34 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> The new layout using static IRQ number does not leave much space to
>> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
>> number of IRQS for newer machines and introduce a legacy XICS backend
>> for pre-3.1 machines to maintain compatibility.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_irq.h |  1 +
>>  hw/ppc/spapr.c             |  1 +
>>  hw/ppc/spapr_irq.c         | 12 +++++++++++-
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 0e98c4474bb2..626160ba475e 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -40,6 +40,7 @@ typedef struct sPAPRIrq {
>>  } sPAPRIrq;
>> =20
>>  extern sPAPRIrq spapr_irq_xics;
>> +extern sPAPRIrq spapr_irq_xics_legacy;
>> =20
>>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d9f8cca49208..5ae62b0682d2 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3947,6 +3947,7 @@ static void spapr_machine_3_0_class_options(Mach=
ineClass *mc)
>>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
>> =20
>>      smc->legacy_irq_allocation =3D true;
>> +    smc->irq =3D &spapr_irq_xics_legacy;
>>  }
>> =20
>>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 0cbb5dd39368..620c49b38455 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -196,7 +196,7 @@ static void spapr_irq_print_info_xics(sPAPRMachine=
State *spapr, Monitor *mon)
>>  }
>> =20
>>  sPAPRIrq spapr_irq_xics =3D {
>> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
>> +    .nr_irqs     =3D 0x1000,
>=20
> IMHO using XICS_IRQS_SPAPR as the total number of MSIs for the whole
> machine was bogus, since the DT also advertises this same number of
> available MSIs per PHB:
>=20
> *** hw/ppc/spapr_pci.c:
> spapr_populate_pci_dt[2126]
>=20
>     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_=
SPAPR));
>=20
> Even if you bump the limit from 1024 to 4096, we still have a discrepan=
cy
> between what we tell the guest and what the machine can actually do.

Yes. But that is another unrelated problem that this patch is not=20
trying to solve. The patch is just about increasing the total=20
number of IRQs to have some more MSIs to allocate at a machine=20
level.

> I'm wondering if we should take into account the number of possible
> PHBs when initializing the bitmap allocator, ie, .nr_irqs should
> rather be SPAPR_MAX_PHBS * XICS_IRQS_SPAPR ?

XICS_IRQS_SPAPR is a machine level number and it is a little more=20
complex than that. Something like  :=20

	SPAPR_IRQ_MSI - XICS_IRQ_BASE + (max_phbs * max_msis_per_phb).=20


C.

>> =20
>>      .init        =3D spapr_irq_init_xics,
>>      .claim       =3D spapr_irq_claim_xics,
>> @@ -284,3 +284,13 @@ int spapr_irq_find(sPAPRMachineState *spapr, int =
num, bool align, Error **errp)
>> =20
>>      return first + ics->offset;
>>  }
>> +
>> +sPAPRIrq spapr_irq_xics_legacy =3D {
>> +    .nr_irqs     =3D XICS_IRQS_SPAPR,
>> +
>> +    .init        =3D spapr_irq_init_xics,
>> +    .claim       =3D spapr_irq_claim_xics,
>> +    .free        =3D spapr_irq_free_xics,
>> +    .qirq        =3D spapr_qirq_xics,
>> +    .print_info  =3D spapr_irq_print_info_xics,
>> +};
>=20
