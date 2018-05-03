Received: from eggs.gnu.org ([2001:4830:134:3::10]:53036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8KM-0003Fm-M8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8KH-00010B-Ip
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:06:54 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:36692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8KH-0000zd-Ac
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:06:49 -0400
Received: from player714.ha.ovh.net (unknown [10.109.120.16])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B142BF2D20
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:06:47 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d63a7712-8de6-15e9-acb7-4638ba834144@kaod.org>
Date: Thu, 3 May 2018 09:06:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: Add ppc_store_lpcr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On 05/03/2018 08:21 AM, David Gibson wrote:
> There are some fields in the cpu state which need to be updated when th=
e
> LPCR register is changed, which is done by ppc_hash64_update_rmls() and
> ppc_hash64_update_vrma().  Code which alters env->spr[SPR_LPCR] needs t=
o
> call them afterwards to make sure the state is up to date.
>=20
> That's easy to get wrong.  The normal way of dealing with sitautions li=
ke
> that is to use a helper which both updates the basic register value and=
 the
> derived state.
>=20
> So, do that.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Although, I am not sure mmu-hash64.c is the right file for the ppc_store_=
lpcr()
helper. This is minor.

C.

> ---
>  target/ppc/mmu-hash64.c     | 15 +++++++++++----
>  target/ppc/mmu-hash64.h     |  3 +--
>  target/ppc/translate_init.c |  6 +-----
>  3 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 7e0adecfd9..a1db20e3a8 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -942,7 +942,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, tar=
get_ulong ptex,
>      cpu->env.tlb_need_flush =3D TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL=
_FLUSH;
>  }
> =20
> -void ppc_hash64_update_rmls(PowerPCCPU *cpu)
> +static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      uint64_t lpcr =3D env->spr[SPR_LPCR];
> @@ -977,7 +977,7 @@ void ppc_hash64_update_rmls(PowerPCCPU *cpu)
>      }
>  }
> =20
> -void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> +static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      const PPCHash64SegmentPageSizes *sps =3D NULL;
> @@ -1028,9 +1028,9 @@ void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>      slb->sps =3D sps;
>  }
> =20
> -void helper_store_lpcr(CPUPPCState *env, target_ulong val)
> +void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>  {
> -    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    CPUPPCState *env =3D &cpu->env;
>      uint64_t lpcr =3D 0;
> =20
>      /* Filter out bits */
> @@ -1096,6 +1096,13 @@ void helper_store_lpcr(CPUPPCState *env, target_=
ulong val)
>      ppc_hash64_update_vrma(cpu);
>  }
> =20
> +void helper_store_lpcr(CPUPPCState *env, target_ulong val)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +
> +    ppc_store_lpcr(cpu, val);
> +}
> +
>  void ppc_hash64_init(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env =3D &cpu->env;
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index f6349ccdb3..53dcec5b93 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -17,8 +17,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
>                                 target_ulong pte0, target_ulong pte1);
>  unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
>                                            uint64_t pte0, uint64_t pte1=
);
> -void ppc_hash64_update_vrma(PowerPCCPU *cpu);
> -void ppc_hash64_update_rmls(PowerPCCPU *cpu);
> +void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
>  void ppc_hash64_init(PowerPCCPU *cpu);
>  void ppc_hash64_finalize(PowerPCCPU *cpu);
>  #endif
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c83c910a29..3fd380dad6 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8940,15 +8940,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtu=
alHypervisor *vhyp)
>      /* We should be followed by a CPU reset but update the active valu=
e
>       * just in case...
>       */
> -    env->spr[SPR_LPCR] =3D lpcr->default_value;
> +    ppc_store_lpcr(cpu, lpcr->default_value);
> =20
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
>      env->spr[SPR_AMOR] =3D amor->default_value =3D 0xffffffffffffffffu=
ll;
> =20
> -    /* Update some env bits based on new LPCR value */
> -    ppc_hash64_update_rmls(cpu);
> -    ppc_hash64_update_vrma(cpu);
> -
>      /* Tell KVM that we're in PAPR mode */
>      if (kvm_enabled()) {
>          kvmppc_set_papr(cpu);
>=20
