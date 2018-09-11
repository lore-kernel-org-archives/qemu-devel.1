Received: from eggs.gnu.org ([2001:4830:134:3::10]:43981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzaZR-0005fo-Eo
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzaUV-0008BH-CY
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:41:34 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:34083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzaUV-0008B1-4w
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:41:31 -0400
Received: from player772.ha.ovh.net (unknown [10.109.146.86])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6B1441D18EF
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 06:41:29 +0200 (CEST)
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910110222.8162-2-clg@kaod.org>
	<20180911014821.GE7978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e8f02b91-6e8f-9215-18c8-401049be5416@kaod.org>
Date: Tue, 11 Sep 2018 06:41:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180911014821.GE7978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: introduce a spapr_irq class
 'nr_msis' attribute
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

On 09/11/2018 03:48 AM, David Gibson wrote:
> On Mon, Sep 10, 2018 at 01:02:20PM +0200, C=E9dric Le Goater wrote:
> 11;rgb:ffff/ffff/ffff> The number of MSI interrupts a sPAPR machine can=
 allocate is in direct
>> relation with the number of interrupts of the sPAPRIrq backend. Define
>> statically this value at the sPAPRIrq class level.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_irq.h | 1 +
>>  hw/ppc/spapr_irq.c         | 9 +++++++--
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 0e98c4474bb2..650f810ad2aa 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>> =20
>>  typedef struct sPAPRIrq {
>>      uint32_t    nr_irqs;
>> +    uint32_t    nr_msis;
>> =20
>>      void (*init)(sPAPRMachineState *spapr, Error **errp);
>>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 0cbb5dd39368..d369ac96f5cd 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *s=
papr, Error **errp)
>> =20
>>      /* Initialize the MSI IRQ allocator. */
>>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
>> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
>>      }
>> =20
>>      if (kvm_enabled()) {
>> @@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachin=
eState *spapr, Monitor *mon)
>>      ics_pic_print_info(spapr->ics, mon);
>>  }
>> =20
>> +#define SPAPR_IRQ_XICS_NR_IRQS     XICS_IRQS_SPAPR
>> +#define SPAPR_IRQ_XICS_NR_MSIS     \
>> +    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
>=20
> Uh.. I'm not quite understanding how XICS_IRQ_BASE gets into this.

because the IRQ ranges of the new static IRQ number space start at=20
the sPAPR IRQ number offset.

XICS_IRQ_BASE		0x1000
SPAPR_IRQ_XICS_NR_IRQS	0x400

SPAPR_IRQ_MSI		0x1300

0x1000 + 0x400 - 0x1300 =3D 0x100

we could use SPAPR_IRQ_EPOW instead or some other value defining=20
the IRQ0 number.

>=20
>>  sPAPRIrq spapr_irq_xics =3D {
>> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
>> +    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
>> +    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
>> =20
>>      .init        =3D spapr_irq_init_xics,
>>      .claim       =3D spapr_irq_claim_xics,
>=20
