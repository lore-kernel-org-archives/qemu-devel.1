Received: from eggs.gnu.org ([2001:4830:134:3::10]:60093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfkr-0004XI-8L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfkm-00026o-W2
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:59:09 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:41915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWfkm-00024l-PF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:59:04 -0500
Received: from player729.ha.ovh.net (unknown [10.109.160.251])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0387AD6B9A
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:59:02 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-15-clg@kaod.org>
	<20181211014614.GD4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bb397691-a805-6506-a1a9-0c16b62ff75c@kaod.org>
Date: Tue, 11 Dec 2018 11:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181211014614.GD4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 14/19] spapr: set the interrupt
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

On 12/11/18 2:46 AM, David Gibson wrote:
> On Sun, Dec 09, 2018 at 08:46:05PM +0100, C=E9dric Le Goater wrote:
>> Currently, the interrupt presenter of the vCPU is set at realize
>> time. Setting it at reset will become useful when the new machine
>> supporting both interrupt modes is introduced. In this machine, the
>> interrupt mode is chosen at CAS time and activated after a reset.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Shouldn't this also remove the code which sets cpu->intc at realize
> time, in order to avoid confusion?

yes. Which also raises the question of the parenthood when a CPU is=20
hot-unplugged (spapr_unrealize_vcpu)

C.

>=20
>> ---
>>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>>  hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
>>  hw/ppc/spapr_irq.c              | 12 ++++++++++++
>>  3 files changed, 40 insertions(+)
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
>> +
>> +    cpu->intc =3D args.intc;
>> +}
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 7a0d4f529763..b423cee30e2c 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -12,6 +12,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>>  #include "hw/ppc/spapr.h"
>> +#include "hw/ppc/spapr_cpu_core.h"
>>  #include "hw/ppc/spapr_xive.h"
>>  #include "hw/ppc/xics.h"
>>  #include "sysemu/kvm.h"
>> @@ -211,6 +212,11 @@ static int spapr_irq_post_load_xics(sPAPRMachineS=
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
>> @@ -341,6 +347,12 @@ static int spapr_irq_post_load_xive(sPAPRMachineS=
tate *spapr, int version_id)
>> =20
>>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **er=
rp)
>>  {
>> +    CPUState *cs;
>> +
>> +    CPU_FOREACH(cs) {
>> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), TYPE_XIVE_TCTX);
>> +    }
>> +
>>      /*
>>       * Set the OS CAM line of the cpu interrupt thread context. Needs
>>       * to come after the XiveTCTX reset handlers.
>=20
