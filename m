Received: from eggs.gnu.org ([2001:4830:134:3::10]:37205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNKHv-0001zq-7j
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNKHr-00009n-VO
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:42:23 -0400
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNKHr-00007S-Kw
	for qemu-devel@nongnu.org; Mon, 28 May 2018 11:42:19 -0400
Received: from player716.ha.ovh.net (unknown [10.109.120.15])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 21A6915D0E4
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 17:42:15 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-5-clg@kaod.org>
	<20180528171833.40499816@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d49748a6-03e5-e829-9cb2-ac8d21e5f22d@kaod.org>
Date: Mon, 28 May 2018 17:42:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180528171833.40499816@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] spapr: introduce a new IRQ backend
 using fixed IRQ number ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 05/28/2018 05:18 PM, Greg Kurz wrote:
> On Fri, 18 May 2018 18:44:05 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> The proposed layout of the IRQ number space is organized as follow :
>>
>>    RANGES             DEVICES
>>
>>    0x0000 - 0x0FFF    Reserved for future use (IPI =3D 2)
>>    0x1000 - 0x1000    1 EPOW
>>    0x1001 - 0x1001    1 HOTPLUG
>>    0x1002 - 0x10FF    unused
>>    0x1100 - 0x11FF    256 VIO devices    (1 IRQ each)
>>    0x1200 - 0x1283    32 PCI LSI devices (4 IRQs each)
>>    0x1284 - 0x13FF    unused
>>    0x1400 - 0x17FF    PCI MSI device 1   (1024 IRQs each)
>>    0x1800 - 0x1BFF    PCI MSI device 1
>=20
> device 2 and...
>=20
>>    0x1c00 - 0x1FFF    PCI MSI device 2
>=20
> device 3 ?

ah yes :)
>=20
>>
>>    0x2000    ....     not allocated. Need to increase NR_IRQS
>>
>=20
> What's NR_IRQS ?=20

The total number of IRQs in the backend.=20

> What's the goal to have several 1k ranges ?

to support multiple PHBs with different allocatable MSI ranges,
which is not the case today.

> So that each one may be affected to a single device ?

yes.

>> The MSI range is a bit more complex to handle as the IRQS are dynamica=
lly
>> allocated by the guest OS. In consequence, we use a bitmap allocator
>> under the machine for these.
>>
>> The XICS IRQ number space is increased to 4K, which gives three MSI
>> ranges of 1K for the PHBs. The XICS source IRQ numbers still have the
>> 4K offset.
>>
>=20
> Why ?

It's the legacy IRQ offset value for the sPAPR sources (2 being=20
reserved for XICS IPIs) and because XIVE will use the range for=20
IPIs :

    0x0000 - 0x0FFF    Reserved for future use (IPI =3D 2)

So not changing the value serve our purpose.

>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h     |   2 +
>>  include/hw/ppc/spapr_irq.h |  12 +++
>>  hw/ppc/spapr.c             |  22 +++++
>>  hw/ppc/spapr_irq.c         | 220 ++++++++++++++++++++++++++++++++++++=
++++++++-
>>  4 files changed, 255 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 4eb212b16a51..fcc1b1c1451d 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -165,6 +165,8 @@ struct sPAPRMachineState {
>>      char *kvm_type;
>>      MemoryHotplugState hotplug_memory;
>> =20
>> +    int32_t nr_irqs;
>> +    unsigned long *irq_map;
>>      const char *icp_type;
>> =20
>>      bool cmd_line_caps[SPAPR_CAP_NUM];
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index caf4c33d4cec..d1af4c4d11ba 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -22,8 +22,16 @@
>>  #define SPAPR_IRQ_PCI_MSI    0x1400  /* 1K IRQs per device covered by
>>                                        * a bitmap allocator */
>> =20
>> +typedef struct sPAPRPIrqRange {
>> +    const char   *name;
>> +    uint32_t     offset;
>> +    uint32_t     width;
>> +    uint32_t     max_index;
>> +} sPAPRPIrqRange;
>> +
>>  typedef struct sPAPRIrq {
>>      uint32_t    nr_irqs;
>> +    const sPAPRPIrqRange *ranges;
>> =20
>>      void (*init)(sPAPRMachineState *spapr, Error **errp);
>>      int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
>> @@ -35,6 +43,10 @@ typedef struct sPAPRIrq {
>>  } sPAPRIrq;
>> =20
>>  extern sPAPRIrq spapr_irq_default;
>> +extern sPAPRIrq spapr_irq_2_12;
>> +
>> +const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
>> +                                          uint32_t offset);
>> =20
>>  int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_=
t index,
>>                      Error **errp);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 09f095d73eae..f2ebd6f20414 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1848,6 +1848,24 @@ static const VMStateDescription vmstate_spapr_p=
atb_entry =3D {
>>      },
>>  };
>> =20
>> +static bool spapr_irq_map_needed(void *opaque)
>> +{
>> +    sPAPRMachineState *spapr =3D opaque;
>> +
>> +    return spapr->irq_map && !bitmap_empty(spapr->irq_map, spapr->nr_=
irqs);
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_irq_map =3D {
>> +    .name =3D "spapr_irq_map",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
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
>> @@ -1875,6 +1893,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>>          &vmstate_spapr_cap_cfpc,
>>          &vmstate_spapr_cap_sbbc,
>>          &vmstate_spapr_cap_ibs,
>> +        &vmstate_spapr_irq_map,
>>          NULL
>>      }
>>  };
>> @@ -3916,7 +3935,10 @@ static void spapr_machine_2_12_instance_options=
(MachineState *machine)
>> =20
>>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>>  {
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>> +
>>      spapr_machine_2_13_class_options(mc);
>> +    smc->irq =3D &spapr_irq_2_12;
>>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
>>  }
>> =20
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index ff6cb1aafd25..bfffb1467336 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -192,7 +192,7 @@ static qemu_irq spapr_qirq_2_12(sPAPRMachineState =
*spapr, int irq)
>>      return NULL;
>>  }
>> =20
>> -sPAPRIrq spapr_irq_default =3D {
>> +sPAPRIrq spapr_irq_2_12 =3D {
>>      .nr_irqs     =3D XICS_IRQS_SPAPR,
>>      .init        =3D spapr_irq_init_2_12,
>>      .alloc       =3D spapr_irq_alloc_2_12,
>> @@ -201,6 +201,224 @@ sPAPRIrq spapr_irq_default =3D {
>>      .qirq        =3D spapr_qirq_2_12,
>>  };
>> =20
>> +/*
>> + * IRQ range helpers for new IRQ backends
>> + */
>> +const sPAPRPIrqRange *spapr_irq_get_range(sPAPRMachineState *spapr,
>> +                                          uint32_t offset)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +    const sPAPRPIrqRange *range =3D smc->irq->ranges;
>> +
>> +    if (range) {
>> +        while (range->name && range->offset !=3D offset) {
>> +            range++;
>> +        }
>> +
>> +        if (!range->name) {
>> +            return NULL;
>> +        }
>> +    }
>> +
>> +    return range;
>> +}
>> +
>> +static int spapr_irq_get_base(sPAPRMachineState *spapr, uint32_t offs=
et,
>> +                              uint32_t index, Error **errp)
>> +{
>> +    const sPAPRPIrqRange *range =3D spapr_irq_get_range(spapr, offset=
);
>> +
>> +    if (!range) {
>> +        error_setg(errp, "Invalid IRQ range %x", offset);
>> +        return -1;
>> +    }
>> +
>> +    if (index > range->max_index) {
>> +        error_setg(errp, "Index %d too big for IRQ range %s", index,
>> +                   range->name);
>> +        return -1;
>> +    }
>> +
>> +    return range->offset + index * range->width;
>> +}
>> +
>> +static int spapr_irq_range_alloc(sPAPRMachineState *spapr,
>> +                                 uint32_t range, uint32_t index, Erro=
r **errp)
>> +{
>> +    return spapr_irq_get_base(spapr, range, index, errp);
>> +}
>> +
>> +static int spapr_irq_range_alloc_msi(sPAPRMachineState *spapr, uint32=
_t range,
>> +                                     uint32_t index, int num, bool al=
ign,
>> +                                     Error **errp)
>> +{
>> +    int msi_base =3D spapr_irq_get_base(spapr, SPAPR_IRQ_PCI_MSI, ind=
ex, errp);
>> +    int irq;
>> +
>> +    /*
>> +     * The 'align_mask' parameter of bitmap_find_next_zero_area()
>> +     * should be one less than a power of 2; 0 means no
>> +     * alignment. Adapt the 'align' value of the former allocator
>> +     * to fit the requirements of bitmap_find_next_zero_area()
>> +     */
>> +    align -=3D 1;
>> +
>> +    irq =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_irqs=
,
>> +                                     msi_base, num, align);
>> +    if (irq =3D=3D spapr->nr_irqs) {
>> +        error_setg(errp, "can't find a free MSI %d-IRQ block", num);
>> +        return -1;
>> +    }
>> +
>> +    bitmap_set(spapr->irq_map, irq, num);
>> +    return irq;
>> +}
>> +
>> +static void spapr_irq_range_free_msi(sPAPRMachineState *spapr, int ir=
q, int num)
>> +{
>> +    bitmap_clear(spapr->irq_map, irq, num);
>> +}
>> +
>> +/*
>> + * New XICS IRQ backend
>> + *
>> + * using the IRQ ranges and device indexes
>> + */
>> +static void spapr_irq_init_2_13(sPAPRMachineState *spapr, Error **err=
p)
>=20
> FYI, next QEMU version will likely be 3.0:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04879.html

ah yes.

> Also, it is useful to add version information to the name in case of
> existing machine types. I guess _default or _new is a better choice
> here.

ok.
=20
>> +{
>> +    MachineState *machine =3D MACHINE(spapr);
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>> +
>> +    spapr_irq_init_2_12(spapr, errp);
>=20
> Hmm... it's a bit confusing. I'd rather have each init function to call=
 a
> common helper.

well, I followed the machine class pattern.

>=20
>> +
>> +    /*
>> +     * Initialize the MSI IRQ allocator. The full XICS IRQ number
>> +     * space is covered even though the bottow IRQ numbers below the
>> +     * XICS source number offset (4K) are unused and that only MSI IR=
Q
>> +     * numbers can be allocated. We does waste some bytes but it make=
s
>> +     * things easier. We will optimize later.
>> +     */
>> +    spapr->nr_irqs  =3D smc->irq->nr_irqs + spapr->ics->offset;
>> +    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
>> +}
>> +
>> +static int spapr_irq_alloc_2_13(sPAPRMachineState *spapr,
>> +                                uint32_t range, uint32_t index, Error=
 **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
>> +    int irq =3D spapr_irq_range_alloc(spapr, range, index, errp);
>> +
>> +    if (irq < 0) {
>> +        return irq;
>> +    }
>> +
>> +    /* Update the IRQState in the XICS source */
>> +    ics_set_irq_type(ics, irq - ics->offset, lsi);
>> +
>> +    return irq;
>> +}
>> +
>> +static int spapr_irq_alloc_block_2_13(sPAPRMachineState *spapr, uint3=
2_t range,
>> +                                      uint32_t index, int num, bool a=
lign,
>> +                                      Error **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    bool lsi =3D (range =3D=3D SPAPR_IRQ_PCI_LSI);
>> +    int irq;
>> +    int i;
>> +
>> +    if (range =3D=3D SPAPR_IRQ_PCI_MSI) {
>> +        irq =3D spapr_irq_range_alloc_msi(spapr, range, index, num, a=
lign, errp);
>> +    } else {
>> +        /* TODO: check IRQ range width vs. required block size */
>> +        irq =3D spapr_irq_range_alloc(spapr, range, index, errp);
>> +    }
>> +
>> +    if (irq < 0) {
>> +        return irq;
>> +    }
>> +
>> +    /* Update the IRQState in the XICS source */
>> +    for (i =3D irq; i < irq + num; ++i) {
>> +        ics_set_irq_type(ics, i - ics->offset, lsi);
>> +    }
>> +
>> +    return irq;
>> +}
>> +
>> +static void spapr_irq_free_2_13(sPAPRMachineState *spapr, int irq, in=
t num,
>> +                                Error **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    int msi_base =3D spapr_irq_get_base(spapr, SPAPR_IRQ_PCI_MSI, 0, =
NULL);
>> +    int i;
>> +
>> +    /* Any IRQ below MSI base should not be freed */
>> +    if (irq < msi_base) {
>> +        error_setg(errp, "IRQs %x-%x can not be freed", irq, irq + nu=
m);
>> +        return;
>> +    }
>> +
>> +    spapr_irq_range_free_msi(spapr, irq, num);
>> +
>> +    /* Clear out the IRQState from the XICS source */
>> +    for (i =3D irq; i < irq + num; ++i) {
>> +        if (ics_valid_irq(ics, i)) {
>> +            uint32_t srcno =3D i - ics->offset;
>> +            memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
>> +        }
>> +    }
>> +}
>> +
>> +static qemu_irq spapr_qirq_2_13(sPAPRMachineState *spapr, int irq)
>> +{
>> +    return spapr_qirq_2_12(spapr, irq);
>> +}
>> +
>> +/*
>> + *   RANGES             DEVICES
>> + *
>> + *   0x0000 - 0x0FFF    Reserved (IPI =3D 2)
>> + *
>> + *   0x1000 - 0x1000    1 EPOW
>> + *   0x1001 - 0x1001    1 HOTPLUG
>> + *   0x1002 - 0x10FF    unused
>> + *   0x1100 - 0x11FF    256 VIO devices    (1 IRQ each)
>> + *   0x1200 - 0x1283    32 PCI LSI devices (4 IRQs each)
>> + *   0x1284 - 0x13FF    unused
>> + *   0x1400 - 0x17FF    PCI MSI device 1   (1024 IRQs each)
>> + *   0x1800 - 0x1BFF    PCI MSI device 1
>> + *   0x1c00 - 0x1FFF    PCI MSI device 2
>> + *   0x2000    ....     not allocated. Need to increase NR_IRQS
>> + */
>> +static const sPAPRPIrqRange spapr_irq_ranges_2_13[] =3D {
>> +    /* "IPI" Not used */
>> +    { "EPOW",       SPAPR_IRQ_EPOW,       1,               0      },
>> +    { "HOTPLUG",    SPAPR_IRQ_HOTPLUG,    1,               0      },
>> +    { "VIO",        SPAPR_IRQ_VIO,        1,               0xFF   },
>> +    { "PCI LSI",    SPAPR_IRQ_PCI_LSI,    PCI_NUM_PINS,    0x1F   },
>> +    { "PCI MSI",    SPAPR_IRQ_PCI_MSI,    0x400,           0x1F   },
>> +    { NULL,         0,                    0,               0      },
>> +};
>> +
>> +/*
>> + * Increase the XICS IRQ number space to 4K. It gives us 3 possible
>> + * MSI ranges for the PHBs. The XICS Source IRQ numbers still have th=
e
>> + * 4K offset.
>> + */
>> +#define SPAPR_NR_IRQS_2_13    0x1000
>> +
>> +sPAPRIrq spapr_irq_default =3D {
>> +    .nr_irqs     =3D SPAPR_NR_IRQS_2_13,
>=20
> Since there's only one user for this define, why not open-coding the va=
lue
> here ?

yes. I agree.

Thanks,

C.

>> +    .init        =3D spapr_irq_init_2_13,
>> +    .ranges      =3D spapr_irq_ranges_2_13,
>> +    .alloc       =3D spapr_irq_alloc_2_13,
>> +    .alloc_block =3D spapr_irq_alloc_block_2_13,
>> +    .free        =3D spapr_irq_free_2_13,
>> +    .qirq        =3D spapr_qirq_2_13,
>> +};
>> +
>>  int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_=
t index,
>>                      Error **errp)
>>  {
>=20
