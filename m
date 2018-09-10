Received: from eggs.gnu.org ([2001:4830:134:3::10]:40434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzFlQ-0007fh-2a
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzFlM-00033i-Qc
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:33:35 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:46732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzFlM-000335-ES
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:33:32 -0400
Received: from player778.ha.ovh.net (unknown [10.109.143.109])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 07C5928AFF
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 08:33:30 +0200 (CEST)
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-5-clg@kaod.org>
	<20180910061223.GF24181@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3eb205c2-fa99-19e0-e07a-fc0ba0313d23@kaod.org>
Date: Mon, 10 Sep 2018 08:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180910061223.GF24181@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 09/10/2018 08:12 AM, David Gibson wrote:
> On Mon, Jul 30, 2018 at 04:11:34PM +0200, C=E9dric Le Goater wrote:
>> The new layout using static IRQ number does not leave much space to
>> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
>> number of IRQS for newer machines and introduce a legacy XICS backend
>> for pre-3.1 machines to maintain compatibility.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Sorry, I got sidetracked and forgot about reviewing this patch.

No problem. It is giving us time to work on OpenCAPI passthrough
and challenge a bit more the static IRQ layout and the sPAPR XIVE=20
interrupt mode. =20

> Now that the number of irqs is set in the backend, I think the
> reference to XICS_IRQS_SPAPR setting ibm,pe-total-#msi in
> spapr_populate_pci_dt() needs to be change to look at the backend
> instead...

Yes. The number is in direct relation with the msi allocator. =20

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
>=20
> .. and with that done, I think it makes to just inline the old value
> here and remove the XICS_IRQS_SPAPR #define, since its name is no
> longer accurate.

yes

Thanks,

C.

>> +
>> +    .init        =3D spapr_irq_init_xics,
>> +    .claim       =3D spapr_irq_claim_xics,
>> +    .free        =3D spapr_irq_free_xics,
>> +    .qirq        =3D spapr_qirq_xics,
>> +    .print_info  =3D spapr_irq_print_info_xics,
>> +};
>=20
