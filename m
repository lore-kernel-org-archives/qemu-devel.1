Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJkSs-0001Cn-0U
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJkSp-0006AU-6n
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:18:37 -0500
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:38353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eJkSo-000690-US
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:18:35 -0500
Received: from player738.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 782FD4A2F1
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 19:18:26 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-10-clg@kaod.org>
	<20171128054553.GO11775@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b921075a-8c4a-c806-e169-5d17c4b233f5@kaod.org>
Date: Tue, 28 Nov 2017 18:18:20 +0000
MIME-Version: 1.0
In-Reply-To: <20171128054553.GO11775@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/25] spapr: introduce handlers for XIVE
 interrupt sources
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

On 11/28/2017 05:45 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:39PM +0100, C=E9dric Le Goater wrote:
>> These are very similar to the XICS handlers in a simpler form. They ma=
ke
>> use of a status array for the LSI interrupts. The spapr_xive_irq() rou=
tine
>> in charge of triggering the CPU interrupt line will be filled later on=
.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Is the status word you add here architected as part of the XIVE spec,
> or purely internal / implementation specific?

this is the model.

>=20
>> ---
>>  hw/intc/spapr_xive.c        | 55 ++++++++++++++++++++++++++++++++++++=
+++++++--
>>  include/hw/ppc/spapr_xive.h | 14 +++++++++++-
>>  2 files changed, 66 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index b2fc3007c85f..66c533fb1d78 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -26,6 +26,47 @@
>> =20
>>  #include "xive-internal.h"
>> =20
>> +static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>> +{
>> +
>> +}
>> +
>> +/*
>> + * XIVE Interrupt Source
>> + */
>> +static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int lisn, =
int val)
>> +{
>> +    if (val) {
>> +        spapr_xive_irq(xive, lisn);
>> +    }
>> +}
>> +
>> +static void spapr_xive_source_set_irq_lsi(sPAPRXive *xive, int lisn, =
int val)
>> +{
>> +    if (val) {
>> +        xive->status[lisn] |=3D XIVE_STATUS_ASSERTED;
>> +    } else {
>> +        xive->status[lisn] &=3D ~XIVE_STATUS_ASSERTED;
>> +    }
>> +
>> +    if (xive->status[lisn] & XIVE_STATUS_ASSERTED &&
>> +        !(xive->status[lisn] & XIVE_STATUS_SENT)) {
>> +        xive->status[lisn] |=3D XIVE_STATUS_SENT;
>> +        spapr_xive_irq(xive, lisn);
>> +    }
>> +}
>> +
>> +static void spapr_xive_source_set_irq(void *opaque, int lisn, int val=
)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +
>> +    if (spapr_xive_irq_is_lsi(xive, lisn)) {
>> +        spapr_xive_source_set_irq_lsi(xive, lisn, val);
>> +    } else {
>> +        spapr_xive_source_set_irq_msi(xive, lisn, val);
>> +    }
>> +}
>> +
>>  /*
>>   * Main XIVE object
>>   */
>> @@ -41,7 +82,8 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Moni=
tor *mon)
>>              continue;
>>          }
>> =20
>> -        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
>> +        monitor_printf(mon, "  %4x %s %s %08x %08x\n", i,
>> +                       spapr_xive_irq_is_lsi(xive, i) ? "LSI" : "MSI"=
,
>>                         ive->w & IVE_MASKED ? "M" : " ",
>>                         (int) GETFIELD(IVE_EQ_INDEX, ive->w),
>>                         (int) GETFIELD(IVE_EQ_DATA, ive->w));
>> @@ -53,6 +95,8 @@ void spapr_xive_reset(void *dev)
>>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>>      int i;
>> =20
>> +    /* Do not clear IRQs status */
>> +
>>      /* Mask all valid IVEs in the IRQ number space. */
>>      for (i =3D 0; i < xive->nr_irqs; i++) {
>>          XiveIVE *ive =3D &xive->ivt[i];
>> @@ -71,6 +115,11 @@ static void spapr_xive_realize(DeviceState *dev, E=
rror **errp)
>>          return;
>>      }
>> =20
>> +    /* QEMU IRQs */
>> +    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xiv=
e,
>> +                                     xive->nr_irqs);
>> +    xive->status =3D g_malloc0(xive->nr_irqs);
>> +
>>      /* Allocate the IVT (Interrupt Virtualization Table) */
>>      xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
>> =20
>> @@ -102,6 +151,7 @@ static const VMStateDescription vmstate_spapr_xive=
 =3D {
>>          VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
>>          VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 1=
,
>>                                             vmstate_spapr_xive_ive, Xi=
veIVE),
>> +        VMSTATE_VBUFFER_UINT32(status, sPAPRXive, 1, NULL, nr_irqs),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> @@ -140,7 +190,7 @@ XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint3=
2_t lisn)
>>      return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
>>  }
>> =20
>> -bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn)
>> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn, bool lsi)
>>  {
>>      XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
>> =20
>> @@ -149,6 +199,7 @@ bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t =
lisn)
>>      }
>> =20
>>      ive->w |=3D IVE_VALID;
>> +    xive->status[lisn] |=3D lsi ? XIVE_STATUS_LSI : 0;
>=20
> How does a hardware XIVE know which irqs are LSI and which are MSI?

AFAICT, it doesn't. LSI events are configured as the other XIVE interrupt=
s.=20
The level is converted in the P bit and the Q bit should always be zero.
So I should be able to simplify the proposed model which still is mimicki=
ng=20
XICS  ... I will take a look at it.=20

There are a sort of special degenerated LSIs but these are for bringup.

Thanks,

C.=20

>>      return true;
>>  }
>> =20
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 795b3f4ded7c..6a799cdaba66 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -33,11 +33,23 @@ struct sPAPRXive {
>>      /* Properties */
>>      uint32_t     nr_irqs;
>> =20
>> +     /* IRQ */
>> +    qemu_irq     *qirqs;
>> +#define XIVE_STATUS_LSI                0x1
>> +#define XIVE_STATUS_ASSERTED           0x2
>> +#define XIVE_STATUS_SENT               0x4
>> +    uint8_t      *status;
>> +
>>      /* XIVE internal tables */
>>      XiveIVE      *ivt;
>>  };
>> =20
>> -bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn);
>> +static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xive, int lisn)
>> +{
>> +    return xive->status[lisn] & XIVE_STATUS_LSI;
>> +}
>> +
>> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn, bool lsi);
>>  bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t lisn);
>>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>> =20
>=20
