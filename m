Received: from eggs.gnu.org ([2001:4830:134:3::10]:51436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kF8-0004YW-N5
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kF3-0003nb-7G
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:46:10 -0400
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:41074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f0kF2-0003mU-UJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:46:05 -0400
Received: from player762.ha.ovh.net (unknown [10.109.108.183])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id BC51114DA0F
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 10:46:02 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-5-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7387b3e2-5c5a-8e30-e001-295303545906@kaod.org>
Date: Tue, 27 Mar 2018 10:45:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 04/12] target/ppc: Avoid taking
 "env" parameter to mmu-hash64 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com

On 03/27/2018 06:37 AM, David Gibson wrote:
> In most cases we prefer to pass a PowerPCCPU rather than the (embedded)
> CPUPPCState.
>=20
> For ppc_hash64_update_{rmls,vrma}() change to take "cpu" instead of "en=
v".
> For ppc_hash64_set_{dsi,isi}() remove the redundant "env" parameter.
>=20
> In theory this makes more work for the functions, but since "cs", "cpu"
> and "env" are related by at most constant offsets, the compiler should =
be
> able to optimize out the difference at effectively zero cost.
>=20
> helper_*() functions are left alone - since they're more closely tied t=
o
> the TCG generated code, passing "env" is still the standard there.
>=20
> While we're there, fix an incorrect indentation.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-hash64.c     | 35 +++++++++++++++++++----------------
>  target/ppc/mmu-hash64.h     |  4 ++--
>  target/ppc/translate_init.c |  4 ++--
>  3 files changed, 23 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index c9b72b7429..a87fa7c83f 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -633,9 +633,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCP=
U *cpu,
>      return 0;
>  }
> =20
> -static void ppc_hash64_set_isi(CPUState *cs, CPUPPCState *env,
> -                               uint64_t error_code)
> +static void ppc_hash64_set_isi(CPUState *cs, uint64_t error_code)
>  {
> +    CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
>      bool vpm;
> =20
>      if (msr_ir) {
> @@ -659,9 +659,9 @@ static void ppc_hash64_set_isi(CPUState *cs, CPUPPC=
State *env,
>      env->error_code =3D error_code;
>  }
> =20
> -static void ppc_hash64_set_dsi(CPUState *cs, CPUPPCState *env, uint64_=
t dar,
> -                               uint64_t dsisr)
> +static void ppc_hash64_set_dsi(CPUState *cs, uint64_t dar, uint64_t ds=
isr)
>  {
> +    CPUPPCState *env =3D &POWERPC_CPU(cs)->env;
>      bool vpm;
> =20
>      if (msr_dr) {
> @@ -741,13 +741,13 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, =
vaddr eaddr,
>              } else {
>                  /* The access failed, generate the approriate interrup=
t */
>                  if (rwx =3D=3D 2) {
> -                    ppc_hash64_set_isi(cs, env, SRR1_PROTFAULT);
> +                    ppc_hash64_set_isi(cs, SRR1_PROTFAULT);
>                  } else {
>                      int dsisr =3D DSISR_PROTFAULT;
>                      if (rwx =3D=3D 1) {
>                          dsisr |=3D DSISR_ISSTORE;
>                      }
> -                    ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
> +                    ppc_hash64_set_dsi(cs, eaddr, dsisr);
>                  }
>                  return 1;
>              }
> @@ -783,7 +783,7 @@ skip_slb_search:
> =20
>      /* 3. Check for segment level no-execute violation */
>      if ((rwx =3D=3D 2) && (slb->vsid & SLB_VSID_N)) {
> -        ppc_hash64_set_isi(cs, env, SRR1_NOEXEC_GUARD);
> +        ppc_hash64_set_isi(cs, SRR1_NOEXEC_GUARD);
>          return 1;
>      }
> =20
> @@ -791,13 +791,13 @@ skip_slb_search:
>      ptex =3D ppc_hash64_htab_lookup(cpu, slb, eaddr, &pte, &apshift);
>      if (ptex =3D=3D -1) {
>          if (rwx =3D=3D 2) {
> -            ppc_hash64_set_isi(cs, env, SRR1_NOPTE);
> +            ppc_hash64_set_isi(cs, SRR1_NOPTE);
>          } else {
>              int dsisr =3D DSISR_NOPTE;
>              if (rwx =3D=3D 1) {
>                  dsisr |=3D DSISR_ISSTORE;
>              }
> -            ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
> +            ppc_hash64_set_dsi(cs, eaddr, dsisr);
>          }
>          return 1;
>      }
> @@ -824,7 +824,7 @@ skip_slb_search:
>              if (PAGE_EXEC & ~amr_prot) {
>                  srr1 |=3D SRR1_IAMR; /* Access violates virt pg class =
key prot */
>              }
> -            ppc_hash64_set_isi(cs, env, srr1);
> +            ppc_hash64_set_isi(cs, srr1);
>          } else {
>              int dsisr =3D 0;
>              if (need_prot[rwx] & ~pp_prot) {
> @@ -836,7 +836,7 @@ skip_slb_search:
>              if (need_prot[rwx] & ~amr_prot) {
>                  dsisr |=3D DSISR_AMR;
>              }
> -            ppc_hash64_set_dsi(cs, env, eaddr, dsisr);
> +            ppc_hash64_set_dsi(cs, eaddr, dsisr);
>          }
>          return 1;
>      }
> @@ -942,8 +942,9 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, tar=
get_ulong ptex,
>      cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL=
_FLUSH;
>  }
> =20
> -void ppc_hash64_update_rmls(CPUPPCState *env)
> +void ppc_hash64_update_rmls(PowerPCCPU *cpu)
>  {
> +    CPUPPCState *env =3D &cpu->env;
>      uint64_t lpcr =3D env->spr[SPR_LPCR];
> =20
>      /*
> @@ -976,8 +977,9 @@ void ppc_hash64_update_rmls(CPUPPCState *env)
>      }
>  }
> =20
> -void ppc_hash64_update_vrma(CPUPPCState *env)
> +void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>  {
> +    CPUPPCState *env =3D &cpu->env;
>      const struct ppc_one_seg_page_size *sps =3D NULL;
>      target_ulong esid, vsid, lpcr;
>      ppc_slb_t *slb =3D &env->vrma_slb;
> @@ -1002,7 +1004,7 @@ void ppc_hash64_update_vrma(CPUPPCState *env)
>      vsid |=3D (vrmasd << 4) & (SLB_VSID_L | SLB_VSID_LP);
>      esid =3D SLB_ESID_V;
> =20
> -   for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> +    for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
>          const struct ppc_one_seg_page_size *sps1 =3D &env->sps.sps[i];
> =20
>          if (!sps1->page_shift) {
> @@ -1028,6 +1030,7 @@ void ppc_hash64_update_vrma(CPUPPCState *env)
> =20
>  void helper_store_lpcr(CPUPPCState *env, target_ulong val)
>  {
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>      uint64_t lpcr =3D 0;
> =20
>      /* Filter out bits */
> @@ -1089,6 +1092,6 @@ void helper_store_lpcr(CPUPPCState *env, target_u=
long val)
>          ;
>      }
>      env->spr[SPR_LPCR] =3D lpcr;
> -    ppc_hash64_update_rmls(env);
> -    ppc_hash64_update_vrma(env);
> +    ppc_hash64_update_rmls(cpu);
> +    ppc_hash64_update_vrma(cpu);
>  }
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index d297b97d37..95a8c330d6 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -17,8 +17,8 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
>                                 target_ulong pte0, target_ulong pte1);
>  unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
>                                            uint64_t pte0, uint64_t pte1=
);
> -void ppc_hash64_update_vrma(CPUPPCState *env);
> -void ppc_hash64_update_rmls(CPUPPCState *env);
> +void ppc_hash64_update_vrma(PowerPCCPU *cpu);
> +void ppc_hash64_update_rmls(PowerPCCPU *cpu);
>  #endif
> =20
>  /*
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 2ae718242a..29bd6f3654 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8975,8 +8975,8 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
>      env->spr[SPR_AMOR] =3D amor->default_value =3D 0xffffffffffffffffu=
ll;
> =20
>      /* Update some env bits based on new LPCR value */
> -    ppc_hash64_update_rmls(env);
> -    ppc_hash64_update_vrma(env);
> +    ppc_hash64_update_rmls(cpu);
> +    ppc_hash64_update_vrma(cpu);
> =20
>      /* Tell KVM that we're in PAPR mode */
>      if (kvm_enabled()) {
>=20
