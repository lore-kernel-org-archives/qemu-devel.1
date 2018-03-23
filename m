Received: from eggs.gnu.org ([2001:4830:134:3::10]:36678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ezITO-0008Ex-7l
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ezITK-0002x4-5w
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:54:54 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:49022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ezITJ-0002tn-SZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 04:54:50 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.225])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id C158EB6015
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 09:54:39 +0100 (CET)
References: <20180315133402.13470-1-clg@kaod.org>
	<20180315133402.13470-4-clg@kaod.org>
	<20180323082447.GU3905@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2781e095-b669-e5d7-4a07-4624f23ec438@kaod.org>
Date: Fri, 23 Mar 2018 09:54:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180323082447.GU3905@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] target/ppc: add hash MMU support on
 POWER9 for PowerNV only
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

On 03/23/2018 09:24 AM, David Gibson wrote:
> I'm not quite sure what the "for PowerNV only" in the subject is
> supposed to be indicating.

That's the initial subject which didn't evolve with the code, which is=20
now changing some sPAPR hcalls. And anyhow, hash MMU is supported on
POWER9 TCG, so there is no reason for the 'only'. KVM is another matter.

I will change the subject and split the patch in two parts, a first=20
one for the changes in the HPTE bits definitions introduced by ISA v3.0=20
which has some impact on the sPAPR platform. And a second patch to
introduce ppc_hash64_hpt_reg() which adds support for hash MMU to
the PowerNV platform.

Thanks,

C.

=20
> On Thu, Mar 15, 2018 at 01:34:01PM +0000, C=E9dric Le Goater wrote:
>> The HPTE bits definitions are slightly modified in ISA v3.0. Let's add
>> some helpers to hide the differences in the hash MMU code.
>>
>> On a POWER9 processor, the Partition Table is composed of a pair of
>> doublewords per partition. The first doubleword indicates whether the
>> partition uses HPT or Radix Trees translation and contains the address
>> of the host's translation table structure and size.
>>
>> The first doubleword of the PTCR holds the Hash Page Table base
>> address for the host when the hash MMU is in use. Also add an helper
>> to retrieve the HPT base address depending on the MMU revision.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v2:
>>
>>  - reworked ppc_hash64_hpt_reg() to cover only powernv machines. pseri=
es
>>    machines being handled with cpu->vhyp at the ppc_hash64_hpt_base()
>>    level.
>>
>>  Changes since v1:
>>
>>  - introduced ppc64_v3_get_patbe0()
>> =20
>>  hw/ppc/spapr_hcall.c       |  5 +++--
>>  target/ppc/mmu-book3s-v3.h |  5 +++++
>>  target/ppc/mmu-hash64.c    | 52 +++++++++++++++++++++++++++++++++++++=
+--------
>>  target/ppc/mmu-hash64.h    | 34 ++++++++++++++++++++++++++++--
>>  4 files changed, 83 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 3215c3b4aec3..b437f8825819 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -94,7 +94,7 @@ static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
>>          return H_PARAMETER;
>>      }
>> =20
>> -    raddr =3D (ptel & HPTE64_R_RPN) & ~((1ULL << apshift) - 1);
>> +    raddr =3D (ptel & ppc_hash64_hpte_r_rpn(cpu)) & ~((1ULL << apshif=
t) - 1);
>=20
> h_enter() will never be used on PowerNV, for example, so why is it
> being changed?
>=20
>>      if (is_ram_address(spapr, raddr)) {
>>          /* Regular RAM - should have WIMG=3D0010 */
>> @@ -586,7 +586,8 @@ static int rehash_hpte(PowerPCCPU *cpu,
>> =20
>>      base_pg_shift =3D ppc_hash64_hpte_page_shift_noslb(cpu, pte0, pte=
1);
>>      assert(base_pg_shift); /* H_ENTER shouldn't allow a bad encoding =
*/
>> -    avpn =3D HPTE64_V_AVPN_VAL(pte0) & ~(((1ULL << base_pg_shift) - 1=
) >> 23);
>> +    avpn =3D ppc_hash64_hpte_v_avpn_val(cpu, pte0) &
>> +        ~(((1ULL << base_pg_shift) - 1) >> 23);
>> =20
>>      if (pte0 & HPTE64_V_SECONDARY) {
>>          pteg =3D ~pteg;
>> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
>> index fdf80987d7b2..a7ab580c3140 100644
>> --- a/target/ppc/mmu-book3s-v3.h
>> +++ b/target/ppc/mmu-book3s-v3.h
>> @@ -54,6 +54,11 @@ static inline bool ppc64_radix_guest(PowerPCCPU *cp=
u)
>>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>                                int mmu_idx);
>> =20
>> +static inline hwaddr ppc64_v3_get_patbe0(PowerPCCPU *cpu)
>> +{
>> +    return ldq_phys(CPU(cpu)->as, cpu->env.spr[SPR_PTCR] & PTCR_PATB)=
;
>> +}
>> +
>>  #endif /* TARGET_PPC64 */
>> =20
>>  #endif /* CONFIG_USER_ONLY */
>> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
>> index c9b72b742956..c425edd93ebe 100644
>> --- a/target/ppc/mmu-hash64.c
>> +++ b/target/ppc/mmu-hash64.c
>> @@ -289,6 +289,26 @@ target_ulong helper_load_slb_vsid(CPUPPCState *en=
v, target_ulong rb)
>>      return rt;
>>  }
>> =20
>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    /* We should not reach this routine on sPAPR machines */
>> +    assert(!cpu->vhyp);
>> +
>> +    /* PowerNV machine */
>> +    if (msr_hv) {
>> +        if (env->mmu_model & POWERPC_MMU_V3) {
>> +            return ppc64_v3_get_patbe0(cpu);
>> +        } else {
>> +            return cpu->env.spr[SPR_SDR1];
>> +        }
>> +    } else {
>> +        error_report("PowerNV guest support Unimplemented");
>> +        exit(1);
>> +    }
>> +}
>> +
>>  /* Check No-Execute or Guarded Storage */
>>  static inline int ppc_hash64_pte_noexec_guard(PowerPCCPU *cpu,
>>                                                ppc_hash_pte64_t pte)
>> @@ -451,8 +471,9 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const=
 ppc_hash_pte64_t *hptes,
>>                          false, n * HASH_PTE_SIZE_64);
>>  }
>> =20
>> -static unsigned hpte_page_shift(const struct ppc_one_seg_page_size *s=
ps,
>> -    uint64_t pte0, uint64_t pte1)
>> +static unsigned hpte_page_shift(PowerPCCPU *cpu,
>> +                                const struct ppc_one_seg_page_size *s=
ps,
>> +                                uint64_t pte0, uint64_t pte1)
>>  {
>>      int i;
>> =20
>> @@ -478,7 +499,7 @@ static unsigned hpte_page_shift(const struct ppc_o=
ne_seg_page_size *sps,
>>              continue;
>>          }
>> =20
>> -        mask =3D ((1ULL << ps->page_shift) - 1) & HPTE64_R_RPN;
>> +        mask =3D ((1ULL << ps->page_shift) - 1) & ppc_hash64_hpte_r_r=
pn(cpu);
>> =20
>>          if ((pte1 & mask) =3D=3D ((uint64_t)ps->pte_enc << HPTE64_R_R=
PN_SHIFT)) {
>>              return ps->page_shift;
>> @@ -488,6 +509,18 @@ static unsigned hpte_page_shift(const struct ppc_=
one_seg_page_size *sps,
>>      return 0; /* Bad page size encoding */
>>  }
>> =20
>> +static bool ppc_hash64_hpte_v_compare(PowerPCCPU *cpu, target_ulong p=
te0,
>> +                                      target_ulong ptem)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    if (env->mmu_model & POWERPC_MMU_V3) {
>> +        return HPTE64_V_COMPARE_3_0(pte0, ptem);
>> +    } else {
>> +        return HPTE64_V_COMPARE(pte0, ptem);
>> +    }
>> +}
>> +
>>  static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu, hwaddr hash,
>>                                       const struct ppc_one_seg_page_si=
ze *sps,
>>                                       target_ulong ptem,
>> @@ -508,8 +541,8 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *c=
pu, hwaddr hash,
>>          pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
>> =20
>>          /* This compares V, B, H (secondary) and the AVPN */
>> -        if (HPTE64_V_COMPARE(pte0, ptem)) {
>> -            *pshift =3D hpte_page_shift(sps, pte0, pte1);
>> +        if (ppc_hash64_hpte_v_compare(cpu, pte0, ptem)) {
>> +            *pshift =3D hpte_page_shift(cpu, sps, pte0, pte1);
>>              /*
>>               * If there is no match, ignore the PTE, it could simply
>>               * be for a different segment size encoding and the
>> @@ -569,7 +602,8 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *c=
pu,
>>          epn =3D (eaddr & ~SEGMENT_MASK_256M) & epnmask;
>>          hash =3D vsid ^ (epn >> sps->page_shift);
>>      }
>> -    ptem =3D (slb->vsid & SLB_VSID_PTEM) | ((epn >> 16) & HPTE64_V_AV=
PN);
>> +    ptem =3D (slb->vsid & SLB_VSID_PTEM) | ((epn >> 16) &
>> +                                          ppc_hash64_hpte_v_avpn(cpu)=
);
>>      ptem |=3D HPTE64_V_VALID;
>> =20
>>      /* Page address translation */
>> @@ -624,7 +658,7 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCC=
PU *cpu,
>>              break;
>>          }
>> =20
>> -        shift =3D hpte_page_shift(sps, pte0, pte1);
>> +        shift =3D hpte_page_shift(cpu, sps, pte0, pte1);
>>          if (shift) {
>>              return shift;
>>          }
>> @@ -860,7 +894,7 @@ skip_slb_search:
>> =20
>>      /* 7. Determine the real address from the PTE */
>> =20
>> -    raddr =3D deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, eaddr);
>> +    raddr =3D deposit64(pte.pte1 & ppc_hash64_hpte_r_rpn(cpu), 0, aps=
hift, eaddr);
>> =20
>>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MA=
SK,
>>                   prot, mmu_idx, 1ULL << apshift);
>> @@ -910,7 +944,7 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *=
cpu, target_ulong addr)
>>          return -1;
>>      }
>> =20
>> -    return deposit64(pte.pte1 & HPTE64_R_RPN, 0, apshift, addr)
>> +    return deposit64(pte.pte1 & ppc_hash64_hpte_r_rpn(cpu), 0, apshif=
t, addr)
>>          & TARGET_PAGE_MASK;
>>  }
>> =20
>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>> index 0ade8d15d9e4..708f4f6d222a 100644
>> --- a/target/ppc/mmu-hash64.h
>> +++ b/target/ppc/mmu-hash64.h
>> @@ -69,8 +69,12 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>>  #define HPTE64_V_SSIZE_SHIFT    62
>>  #define HPTE64_V_AVPN_SHIFT     7
>>  #define HPTE64_V_AVPN           0x3fffffffffffff80ULL
>> +#define HPTE64_V_AVPN_3_0       0x000fffffffffff80ULL
>>  #define HPTE64_V_AVPN_VAL(x)    (((x) & HPTE64_V_AVPN) >> HPTE64_V_AV=
PN_SHIFT)
>> +#define HPTE64_V_AVPN_VAL_3_0(x)                        \
>> +    (((x) & HPTE64_V_AVPN_3_0) >> HPTE64_V_AVPN_SHIFT)
>>  #define HPTE64_V_COMPARE(x, y)  (!(((x) ^ (y)) & 0xffffffffffffff83UL=
L))
>> +#define HPTE64_V_COMPARE_3_0(x, y)  (!(((x) ^ (y)) & 0x3fffffffffffff=
83ULL))
>>  #define HPTE64_V_BOLTED         0x0000000000000010ULL
>>  #define HPTE64_V_LARGE          0x0000000000000004ULL
>>  #define HPTE64_V_SECONDARY      0x0000000000000002ULL
>> @@ -81,6 +85,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>>  #define HPTE64_R_KEY_HI         0x3000000000000000ULL
>>  #define HPTE64_R_RPN_SHIFT      12
>>  #define HPTE64_R_RPN            0x0ffffffffffff000ULL
>> +#define HPTE64_R_RPN_3_0        0x01fffffffffff000ULL
>>  #define HPTE64_R_FLAGS          0x00000000000003ffULL
>>  #define HPTE64_R_PP             0x0000000000000003ULL
>>  #define HPTE64_R_N              0x0000000000000004ULL
>> @@ -98,6 +103,31 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
>> =20
>> +static inline target_ulong ppc_hash64_hpte_r_rpn(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    return env->mmu_model & POWERPC_MMU_V3 ? HPTE64_R_RPN_3_0 : HPTE6=
4_R_RPN;
>> +}
>> +
>> +static inline target_ulong ppc_hash64_hpte_v_avpn(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    return env->mmu_model & POWERPC_MMU_V3 ? HPTE64_V_AVPN_3_0 : HPTE=
64_V_AVPN;
>> +}
>> +
>> +static inline target_ulong ppc_hash64_hpte_v_avpn_val(PowerPCCPU *cpu=
,
>> +                                                      target_ulong pt=
e0)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    return env->mmu_model & POWERPC_MMU_V3 ?
>> +        HPTE64_V_AVPN_VAL_3_0(pte0) : HPTE64_V_AVPN_VAL(pte0);
>> +}
>> +
>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu);
>> +
>>  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>>  {
>>      if (cpu->vhyp) {
>> @@ -105,7 +135,7 @@ static inline hwaddr ppc_hash64_hpt_base(PowerPCCP=
U *cpu)
>>              PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>>          return vhc->hpt_base(cpu->vhyp);
>>      }
>> -    return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
>> +    return ppc_hash64_hpt_reg(cpu) & SDR_64_HTABORG;
>>  }
>> =20
>>  static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
>> @@ -115,7 +145,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCP=
U *cpu)
>>              PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>>          return vhc->hpt_mask(cpu->vhyp);
>>      }
>> -    return (1ULL << ((cpu->env.spr[SPR_SDR1] & SDR_64_HTABSIZE) + 18 =
- 7)) - 1;
>> +    return (1ULL << ((ppc_hash64_hpt_reg(cpu) & SDR_64_HTABSIZE) + 18=
 - 7)) - 1;
>>  }
>> =20
>>  struct ppc_hash_pte64 {
>=20
