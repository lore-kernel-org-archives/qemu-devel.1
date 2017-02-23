Received: from eggs.gnu.org ([2001:4830:134:3::10]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cgkzz-0001YF-HL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cgkzy-00012e-Hn
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:27:23 -0500
Message-ID: <1487824031.23895.8.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 23 Feb 2017 15:27:11 +1100
In-Reply-To: <20170223020936.29220-3-david@gibson.dropbear.id.au>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] target/ppc: Merge cpu_ppc_set_vhyp()
 with cpu_ppc_set_papr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org

On Thu, 2017-02-23 at 13:09 +1100, David Gibson wrote:
> cpu_ppc_set_papr() sets up various aspects of CPU state for use with
> PAPR
> paravirtualized guests.  However, it doesn't set the virtual
> hypervisor,
> so callers must also call cpu_ppc_set_vhyp() so that PAPR hypercalls
> are
> handled properly.  This is a bit silly, so fold setting the virtual
> hypervisor into cpu_ppc_set_papr().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_cpu_core.c     |  3 +--
>  target/ppc/cpu.h            |  3 +--
>  target/ppc/translate_init.c | 10 +++-------
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 55cd045..76563c4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -57,8 +57,7 @@ static void spapr_cpu_init(sPAPRMachineState
> *spapr, PowerPCCPU *cpu,
>      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>  
>      /* Enable PAPR mode in TCG or KVM */
> -    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> -    cpu_ppc_set_papr(cpu);
> +    cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>  
>      if (cpu->max_compat) {
>          Error *local_err = NULL;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 425e79d..f99bcae 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1300,8 +1300,7 @@ void store_booke_tcr (CPUPPCState *env,
> target_ulong val);
>  void store_booke_tsr (CPUPPCState *env, target_ulong val);
>  void ppc_tlb_invalidate_all (CPUPPCState *env);
>  void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
> -void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
> -void cpu_ppc_set_papr(PowerPCCPU *cpu);
> +void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
>  #endif
>  #endif
>  
> diff --git a/target/ppc/translate_init.c
> b/target/ppc/translate_init.c
> index be35cbd..a1405e9 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8835,18 +8835,14 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void
> *data)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> -
> -void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
> -{
> -    cpu->vhyp = vhyp;
> -}
> -
> -void cpu_ppc_set_papr(PowerPCCPU *cpu)
> +void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>  {
>      CPUPPCState *env = &cpu->env;
>      ppc_spr_t *lpcr = &env->spr_cb[SPR_LPCR];
>      ppc_spr_t *amor = &env->spr_cb[SPR_AMOR];
>  
> +    cpu->vhyp = vhyp;
> +
>      /* PAPR always has exception vectors in RAM not ROM. To ensure
> this,
>       * MSR[IP] should never be set.
>       *

Sounds Good

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
