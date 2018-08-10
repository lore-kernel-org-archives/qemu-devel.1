Received: from eggs.gnu.org ([2001:4830:134:3::10]:37244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fo29d-0007hs-MK
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fo29Y-0005j6-MQ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:48:13 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:51522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fo29Y-0005D5-B4
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:48:08 -0400
Received: from player756.ha.ovh.net (unknown [10.109.160.143])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0ABDAE2753
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 09:47:57 +0200 (CEST)
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-4-clg@kaod.org> <20180810004646.GA4079@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c3ea427-a373-36e9-dfb3-179584a9b060@kaod.org>
Date: Fri, 10 Aug 2018 09:47:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180810004646.GA4079@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/4] spapr: introduce a IRQ controller
 backend to the machine
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

On 08/10/2018 02:46 AM, David Gibson wrote:
> On Mon, Jul 30, 2018 at 04:11:33PM +0200, C=E9dric Le Goater wrote:
>> This proposal moves all the related IRQ routines of the sPAPR machine
>> behind a sPAPR IRQ backend interface 'spapr_irq' to prepare for future
>> changes. First of which will be to increase the size of the IRQ number
>> space, then, will follow a new backend for the POWER9 XIVE IRQ control=
ler.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Applied to ppc-for-3.1.

I see that you have applied patch 2/4 and not 3/4. I suppose you=20
are still reviewing 3/4.


Btw, it would be good if we could change the way the interrupt=20
device objects (ICSState and soon sPAPRXive) are allocated and=20
use object_initialize() instead of object_new(). That can come=20
later for XICS but for XIVE, it would be better to get the initial=20
patch right. This means that the holding C struct is common to=20
the QEMU and KVM devices. =20

Thanks,

C.=20
=20
>> ---
>>  include/hw/ppc/spapr.h     |  11 +-
>>  include/hw/ppc/spapr_irq.h |  22 ++++
>>  hw/ppc/spapr.c             | 180 +----------------------------
>>  hw/ppc/spapr_cpu_core.c    |   1 +
>>  hw/ppc/spapr_irq.c         | 230 ++++++++++++++++++++++++++++++++++++=
+
>>  5 files changed, 259 insertions(+), 185 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 73067f5ee8aa..ad4d7cfd97b0 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -4,7 +4,6 @@
>>  #include "qemu/units.h"
>>  #include "sysemu/dma.h"
>>  #include "hw/boards.h"
>> -#include "hw/ppc/xics.h"
>>  #include "hw/ppc/spapr_drc.h"
>>  #include "hw/mem/pc-dimm.h"
>>  #include "hw/ppc/spapr_ovec.h"
>> @@ -16,6 +15,7 @@ struct sPAPRNVRAM;
>>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>>  typedef struct sPAPREventSource sPAPREventSource;
>>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
>> +typedef struct ICSState ICSState;
>> =20
>>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>>  #define SPAPR_ENTRY_POINT       0x100
>> @@ -110,6 +110,7 @@ struct sPAPRMachineClass {
>>                            unsigned n_dma, uint32_t *liobns, Error **e=
rrp);
>>      sPAPRResizeHPT resize_hpt_default;
>>      sPAPRCapabilities default_caps;
>> +    sPAPRIrq *irq;
>>  };
>> =20
>>  /**
>> @@ -780,14 +781,6 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
>>  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
>> =20
>> -int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align,
>> -                   Error **errp);
>> -#define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false=
, errp)
>> -int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
>> -void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>> -qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>> -
>> -
>>  int spapr_caps_pre_load(void *opaque);
>>  int spapr_caps_pre_save(void *opaque);
>> =20
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 6f7f50548809..0e98c4474bb2 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -29,4 +29,26 @@ int spapr_irq_msi_alloc(sPAPRMachineState *spapr, u=
int32_t num, bool align,
>>  void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t n=
um);
>>  void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>> =20
>> +typedef struct sPAPRIrq {
>> +    uint32_t    nr_irqs;
>> +
>> +    void (*init)(sPAPRMachineState *spapr, Error **errp);
>> +    int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>> +    void (*free)(sPAPRMachineState *spapr, int irq, int num);
>> +    qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
>> +    void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
>> +} sPAPRIrq;
>> +
>> +extern sPAPRIrq spapr_irq_xics;
>> +
>> +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp);
>> +void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>> +qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>> +
>> +/*
>> + * XICS legacy routines
>> + */
>> +int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Err=
or **errp);
>> +#define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false=
, errp)
>> +
>>  #endif
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 792e24453d8b..d9f8cca49208 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -54,7 +54,6 @@
>>  #include "hw/ppc/spapr.h"
>>  #include "hw/ppc/spapr_vio.h"
>>  #include "hw/pci-host/spapr.h"
>> -#include "hw/ppc/xics.h"
>>  #include "hw/pci/msi.h"
>> =20
>>  #include "hw/pci/pci.h"
>> @@ -117,33 +116,6 @@ static bool spapr_is_thread0_in_vcore(sPAPRMachin=
eState *spapr,
>>      return spapr_get_vcpu_id(cpu) % spapr->vsmt =3D=3D 0;
>>  }
>> =20
>> -static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
>> -                                  const char *type_ics,
>> -                                  int nr_irqs, Error **errp)
>> -{
>> -    Error *local_err =3D NULL;
>> -    Object *obj;
>> -
>> -    obj =3D object_new(type_ics);
>> -    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort=
);
>> -    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>> -                                   &error_abort);
>> -    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
>> -    if (local_err) {
>> -        goto error;
>> -    }
>> -    object_property_set_bool(obj, true, "realized", &local_err);
>> -    if (local_err) {
>> -        goto error;
>> -    }
>> -
>> -    return ICS_BASE(obj);
>> -
>> -error:
>> -    error_propagate(errp, local_err);
>> -    return NULL;
>> -}
>> -
>>  static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>>  {
>>      /* Dummy entries correspond to unused ICPState objects in older Q=
EMUs,
>> @@ -184,43 +156,6 @@ static int xics_max_server_number(sPAPRMachineSta=
te *spapr)
>>      return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
>>  }
>> =20
>> -static void xics_system_init(MachineState *machine, int nr_irqs, Erro=
r **errp)
>> -{
>> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
>> -    Error *local_err =3D NULL;
>> -
>> -    /* Initialize the MSI IRQ allocator. */
>> -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
>> -    }
>> -
>> -    if (kvm_enabled()) {
>> -        if (machine_kernel_irqchip_allowed(machine) &&
>> -            !xics_kvm_init(spapr, &local_err)) {
>> -            spapr->icp_type =3D TYPE_KVM_ICP;
>> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_i=
rqs,
>> -                                          &local_err);
>> -        }
>> -        if (machine_kernel_irqchip_required(machine) && !spapr->ics) =
{
>> -            error_prepend(&local_err,
>> -                          "kernel_irqchip requested but unavailable: =
");
>> -            goto error;
>> -        }
>> -        error_free(local_err);
>> -        local_err =3D NULL;
>> -    }
>> -
>> -    if (!spapr->ics) {
>> -        xics_spapr_init(spapr);
>> -        spapr->icp_type =3D TYPE_ICP;
>> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_ir=
qs,
>> -                                      &local_err);
>> -    }
>> -
>> -error:
>> -    error_propagate(errp, local_err);
>> -}
>> -
>>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *=
cpu,
>>                                    int smt_threads)
>>  {
>> @@ -2618,7 +2553,7 @@ static void spapr_machine_init(MachineState *mac=
hine)
>>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
>> =20
>>      /* Set up Interrupt Controller before we create the VCPUs */
>> -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
>> +    smc->irq->init(spapr, &error_fatal);
>> =20
>>      /* Set up containers for ibm,client-architecture-support negotiat=
ed options
>>       */
>> @@ -3810,121 +3745,13 @@ static ICPState *spapr_icp_get(XICSFabric *xi=
, int vcpu_id)
>>      return cpu ? ICP(cpu->intc) : NULL;
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
>> -int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Err=
or **errp)
>> -{
>> -    ICSState *ics =3D spapr->ics;
>> -    int first =3D -1;
>> -
>> -    assert(ics);
>> -
>> -    /*
>> -     * MSIMesage::data is used for storing VIRQ so
>> -     * it has to be aligned to num to support multiple
>> -     * MSI vectors. MSI-X is not affected by this.
>> -     * The hint is used for the first IRQ, the rest should
>> -     * be allocated continuously.
>> -     */
>> -    if (align) {
>> -        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
>> -               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
>> -        first =3D ics_find_free_block(ics, num, num);
>> -    } else {
>> -        first =3D ics_find_free_block(ics, num, 1);
>> -    }
>> -
>> -    if (first < 0) {
>> -        error_setg(errp, "can't find a free %d-IRQ block", num);
>> -        return -1;
>> -    }
>> -
>> -    return first + ics->offset;
>> -}
>> -
>> -int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
>> -{
>> -    ICSState *ics =3D spapr->ics;
>> -
>> -    assert(ics);
>> -
>> -    if (!ics_valid_irq(ics, irq)) {
>> -        error_setg(errp, "IRQ %d is invalid", irq);
>> -        return -1;
>> -    }
>> -
>> -    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
>> -        error_setg(errp, "IRQ %d is not free", irq);
>> -        return -1;
>> -    }
>> -
>> -    ics_set_irq_type(ics, irq - ics->offset, lsi);
>> -    return 0;
>> -}
>> -
>> -void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
>> -{
>> -    ICSState *ics =3D spapr->ics;
>> -    int srcno =3D irq - ics->offset;
>> -    int i;
>> -
>> -    if (ics_valid_irq(ics, irq)) {
>> -        trace_spapr_irq_free(0, irq, num);
>> -        for (i =3D srcno; i < srcno + num; ++i) {
>> -            if (ICS_IRQ_FREE(ics, i)) {
>> -                trace_spapr_irq_free_warn(0, i + ics->offset);
>> -            }
>> -            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>> -        }
>> -    }
>> -}
>> -
>> -qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
>> -{
>> -    ICSState *ics =3D spapr->ics;
>> -
>> -    if (ics_valid_irq(ics, irq)) {
>> -        return ics->qirqs[irq - ics->offset];
>> -    }
>> -
>> -    return NULL;
>> -}
>> -
>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>>                                   Monitor *mon)
>>  {
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
>> -    CPUState *cs;
>> -
>> -    CPU_FOREACH(cs) {
>> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> -
>> -        icp_pic_print_info(ICP(cpu->intc), mon);
>> -    }
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> =20
>> -    ics_pic_print_info(spapr->ics, mon);
>> +    smc->irq->print_info(spapr, mon);
>>  }
>> =20
>>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>> @@ -4036,6 +3863,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64ki=
B */
>>      spapr_caps_add_properties(smc, &error_abort);
>> +    smc->irq =3D &spapr_irq_xics;
>>  }
>> =20
>>  static const TypeInfo spapr_machine_info =3D {
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 993759db47fa..fb091995a11f 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -11,6 +11,7 @@
>>  #include "hw/ppc/spapr_cpu_core.h"
>>  #include "target/ppc/cpu.h"
>>  #include "hw/ppc/spapr.h"
>> +#include "hw/ppc/xics.h" /* for icp_create() - to be removed */
>>  #include "hw/boards.h"
>>  #include "qapi/error.h"
>>  #include "sysemu/cpus.h"
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 24e9c1d4433c..0cbb5dd39368 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -13,6 +13,9 @@
>>  #include "qapi/error.h"
>>  #include "hw/ppc/spapr.h"
>>  #include "hw/ppc/xics.h"
>> +#include "sysemu/kvm.h"
>> +
>> +#include "trace.h"
>> =20
>>  void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis)
>>  {
>> @@ -54,3 +57,230 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
>>  {
>>      bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
>>  }
>> +
>> +
>> +/*
>> + * XICS IRQ backend.
>> + */
>> +
>> +static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
>> +                                  const char *type_ics,
>> +                                  int nr_irqs, Error **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    Object *obj;
>> +
>> +    obj =3D object_new(type_ics);
>> +    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort=
);
>> +    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>> +                                   &error_abort);
>> +    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +    object_property_set_bool(obj, true, "realized", &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +
>> +    return ICS_BASE(obj);
>> +
>> +error:
>> +    error_propagate(errp, local_err);
>> +    return NULL;
>> +}
>> +
>> +static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **err=
p)
>> +{
>> +    MachineState *machine =3D MACHINE(spapr);
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +    int nr_irqs =3D smc->irq->nr_irqs;
>> +    Error *local_err =3D NULL;
>> +
>> +    /* Initialize the MSI IRQ allocator. */
>> +    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> +        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
>> +    }
>> +
>> +    if (kvm_enabled()) {
>> +        if (machine_kernel_irqchip_allowed(machine) &&
>> +            !xics_kvm_init(spapr, &local_err)) {
>> +            spapr->icp_type =3D TYPE_KVM_ICP;
>> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_i=
rqs,
>> +                                          &local_err);
>> +        }
>> +        if (machine_kernel_irqchip_required(machine) && !spapr->ics) =
{
>> +            error_prepend(&local_err,
>> +                          "kernel_irqchip requested but unavailable: =
");
>> +            goto error;
>> +        }
>> +        error_free(local_err);
>> +        local_err =3D NULL;
>> +    }
>> +
>> +    if (!spapr->ics) {
>> +        xics_spapr_init(spapr);
>> +        spapr->icp_type =3D TYPE_ICP;
>> +        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_ir=
qs,
>> +                                      &local_err);
>> +    }
>> +
>> +error:
>> +    error_propagate(errp, local_err);
>> +}
>> +
>> +#define ICS_IRQ_FREE(ics, srcno)   \
>> +    (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
>> +
>> +static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bo=
ol lsi,
>> +                                Error **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +
>> +    assert(ics);
>> +
>> +    if (!ics_valid_irq(ics, irq)) {
>> +        error_setg(errp, "IRQ %d is invalid", irq);
>> +        return -1;
>> +    }
>> +
>> +    if (!ICS_IRQ_FREE(ics, irq - ics->offset)) {
>> +        error_setg(errp, "IRQ %d is not free", irq);
>> +        return -1;
>> +    }
>> +
>> +    ics_set_irq_type(ics, irq - ics->offset, lsi);
>> +    return 0;
>> +}
>> +
>> +static void spapr_irq_free_xics(sPAPRMachineState *spapr, int irq, in=
t num)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    uint32_t srcno =3D irq - ics->offset;
>> +    int i;
>> +
>> +    if (ics_valid_irq(ics, irq)) {
>> +        trace_spapr_irq_free(0, irq, num);
>> +        for (i =3D srcno; i < srcno + num; ++i) {
>> +            if (ICS_IRQ_FREE(ics, i)) {
>> +                trace_spapr_irq_free_warn(0, i);
>> +            }
>> +            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>> +        }
>> +    }
>> +}
>> +
>> +static qemu_irq spapr_qirq_xics(sPAPRMachineState *spapr, int irq)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    uint32_t srcno =3D irq - ics->offset;
>> +
>> +    if (ics_valid_irq(ics, irq)) {
>> +        return ics->qirqs[srcno];
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static void spapr_irq_print_info_xics(sPAPRMachineState *spapr, Monit=
or *mon)
>> +{
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +
>> +        icp_pic_print_info(ICP(cpu->intc), mon);
>> +    }
>> +
>> +    ics_pic_print_info(spapr->ics, mon);
>> +}
>> +
>> +sPAPRIrq spapr_irq_xics =3D {
>> +    .nr_irqs     =3D XICS_IRQS_SPAPR,
>> +
>> +    .init        =3D spapr_irq_init_xics,
>> +    .claim       =3D spapr_irq_claim_xics,
>> +    .free        =3D spapr_irq_free_xics,
>> +    .qirq        =3D spapr_qirq_xics,
>> +    .print_info  =3D spapr_irq_print_info_xics,
>> +};
>> +
>> +/*
>> + * sPAPR IRQ frontend routines for devices
>> + */
>> +
>> +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +
>> +    return smc->irq->claim(spapr, irq, lsi, errp);
>> +}
>> +
>> +void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +
>> +    smc->irq->free(spapr, irq, num);
>> +}
>> +
>> +qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +
>> +    return smc->irq->qirq(spapr, irq);
>> +}
>> +
>> +/*
>> + * XICS legacy routines - to deprecate one day
>> + */
>> +
>> +static int ics_find_free_block(ICSState *ics, int num, int alignnum)
>> +{
>> +    int first, i;
>> +
>> +    for (first =3D 0; first < ics->nr_irqs; first +=3D alignnum) {
>> +        if (num > (ics->nr_irqs - first)) {
>> +            return -1;
>> +        }
>> +        for (i =3D first; i < first + num; ++i) {
>> +            if (!ICS_IRQ_FREE(ics, i)) {
>> +                break;
>> +            }
>> +        }
>> +        if (i =3D=3D (first + num)) {
>> +            return first;
>> +        }
>> +    }
>> +
>> +    return -1;
>> +}
>> +
>> +int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Err=
or **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    int first =3D -1;
>> +
>> +    assert(ics);
>> +
>> +    /*
>> +     * MSIMesage::data is used for storing VIRQ so
>> +     * it has to be aligned to num to support multiple
>> +     * MSI vectors. MSI-X is not affected by this.
>> +     * The hint is used for the first IRQ, the rest should
>> +     * be allocated continuously.
>> +     */
>> +    if (align) {
>> +        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
>> +               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
>> +        first =3D ics_find_free_block(ics, num, num);
>> +    } else {
>> +        first =3D ics_find_free_block(ics, num, 1);
>> +    }
>> +
>> +    if (first < 0) {
>> +        error_setg(errp, "can't find a free %d-IRQ block", num);
>> +        return -1;
>> +    }
>> +
>> +    return first + ics->offset;
>> +}
>=20
