Received: from eggs.gnu.org ([2001:4830:134:3::10]:55324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eEtM1-0007GB-9W
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eEtLy-00065X-3t
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:47:29 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:33059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eEtLx-00063y-R9
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:47:26 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1A61F868F9
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 09:47:24 +0100 (CET)
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-6-clg@kaod.org>
	<20171114104224.63ed5e87@bahia.lan>
	<9e36e339-3ea5-237c-e06a-d0ae4c1595e6@kaod.org>
	<20171114162810.77d378ab@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a8b989d6-4a0e-8328-fcae-ce3a5c88e8fa@kaod.org>
Date: Wed, 15 Nov 2017 09:47:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171114162810.77d378ab@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 05/11] spapr: introduce an IRQ
 allocator using a bitmap
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

On 11/14/2017 04:28 PM, Greg Kurz wrote:
> On Tue, 14 Nov 2017 11:54:53 +0000
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 11/14/2017 09:42 AM, Greg Kurz wrote:
>>> On Fri, 10 Nov 2017 15:20:11 +0000
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>  =20
>>>> Let's define a new set of XICSFabric IRQ operations for the latest
>>>> pseries machine. These simply use a a bitmap 'irq_map' as a IRQ numb=
er
>>>> allocator.
>>>>
>>>> The previous pseries machines keep the old set of IRQ operations usi=
ng
>>>> the ICSIRQState array.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>
>>>>  Changes since v2 :
>>>>
>>>>  - introduced a second set of XICSFabric IRQ operations for older
>>>>    pseries machines
>>>>
>>>>  hw/ppc/spapr.c         | 76 +++++++++++++++++++++++++++++++++++++++=
+++++++----
>>>>  include/hw/ppc/spapr.h |  3 ++
>>>>  2 files changed, 74 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 4bdceb45a14f..4ef0b73559ca 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -1681,6 +1681,22 @@ static const VMStateDescription vmstate_spapr=
_patb_entry =3D {
>>>>      },
>>>>  };
>>>> =20
>>>> +static bool spapr_irq_map_needed(void *opaque)
>>>> +{
>>>> +    return true; =20
>>>
>>> I see that the next patch adds some code to avoid sending the
>>> bitmap if it doesn't contain state, but I guess you should also
>>> explicitly have this function to return false for older machine
>>> types (see remark below).
>>>  =20
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_spapr_irq_map =3D {
>>>> +    .name =3D "spapr_irq_map",
>>>> +    .version_id =3D 0,
>>>> +    .minimum_version_id =3D 0,
>>>> +    .needed =3D spapr_irq_map_needed,
>>>> +    .fields =3D (VMStateField[]) {
>>>> +        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, nr_irqs),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    },
>>>> +};
>>>> +
>>>>  static const VMStateDescription vmstate_spapr =3D {
>>>>      .name =3D "spapr",
>>>>      .version_id =3D 3,
>>>> @@ -1700,6 +1716,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
>>>>          &vmstate_spapr_ov5_cas,
>>>>          &vmstate_spapr_patb_entry,
>>>>          &vmstate_spapr_pending_events,
>>>> +        &vmstate_spapr_irq_map,
>>>>          NULL
>>>>      }
>>>>  };
>>>> @@ -2337,8 +2354,12 @@ static void ppc_spapr_init(MachineState *mach=
ine)
>>>>      /* Setup a load limit for the ramdisk leaving room for SLOF and=
 FDT */
>>>>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEA=
D;
>>>> =20
>>>> +    /* Initialize the IRQ allocator */
>>>> +    spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
>=20
> BTW, is this constant for the machine lifetime ? If so, maybe it should=
 go
> to sPAPRMachineClass.

For Xive, we will be increasing the value of 'nr_irqs' with the number=20
of max_cpus to handle the IPIs.

C.


>=20
>>>> +    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
>>>> + =20
>>>
>>> I think you should introduce a sPAPRMachineClass::has_irq_bitmap bool=
ean
>>> so that the bitmap is only allocated for newer machine types. And you=
 should
>>> then use this flag in spapr_irq_map_needed() above. =20
>>
>> yes. I can add a boot to be more explicit on the use of the bitmap.
>>
>> Thanks,
>>
>> C.=20
>>
>>
>>>
>>> Apart from that, the rest of the patch looks good.
>>>  =20
>>>>      /* Set up Interrupt Controller before we create the VCPUs */
>>>> -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
>>>> +    xics_system_init(machine, spapr->nr_irqs, &error_fatal);
>>>> =20
>>>>      /* Set up containers for ibm,client-architecture-support negoti=
ated options
>>>>       */
>>>> @@ -3560,7 +3581,7 @@ static int ics_find_free_block(ICSState *ics, =
int num, int alignnum)
>>>>      return -1;
>>>>  }
>>>> =20
>>>> -static bool spapr_irq_test(XICSFabric *xi, int irq)
>>>> +static bool spapr_irq_test_2_11(XICSFabric *xi, int irq)
>>>>  {
>>>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>>>>      ICSState *ics =3D spapr->ics;
>>>> @@ -3569,7 +3590,7 @@ static bool spapr_irq_test(XICSFabric *xi, int=
 irq)
>>>>      return !ICS_IRQ_FREE(ics, srcno);
>>>>  }
>>>> =20
>>>> -static int spapr_irq_alloc_block(XICSFabric *xi, int count, int ali=
gn)
>>>> +static int spapr_irq_alloc_block_2_11(XICSFabric *xi, int count, in=
t align)
>>>>  {
>>>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>>>>      ICSState *ics =3D spapr->ics;
>>>> @@ -3583,7 +3604,7 @@ static int spapr_irq_alloc_block(XICSFabric *x=
i, int count, int align)
>>>>      return srcno + ics->offset;
>>>>  }
>>>> =20
>>>> -static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
>>>> +static void spapr_irq_free_block_2_11(XICSFabric *xi, int irq, int =
num)
>>>>  {
>>>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>>>>      ICSState *ics =3D spapr->ics;
>>>> @@ -3601,6 +3622,46 @@ static void spapr_irq_free_block(XICSFabric *=
xi, int irq, int num)
>>>>      }
>>>>  }
>>>> =20
>>>> +static bool spapr_irq_test(XICSFabric *xi, int irq)
>>>> +{
>>>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>>>> +    int srcno =3D irq - spapr->ics->offset;
>>>> +
>>>> +    return test_bit(srcno, spapr->irq_map);
>>>> +}
>>>> +
>>>> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int ali=
gn)
>>>> +{
>>>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>>>> +    int start =3D 0;
>>>> +    int srcno;
>>>> +
>>>> +    /*
>>>> +     * The 'align_mask' parameter of bitmap_find_next_zero_area()
>>>> +     * should be one less than a power of 2; 0 means no
>>>> +     * alignment. Adapt the 'align' value of the former allocator t=
o
>>>> +     * fit the requirements of bitmap_find_next_zero_area()
>>>> +     */
>>>> +    align -=3D 1;
>>>> +
>>>> +    srcno =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_=
irqs, start,
>>>> +                                       count, align);
>>>> +    if (srcno =3D=3D spapr->nr_irqs) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    bitmap_set(spapr->irq_map, srcno, count);
>>>> +    return srcno + spapr->ics->offset;
>>>> +}
>>>> +
>>>> +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
>>>> +{
>>>> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>>>> +    int srcno =3D irq - spapr->ics->offset;
>>>> +
>>>> +    bitmap_clear(spapr->irq_map, srcno, num);
>>>> +}
>>>> +
>>>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>>>>                                   Monitor *mon)
>>>>  {
>>>> @@ -3778,7 +3839,12 @@ static void spapr_machine_2_11_instance_optio=
ns(MachineState *machine)
>>>> =20
>>>>  static void spapr_machine_2_11_class_options(MachineClass *mc)
>>>>  {
>>>> -    /* Defaults for the latest behaviour inherited from the base cl=
ass */
>>>> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(mc);
>>>> +
>>>> +    spapr_machine_2_12_class_options(mc);
>>>> +    xic->irq_test =3D spapr_irq_test_2_11;
>>>> +    xic->irq_alloc_block =3D spapr_irq_alloc_block_2_11;
>>>> +    xic->irq_free_block =3D spapr_irq_free_block_2_11;
>>>>  }
>>>> =20
>>>>  DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 9d21ca9bde3a..5835c694caff 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -7,6 +7,7 @@
>>>>  #include "hw/ppc/spapr_drc.h"
>>>>  #include "hw/mem/pc-dimm.h"
>>>>  #include "hw/ppc/spapr_ovec.h"
>>>> +#include "qemu/bitmap.h"
>>>> =20
>>>>  struct VIOsPAPRBus;
>>>>  struct sPAPRPHBState;
>>>> @@ -78,6 +79,8 @@ struct sPAPRMachineState {
>>>>      struct VIOsPAPRBus *vio_bus;
>>>>      QLIST_HEAD(, sPAPRPHBState) phbs;
>>>>      struct sPAPRNVRAM *nvram;
>>>> +    int32_t nr_irqs;
>>>> +    unsigned long *irq_map;
>>>>      ICSState *ics;
>>>>      sPAPRRTCState rtc;
>>>>   =20
>>>  =20
>>
>=20
