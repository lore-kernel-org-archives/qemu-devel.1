Received: from eggs.gnu.org ([2001:4830:134:3::10]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEDYh-0006Ip-QT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fEDYe-0003Qx-Ne
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:42:03 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fEDYe-0003QZ-Gv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:42:00 -0400
Received: from player760.ha.ovh.net (unknown [10.109.108.30])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id E9A12117E5
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 14:41:58 +0200 (CEST)
Date: Thu, 3 May 2018 14:41:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180503144150.51f221a7@bahia.lan>
In-Reply-To: <20180503062145.17899-2-david@gibson.dropbear.id.au>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: Add ppc_store_lpcr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On Thu,  3 May 2018 16:21:38 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> There are some fields in the cpu state which need to be updated when the
> LPCR register is changed, which is done by ppc_hash64_update_rmls() and
> ppc_hash64_update_vrma().  Code which alters env->spr[SPR_LPCR] needs to
> call them afterwards to make sure the state is up to date.
> 
> That's easy to get wrong.  The normal way of dealing with sitautions like
> that is to use a helper which both updates the basic register value and the
> derived state.
> 
> So, do that.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/mmu-hash64.c     | 15 +++++++++++----
>  target/ppc/mmu-hash64.h     |  3 +--
>  target/ppc/translate_init.c |  6 +-----
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 7e0adecfd9..a1db20e3a8 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -942,7 +942,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
>      cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
>  }
>  
> -void ppc_hash64_update_rmls(PowerPCCPU *cpu)
> +static void ppc_hash64_update_rmls(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env = &cpu->env;
>      uint64_t lpcr = env->spr[SPR_LPCR];
> @@ -977,7 +977,7 @@ void ppc_hash64_update_rmls(PowerPCCPU *cpu)
>      }
>  }
>  
> -void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> +static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env = &cpu->env;
>      const PPCHash64SegmentPageSizes *sps = NULL;
> @@ -1028,9 +1028,9 @@ void ppc_hash64_update_vrma(PowerPCCPU *cpu)
>      slb->sps = sps;
>  }
>  
> -void helper_store_lpcr(CPUPPCState *env, target_ulong val)
> +void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>  {
> -    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +    CPUPPCState *env = &cpu->env;
>      uint64_t lpcr = 0;
>  
>      /* Filter out bits */
> @@ -1096,6 +1096,13 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
>      ppc_hash64_update_vrma(cpu);
>  }
>  
> +void helper_store_lpcr(CPUPPCState *env, target_ulong val)
> +{
> +    PowerPCCPU *cpu = ppc_env_get_cpu(env);
> +
> +    ppc_store_lpcr(cpu, val);
> +}
> +
>  void ppc_hash64_init(PowerPCCPU *cpu)
>  {
>      CPUPPCState *env = &cpu->env;
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index f6349ccdb3..53dcec5b93 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -17,8 +17,7 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu,
>                                 target_ulong pte0, target_ulong pte1);
>  unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *cpu,
>                                            uint64_t pte0, uint64_t pte1);
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
> @@ -8940,15 +8940,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>      /* We should be followed by a CPU reset but update the active value
>       * just in case...
>       */
> -    env->spr[SPR_LPCR] = lpcr->default_value;
> +    ppc_store_lpcr(cpu, lpcr->default_value);
>  
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
>      env->spr[SPR_AMOR] = amor->default_value = 0xffffffffffffffffull;
>  
> -    /* Update some env bits based on new LPCR value */
> -    ppc_hash64_update_rmls(cpu);
> -    ppc_hash64_update_vrma(cpu);
> -
>      /* Tell KVM that we're in PAPR mode */
>      if (kvm_enabled()) {
>          kvmppc_set_papr(cpu);
