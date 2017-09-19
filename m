Received: from eggs.gnu.org ([2001:4830:134:3::10]:52605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duK8W-0004FV-Ja
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duK8T-0007dW-Qe
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:08:32 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:59009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duK8T-0007cc-L7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:08:29 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5482A158D25
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 17:08:28 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-7-clg@kaod.org> <20170919024849.GL27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7e43adba-0e65-df5f-b87a-e16115fb3c95@kaod.org>
Date: Tue, 19 Sep 2017 17:08:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170919024849.GL27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/21] ppc/xive: introduce handlers
 for interrupt sources
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

On 09/19/2017 04:48 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:20PM +0200, C=E9dric Le Goater wrote:
>> These are very similar to the XICS handlers in a simpler form. They
>> make use of the ICSIRQState array of the XICS interrupt source to
>> differentiate the MSI from the LSI interrupts. The spapr_xive_irq()
>> routine in charge of triggering the CPU interrupt line will be filled
>> later on.
>>
>> The next patch will introduce the MMIO handlers to interact with XIVE
>> interrupt sources.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c        | 46 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 52c32f588d6d..1ed7b6a286e9 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -27,6 +27,50 @@
>> =20
>>  #include "xive-internal.h"
>> =20
>> +static void spapr_xive_irq(sPAPRXive *xive, int srcno)
>> +{
>> +
>> +}
>> +
>> +/*
>> + * XIVE Interrupt Source
>> + */
>> +static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int srcno,=
 int val)
>> +{
>> +    if (val) {
>> +        spapr_xive_irq(xive, srcno);
>> +    }
>> +}
>=20
> So in XICS "srcno" (vs "irq") indicates an offset within a single ICS
> object, as opposed to a global irq number.  Does that concept even
> exist in XIVE?

We don't really care in the internals. 'srcno' is just an index in the=20
tables, may be I should change the name. It could be the same in XICS=20
but the xirr is manipulated at low level and so we need to propagate=20
the source offset in a couple of places.=20

This to say that the 'irq' number is a guest level information which
in the patchset should only be used at the hcall level to identify=20
a source.
=20
>> +
>> +static void spapr_xive_source_set_irq_lsi(sPAPRXive *xive, int srcno,=
 int val)
>> +{
>> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
>> +
>> +    if (val) {
>> +        irq->status |=3D XICS_STATUS_ASSERTED;
>> +    } else {
>> +        irq->status &=3D ~XICS_STATUS_ASSERTED;
>=20
> More mangling a XICS specific object for XIVE operations.  Please
> stop.

ah ! we will still need the same information and that means introducing=20
a common source object. The patchset today just uses the XICS ICSIRQState=
=20
array as a common object.
=20
>> +    }
>> +
>> +    if (irq->status & XICS_STATUS_ASSERTED
>> +        && !(irq->status & XICS_STATUS_SENT)) {
>> +        irq->status |=3D XICS_STATUS_SENT;
>> +        spapr_xive_irq(xive, srcno);
>> +    }
>> +}
>> +
>> +static void spapr_xive_source_set_irq(void *opaque, int srcno, int va=
l)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
>> +
>> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
>> +        spapr_xive_source_set_irq_lsi(xive, srcno, val);
>> +    } else {
>> +        spapr_xive_source_set_irq_msi(xive, srcno, val);
>> +    }
>> +}
>> +
>>  /*
>>   * Main XIVE object
>>   */
>> @@ -80,6 +124,8 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
>>      }
>> =20
>>      xive->ics =3D ICS_BASE(obj);
>> +    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xiv=
e,
>> +                                     xive->nr_irqs);
>> =20
>>      /* Allocate the last IRQ numbers for the IPIs */
>>      for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i=
++) {
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 29112589b37f..eab92c4c1bb8 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -38,6 +38,7 @@ struct sPAPRXive {
>> =20
>>      /* IRQ */
>>      ICSState     *ics;  /* XICS source inherited from the SPAPR machi=
ne */
>> +    qemu_irq     *qirqs;
>> =20
>>      /* XIVE internal tables */
>>      uint8_t      *sbe;
>=20
