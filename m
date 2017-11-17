Received: from eggs.gnu.org ([2001:4830:134:3::10]:37230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eFatY-0006c0-2h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eFatU-0008TX-1O
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:17:00 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:57166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eFatT-0008R2-S5
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:16:55 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 481A79DB80
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 08:16:54 +0100 (CET)
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-4-clg@kaod.org>
	<20171117044825.GA26448@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ef798010-c69f-2a7c-c083-7f6d227e4836@kaod.org>
Date: Fri, 17 Nov 2017 08:16:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171117044825.GA26448@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 03/11] spapr: introduce new
 XICSFabric operations for an IRQ allocator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/17/2017 05:48 AM, David Gibson wrote:
> On Fri, Nov 10, 2017 at 03:20:09PM +0000, C=E9dric Le Goater wrote:
>> Currently, the ICSState 'ics' object of the sPAPR machine acts as the
>> global interrupt source handler and also as the IRQ number allocator
>> for the machine. Some IRQ numbers are allocated very early in the
>> machine initialization sequence to populate the device tree, and this
>> is a problem to introduce the new POWER XIVE interrupt model, as it
>> needs to share the IRQ numbers with the older model.
>>
>> To prepare ground for XIVE, here is a set of new XICSFabric operations
>> to let the machine handle directly the IRQ number allocation and to
>> decorrelate the allocation from the interrupt source object :
>>
>>     bool (*irq_test)(XICSFabric *xi, int irq);
>>     int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>>     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>>
>> In these prototypes, the 'irq' parameter refers to a number in the
>> global IRQ number space. Indexes for arrays storing different state
>> informations on the interrupts, like the ICSIRQState, are usually
>> named 'srcno'.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This doesn't seem sensible to me.  When I said you should move irq
> allocation to the machine, I mean actually move the code.  The only
> user of irq allocation should be in the machine, so we shouldn't need
> to indirect via the XICSFabric interface to do that.

OK. so we can probably do the same with machine class handlers because=20
we do need an indirection to handle the way older pseries machines=20
allocate IRQs that will change with newer machines  supporting XIVE.

> And, we shouldn't be using XICSFabric things for XIVE.

ok. The spapr machine should be enough.=20

Thanks,

C.
=20
>> ---
>>  hw/ppc/spapr.c        | 19 +++++++++++++++++++
>>  include/hw/ppc/xics.h |  4 ++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index a2dcbee07214..84d68f2fdbae 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3536,6 +3536,21 @@ static ICPState *spapr_icp_get(XICSFabric *xi, =
int vcpu_id)
>>      return cpu ? ICP(cpu->intc) : NULL;
>>  }
>> =20
>> +static bool spapr_irq_test(XICSFabric *xi, int irq)
>> +{
>> +    return false;
>> +}
>> +
>> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align=
)
>> +{
>> +    return -1;
>> +}
>> +
>> +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
>> +{
>> +    ;
>> +}
>> +
>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>>                                   Monitor *mon)
>>  {
>> @@ -3630,6 +3645,10 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
>>      xic->ics_get =3D spapr_ics_get;
>>      xic->ics_resend =3D spapr_ics_resend;
>>      xic->icp_get =3D spapr_icp_get;
>> +    xic->irq_test =3D spapr_irq_test;
>> +    xic->irq_alloc_block =3D spapr_irq_alloc_block;
>> +    xic->irq_free_block =3D spapr_irq_free_block;
>> +
>>      ispc->print_info =3D spapr_pic_print_info;
>>      /* Force NUMA node memory size to be a multiple of
>>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 28d248abad61..30e7f2e0a7dd 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -175,6 +175,10 @@ typedef struct XICSFabricClass {
>>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
>>      void (*ics_resend)(XICSFabric *xi);
>>      ICPState *(*icp_get)(XICSFabric *xi, int server);
>> +    /* IRQ allocator helpers */
>> +    bool (*irq_test)(XICSFabric *xi, int irq);
>> +    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>> +    void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>>  } XICSFabricClass;
>> =20
>>  #define XICS_IRQS_SPAPR               1024
>=20
