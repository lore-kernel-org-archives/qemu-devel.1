Received: from eggs.gnu.org ([2001:4830:134:3::10]:54436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YOa-0002B3-Bw
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YOX-0001Jy-57
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:56:20 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:55321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9YOW-0001Ig-UC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:56:17 -0400
Received: from player791.ha.ovh.net (unknown [10.109.122.75])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 53FEC13DA0
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:56:15 +0200 (CEST)
Date: Fri, 20 Apr 2018 17:56:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420175610.79dd9a9a@bahia.lan>
In-Reply-To: <20180417071722.9399-9-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-9-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 08/10] spapr: Clean up handling of
 LPCR power-saving exit bits
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

On Tue, 17 Apr 2018 17:17:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> To prevent spurious wakeups on cpus that are supposed to be disabled, we
> need to clear the LPCR bits which control certain wakeup events.
> spapr_cpu_reset() has separate cases here for boot and non-boot (initially
> inactive) cpus.  rtas_start_cpu() then turns the LPCR bits on when the
> non-boot cpus are activated.
> 
> But explicit checks against first_cpu are not how we usually do things:
> instead spapr_cpu_reset() generally sets things up for non-boot (inactive)
> cpus, then spapr_machine_reset() and/or rtas_start_cpu() override as
> necessary.
> 
> So, do that instead.  Because the LPCR activation is identical for boot
> cpus and non-boot cpus just activated with rtas_start_cpu() we can put the
> code common in spapr_cpu_set_entry_state().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Ok, ok, I hadn't seen this patch yet when I commented on patch 5 :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_cpu_core.c | 22 +++++++---------------
>  hw/ppc/spapr_rtas.c     |  4 ----
>  2 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ecd40dbf03..8be0265d04 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -52,28 +52,17 @@ static void spapr_cpu_reset(void *opaque)
>       * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
>       * real mode accesses, which thankfully defaults to 0 and isn't
>       * accessible in guest mode.
> +     *
> +     * Disable Power-saving mode Exit Cause exceptions for the CPU, so
> +     * we don't get spurious wakups before an RTAS start-cpu call.
>       */
> -    lpcr &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
> +    lpcr &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_pm);
>      lpcr |= LPCR_LPES0 | LPCR_LPES1;
>  
>      /* Set RMLS to the max (ie, 16G) */
>      lpcr &= ~LPCR_RMLS;
>      lpcr |= 1ull << LPCR_RMLS_SHIFT;
>  
> -    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> -     * CPU. The RTAS command start-cpu will enable them on secondaries.
> -     */
> -    if (cs == first_cpu) {
> -        lpcr |= pcc->lpcr_pm;
> -    }
> -
> -    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> -     * This can cause issues when rebooting the guest if a secondary
> -     * is awaken */
> -    if (cs != first_cpu) {
> -        lpcr &= ~pcc->lpcr_pm;
> -    }
> -
>      ppc_store_lpcr(cpu, lpcr);
>  
>      /* Set a full AMOR so guest can use the AMR as it sees fit */
> @@ -82,11 +71,14 @@ static void spapr_cpu_reset(void *opaque)
>  
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
>  {
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
>  
>      env->nip = SPAPR_ENTRY_POINT;
>      env->gpr[3] = r3;
>      CPU(cpu)->halted = 0;
> +    /* Enable Power-saving mode Exit Cause exceptions */
> +    ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
>  }
>  
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d79aa44467..e720d54eb5 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -162,7 +162,6 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
>      if (cpu != NULL) {
>          CPUState *cs = CPU(cpu);
>          CPUPPCState *env = &cpu->env;
> -        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>  
>          if (!cs->halted) {
>              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> @@ -178,9 +177,6 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
>  
>          env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
>  
> -        /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
> -        env->spr[SPR_LPCR] |= pcc->lpcr_pm;
> -
>          spapr_cpu_set_endianness(cpu);
>          spapr_cpu_update_tb_offset(cpu);
>  
