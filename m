Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1evSIw-0000AC-9i
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1evSIt-0005eR-44
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:14 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:38243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1evSIs-0005dl-Pa
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:11 -0400
Received: from player746.ha.ovh.net (unknown [10.109.108.55])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3664D1922F2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 19:36:09 +0100 (CET)
References: <20180216084504.24958-1-clg@kaod.org>
	<20180216084504.24958-4-clg@kaod.org>
	<20180219032914.GG1109@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7f1c8d29-f0b9-c2b9-1bdb-221d2cd2b2c3@kaod.org>
Date: Mon, 12 Mar 2018 19:36:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180219032914.GG1109@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/ppc: generalize check on
 radix when in HV mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 02/19/2018 04:29 AM, David Gibson wrote:
> On Fri, Feb 16, 2018 at 09:45:04AM +0100, C=E9dric Le Goater wrote:
>> On a POWER9 processor, the first doubleword of the partition table
>> entry (as pointed to by the PTCR) indicates whether the host uses HPT
>> or Radix Tree translation for that partition. Use that bit to check
>> for radix mode on pseries and powernv QEMU machines.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  Changes since v1:
>>
>>  - fixed commit log
>>  - introduced ppc64_v3_get_patbe0()
>>  - renamed ppc64_radix() in ppc64_v3_radix()
>> =20
>>  target/ppc/mmu-book3s-v3.c  | 16 +++++++++++++++-
>>  target/ppc/mmu-book3s-v3.h  | 11 +++--------
>>  target/ppc/mmu_helper.c     |  4 ++--
>>  target/ppc/translate_init.c |  2 +-
>>  4 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
>> index b60df4408f3b..9d05e07ef6bd 100644
>> --- a/target/ppc/mmu-book3s-v3.c
>> +++ b/target/ppc/mmu-book3s-v3.c
>> @@ -23,10 +23,24 @@
>>  #include "mmu-book3s-v3.h"
>>  #include "mmu-radix64.h"
>> =20
>> +bool ppc64_v3_radix(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    if (msr_hv) {
>> +        return ppc64_v3_get_patbe0(cpu) & PATBE0_HR;
>> +    } else  {
>> +        PPCVirtualHypervisorClass *vhc =3D
>> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> +
>> +        return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
>> +    }
>=20
> I think this is backwards.  If cpu->vhyp is set, you should always the
> get_patbe() hook, before you go looking at anything else.

OK. So, we should probably change the ppc64_radix_guest() name to=20
reflect its relation to spapr. How about ppc64_v3_radix_spapr() ?=20
=20
> This is also wrong if you have a powernv platform but msr_hv is not
> set - which is what you'll have once you get to the point of trying to
> run guests within an emulated powernv machine.

That is a good goal to reach ! I will add an error for the !msr_hv
case.

Thanks,

C.


>> +}
>> +
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx)
>>  {
>> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
>> +    if (ppc64_v3_radix(cpu)) { /* radix mode */
>>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx)=
;
>>      } else { /* Guest uses hash */
>>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
>> index a7ab580c3140..a12bb1e28b45 100644
>> --- a/target/ppc/mmu-book3s-v3.h
>> +++ b/target/ppc/mmu-book3s-v3.h
>> @@ -29,7 +29,8 @@
>>  #define PTCR_PATS               0x000000000000001FULL /* Partition Ta=
ble Size */
>> =20
>>  /* Partition Table Entry Fields */
>> -#define PATBE1_GR 0x8000000000000000
>> +#define PATBE0_HR               PPC_BIT(0)            /* 1:Host Radix=
 0:HPT   */
>> +#define PATBE1_GR               PPC_BIT(0)            /* 1:Guest Radi=
x 0:HPT  */
>> =20
>>  /* Process Table Entry */
>>  struct prtb_entry {
>> @@ -43,13 +44,7 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *c=
pu)
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
>> +bool ppc64_v3_radix(PowerPCCPU *cpu);
>> =20
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx);
>> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
>> index 82e63552f617..81a43982e421 100644
>> --- a/target/ppc/mmu_helper.c
>> +++ b/target/ppc/mmu_helper.c
>> @@ -1285,7 +1285,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fpri=
ntf, CPUPPCState *env)
>>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>>          break;
>>      case POWERPC_MMU_VER_3_00:
>> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
>>              /* TODO - Unsupported */
>>          } else {
>>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>> @@ -1431,7 +1431,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs,=
 vaddr addr)
>>      case POWERPC_MMU_VER_2_07:
>>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>>      case POWERPC_MMU_VER_3_00:
>> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
>>              return ppc_radix64_get_phys_page_debug(cpu, addr);
>>          } else {
>>              return ppc_hash64_get_phys_page_debug(cpu, addr);
>> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
>> index c998ac2ee405..21d5dcd15386 100644
>> --- a/target/ppc/translate_init.c
>> +++ b/target/ppc/translate_init.c
>> @@ -8967,7 +8967,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtua=
lHypervisor *vhyp)
>>           * KVM but not under TCG. Update the default LPCR to keep new
>>           * CPUs in sync when radix is enabled.
>>           */
>> -        if (ppc64_radix_guest(cpu)) {
>> +        if (ppc64_v3_radix(cpu)) {
>>              lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
>>          } else {
>>              lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
>=20
