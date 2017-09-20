Received: from eggs.gnu.org ([2001:4830:134:3::10]:38925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duf5m-0006Pj-Du
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duf5i-0006u2-4O
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:06 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:60490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duf5h-0006tP-Qy
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:31:02 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B8CB4AC355
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:52:01 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-17-clg@kaod.org> <20170919083818.GW27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <85b1f88f-77ff-8d3e-c710-b7273564637c@kaod.org>
Date: Wed, 20 Sep 2017 11:51:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170919083818.GW27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 16/21] spapr: add a XIVE object to
 the sPAPR machine
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

On 09/19/2017 10:38 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:30PM +0200, C=E9dric Le Goater wrote:
>> If the machine supports XIVE (POWER9 CPU), create a XIVE object. The
>> CAS negotiation process will decide which model (legacy or XIVE) will
>> be used for the interrupt controller depending on the guest
>> capabilities.
>>
>> Also extend the number of provisionned IRQs with the number of CPUs,
>> this is required for XIVE which allocates one IRQ number for each IPI.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr.c         | 63 +++++++++++++++++++++++++++++++++++++++++=
+++++++--
>>  include/hw/ppc/spapr.h |  2 ++
>>  2 files changed, 63 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 5d69df928434..b6577dbecdea 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -44,6 +44,7 @@
>>  #include "mmu-hash64.h"
>>  #include "mmu-book3s-v3.h"
>>  #include "qom/cpu.h"
>> +#include "target/ppc/cpu-models.h"
>> =20
>>  #include "hw/boards.h"
>>  #include "hw/ppc/ppc.h"
>> @@ -54,6 +55,7 @@
>>  #include "hw/ppc/spapr_vio.h"
>>  #include "hw/pci-host/spapr.h"
>>  #include "hw/ppc/xics.h"
>> +#include "hw/ppc/spapr_xive.h"
>>  #include "hw/pci/msi.h"
>> =20
>>  #include "hw/pci/pci.h"
>> @@ -202,6 +204,35 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
>>      }
>>  }
>> =20
>> +static sPAPRXive *spapr_spapr_xive_create(sPAPRMachineState *spapr, i=
nt nr_irqs,
>> +                               int nr_servers, Error **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    Object *obj;
>> +
>> +    obj =3D object_new(TYPE_SPAPR_XIVE);
>> +    object_property_add_child(OBJECT(spapr), "xive", obj, &error_abor=
t);
>> +    object_property_add_const_link(obj, "ics", OBJECT(spapr->ics),
>> +                                   &error_abort);
>> +    object_property_set_int(obj, nr_irqs, "nr-irqs",  &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +    object_property_set_int(obj, nr_servers, "nr-targets", &local_err=
);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +    object_property_set_bool(obj, true, "realized", &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +
>> +    return SPAPR_XIVE(obj);
>> +error:
>> +    error_propagate(errp, local_err);
>> +    return NULL;
>> +}
>> +
>>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *=
cpu,
>>                                    int smt_threads)
>>  {
>> @@ -1093,7 +1124,8 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
>>      }
>> =20
>>      QLIST_FOREACH(phb, &spapr->phbs, list) {
>> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, XICS_IR=
QS_SPAPR);
>> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
>> +                                    XICS_IRQS_SPAPR + xics_max_server=
_number());
>>          if (ret < 0) {
>>              error_report("couldn't setup PCI devices in fdt");
>>              exit(1);
>> @@ -2140,6 +2172,16 @@ static void spapr_init_cpus(sPAPRMachineState *=
spapr)
>>      g_free(type);
>>  }
>> =20
>> +/*
>> + * Only POWER9 Processor chips support the XIVE interrupt controller
>> + */
>> +static bool ppc_support_xive(MachineState *machine)
>> +{
>> +   PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(first_cpu);
>> +
>> +   return pcc->pvr_match(pcc, CPU_POWERPC_POWER9_BASE);
>> +}
>> +
>>  /* pSeries LPAR / sPAPR hardware init */
>>  static void ppc_spapr_init(MachineState *machine)
>>  {
>> @@ -2237,7 +2279,8 @@ static void ppc_spapr_init(MachineState *machine=
)
>>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
>> =20
>>      /* Set up Interrupt Controller before we create the VCPUs */
>> -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
>> +    xics_system_init(machine, XICS_IRQS_SPAPR + xics_max_server_numbe=
r(),
>> +                     &error_fatal);
>=20
> Has this hunk leaked from another patch?  AFAICT it only affects XICS
> with what you have so far, which doesn't seem like what you want.

no. We are sharing the ICSIRQState array of XICS. This is why.

C.=20

>>      /* Set up containers for ibm,client-set-architecture negotiated o=
ptions */
>>      spapr->ov5 =3D spapr_ovec_new();
>> @@ -2274,6 +2317,22 @@ static void ppc_spapr_init(MachineState *machin=
e)
>> =20
>>      spapr_init_cpus(spapr);
>> =20
>> +    /* Set up XIVE. CAS will choose whether the guest runs in XICS
>> +     * (legacy mode) or XIVE Exploitation mode
>> +     *
>> +     * We don't have KVM support yet, so check for irqchip=3Don
>> +     */
>> +    if (ppc_support_xive(machine)) {
>> +        if (kvm_enabled() && machine_kernel_irqchip_required(machine)=
) {
>> +            error_report("kernel_irqchip requested. no XIVE support")=
;
>> +        } else {
>> +            spapr->xive =3D spapr_spapr_xive_create(spapr,
>> +                               XICS_IRQS_SPAPR + xics_max_server_numb=
er(),
>> +                               xics_max_server_number(),
>> +                               &error_fatal);
>> +        }
>> +    }
>> +
>>      if (kvm_enabled()) {
>>          /* Enable H_LOGICAL_CI_* so SLOF can talk to in-kernel device=
s */
>>          kvmppc_enable_logical_ci_hcalls();
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 2a303a705c17..6cd5ab73c5dc 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
>>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>>  typedef struct sPAPREventSource sPAPREventSource;
>>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
>> +typedef struct sPAPRXive sPAPRXive;
>> =20
>>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>>  #define SPAPR_ENTRY_POINT       0x100
>> @@ -127,6 +128,7 @@ struct sPAPRMachineState {
>>      MemoryHotplugState hotplug_memory;
>> =20
>>      const char *icp_type;
>> +    sPAPRXive  *xive;
>>  };
>> =20
>>  #define H_SUCCESS         0
>=20
