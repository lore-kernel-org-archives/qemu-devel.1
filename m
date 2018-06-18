Received: from eggs.gnu.org ([2001:4830:134:3::10]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUu6u-00047w-2v
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUu6q-0003qg-P1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:22:20 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:48000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUu6q-0003q7-EP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:22:16 -0400
Received: from player756.ha.ovh.net (unknown [10.109.105.36])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 771FD18990
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 15:22:14 +0200 (CEST)
Date: Mon, 18 Jun 2018 15:22:03 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180618152203.59158d68@bahia.lan>
In-Reply-To: <20180618063606.2513-2-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] target/ppc: Allow cpu compatiblity
 checks based on type, not instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On Mon, 18 Jun 2018 16:35:58 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> ppc_check_compat() is used in a number of places to check if a cpu object
> supports a certain compatiblity mode, subject to various constraints.
> 
> It takes a PowerPCCPU *, however it really only depends on the cpu's class.
> We have upcoming cases where it would be useful to make compatibility
> checks before we fully instantiate the cpu objects.
> 
> ppc_type_check_compat() will now make an equivalent check, but based on a
> CPU's QOM typename instead of an instantiated CPU object.
> 
> We make use of the new interface in several places in spapr, where we're
> essentially making a global check, rather than one specific to a particular
> cpu.  This avoids some ugly uses of first_cpu to grab a "representative"
> instance.
> 

Nice cleanup !

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c      | 10 ++++------
>  hw/ppc/spapr_caps.c | 19 +++++++++----------
>  target/ppc/compat.c | 27 +++++++++++++++++++++------
>  target/ppc/cpu.h    |  4 ++++
>  4 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index db0fb385d4..b0b94fc1f0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1616,8 +1616,8 @@ static void spapr_machine_reset(void)
>  
>      first_ppc_cpu = POWERPC_CPU(first_cpu);
>      if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
> -        ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> -                         spapr->max_compat_pvr)) {
> +        ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
>          /* If using KVM with radix mode available, VCPUs can be started
>           * without a HPT because KVM will start them in radix mode.
>           * Set the GR bit in PATB so that we know there is no HPT. */
> @@ -2520,7 +2520,6 @@ static void spapr_machine_init(MachineState *machine)
>      long load_limit, fw_size;
>      char *filename;
>      Error *resize_hpt_err = NULL;
> -    PowerPCCPU *first_ppc_cpu;
>  
>      msi_nonbroken = true;
>  
> @@ -2618,10 +2617,9 @@ static void spapr_machine_init(MachineState *machine)
>      /* init CPUs */
>      spapr_init_cpus(spapr);
>  
> -    first_ppc_cpu = POWERPC_CPU(first_cpu);
>      if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
> -        ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> -                         spapr->max_compat_pvr)) {
> +        ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
>          /* KVM and TCG always allow GTSE with radix... */
>          spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
>      }
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 00e43a9ba7..469f38f0ef 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -327,27 +327,26 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>  };
>  
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> -                                               CPUState *cs)
> +                                               const char *cputype)
>  {
>      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> -    PowerPCCPU *cpu = POWERPC_CPU(cs);
>      sPAPRCapabilities caps;
>  
>      caps = smc->default_caps;
>  
> -    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> -                          0, spapr->max_compat_pvr)) {
> +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_07,
> +                               0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>          caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>      }
>  
> -    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06_PLUS,
> -                          0, spapr->max_compat_pvr)) {
> +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_06_PLUS,
> +                               0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>      }
>  
> -    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
> -                          0, spapr->max_compat_pvr)) {
> +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_06,
> +                               0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_OFF;
>          caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_OFF;
>          caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
> @@ -384,7 +383,7 @@ int spapr_caps_post_migration(sPAPRMachineState *spapr)
>      sPAPRCapabilities dstcaps = spapr->eff;
>      sPAPRCapabilities srccaps;
>  
> -    srccaps = default_caps_with_cpu(spapr, first_cpu);
> +    srccaps = default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
>      for (i = 0; i < SPAPR_CAP_NUM; i++) {
>          /* If not default value then assume came in with the migration */
>          if (spapr->mig.caps[i] != spapr->def.caps[i]) {
> @@ -446,7 +445,7 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
>      int i;
>  
>      /* First compute the actual set of caps we're running with.. */
> -    default_caps = default_caps_with_cpu(spapr, first_cpu);
> +    default_caps = default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
>  
>      for (i = 0; i < SPAPR_CAP_NUM; i++) {
>          /* Store the defaults */
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index 807c906f68..7de4bf3122 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -105,17 +105,13 @@ static const CompatInfo *compat_by_pvr(uint32_t pvr)
>      return NULL;
>  }
>  
> -bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
> -                      uint32_t min_compat_pvr, uint32_t max_compat_pvr)
> +static bool pcc_compat(PowerPCCPUClass *pcc, uint32_t compat_pvr,
> +                       uint32_t min_compat_pvr, uint32_t max_compat_pvr)
>  {
> -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      const CompatInfo *compat = compat_by_pvr(compat_pvr);
>      const CompatInfo *min = compat_by_pvr(min_compat_pvr);
>      const CompatInfo *max = compat_by_pvr(max_compat_pvr);
>  
> -#if !defined(CONFIG_USER_ONLY)
> -    g_assert(cpu->vhyp);
> -#endif
>      g_assert(!min_compat_pvr || min);
>      g_assert(!max_compat_pvr || max);
>  
> @@ -134,6 +130,25 @@ bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
>      return true;
>  }
>  
> +bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
> +                      uint32_t min_compat_pvr, uint32_t max_compat_pvr)
> +{
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +
> +#if !defined(CONFIG_USER_ONLY)
> +    g_assert(cpu->vhyp);
> +#endif
> +
> +    return pcc_compat(pcc, compat_pvr, min_compat_pvr, max_compat_pvr);
> +}
> +
> +bool ppc_type_check_compat(const char *cputype, uint32_t compat_pvr,
> +                           uint32_t min_compat_pvr, uint32_t max_compat_pvr)
> +{
> +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(object_class_by_name(cputype));
> +    return pcc_compat(pcc, compat_pvr, min_compat_pvr, max_compat_pvr);
> +}
> +
>  void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
>  {
>      const CompatInfo *compat = compat_by_pvr(compat_pvr);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 874da6efbc..c7f3fb6b73 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1369,7 +1369,11 @@ static inline int cpu_mmu_index (CPUPPCState *env, bool ifetch)
>  #if defined(TARGET_PPC64)
>  bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
>                        uint32_t min_compat_pvr, uint32_t max_compat_pvr);
> +bool ppc_type_check_compat(const char *cputype, uint32_t compat_pvr,
> +                           uint32_t min_compat_pvr, uint32_t max_compat_pvr);
> +
>  void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
> +
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
>  #endif
