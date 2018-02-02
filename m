Received: from eggs.gnu.org ([2001:4830:134:3::10]:42264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ehccU-0003cT-Br
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ehccP-0004dO-9D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:14 -0500
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:54732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ehccO-0004aa-QU
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:09 -0500
Received: from player699.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3BE7756D59
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 15:47:07 +0100 (CET)
References: <20180131082749.1803-1-clg@kaod.org>
	<20180131082749.1803-4-clg@kaod.org>
	<1517539400.2332.22.camel@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2e91bba8-9d26-8000-20a0-66390cad7b5f@kaod.org>
Date: Fri, 2 Feb 2018 15:46:58 +0100
MIME-Version: 1.0
In-Reply-To: <1517539400.2332.22.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: generalize check on radix
 when in HV mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 02/02/2018 03:43 AM, Suraj Jitindar Singh wrote:
> On Wed, 2018-01-31 at 09:27 +0100, C=C3=A9dric Le Goater wrote:
>> On a POWER9 processor, the first doubleword of the PTCR indicates
>> whether the partition uses HPT or Radix Trees translation. Use that
>> bit to check for radix mode on powernv QEMU machines.
>=20
> The above isn't quite right.
>=20
> On a POWER9 processor, the first doubleword of the partition table
> entry (as pointed to by the PTCR) indicates whether the host uses HPT
> or Radix Tree translation for that partition.

yes. This is better.

>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  target/ppc/mmu-book3s-v3.c  | 17 ++++++++++++++++-
>>  target/ppc/mmu-book3s-v3.h  |  8 +-------
>>  target/ppc/mmu-hash64.h     |  1 +
>>  target/ppc/mmu_helper.c     |  4 ++--
>>  target/ppc/translate_init.c |  2 +-
>>  5 files changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
>> index e7798b3582b0..50b60fca3445 100644
>> --- a/target/ppc/mmu-book3s-v3.c
>> +++ b/target/ppc/mmu-book3s-v3.c
>> @@ -24,10 +24,25 @@
>>  #include "mmu-book3s-v3.h"
>>  #include "mmu-radix64.h"
>> =20
>> +bool ppc64_radix(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    if (msr_hv) {
>=20
> I would prefer something like:
>=20
> uint64_t prtbe0 =3D ldq_phys(...);
> return prtbe0 & HR;

I will add a helper to retrieve the first partition table entry,
as we need it in other places in patch 2.=20

>> +        return ldq_phys(CPU(cpu)->as, cpu->env.spr[SPR_PTCR] &
>> +                        PTCR_PTAB) & PTCR_PTAB_HR;
>> +    } else  {
>> +        PPCVirtualHypervisorClass *vhc =3D
>> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> +
>> +        return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
>> +    }
>> +}
>> +
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx)
>>  {
>> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
>> +    if (ppc64_radix(cpu)) { /* radix mode */
>>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx,
>> mmu_idx);
>>      } else { /* Guest uses hash */
>>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx,
>> mmu_idx);
>> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
>> index 56095dab522c..3876cb51b35c 100644
>> --- a/target/ppc/mmu-book3s-v3.h
>> +++ b/target/ppc/mmu-book3s-v3.h
>> @@ -37,13 +37,7 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU
>> *cpu)
>>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
>>  }
>> =20
>> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
>> -{
>> -    PPCVirtualHypervisorClass *vhc =3D
>> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> -
>> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
>> -}
>> +bool ppc64_radix(PowerPCCPU *cpu);
>> =20
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx);
>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>> index 4dc6b3968ec0..7e2ac64b6eeb 100644
>> --- a/target/ppc/mmu-hash64.h
>> +++ b/target/ppc/mmu-hash64.h
>> @@ -106,6 +106,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>>  /*
>>   * Partition table definitions
>>   */
>> +#define PTCR_PTAB_HR            PPC_BIT(0)            /* 1:Host=20
>=20
> This isn't a bit in the partition table register, it is a bit in the
> partition table entry. It should be defined in target/ppc/mmu-book3s-
> v3.h as part of "/* Partition Table Entry Fields */"
>=20
> Also to follow the naming, please call it:
> #define PATBE0_HR	PPC_BIT(0)
>=20
> :)

yeah sure.

Thanks,

C.=20

>> Radix 0:HPT   */
>>  #define PTCR_PTAB               0x0FFFFFFFFFFFF000ULL /* Partition
>> Table Base */
>>  #define PTCR_PTAS               0x000000000000001FULL /* Partition
>> Table Size */
>> =20
>> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
>> index b1e660a4d16a..059863b99b2e 100644
>> --- a/target/ppc/mmu_helper.c
>> +++ b/target/ppc/mmu_helper.c
>> @@ -1286,7 +1286,7 @@ void dump_mmu(FILE *f, fprintf_function
>> cpu_fprintf, CPUPPCState *env)
>>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>>          break;
>>      case POWERPC_MMU_VER_3_00:
>> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>> +        if (ppc64_radix(ppc_env_get_cpu(env))) {
>>              /* TODO - Unsupported */
>>          } else {
>>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>> @@ -1432,7 +1432,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState
>> *cs, vaddr addr)
>>      case POWERPC_MMU_VER_2_07:
>>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>>      case POWERPC_MMU_VER_3_00:
>> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>> +        if (ppc64_radix(ppc_env_get_cpu(env))) {
>>              return ppc_radix64_get_phys_page_debug(cpu, addr);
>>          } else {
>>              return ppc_hash64_get_phys_page_debug(cpu, addr);
>> diff --git a/target/ppc/translate_init.c
>> b/target/ppc/translate_init.c
>> index a6eaa74244ca..07012ee75e81 100644
>> --- a/target/ppc/translate_init.c
>> +++ b/target/ppc/translate_init.c
>> @@ -8965,7 +8965,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu,
>> PPCVirtualHypervisor *vhyp)
>>           * KVM but not under TCG. Update the default LPCR to keep
>> new
>>           * CPUs in sync when radix is enabled.
>>           */
>> -        if (ppc64_radix_guest(cpu)) {
>> +        if (ppc64_radix(cpu)) {
>>              lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
>>          } else {
>>              lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
