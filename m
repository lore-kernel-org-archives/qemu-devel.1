Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZxl7-0008QF-6C
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZxl3-0006cx-Ve
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:16:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38486
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZxl3-0006c1-Mx
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:16:41 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-14-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <df7d8f89-1af4-4131-217d-000a25ba1fce@arm.com>
Date: Mon, 2 Jul 2018 13:16:36 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-14-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/20] kvm: arm64: Configure VTCR per VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On 29/06/18 12:15, Suzuki K Poulose wrote:
> We set VTCR_EL2 very early during the stage2 init and don't
> touch it ever. This is fine as we had a fixed IPA size. This
> patch changes the behavior to set the VTCR for a given VM,
> depending on its stage2 table. The common configuration for
> VTCR is still performed during the early init as we have to
> retain the hardware access flag update bits (VTCR_EL2_HA)
> per CPU (as they are only set for the CPUs which are capabile).

capable

> The bits defining the number of levels in the page table (SL0)
> and and the size of the Input address to the translation (T0SZ)
> are programmed for each VM upon entry to the guest.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Change since V2:
>  - Load VTCR for TLB operations
> ---
>  arch/arm64/include/asm/kvm_arm.h  | 19 +++++++++----------
>  arch/arm64/include/asm/kvm_asm.h  |  2 +-
>  arch/arm64/include/asm/kvm_host.h |  9 ++++++---
>  arch/arm64/include/asm/kvm_hyp.h  | 11 +++++++++++
>  arch/arm64/kvm/hyp/s2-setup.c     | 17 +----------------
>  5 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 11a7db0..b02c316 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -120,9 +120,7 @@
>  #define VTCR_EL2_IRGN0_WBWA	TCR_IRGN0_WBWA
>  #define VTCR_EL2_SL0_SHIFT	6
>  #define VTCR_EL2_SL0_MASK	(3 << VTCR_EL2_SL0_SHIFT)
> -#define VTCR_EL2_SL0_LVL1	(1 << VTCR_EL2_SL0_SHIFT)
>  #define VTCR_EL2_T0SZ_MASK	0x3f
> -#define VTCR_EL2_T0SZ_40B	24
>  #define VTCR_EL2_VS_SHIFT	19
>  #define VTCR_EL2_VS_8BIT	(0 << VTCR_EL2_VS_SHIFT)
>  #define VTCR_EL2_VS_16BIT	(1 << VTCR_EL2_VS_SHIFT)
> @@ -137,43 +135,44 @@
>   * VTCR_EL2.PS is extracted from ID_AA64MMFR0_EL1.PARange at boot time
>   * (see hyp-init.S).
>   *
> + * VTCR_EL2.SL0 and T0SZ are configured per VM at runtime before switching to
> + * the VM.
> + *
>   * Note that when using 4K pages, we concatenate two first level page tables
>   * together. With 16K pages, we concatenate 16 first level page tables.
>   *
>   */
>  
> -#define VTCR_EL2_T0SZ_IPA	VTCR_EL2_T0SZ_40B
>  #define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
>  				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_RES1)
> +#define VTCR_EL2_PRIVATE_MASK	(VTCR_EL2_SL0_MASK | VTCR_EL2_T0SZ_MASK)

What does "private" mean here? It really is the IPA configuration, so
I'd rather have a naming that reflects that.

>  #ifdef CONFIG_ARM64_64K_PAGES
>  /*
>   * Stage2 translation configuration:
>   * 64kB pages (TG0 = 1)
> - * 2 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
> +#define VTCR_EL2_TGRAN			VTCR_EL2_TG0_64K
>  #define VTCR_EL2_TGRAN_SL0_BASE		3UL
>  
>  #elif defined(CONFIG_ARM64_16K_PAGES)
>  /*
>   * Stage2 translation configuration:
>   * 16kB pages (TG0 = 2)
> - * 2 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
> +#define VTCR_EL2_TGRAN			VTCR_EL2_TG0_16K
>  #define VTCR_EL2_TGRAN_SL0_BASE		3UL
>  #else	/* 4K */
>  /*
>   * Stage2 translation configuration:
>   * 4kB pages (TG0 = 0)
> - * 3 level page tables (SL = 1)
>   */
> -#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
> +#define VTCR_EL2_TGRAN			VTCR_EL2_TG0_4K
>  #define VTCR_EL2_TGRAN_SL0_BASE		2UL
>  #endif
>  
> -#define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
> +#define VTCR_EL2_FLAGS		(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN)
> +
>  /*
>   * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
>   * Interestingly, it depends on the page size.
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 102b5a5..91372eb 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -72,7 +72,7 @@ extern void __vgic_v3_init_lrs(void);
>  
>  extern u32 __kvm_get_mdcr_el2(void);
>  
> -extern u32 __init_stage2_translation(void);
> +extern void __init_stage2_translation(void);
>  
>  /* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
>  #define __hyp_this_cpu_ptr(sym)						\
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index fe8777b..328f472 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -442,10 +442,13 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  
>  static inline void __cpu_init_stage2(void)
>  {
> -	u32 parange = kvm_call_hyp(__init_stage2_translation);
> +	u32 ps;
>  
> -	WARN_ONCE(parange < 40,
> -		  "PARange is %d bits, unsupported configuration!", parange);
> +	kvm_call_hyp(__init_stage2_translation);
> +	/* Sanity check for minimum IPA size support */
> +	ps = id_aa64mmfr0_parange_to_phys_shift(read_sysreg(id_aa64mmfr0_el1) & 0x7);
> +	WARN_ONCE(ps < 40,
> +		  "PARange is %d bits, unsupported configuration!", ps);
>  }
>  
>  /* Guest/host FPSIMD coordination helpers */
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 82f9994..3e8052d1 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -20,6 +20,7 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/kvm_host.h>
> +#include <asm/kvm_mmu.h>
>  #include <asm/sysreg.h>
>  
>  #define __hyp_text __section(.hyp.text) notrace
> @@ -158,6 +159,16 @@ void __noreturn __hyp_do_panic(unsigned long, ...);
>  /* Must be called from hyp code running at EL2 */
>  static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
>  {
> +	/*
> +	 * Configure the VTCR translation control bits
> +	 * for this VM.
> +	 */
> +	u64 vtcr = read_sysreg(vtcr_el2);
> +
> +	vtcr &= ~VTCR_EL2_PRIVATE_MASK;
> +	vtcr |= VTCR_EL2_SL0(kvm_stage2_levels(kvm)) |
> +		VTCR_EL2_T0SZ(kvm_phys_shift(kvm));
> +	write_sysreg(vtcr, vtcr_el2);

Can't we generate the whole vtcr value in one go, without reading it
back? Specially given that on patch 16, you're actually switching to a
per-VM variable, and it would make a lot of sense to start with that here.

>  	write_sysreg(kvm->arch.vttbr, vttbr_el2);
>  }
>  
> diff --git a/arch/arm64/kvm/hyp/s2-setup.c b/arch/arm64/kvm/hyp/s2-setup.c
> index 81094f1..6567315 100644
> --- a/arch/arm64/kvm/hyp/s2-setup.c
> +++ b/arch/arm64/kvm/hyp/s2-setup.c
> @@ -19,13 +19,11 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_hyp.h>
> -#include <asm/cpufeature.h>
>  
> -u32 __hyp_text __init_stage2_translation(void)
> +void __hyp_text __init_stage2_translation(void)
>  {
>  	u64 val = VTCR_EL2_FLAGS;
>  	u64 parange;
> -	u32 phys_shift;
>  	u64 tmp;
>  
>  	/*
> @@ -38,17 +36,6 @@ u32 __hyp_text __init_stage2_translation(void)
>  		parange = ID_AA64MMFR0_PARANGE_MAX;
>  	val |= parange << VTCR_EL2_PS_SHIFT;
>  
> -	/* Compute the actual PARange... */
> -	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
> -
> -	/*
> -	 * ... and clamp it to 40 bits, unless we have some braindead
> -	 * HW that implements less than that. In all cases, we'll
> -	 * return that value for the rest of the kernel to decide what
> -	 * to do.
> -	 */
> -	val |= VTCR_EL2_T0SZ(phys_shift > 40 ? 40 : phys_shift);
> -
>  	/*
>  	 * Check the availability of Hardware Access Flag / Dirty Bit
>  	 * Management in ID_AA64MMFR1_EL1 and enable the feature in VTCR_EL2.
> @@ -67,6 +54,4 @@ u32 __hyp_text __init_stage2_translation(void)
>  			VTCR_EL2_VS_8BIT;
>  
>  	write_sysreg(val, vtcr_el2);

And then most of the code here could run on a per-VM basis.

> -
> -	return phys_shift;
>  }
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
