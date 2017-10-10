Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1wtL-00031V-6Z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1wtG-0001fF-N1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:56:23 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:57919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1wtG-0001cu-Dr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:56:18 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id AFB2159E91
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:56:16 +0200 (CEST)
References: <20171009154930.29095-1-clg@kaod.org>
	<20171009154930.29095-3-clg@kaod.org>
	<1507622927.25065.200.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9060b77b-356e-a2b2-cf48-d55261032376@kaod.org>
Date: Tue, 10 Oct 2017 17:56:08 +0200
MIME-Version: 1.0
In-Reply-To: <1507622927.25065.200.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 10/10/2017 10:08 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2017-10-09 at 17:49 +0200, C=C3=A9dric Le Goater wrote:
>> When a CPU is stopped with the 'stop-self' RTAS call, its state
>> 'halted' is switched to 1 and, in this case, the MSR is not taken into
>> account anymore in the cpu_has_work() routine. Only the pending
>> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>>
>> If the DECR timer fires after 'stop-self' is called and before the CPU
>> 'stop' state is reached, the nearly-dead CPU will have some work to do
>> and the guest will crash. This case happens very frequently with the
>> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
>> occasionally fired but after 'stop' state, so no work is to be done
>> and the guest survives.
>>
>> I suspect there is a race between the QEMU mainloop triggering the
>> timers and the TCG CPU thread but I could not quite identify the root
>> cause. To be safe, let's disable the decrementer interrupt in the LPCR
>> when the CPU is halted and reenable it when the CPU is restarted.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> We should disable external interrupts and doorbells too no ? IE, we
> could clear all of PECE in fact.

and enable them all in 'start-cpu' for secondaries then ?=20

C.=20


>=20
>> ---
>>
>> Changes in v2:
>>
>>  - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
>>  - removed the LPCR:PECE* enablement bit when the CPU is initialized
>>    if it is a secondary
>>
>>  hw/ppc/spapr_rtas.c         | 20 ++++++++++++++++++++
>>  target/ppc/translate_init.c | 19 +++++++++++++++++--
>>  2 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index cdf0b607a0a0..dfdbf1e2c6f8 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -46,6 +46,7 @@
>>  #include "qemu/cutils.h"
>>  #include "trace.h"
>>  #include "hw/ppc/fdt.h"
>> +#include "target/ppc/cpu-models.h"
>> =20
>>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState=
 *spapr,
>>                                     uint32_t token, uint32_t nargs,
>> @@ -174,6 +175,15 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
>>          kvm_cpu_synchronize_state(cs);
>> =20
>>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
>> +
>> +        /* Enable DECR interrupt */
>> +        if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
>> +            env->spr[SPR_LPCR] |=3D LPCR_DEE;
>> +        } else {
>> +            /* P7 and P8 both have same bit for DECR */
>> +            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
>> +        }
>> +
>>          env->nip =3D start;
>>          env->gpr[3] =3D r3;
>>          cs->halted =3D 0;
>> @@ -210,6 +220,16 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
>>       * no need to bother with specific bits, we just clear it.
>>       */
>>      env->msr =3D 0;
>> +
>> +    /* Don't let the decremeter run on a CPU being stopped. This coul=
d
>> +     * deliver an interrupt on a dying CPU and crash the guest.
>> +     */
>> +    if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
>> +        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
>> +    } else {
>> +        /* P7 and P8 both have same bit for DECR */
>> +        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
>> +    }
>>  }
>> =20
>>  static inline int sysparm_st(target_ulong addr, target_ulong len,
>> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
>> index 0d6379fcc5b4..1a62159843e7 100644
>> --- a/target/ppc/translate_init.c
>> +++ b/target/ppc/translate_init.c
>> @@ -8905,6 +8905,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp)
>>      CPUPPCState *env =3D &cpu->env;
>>      ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
>>      ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
>> +    CPUState *cs =3D CPU(cpu);
>> =20
>>      cpu->vhyp =3D vhyp;
>> =20
>> @@ -8946,8 +8947,15 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtu=
alHypervisor *vhyp)
>>          } else {
>>              lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
>>          }
>> -        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | L=
PCR_DEE |
>> +        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
>>                                 LPCR_OEE;
>> +
>> +        /* Only let the decremeter wake up the boot CPU. The RTAS
>> +         * command start-cpu will enable it on secondaries.
>> +         */
>> +        if (cs =3D=3D first_cpu) {
>> +            lpcr->default_value |=3D LPCR_DEE;
>> +        }
>>          break;
>>      default:
>>          /* P7 and P8 has slightly different PECE bits, mostly because=
 P8 adds
>> @@ -8955,7 +8963,14 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtu=
alHypervisor *vhyp)
>>           * will work as expected for both implementations
>>           */
>>          lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR=
_P8_PECE2 |
>> -                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
>> +                               LPCR_P8_PECE4;
>> +
>> +        /* Only let the decremeter wake up the boot CPU. The RTAS
>> +         * command start-cpu will enable it on secondaries.
>> +         */
>> +        if (cs =3D=3D first_cpu) {
>> +            lpcr->default_value |=3D LPCR_P8_PECE3;
>> +        }
>>      }
>> =20
>>      /* We should be followed by a CPU reset but update the active val=
ue
