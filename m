Received: from eggs.gnu.org ([2001:4830:134:3::10]:42155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZyw7-0000yV-7L
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZyw3-0002iy-7g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:32:11 -0400
Received: from foss.arm.com ([217.140.101.70]:39730)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZyw2-0002ih-UT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:32:07 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-17-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <98b1fa06-d026-52b2-09de-87ec1dfdbfb2@arm.com>
Date: Mon, 2 Jul 2018 14:32:02 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-17-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/20] kvm: arm64: Switch to per VM IPA
 limit
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
> Now that we can manage the stage2 page table per VM, switch the
> configuration details to per VM instance. We keep track of the
> IPA bits, number of page table levels and the VTCR bits (which
> depends on the IPA and the number of levels). While at it, remove
> unused pgd_lock field from kvm_arch for arm64.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h       | 14 ++++++++++++--
>  arch/arm64/include/asm/kvm_hyp.h        |  3 +--
>  arch/arm64/include/asm/kvm_mmu.h        | 20 ++++++++++++++++++--
>  arch/arm64/include/asm/stage2_pgtable.h |  1 -
>  virt/kvm/arm/mmu.c                      |  4 ++++
>  5 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 328f472..9a15860 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -61,13 +61,23 @@ struct kvm_arch {
>  	u64    vmid_gen;
>  	u32    vmid;
>  
> -	/* 1-level 2nd stage table and lock */
> -	spinlock_t pgd_lock;
> +	/* stage-2 page table */
>  	pgd_t *pgd;
>  
>  	/* VTTBR value associated with above pgd and vmid */
>  	u64    vttbr;
>  
> +	/* Private bits of VTCR_EL2 for this VM */
> +	u64    vtcr_private;

As I said in another email, this should become a full VTCR_EL2 copy.

> +	/* Size of the PA size for this guest */
> +	u8     phys_shift;
> +	/*
> +	 * Number of levels in page table. We could always calculate
> +	 * it from phys_shift above. We cache it for faster switches
> +	 * in stage2 page table helpers.
> +	 */
> +	u8     s2_levels;

And these two fields feel like they should be derived from the VTCR
itself, instead of being there on their own. Any chance you could look
into this?

> +
>  	/* The last vcpu id that ran on each physical CPU */
>  	int __percpu *last_vcpu_ran;
>  
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 3e8052d1..699f678 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -166,8 +166,7 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
>  	u64 vtcr = read_sysreg(vtcr_el2);
>  
>  	vtcr &= ~VTCR_EL2_PRIVATE_MASK;
> -	vtcr |= VTCR_EL2_SL0(kvm_stage2_levels(kvm)) |
> -		VTCR_EL2_T0SZ(kvm_phys_shift(kvm));
> +	vtcr |= kvm->arch.vtcr_private;
>  	write_sysreg(vtcr, vtcr_el2);
>  	write_sysreg(kvm->arch.vttbr, vttbr_el2);
>  }
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index f3fb05a3..a291cdc 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -143,9 +143,10 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>   */
>  #define KVM_PHYS_SHIFT	(40)
>  
> -#define kvm_phys_shift(kvm)		KVM_PHYS_SHIFT
> +#define kvm_phys_shift(kvm)		(kvm->arch.phys_shift)
>  #define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
>  #define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))
> +#define kvm_stage2_levels(kvm)		(kvm->arch.s2_levels)
>  
>  static inline bool kvm_page_empty(void *ptr)
>  {
> @@ -528,6 +529,18 @@ static inline u64 kvm_vttbr_baddr_mask(struct kvm *kvm)
>  
>  static inline void *stage2_alloc_pgd(struct kvm *kvm)
>  {
> +	u32 ipa, lvls;
> +
> +	/*
> +	 * Stage2 page table can support concatenation of (upto 16) tables
> +	 * at the entry level, thereby reducing the number of levels.
> +	 */
> +	ipa = kvm_phys_shift(kvm);
> +	lvls = stage2_pt_levels(ipa);
> +
> +	kvm->arch.s2_levels = lvls;
> +	kvm->arch.vtcr_private = VTCR_EL2_SL0(lvls) | TCR_T0SZ(ipa);
> +
>  	return alloc_pages_exact(stage2_pgd_size(kvm),
>  				 GFP_KERNEL | __GFP_ZERO);
>  }
> @@ -537,7 +550,10 @@ static inline u32 kvm_get_ipa_limit(void)
>  	return KVM_PHYS_SHIFT;
>  }
>  
> -static inline void kvm_config_stage2(struct kvm *kvm, u32 ipa_shift) {}
> +static inline void kvm_config_stage2(struct kvm *kvm, u32 ipa_shift)
> +{
> +	kvm->arch.phys_shift = ipa_shift;
> +}
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> index ffc37cc..91d7936 100644
> --- a/arch/arm64/include/asm/stage2_pgtable.h
> +++ b/arch/arm64/include/asm/stage2_pgtable.h
> @@ -65,7 +65,6 @@
>  #define __s2_pgd_ptrs(pa, lvls)	(1 << ((pa) - pt_levels_pgdir_shift((lvls))))
>  #define __s2_pgd_size(pa, lvls)	(__s2_pgd_ptrs((pa), (lvls)) * sizeof(pgd_t))
>  
> -#define kvm_stage2_levels(kvm)		stage2_pt_levels(kvm_phys_shift(kvm))
>  #define stage2_pgdir_shift(kvm)	\
>  		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
>  #define stage2_pgdir_size(kvm)		(_AC(1, UL) << stage2_pgdir_shift((kvm)))
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index a339e00..d7822e1 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -867,6 +867,10 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  		return -EINVAL;
>  	}
>  
> +	/* Make sure we have the stage2 configured for this VM */
> +	if (WARN_ON(!kvm_phys_shift(kvm)))

Can this be triggered from userspace?

> +		return -EINVAL;
> +
>  	/* Allocate the HW PGD, making sure that each page gets its own refcount */
>  	pgd = stage2_alloc_pgd(kvm);
>  	if (!pgd)
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
