Received: from eggs.gnu.org ([2001:4830:134:3::10]:56347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YRD-0004jK-Qr
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YRB-0004mf-8p
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:59:03 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:49743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9YRB-0004lH-30
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:59:01 -0400
Received: from player696.ha.ovh.net (unknown [10.109.105.86])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 85041B9BF9
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:58:59 +0200 (CEST)
Date: Fri, 20 Apr 2018 17:58:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420175855.58f548a6@bahia.lan>
In-Reply-To: <20180417071722.9399-11-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-11-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 10/10] spapr: Move PAPR specific
 cpu logic to pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 17 Apr 2018 17:17:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> cpu_ppc_set_papr() does three things: 1) it sets up the virtual hypervisor
> interface, 2) it prevents the cpu from ever entering hypervisor mode and
> 3) it tells KVM that we're emulating a cpu in PAPR mode.
> 
> (1) & (2) make sense for any virtual hypervisor (if one ever exists).  (3)
> belongs more properly in the machine type specific to a PAPR guest.
> 
> While we're at it, remove an unnecessary test on kvm_enabled() by making
> kvmppc_set_papr() a safe no-op on non-KVM.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_cpu_core.c     | 4 ++--
>  target/ppc/cpu.h            | 2 +-
>  target/ppc/kvm.c            | 4 ++++
>  target/ppc/translate_init.c | 7 +------
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 8be0265d04..0a668b8954 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -94,8 +94,8 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>  
> -    /* Enable PAPR mode in TCG or KVM */
> -    cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> +    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> +    kvmppc_set_papr(cpu);
>  
>      qemu_register_reset(spapr_cpu_reset, cpu);
>  }
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8c9e03f54d..740939a085 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1331,7 +1331,7 @@ void store_booke_tcr (CPUPPCState *env, target_ulong val);
>  void store_booke_tsr (CPUPPCState *env, target_ulong val);
>  void ppc_tlb_invalidate_all (CPUPPCState *env);
>  void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
> -void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
> +void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
>  #endif
>  #endif
>  
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 51177a8e00..e4341d6ff7 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2090,6 +2090,10 @@ void kvmppc_set_papr(PowerPCCPU *cpu)
>      CPUState *cs = CPU(cpu);
>      int ret;
>  
> +    if (!kvm_enabled()) {
> +        return;
> +    }
> +
>      ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_PAPR, 0);
>      if (ret) {
>          error_report("This vCPU type or KVM version does not support PAPR");
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index bb5559d799..95e8dba97a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8864,7 +8864,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> -void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
> +void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>  {
>      CPUPPCState *env = &cpu->env;
>  
> @@ -8875,11 +8875,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>       * hypervisor mode itself
>       */
>      env->msr_mask &= ~MSR_HVB;
> -
> -    /* Tell KVM that we're in PAPR mode */
> -    if (kvm_enabled()) {
> -        kvmppc_set_papr(cpu);
> -    }
>  }
>  
>  #endif /* !defined(CONFIG_USER_ONLY) */
