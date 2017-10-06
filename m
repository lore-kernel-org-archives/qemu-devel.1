Received: from eggs.gnu.org ([2001:4830:134:3::10]:34083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0ZyF-000655-K1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0ZyC-0000kg-Ci
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:15:47 -0400
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:59365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0ZyC-0000k5-5x
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:15:44 -0400
Received: from player787.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id AF69E112CCA
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 23:15:40 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-2-clg@kaod.org>
	<20171006090722.GD10961@umbus.fritz.box>
Message-ID: <63250b25-6c88-17a1-df4b-6a1e385ae7dd@kaod.org>
Date: Fri, 6 Oct 2017 23:15:31 +0200
MIME-Version: 1.0
In-Reply-To: <20171006090722.GD10961@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 10/06/2017 11:07 AM, David Gibson wrote:
> On Thu, Oct 05, 2017 at 06:49:58PM +0200, C=E9dric Le Goater wrote:
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
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr_rtas.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index cdf0b607a0a0..2389220c9738 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAP=
RMachineState *spapr,
>>          kvm_cpu_synchronize_state(cs);
>> =20
>>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
>> +
>> +        /* Enable DECR interrupt */
>> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>=20
> Hm.  Checking mmu_model doesn't seem right to me.  I mean, it'll get
> the right answer in practice, but the LPCR programming has nothing
> whatsoever to do with the MMU.
>=20
> I think explicitly checking if cpu_ is a POWER9 instance with
> object_dynamic_cast would be a better option.

OK. So I guess we should change the switch statement in cpu_ppc_set_papr(=
)
also.

C.=20

>=20
>> +            env->spr[SPR_LPCR] |=3D LPCR_DEE;
>> +        } else {
>> +            /* P7 and P8 both have same bit for DECR */
>> +            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
>> +        }
>> +
>>          env->nip =3D start;
>>          env->gpr[3] =3D r3;
>>          cs->halted =3D 0;
>> @@ -210,6 +219,13 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
>>       * no need to bother with specific bits, we just clear it.
>>       */
>>      env->msr =3D 0;
>> +
>> +    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>> +        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
>> +    } else {
>> +        /* P7 and P8 both have same bit for DECR */
>> +        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
>> +    }
>>  }
>> =20
>>  static inline int sysparm_st(target_ulong addr, target_ulong len,
>=20
