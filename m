Received: from eggs.gnu.org ([2001:4830:134:3::10]:57196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cqy4N-0001py-37
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cqy4J-0000pu-Se
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:26:07 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:45199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cqy4J-0000oW-BG
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:26:03 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 879EB44259
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 09:26:00 +0100 (CET)
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-6-git-send-email-clg@kaod.org>
	<20170323041612.GI19078@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1becb703-05d2-a5fd-25c1-ecd1037acd0c@kaod.org>
Date: Thu, 23 Mar 2017 09:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170323041612.GI19078@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] ppc/pnv: create the ICP and ICS
 objects under the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03/23/2017 05:16 AM, David Gibson wrote:
> On Thu, Mar 16, 2017 at 03:35:09PM +0100, C=E9dric Le Goater wrote:
>> Like this is done for the sPAPR machine, we use a simple array under
>> the PowerNV machine to store the Interrupt Control Presenters (ICP)
>> objects, one for each vCPU. This array is indexed by 'cpu_index' of
>> the CPUState but the users will provide a core PIR number. The mapping
>> is done in the icp_get() handler of the machine and is transparent to
>> XICS.
>=20
> I note that you don't actually seem to be setting the cpu's icp backlin=
k.

Indeed. The PowerNV cpu's ICP backlink is assigned in patch :=20

	[PATCH v2 7/8] ppc/pnv: link the CPUs to the machine XICSFabric

when the thread realize routine is called, like this is done for=20
the sPAPR core. I did not use an object property link because it=20
was adding complexity but I suppose it could be done that way if=20
needed.=20

Ideally, we could allocate the ICP object when the thread object=20
is created but we would need to know which type to use, maybe=20
through a new XICSFabric handler.

>=20
>> We use a list to hold the different Interrupt Control Sources (ICS)
>> objects, as PowerNV needs to handle multiple sources: for PCI-E and
>> for the Processor Service Interface (PSI).
>=20
> This is reasonable for now, but I wonder if we could use the fact we
> know the platform architecture to avoid having an explicit ics list.
> IIUC there's one ICS per chip (are there some extras as well?), so we
> could just iterate through the existing chip array, and check each
> one's ICS.

Each PHB object will bring two extra ICS objects (LSI and MSI) and=20
there can be a few PHB per chip. But, yes, instead of using a list,=20
we could also loop on the machine chips, checking PSI and the PHBs :

	pnv->chips[i]->psi.ics
	pnv->chips[i]->phb[j].lsi_ics
	pnv->chips[i]->phb[j].msis

using QLIST_FOREACH() makes the loop real simple though. Another=20
solution would be to use :

	object_child_foreach_recursive(OBJECT(chip), ...);

but that would be slower.


>> Finally, to interface with the XICS layer which manipulates the ICP
>> and ICS objects, we extend the PowerNV machine with an XICSFabric
>> interface and its associated handlers.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v1:
>>
>>  - handled pir-to-cpu_index mapping under icp_get=20
>>  - removed ics_eio handler
>>  - changed ICP name indexing
>>  - removed sysbus parenting of the ICP object
>>
>>  hw/ppc/pnv.c          | 102 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/pnv.h  |   4 ++
>>  include/hw/ppc/xics.h |   1 +
>>  3 files changed, 107 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 3fa722af82e6..6ff01c3b84d5 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -33,7 +33,10 @@
>>  #include "exec/address-spaces.h"
>>  #include "qemu/cutils.h"
>>  #include "qapi/visitor.h"
>> +#include "monitor/monitor.h"
>> +#include "hw/intc/intc.h"
>> =20
>> +#include "hw/ppc/xics.h"
>>  #include "hw/ppc/pnv_xscom.h"
>> =20
>>  #include "hw/isa/isa.h"
>> @@ -417,6 +420,26 @@ static void ppc_powernv_init(MachineState *machin=
e)
>>          machine->cpu_model =3D "POWER8";
>>      }
>> =20
>> +    /* Create the Interrupt Control Presenters before the vCPUs */
>> +    pnv->nr_servers =3D pnv->num_chips * smp_cores * smp_threads;
>> +    pnv->icps =3D g_new0(PnvICPState, pnv->nr_servers);
>> +    for (i =3D 0; i < pnv->nr_servers; i++) {
>> +        PnvICPState *icp =3D &pnv->icps[i];
>> +        char name[32];
>> +
>> +        /* TODO: fix ICP object name to be in sync with the core name=
 */
>> +        snprintf(name, sizeof(name), "icp[%d]", i);
>> +        object_initialize(icp, sizeof(*icp), TYPE_PNV_ICP);
>> +        object_property_add_child(OBJECT(pnv), name, OBJECT(icp),
>> +                                  &error_fatal);
>> +        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(pn=
v),
>> +                                       &error_fatal);
>> +        object_property_set_bool(OBJECT(icp), true, "realized", &erro=
r_fatal);
>> +    }
>> +
>> +    /* and the list of Interrupt Control Sources */
>> +    QLIST_INIT(&pnv->ics);
>> +
>>      /* Create the processor chips */
>>      chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->c=
pu_model);
>>      if (!object_class_by_name(chip_typename)) {
>> @@ -743,6 +766,58 @@ static void pnv_get_num_chips(Object *obj, Visito=
r *v, const char *name,
>>      visit_type_uint32(v, name, &POWERNV_MACHINE(obj)->num_chips, errp=
);
>>  }
>> =20
>> +static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>> +{
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
>> +    ICSState *ics;
>> +
>> +    QLIST_FOREACH(ics, &pnv->ics, list) {
>> +        if (ics_valid_irq(ics, irq)) {
>> +            return ics;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static void pnv_ics_resend(XICSFabric *xi)
>> +{
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
>> +    ICSState *ics;
>> +
>> +    QLIST_FOREACH(ics, &pnv->ics, list) {
>> +        ics_resend(ics);
>> +    }
>> +}
>> +
>> +static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
>> +{
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +        CPUPPCState *env =3D &cpu->env;
>> +
>> +        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
>> +            return cpu;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
>> +{
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
>> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
>> +
>> +    if (!cpu) {
>> +        return NULL;
>> +    }
>> +
>> +    assert(cpu->parent_obj.cpu_index < pnv->nr_servers);
>> +    return ICP(&pnv->icps[cpu->parent_obj.cpu_index]);
>> +}
>> +
>>  static void pnv_set_num_chips(Object *obj, Visitor *v, const char *na=
me,
>>                                void *opaque, Error **errp)
>>  {
>> @@ -784,9 +859,27 @@ static void powernv_machine_class_props_init(Obje=
ctClass *oc)
>>                                NULL);
>>  }
>> =20
>> +static void pnv_pic_print_info(InterruptStatsProvider *obj,
>> +                               Monitor *mon)
>> +{
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
>> +    ICSState *ics;
>> +    int i;
>> +
>> +    for (i =3D 0; i < pnv->nr_servers; i++) {
>> +        icp_pic_print_info(ICP(&pnv->icps[i]), mon);
>> +    }
>> +
>> +    QLIST_FOREACH(ics, &pnv->ics, list) {
>> +        ics_pic_print_info(ics, mon);
>> +    }
>> +}
>> +
>>  static void powernv_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>> +    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
>> =20
>>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>>      mc->init =3D ppc_powernv_init;
>> @@ -797,6 +890,10 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
>>      mc->no_parallel =3D 1;
>>      mc->default_boot_order =3D NULL;
>>      mc->default_ram_size =3D 1 * G_BYTE;
>> +    xic->icp_get =3D pnv_icp_get;
>> +    xic->ics_get =3D pnv_ics_get;
>> +    xic->ics_resend =3D pnv_ics_resend;
>> +    ispc->print_info =3D pnv_pic_print_info;
>> =20
>>      powernv_machine_class_props_init(oc);
>>  }
>> @@ -807,6 +904,11 @@ static const TypeInfo powernv_machine_info =3D {
>>      .instance_size =3D sizeof(PnvMachineState),
>>      .instance_init =3D powernv_machine_initfn,
>>      .class_init    =3D powernv_machine_class_init,
>> +    .interfaces =3D (InterfaceInfo[]) {
>> +        { TYPE_XICS_FABRIC },
>> +        { TYPE_INTERRUPT_STATS_PROVIDER },
>> +        { },
>> +    },
>>  };
>> =20
>>  static void powernv_machine_register_types(void)
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index df98a72006e4..d6ef04771aff 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -22,6 +22,7 @@
>>  #include "hw/boards.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/ppc/pnv_lpc.h"
>> +#include "hw/ppc/xics.h"
>> =20
>>  #define TYPE_PNV_CHIP "powernv-chip"
>>  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
>> @@ -114,6 +115,9 @@ typedef struct PnvMachineState {
>>      PnvChip      **chips;
>> =20
>>      ISABus       *isa_bus;
>> +    PnvICPState  *icps;
>> +    uint32_t     nr_servers;
>> +    QLIST_HEAD(, ICSState) ics;
>>  } PnvMachineState;
>> =20
>>  #define PNV_FDT_ADDR          0x01000000
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index cfcf7ecece69..4b100869003c 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -128,6 +128,7 @@ struct ICSState {
>>      qemu_irq *qirqs;
>>      ICSIRQState *irqs;
>>      XICSFabric *xics;
>> +    QLIST_ENTRY(ICSState) list;
>>  };
>> =20
>>  static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
>=20
