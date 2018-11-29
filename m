Received: from eggs.gnu.org ([2001:4830:134:3::10]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPBF-0002VS-8Q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPBC-0000R1-1b
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:28:45 -0500
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:41322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSPBB-0000QO-J2
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:28:41 -0500
Received: from player157.ha.ovh.net (unknown [10.109.143.249])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CD68E207E3D
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:28:39 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-26-clg@kaod.org>
	<20181129040302.GD14697@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a6fecb88-f643-55fa-d66b-c02ae9d11588@kaod.org>
Date: Thu, 29 Nov 2018 17:28:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181129040302.GD14697@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 25/36] spapr: set the interrupt
 presenter at reset
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

On 11/29/18 5:03 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:18AM +0100, C=E9dric Le Goater wrote:
>> Currently, the interrupt presenter of the VPCU is set at realize
>> time. Setting it at reset will become useful when the new machine
>> supporting both interrupt modes is introduced. In this machine, the
>> interrupt mode is chosen at CAS time and activated after a reset.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>>  hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
>>  hw/ppc/spapr_irq.c              | 11 +++++++++++
>>  3 files changed, 39 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cp=
u_core.h
>> index 9e2821e4b31f..fc8ea9021656 100644
>> --- a/include/hw/ppc/spapr_cpu_core.h
>> +++ b/include/hw/ppc/spapr_cpu_core.h
>> @@ -53,4 +53,6 @@ static inline sPAPRCPUState *spapr_cpu_state(PowerPC=
CPU *cpu)
>>      return (sPAPRCPUState *)cpu->machine_data;
>>  }
>> =20
>> +void spapr_cpu_core_set_intc(PowerPCCPU *cpu, const char *intc_type);
>> +
>>  #endif
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 1811cd48db90..529de0b6b9c8 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -398,3 +398,29 @@ static const TypeInfo spapr_cpu_core_type_infos[]=
 =3D {
>>  };
>> =20
>>  DEFINE_TYPES(spapr_cpu_core_type_infos)
>> +
>> +typedef struct ForeachFindIntCArgs {
>> +    const char *intc_type;
>> +    Object *intc;
>> +} ForeachFindIntCArgs;
>> +
>> +static int spapr_cpu_core_find_intc(Object *child, void *opaque)
>> +{
>> +    ForeachFindIntCArgs *args =3D opaque;
>> +
>> +    if (object_dynamic_cast(child, args->intc_type)) {
>> +        args->intc =3D child;
>> +    }
>> +
>> +    return args->intc !=3D NULL;
>> +}
>> +
>> +void spapr_cpu_core_set_intc(PowerPCCPU *cpu, const char *intc_type)
>> +{
>> +    ForeachFindIntCArgs args =3D { intc_type, NULL };
>> +
>> +    object_child_foreach(OBJECT(cpu), spapr_cpu_core_find_intc, &args=
);
>> +    g_assert(args.intc);
>=20
> We could create some extra links on the cpu to avoid scanning all the
> children, but I guess that's a refinement.

yes. Like an extra ->intc for xive. but as we can have only one interrupt
controller active, having only one presenter per CPU seems reasonable.=20

> Then again.. what do we actually use the cpu->intc pointer for in XIVE
> context? =20

yes for the TIMA MMIOs and also when running the matching algo in the XIV=
E=20
presenter.

C.

> I had a feeling because of the different way notifications
> are handled we might not ever need to go from a cpu handle to the
> associated TCTX.
>
>=20
>> +    cpu->intc =3D args.intc;
>> +}
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 984c6d60cd9f..969efad7e6e9 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -218,6 +218,11 @@ static int spapr_irq_post_load_xics(sPAPRMachineS=
tate *spapr, int version_id)
>> =20
>>  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **er=
rp)
>>  {
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
>> +    }
>>  }
>> =20
>>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>> @@ -370,6 +375,12 @@ static int spapr_irq_post_load_xive(sPAPRMachineS=
tate *spapr, int version_id)
>> =20
>>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **er=
rp)
>>  {
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->xive_tctx_typ=
e);
>> +    }
>> +
>>      spapr_xive_mmio_map(spapr->xive);
>>  }
>> =20
>=20
