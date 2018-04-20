Received: from eggs.gnu.org ([2001:4830:134:3::10]:45980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YBb-0001OT-F8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9YBY-0005oc-5V
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:42:55 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:43054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9YBX-0005nF-Ra
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:42:52 -0400
Received: from player696.ha.ovh.net (unknown [10.109.108.17])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id AFC4412EB22
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 17:42:50 +0200 (CEST)
Date: Fri, 20 Apr 2018 17:42:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180420174245.12713a5e@bahia.lan>
In-Reply-To: <20180417071722.9399-6-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-6-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 05/10] spapr: Move PAPR mode
 register initialization to spapr code
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

On Tue, 17 Apr 2018 17:17:17 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> cpu_ppc_set_papr() has code to make sure the LPCR and AMOR (hypervisor
> privileged registers) have values which will make TCG behave correctly for
> paravirtualized guests, where we don't emulate the cpu when in hypervisor
> mode.
> 
> It does this by mangling the default values of the SPRs, so that they will
> be set correctly at reset time.  Manipulating usually-static parameters of
> the cpu model like this is kind of ugly, especially since the values used
> really have more to do with the platform than the cpu.
> 
> The spapr code already has places for PAPR specific initializations of
> register state, so move the handling of LPCR and AMOR to there.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_cpu_core.c     | 36 +++++++++++++++++++++++++++++++++++-
>  target/ppc/translate_init.c | 39 ---------------------------------------
>  2 files changed, 35 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2aab6ccd15..9080664ec1 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +    target_ulong lpcr;
>  
>      cpu_reset(cs);
>  
> @@ -41,13 +42,46 @@ static void spapr_cpu_reset(void *opaque)
>       * using an RTAS call */
>      cs->halted = 1;
>  
> +    lpcr = env->spr[SPR_LPCR];
> +
> +    /* Set emulated LPCR to not send interrupts to hypervisor. Note that
> +     * under KVM, the actual HW LPCR will be set differently by KVM itself,
> +     * the settings below ensure proper operations with TCG in absence of
> +     * a real hypervisor.
> +     *
> +     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
> +     * real mode accesses, which thankfully defaults to 0 and isn't
> +     * accessible in guest mode.
> +     */
> +    lpcr &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
> +    lpcr |= LPCR_LPES0 | LPCR_LPES1;
> +
> +    /* Set RMLS to the max (ie, 16G) */
> +    lpcr &= ~LPCR_RMLS;
> +    lpcr |= 1ull << LPCR_RMLS_SHIFT;
> +
> +    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> +     * CPU. The RTAS command start-cpu will enable them on secondaries.
> +     */
> +    if (cs == first_cpu) {
> +        lpcr |= pcc->lpcr_pm;
> +    }
> +
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
>       * This can cause issues when rebooting the guest if a secondary
>       * is awaken */
>      if (cs != first_cpu) {
> -        env->spr[SPR_LPCR] &= ~pcc->lpcr_pm;
> +        lpcr &= ~pcc->lpcr_pm;
>      }
>  

Maybe fold these into a single if-else with a consolidated comment ?

    /* Only enable Power-saving mode Exit Cause exceptions on the boot
     * CPU and disable it for secondaries because it is known to cause
     * issues if a secondary is awaken too early when rebooting the guest.
     * The RTAS command start-cpu will enable exceptions on secondaries.
     */
    if (cs == first_cpu) {
        lpcr |= pcc->lpcr_pm;
    } else {
        lpcr &= ~pcc->lpcr_pm;
    }

Anyway, the patch looks good and makes cpu_ppc_set_papr() a lot clearer.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    env->spr[SPR_LPCR] = lpcr;
> +
> +    /* Set a full AMOR so guest can use the AMR as it sees fit */
> +    env->spr[SPR_AMOR] = 0xffffffffffffffffull;
> +
> +    /* Update some env bits based on new LPCR value */
> +    ppc_hash64_update_rmls(cpu);
> +    ppc_hash64_update_vrma(cpu);
>  }
>  
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 14f346f441..5e89901149 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8866,11 +8866,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>  #if !defined(CONFIG_USER_ONLY)
>  void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>  {
> -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
> -    ppc_spr_t *lpcr = &env->spr_cb[SPR_LPCR];
> -    ppc_spr_t *amor = &env->spr_cb[SPR_AMOR];
> -    CPUState *cs = CPU(cpu);
>  
>      cpu->vhyp = vhyp;
>  
> @@ -8881,41 +8877,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
>       */
>      env->msr_mask &= ~((1ull << MSR_EP) | MSR_HVB);
>  
> -    /* Set emulated LPCR to not send interrupts to hypervisor. Note that
> -     * under KVM, the actual HW LPCR will be set differently by KVM itself,
> -     * the settings below ensure proper operations with TCG in absence of
> -     * a real hypervisor.
> -     *
> -     * Clearing VPM0 will also cause us to use RMOR in mmu-hash64.c for
> -     * real mode accesses, which thankfully defaults to 0 and isn't
> -     * accessible in guest mode.
> -     */
> -    lpcr->default_value &= ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV);
> -    lpcr->default_value |= LPCR_LPES0 | LPCR_LPES1;
> -
> -    /* Set RMLS to the max (ie, 16G) */
> -    lpcr->default_value &= ~LPCR_RMLS;
> -    lpcr->default_value |= 1ull << LPCR_RMLS_SHIFT;
> -
> -    /* Only enable Power-saving mode Exit Cause exceptions on the boot
> -     * CPU. The RTAS command start-cpu will enable them on secondaries.
> -     */
> -    if (cs == first_cpu) {
> -        lpcr->default_value |= pcc->lpcr_pm;
> -    }
> -
> -    /* We should be followed by a CPU reset but update the active value
> -     * just in case...
> -     */
> -    env->spr[SPR_LPCR] = lpcr->default_value;
> -
> -    /* Set a full AMOR so guest can use the AMR as it sees fit */
> -    env->spr[SPR_AMOR] = amor->default_value = 0xffffffffffffffffull;
> -
> -    /* Update some env bits based on new LPCR value */
> -    ppc_hash64_update_rmls(cpu);
> -    ppc_hash64_update_vrma(cpu);
> -
>      /* Tell KVM that we're in PAPR mode */
>      if (kvm_enabled()) {
>          kvmppc_set_papr(cpu);
