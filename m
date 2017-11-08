Received: from eggs.gnu.org ([2001:4830:134:3::10]:55927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCTeQ-0004mO-Nw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCTeL-0001G4-RP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:56:30 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:52260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCTeL-0001Ey-Gh
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:56:25 -0500
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0BA907633B
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 17:56:23 +0100 (CET)
References: <20171029181217.9927-1-clg@kaod.org>
	<20171029181217.9927-2-clg@kaod.org>
	<20171108105404.4edc12d4@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c144c7bc-2a76-2baa-7504-dee5afc0038e@kaod.org>
Date: Wed, 8 Nov 2017 16:56:17 +0000
MIME-Version: 1.0
In-Reply-To: <20171108105404.4edc12d4@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] spapr: introduce an IRQ allocator at
 the machine level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/08/2017 09:54 AM, Greg Kurz wrote:
> On Sun, 29 Oct 2017 19:12:10 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Currently, the ICSState 'ics' object of the sPAPR machine acts as the
>> global interrupt source handler and also as the IRQ number allocator
>> for the machine. Some IRQ numbers are allocated very early in the
>> machine initialization sequence to populate the device tree, and this
>> is a problem to introduce the new POWER XIVE interrupt model, as it
>> needs to share the IRQ numbers with the older model.
>>
>> To prepare ground for XIVE, here is a proposal adding a set of new
>> XICSFabric operations to let the machine handle directly the IRQ
>> number allocation and to decorrelate the allocation from the interrupt
>> source object :
>>
>>     bool (*irq_test)(XICSFabric *xi, int irq);
>>     int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>>     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>>
>> In these prototypes, the 'irq' parameter refers to a number in the
>> global IRQ number space. Indexes for arrays storing different state
>> informations on the interrupts, like the ICSIRQState, are named
>> 'srcno'.
>>
>> On the sPAPR platform, these IRQ operations are simply backed by a
>> bitmap 'irq_map' in the machine.
>>
>> 'irq_base' is a base number in sync with the ICSState 'offset'. It
>> lets us allocate only the subset of the IRQ numbers used on the sPAPR
>> platform but we could also choose to waste some extra bytes (512) and
>> allocate the whole number space. 'nr_irqs' is the total number of
>> IRQs, required to manipulate the bitmap.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>=20
> Hi,
>=20
> The idea makes sense but this patch brings too many changes IMHO.

yes. I agree. The next version splits a bit more the changes and=20
introduces the XICSFabric ops before the bitmap.=20
 =20
>>  hw/intc/xics.c         |  3 ++-
>>  hw/intc/xics_spapr.c   | 57 ++++++++++++-----------------------------=
-----
>>  hw/ppc/spapr.c         | 62 +++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  include/hw/ppc/spapr.h |  4 ++++
>>  include/hw/ppc/xics.h  |  4 ++++
>>  5 files changed, 85 insertions(+), 45 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index cc9816e7f204..2c4899f278e2 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -53,6 +53,7 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
>>  void ics_pic_print_info(ICSState *ics, Monitor *mon)
>>  {
>>      uint32_t i;
>> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
>> =20
>>      monitor_printf(mon, "ICS %4x..%4x %p\n",
>>                     ics->offset, ics->offset + ics->nr_irqs - 1, ics);
>> @@ -64,7 +65,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>>      for (i =3D 0; i < ics->nr_irqs; i++) {
>>          ICSIRQState *irq =3D ics->irqs + i;
>> =20
>> -        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
>> +        if (!xic->irq_test(ics->xics, i + ics->offset)) {
>>              continue;
>>          }
>>          monitor_printf(mon, "  %4x %s %02x %02x\n",
>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
>> index d98ea8b13068..f2e20bca5b2e 100644
>> --- a/hw/intc/xics_spapr.c
>> +++ b/hw/intc/xics_spapr.c
>> @@ -245,50 +245,23 @@ void xics_spapr_init(sPAPRMachineState *spapr)
>>      spapr_register_hypercall(H_IPOLL, h_ipoll);
>>  }
>> =20
>> -#define ICS_IRQ_FREE(ics, srcno)   \
>> -    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
>> -
>> -static int ics_find_free_block(ICSState *ics, int num, int alignnum)
>> -{
>> -    int first, i;
>> -
>> -    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
>> -        if (num > (ics->nr_irqs - first)) {
>> -            return -1;
>> -        }
>> -        for (i =3D first; i < first + num; ++i) {
>> -            if (!ICS_IRQ_FREE(ics, i)) {
>> -                break;
>> -            }
>> -        }
>> -        if (i =3D=3D (first + num)) {
>> -            return first;
>> -        }
>> -    }
>> -
>> -    return -1;
>> -}
>> -
>>  int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **er=
rp)
>>  {
>>      int irq;
>> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
>> =20
>> -    if (!ics) {
>> -        return -1;
>> -    }
>=20
> If spapr_ics_alloc() is never called with ics =3D=3D NULL, then you
> should assert. Also, this looks like this deserves a separate
> patch.

yes.
=20
>>      if (irq_hint) {
>> -        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
>> +        if (xic->irq_test(ics->xics, irq_hint)) {
>>              error_setg(errp, "can't allocate IRQ %d: already in use",=
 irq_hint);
>>              return -1;
>>          }
>>          irq =3D irq_hint;
>>      } else {
>> -        irq =3D ics_find_free_block(ics, 1, 1);
>> +        irq =3D xic->irq_alloc_block(ics->xics, 1, 0);
>>          if (irq < 0) {
>>              error_setg(errp, "can't allocate IRQ: no IRQ left");
>>              return -1;
>>          }
>> -        irq +=3D ics->offset;
>>      }
>> =20
>>      ics_set_irq_type(ics, irq - ics->offset, lsi);
>> @@ -305,10 +278,8 @@ int spapr_ics_alloc_block(ICSState *ics, int num,=
 bool lsi,
>>                            bool align, Error **errp)
>>  {
>>      int i, first =3D -1;
>> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
>> =20
>> -    if (!ics) {
>> -        return -1;
>> -    }
>> =20
>=20
> Ditto.
>=20
>>      /*
>>       * MSIMesage::data is used for storing VIRQ so
>> @@ -320,9 +291,9 @@ int spapr_ics_alloc_block(ICSState *ics, int num, =
bool lsi,
>>      if (align) {
>>          assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
>>                 (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
>> -        first =3D ics_find_free_block(ics, num, num);
>> +        first =3D xic->irq_alloc_block(ics->xics, num, num);
>>      } else {
>> -        first =3D ics_find_free_block(ics, num, 1);
>> +        first =3D xic->irq_alloc_block(ics->xics, num, 0);
>>      }
>>      if (first < 0) {
>>          error_setg(errp, "can't find a free %d-IRQ block", num);
>> @@ -331,25 +302,25 @@ int spapr_ics_alloc_block(ICSState *ics, int num=
, bool lsi,
>> =20
>>      if (first >=3D 0) {
>=20
> It looks like this check isn't needed since we return in the first < 0 =
case.
> Maybe you can fix this in a preliminary patch ?

done.

>>          for (i =3D first; i < first + num; ++i) {
>> -            ics_set_irq_type(ics, i, lsi);
>> +            ics_set_irq_type(ics, i - ics->offset, lsi);
>>          }
>>      }
>> -    first +=3D ics->offset;
>> =20
>>      trace_xics_alloc_block(first, num, lsi, align);
>> =20
>>      return first;
>>  }
>> =20
>> -static void ics_free(ICSState *ics, int srcno, int num)
>> +static void ics_free(ICSState *ics, int irq, int num)
>>  {
>>      int i;
>> +    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(ics->xics);
>> =20
>> -    for (i =3D srcno; i < srcno + num; ++i) {
>> -        if (ICS_IRQ_FREE(ics, i)) {
>> -            trace_xics_ics_free_warn(0, i + ics->offset);
>> +    for (i =3D irq; i < irq + num; ++i) {
>> +        if (xic->irq_test(ics->xics, i)) {
>> +            trace_xics_ics_free_warn(0, i);
>>          }
>> -        memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>> +        xic->irq_free_block(ics->xics, i, 1);
>>      }
>>  }
>> =20
>> @@ -357,7 +328,7 @@ void spapr_ics_free(ICSState *ics, int irq, int nu=
m)
>>  {
>>      if (ics_valid_irq(ics, irq)) {
>>          trace_xics_ics_free(0, irq, num);
>> -        ics_free(ics, irq - ics->offset, num);
>> +        ics_free(ics, irq, num);
>>      }
>>  }
>> =20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d682f013d422..88da4bad2328 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1681,6 +1681,24 @@ static const VMStateDescription vmstate_spapr_p=
atb_entry =3D {
>>      },
>>  };
>> =20
>> +static bool spapr_irq_map_needed(void *opaque)
>> +{
>> +    sPAPRMachineState *spapr =3D opaque;
>> +
>> +    return find_first_bit(spapr->irq_map, spapr->nr_irqs) < spapr->nr=
_irqs;
>> +}
>=20
> This will allow migration from older QEMU. Maybe you can add a machine =
property
> so that the subsection is only generated for newer pseries, and you'll =
support
> migration to older QEMU (see details at the end of =3D=3D=3D Subsection=
s =3D=3D=3D in
> docs/devel/migration.txt).

I have found a better way to save state. We will discuss it in the next r=
ound.

>> +
>> +static const VMStateDescription vmstate_spapr_irq_map =3D {
>> +    .name =3D "spapr_irq_map",
>> +    .version_id =3D 0,
>> +    .minimum_version_id =3D 0,
>> +    .needed =3D spapr_irq_map_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, nr_irqs),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>  static const VMStateDescription vmstate_spapr =3D {
>>      .name =3D "spapr",
>>      .version_id =3D 3,
>> @@ -1700,6 +1718,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>>          &vmstate_spapr_ov5_cas,
>>          &vmstate_spapr_patb_entry,
>>          &vmstate_spapr_pending_events,
>> +        &vmstate_spapr_irq_map,
>>          NULL
>>      }
>>  };
>> @@ -2337,8 +2356,13 @@ static void ppc_spapr_init(MachineState *machin=
e)
>>      /* Setup a load limit for the ramdisk leaving room for SLOF and F=
DT */
>>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
>> =20
>> +    /* Initialize the IRQ allocator */
>> +    spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
>> +    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
>> +    spapr->irq_base =3D XICS_IRQ_BASE;
>> +
>>      /* Set up Interrupt Controller before we create the VCPUs */
>> -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
>> +    xics_system_init(machine, spapr->nr_irqs, &error_fatal);
>> =20
>>      /* Set up containers for ibm,client-architecture-support negotiat=
ed options
>>       */
>> @@ -3536,6 +3560,38 @@ static ICPState *spapr_icp_get(XICSFabric *xi, =
int vcpu_id)
>>      return cpu ? ICP(cpu->intc) : NULL;
>>  }
>> =20
>> +static bool spapr_irq_test(XICSFabric *xi, int irq)
>> +{
>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>> +    int srcno =3D irq - spapr->irq_base;
>> +
>> +    return test_bit(srcno, spapr->irq_map);
>> +}
>> +
>> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align=
)
>> +{
>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>> +    int start =3D 0;
>> +    int srcno;
>> +
>> +    srcno =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_ir=
qs, start,
>> +                                       count, align);
>> +    if (srcno =3D=3D spapr->nr_irqs) {
>> +        return -1;
>> +    }
>> +
>> +    bitmap_set(spapr->irq_map, srcno, count);
>> +    return srcno + spapr->irq_base;
>> +}
>> +
>> +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
>> +{
>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>> +    int srcno =3D irq - spapr->irq_base;
>> +
>> +    bitmap_clear(spapr->irq_map, srcno, num);
>> +}
>> +
>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>>                                   Monitor *mon)
>>  {
>> @@ -3630,6 +3686,10 @@ static void spapr_machine_class_init(ObjectClas=
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
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9d21ca9bde3a..b962bfe09bb5 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -7,6 +7,7 @@
>>  #include "hw/ppc/spapr_drc.h"
>>  #include "hw/mem/pc-dimm.h"
>>  #include "hw/ppc/spapr_ovec.h"
>> +#include "qemu/bitmap.h"
>> =20
>>  struct VIOsPAPRBus;
>>  struct sPAPRPHBState;
>> @@ -78,6 +79,9 @@ struct sPAPRMachineState {
>>      struct VIOsPAPRBus *vio_bus;
>>      QLIST_HEAD(, sPAPRPHBState) phbs;
>>      struct sPAPRNVRAM *nvram;
>> +    int32_t nr_irqs;
>> +    unsigned long *irq_map;
>> +    uint32_t irq_base;
>>      ICSState *ics;
>>      sPAPRRTCState rtc;
>> =20
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
>=20
> API looks good to me. I suggest you introduce it in a dedicated patch, =
and
> change the allocator implementation in another patch.

yep.=20

Thanks

C.=20


>>  } XICSFabricClass;
>> =20
>>  #define XICS_IRQS_SPAPR               1024
>=20
