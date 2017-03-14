Received: from eggs.gnu.org ([2001:4830:134:3::10]:40304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cnhYi-0000M9-1z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cnhYe-0001sv-NF
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:11:56 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:56545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cnhYe-0001sM-Hs
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:11:52 -0400
Received: from player730.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C4340614E4
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:11:48 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-2-git-send-email-clg@kaod.org>
	<20170314053856.GH12564@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ed894c5a-a4b0-f67e-812c-870ee644566d@kaod.org>
Date: Tue, 14 Mar 2017 09:11:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170314053856.GH12564@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/8] ppc/xics: add a
 xics_get_cpu_index_by_pir() helper
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

On 03/14/2017 06:38 AM, David Gibson wrote:
> On Wed, Mar 08, 2017 at 11:52:44AM +0100, C=E9dric Le Goater wrote:
>> This helper will be used to translate the server number of the XIVE
>> (which is a PIR) into an ICPState index number (which is a cpu index).
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This seems a slightly roundabout way of doing things.  Why not just
> have the vcpu_by_pir() interface, then have the XICSFabric implementor
> go directly from PIR to xics server state.

yes. This is only used to find ICPs and if we introduce a new ICP=20
type object, as you suggest, we might not need anymore this interface.=20
I will take a look.

Thanks,

C.  =20
=20
>> ---
>>  hw/intc/xics.c        | 11 +++++++++++
>>  hw/ppc/ppc.c          | 16 ++++++++++++++++
>>  include/hw/ppc/xics.h |  1 +
>>  target/ppc/cpu.h      | 10 ++++++++++
>>  4 files changed, 38 insertions(+)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index e740989a1162..209e1a75ecb9 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -49,6 +49,17 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
>>      return -1;
>>  }
>> =20
>> +int xics_get_cpu_index_by_pir(int pir)
>> +{
>> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
>> +
>> +    if (cpu) {
>> +        return cpu->parent_obj.cpu_index;
>> +    }
>> +
>> +    return -1;
>> +}
>> +
>>  void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
>>  {
>>      CPUState *cs =3D CPU(cpu);
>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>> index 5f93083d4a16..94bbe382a73a 100644
>> --- a/hw/ppc/ppc.c
>> +++ b/hw/ppc/ppc.c
>> @@ -1379,6 +1379,22 @@ PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id=
)
>>      return NULL;
>>  }
>> =20
>> +PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
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
>>  void ppc_cpu_parse_features(const char *cpu_model)
>>  {
>>      CPUClass *cc;
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 9a5e715fe553..42bd24e975cb 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -173,6 +173,7 @@ void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *=
cpu);
>> =20
>>  /* Internal XICS interfaces */
>>  int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
>> +int xics_get_cpu_index_by_pir(int pir);
>> =20
>>  void icp_set_cppr(ICPState *icp, uint8_t cppr);
>>  void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 7c4a1f50b38b..24a5af95cb45 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -2518,5 +2518,15 @@ int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
>>   */
>>  PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
>> =20
>> +/**
>> + * ppc_get_vcpu_by_pir_id:
>> + * @pir: Processor Identifier Register (SPR_PIR)
>> + *
>> + * Searches for a CPU by @pir.
>> + *
>> + * Returns: a PowerPCCPU struct
>> + */
>> +PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
>> +
>>  void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int=
 len);
>>  #endif /* PPC_CPU_H */
>=20
