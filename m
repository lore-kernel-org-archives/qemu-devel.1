Received: from eggs.gnu.org ([2001:4830:134:3::10]:58199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZvom-0003mJ-9V
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZvoi-0001bY-TI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:12:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35842
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZvoi-0001ay-Cc
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:12:20 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-8-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <6a51d7dd-7bbe-5ea5-4498-26b5e290d9a6@arm.com>
Date: Mon, 2 Jul 2018 11:12:15 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-8-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/20] kvm: arm/arm64: Prepare for VM
 specific stage2 translations
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
> Right now the stage2 page table for a VM is hard coded, assuming
> an IPA of 40bits. As we are about to add support for per VM IPA,
> prepare the stage2 page table helpers to accept the kvm instance
> to make the right decision for the VM. No functional changes.
> Adds stage2_pgd_size(kvm) to replace S2_PGD_SIZE. Also, moves
> some of the definitions dependent on kvm instance to asm/kvm_mmu.h
> for arm32. In that process drop the _AC() specifier constants
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Update commit description abuot the movement to asm/kvm_mmu.h
>    for arm32
>  - Drop _AC() specifiers
> ---
>  arch/arm/include/asm/kvm_arm.h                |   3 +-
>  arch/arm/include/asm/kvm_mmu.h                |  15 +++-
>  arch/arm/include/asm/stage2_pgtable.h         |  42 ++++-----
>  arch/arm64/include/asm/kvm_mmu.h              |   7 +-
>  arch/arm64/include/asm/stage2_pgtable-nopmd.h |  18 ++--
>  arch/arm64/include/asm/stage2_pgtable-nopud.h |  16 ++--
>  arch/arm64/include/asm/stage2_pgtable.h       |  49 ++++++-----
>  virt/kvm/arm/arm.c                            |   2 +-
>  virt/kvm/arm/mmu.c                            | 119 +++++++++++++-------------
>  virt/kvm/arm/vgic/vgic-kvm-device.c           |   2 +-
>  10 files changed, 148 insertions(+), 125 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
> index 3ab8b37..c3f1f9b 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -133,8 +133,7 @@
>   * space.
>   */
>  #define KVM_PHYS_SHIFT	(40)
> -#define KVM_PHYS_SIZE	(_AC(1, ULL) << KVM_PHYS_SHIFT)
> -#define KVM_PHYS_MASK	(KVM_PHYS_SIZE - _AC(1, ULL))
> +
>  #define PTRS_PER_S2_PGD	(_AC(1, ULL) << (KVM_PHYS_SHIFT - 30))
>  
>  /* Virtualization Translation Control Register (VTCR) bits */
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 8553d68..f36eb20 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -36,15 +36,19 @@
>  	})
>  
>  /*
> - * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation levels.
> + * kvm_mmu_cache_min_pages() is the number of stage2 page
> + * table translation levels, excluding the top level, for
> + * the given VM. Since we have a 3 level page-table, this
> + * is fixed.

I find this comment quite confusing: number of levels, but excluding the
top one? The original one was just as bad, to be honest.

Can't we just say: "kvm_mmu_cache_min_page() is the number of pages
required to install a stage-2 translation"?

>   */
> -#define KVM_MMU_CACHE_MIN_PAGES	2
> +#define kvm_mmu_cache_min_pages(kvm)	2
>  
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/highmem.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cputype.h>
> +#include <asm/kvm_arm.h>
>  #include <asm/kvm_hyp.h>
>  #include <asm/pgalloc.h>
>  #include <asm/stage2_pgtable.h>
> @@ -52,6 +56,13 @@
>  /* Ensure compatibility with arm64 */
>  #define VA_BITS			32
>  
> +#define kvm_phys_shift(kvm)		KVM_PHYS_SHIFT
> +#define kvm_phys_size(kvm)		(1ULL << kvm_phys_shift(kvm))
> +#define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - 1ULL)
> +#define kvm_vttbr_baddr_mask(kvm)	VTTBR_BADDR_MASK
> +
> +#define stage2_pgd_size(kvm)		(PTRS_PER_S2_PGD * sizeof(pgd_t))
> +
>  int create_hyp_mappings(void *from, void *to, pgprot_t prot);
>  int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
>  			   void __iomem **kaddr,
> diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
> index 460d616..e22ae94 100644
> --- a/arch/arm/include/asm/stage2_pgtable.h
> +++ b/arch/arm/include/asm/stage2_pgtable.h
> @@ -19,43 +19,45 @@
>  #ifndef __ARM_S2_PGTABLE_H_
>  #define __ARM_S2_PGTABLE_H_
>  
> -#define stage2_pgd_none(pgd)			pgd_none(pgd)
> -#define stage2_pgd_clear(pgd)			pgd_clear(pgd)
> -#define stage2_pgd_present(pgd)			pgd_present(pgd)
> -#define stage2_pgd_populate(pgd, pud)		pgd_populate(NULL, pgd, pud)
> -#define stage2_pud_offset(pgd, address)		pud_offset(pgd, address)
> -#define stage2_pud_free(pud)			pud_free(NULL, pud)
> +#define stage2_pgd_none(kvm, pgd)		pgd_none(pgd)
> +#define stage2_pgd_clear(kvm, pgd)		pgd_clear(pgd)
> +#define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
> +#define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
> +#define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
> +#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
>  
> -#define stage2_pud_none(pud)			pud_none(pud)
> -#define stage2_pud_clear(pud)			pud_clear(pud)
> -#define stage2_pud_present(pud)			pud_present(pud)
> -#define stage2_pud_populate(pud, pmd)		pud_populate(NULL, pud, pmd)
> -#define stage2_pmd_offset(pud, address)		pmd_offset(pud, address)
> -#define stage2_pmd_free(pmd)			pmd_free(NULL, pmd)
> +#define stage2_pud_none(kvm, pud)		pud_none(pud)
> +#define stage2_pud_clear(kvm, pud)		pud_clear(pud)
> +#define stage2_pud_present(kvm, pud)		pud_present(pud)
> +#define stage2_pud_populate(kvm, pud, pmd)	pud_populate(NULL, pud, pmd)
> +#define stage2_pmd_offset(kvm, pud, address)	pmd_offset(pud, address)
> +#define stage2_pmd_free(kvm, pmd)		pmd_free(NULL, pmd)
>  
> -#define stage2_pud_huge(pud)			pud_huge(pud)
> +#define stage2_pud_huge(kvm, pud)		pud_huge(pud)
>  
>  /* Open coded p*d_addr_end that can deal with 64bit addresses */
> -static inline phys_addr_t stage2_pgd_addr_end(phys_addr_t addr, phys_addr_t end)
> +static inline phys_addr_t
> +stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
>  
>  	return (boundary - 1 < end - 1) ? boundary : end;
>  }
>  
> -#define stage2_pud_addr_end(addr, end)		(end)
> +#define stage2_pud_addr_end(kvm, addr, end)	(end)
>  
> -static inline phys_addr_t stage2_pmd_addr_end(phys_addr_t addr, phys_addr_t end)
> +static inline phys_addr_t
> +stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t boundary = (addr + PMD_SIZE) & PMD_MASK;
>  
>  	return (boundary - 1 < end - 1) ? boundary : end;
>  }
>  
> -#define stage2_pgd_index(addr)				pgd_index(addr)
> +#define stage2_pgd_index(kvm, addr)		pgd_index(addr)
>  
> -#define stage2_pte_table_empty(ptep)			kvm_page_empty(ptep)
> -#define stage2_pmd_table_empty(pmdp)			kvm_page_empty(pmdp)
> -#define stage2_pud_table_empty(pudp)			false
> +#define stage2_pte_table_empty(kvm, ptep)	kvm_page_empty(ptep)
> +#define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
> +#define stage2_pud_table_empty(kvm, pudp)	false
>  
>  #endif	/* __ARM_S2_PGTABLE_H_ */
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index fb9a712..5da8f52 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -141,8 +141,11 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>   * We currently only support a 40bit IPA.
>   */
>  #define KVM_PHYS_SHIFT	(40)
> -#define KVM_PHYS_SIZE	(1UL << KVM_PHYS_SHIFT)
> -#define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1UL)
> +
> +#define kvm_phys_shift(kvm)		KVM_PHYS_SHIFT
> +#define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
> +#define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))
> +#define kvm_vttbr_baddr_mask(kvm)	VTTBR_BADDR_MASK
>  
>  #include <asm/stage2_pgtable.h>
>  
> diff --git a/arch/arm64/include/asm/stage2_pgtable-nopmd.h b/arch/arm64/include/asm/stage2_pgtable-nopmd.h
> index 2656a0f..0280ded 100644
> --- a/arch/arm64/include/asm/stage2_pgtable-nopmd.h
> +++ b/arch/arm64/include/asm/stage2_pgtable-nopmd.h
> @@ -26,17 +26,17 @@
>  #define S2_PMD_SIZE		(1UL << S2_PMD_SHIFT)
>  #define S2_PMD_MASK		(~(S2_PMD_SIZE-1))
>  
> -#define stage2_pud_none(pud)			(0)
> -#define stage2_pud_present(pud)			(1)
> -#define stage2_pud_clear(pud)			do { } while (0)
> -#define stage2_pud_populate(pud, pmd)		do { } while (0)
> -#define stage2_pmd_offset(pud, address)		((pmd_t *)(pud))
> +#define stage2_pud_none(kvm, pud)		(0)
> +#define stage2_pud_present(kvm, pud)		(1)
> +#define stage2_pud_clear(kvm, pud)		do { } while (0)
> +#define stage2_pud_populate(kvm, pud, pmd)	do { } while (0)
> +#define stage2_pmd_offset(kvm, pud, address)	((pmd_t *)(pud))
>  
> -#define stage2_pmd_free(pmd)			do { } while (0)
> +#define stage2_pmd_free(kvm, pmd)		do { } while (0)
>  
> -#define stage2_pmd_addr_end(addr, end)		(end)
> +#define stage2_pmd_addr_end(kvm, addr, end)	(end)
>  
> -#define stage2_pud_huge(pud)			(0)
> -#define stage2_pmd_table_empty(pmdp)		(0)
> +#define stage2_pud_huge(kvm, pud)		(0)
> +#define stage2_pmd_table_empty(kvm, pmdp)	(0)
>  
>  #endif
> diff --git a/arch/arm64/include/asm/stage2_pgtable-nopud.h b/arch/arm64/include/asm/stage2_pgtable-nopud.h
> index 5ee87b5..cd6304e 100644
> --- a/arch/arm64/include/asm/stage2_pgtable-nopud.h
> +++ b/arch/arm64/include/asm/stage2_pgtable-nopud.h
> @@ -24,16 +24,16 @@
>  #define S2_PUD_SIZE		(_AC(1, UL) << S2_PUD_SHIFT)
>  #define S2_PUD_MASK		(~(S2_PUD_SIZE-1))
>  
> -#define stage2_pgd_none(pgd)			(0)
> -#define stage2_pgd_present(pgd)			(1)
> -#define stage2_pgd_clear(pgd)			do { } while (0)
> -#define stage2_pgd_populate(pgd, pud)	do { } while (0)
> +#define stage2_pgd_none(kvm, pgd)		(0)
> +#define stage2_pgd_present(kvm, pgd)		(1)
> +#define stage2_pgd_clear(kvm, pgd)		do { } while (0)
> +#define stage2_pgd_populate(kvm, pgd, pud)	do { } while (0)
>  
> -#define stage2_pud_offset(pgd, address)		((pud_t *)(pgd))
> +#define stage2_pud_offset(kvm, pgd, address)	((pud_t *)(pgd))
>  
> -#define stage2_pud_free(x)			do { } while (0)
> +#define stage2_pud_free(kvm, x)			do { } while (0)
>  
> -#define stage2_pud_addr_end(addr, end)		(end)
> -#define stage2_pud_table_empty(pmdp)		(0)
> +#define stage2_pud_addr_end(kvm, addr, end)	(end)
> +#define stage2_pud_table_empty(kvm, pmdp)	(0)
>  
>  #endif
> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> index 8b68099..057a405 100644
> --- a/arch/arm64/include/asm/stage2_pgtable.h
> +++ b/arch/arm64/include/asm/stage2_pgtable.h
> @@ -65,10 +65,10 @@
>  #define PTRS_PER_S2_PGD			(1 << (KVM_PHYS_SHIFT - S2_PGDIR_SHIFT))
>  
>  /*
> - * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation
> + * kvm_mmmu_cache_min_pages is the number of stage2 page table translation
>   * levels in addition to the PGD.
>   */
> -#define KVM_MMU_CACHE_MIN_PAGES		(STAGE2_PGTABLE_LEVELS - 1)
> +#define kvm_mmu_cache_min_pages(kvm)	(STAGE2_PGTABLE_LEVELS - 1)

Same comment as for the 32bit case.

>  
>  
>  #if STAGE2_PGTABLE_LEVELS > 3
> @@ -77,16 +77,17 @@
>  #define S2_PUD_SIZE			(_AC(1, UL) << S2_PUD_SHIFT)
>  #define S2_PUD_MASK			(~(S2_PUD_SIZE - 1))
>  
> -#define stage2_pgd_none(pgd)				pgd_none(pgd)
> -#define stage2_pgd_clear(pgd)				pgd_clear(pgd)
> -#define stage2_pgd_present(pgd)				pgd_present(pgd)
> -#define stage2_pgd_populate(pgd, pud)			pgd_populate(NULL, pgd, pud)
> -#define stage2_pud_offset(pgd, address)			pud_offset(pgd, address)
> -#define stage2_pud_free(pud)				pud_free(NULL, pud)
> +#define stage2_pgd_none(kvm, pgd)		pgd_none(pgd)
> +#define stage2_pgd_clear(kvm, pgd)		pgd_clear(pgd)
> +#define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
> +#define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
> +#define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
> +#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
>  
> -#define stage2_pud_table_empty(pudp)			kvm_page_empty(pudp)
> +#define stage2_pud_table_empty(kvm, pudp)	kvm_page_empty(pudp)
>  
> -static inline phys_addr_t stage2_pud_addr_end(phys_addr_t addr, phys_addr_t end)
> +static inline phys_addr_t
> +stage2_pud_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t boundary = (addr + S2_PUD_SIZE) & S2_PUD_MASK;
>  
> @@ -102,17 +103,18 @@ static inline phys_addr_t stage2_pud_addr_end(phys_addr_t addr, phys_addr_t end)
>  #define S2_PMD_SIZE			(_AC(1, UL) << S2_PMD_SHIFT)
>  #define S2_PMD_MASK			(~(S2_PMD_SIZE - 1))
>  
> -#define stage2_pud_none(pud)				pud_none(pud)
> -#define stage2_pud_clear(pud)				pud_clear(pud)
> -#define stage2_pud_present(pud)				pud_present(pud)
> -#define stage2_pud_populate(pud, pmd)			pud_populate(NULL, pud, pmd)
> -#define stage2_pmd_offset(pud, address)			pmd_offset(pud, address)
> -#define stage2_pmd_free(pmd)				pmd_free(NULL, pmd)
> +#define stage2_pud_none(kvm, pud)		pud_none(pud)
> +#define stage2_pud_clear(kvm, pud)		pud_clear(pud)
> +#define stage2_pud_present(kvm, pud)		pud_present(pud)
> +#define stage2_pud_populate(kvm, pud, pmd)	pud_populate(NULL, pud, pmd)
> +#define stage2_pmd_offset(kvm, pud, address)	pmd_offset(pud, address)
> +#define stage2_pmd_free(kvm, pmd)		pmd_free(NULL, pmd)
>  
> -#define stage2_pud_huge(pud)				pud_huge(pud)
> -#define stage2_pmd_table_empty(pmdp)			kvm_page_empty(pmdp)
> +#define stage2_pud_huge(kvm, pud)		pud_huge(pud)
> +#define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
>  
> -static inline phys_addr_t stage2_pmd_addr_end(phys_addr_t addr, phys_addr_t end)
> +static inline phys_addr_t
> +stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t boundary = (addr + S2_PMD_SIZE) & S2_PMD_MASK;
>  
> @@ -121,7 +123,7 @@ static inline phys_addr_t stage2_pmd_addr_end(phys_addr_t addr, phys_addr_t end)
>  
>  #endif		/* STAGE2_PGTABLE_LEVELS > 2 */
>  
> -#define stage2_pte_table_empty(ptep)			kvm_page_empty(ptep)
> +#define stage2_pte_table_empty(kvm, ptep)	kvm_page_empty(ptep)
>  
>  #if STAGE2_PGTABLE_LEVELS == 2
>  #include <asm/stage2_pgtable-nopmd.h>
> @@ -129,10 +131,13 @@ static inline phys_addr_t stage2_pmd_addr_end(phys_addr_t addr, phys_addr_t end)
>  #include <asm/stage2_pgtable-nopud.h>
>  #endif
>  
> +#define stage2_pgd_size(kvm)	(PTRS_PER_S2_PGD * sizeof(pgd_t))
>  
> -#define stage2_pgd_index(addr)				(((addr) >> S2_PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
> +#define stage2_pgd_index(kvm, addr) \
> +	(((addr) >> S2_PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
>  
> -static inline phys_addr_t stage2_pgd_addr_end(phys_addr_t addr, phys_addr_t end)
> +static inline phys_addr_t
> +stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
>  	phys_addr_t boundary = (addr + S2_PGDIR_SIZE) & S2_PGDIR_MASK;
>  
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 04e554c..d2637bb 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -538,7 +538,7 @@ static void update_vttbr(struct kvm *kvm)
>  
>  	/* update vttbr to be used with the new vmid */
>  	pgd_phys = virt_to_phys(kvm->arch.pgd);
> -	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
> +	BUG_ON(pgd_phys & ~kvm_vttbr_baddr_mask(kvm));
>  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
>  	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
>  
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 308171c..82dd571 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -45,7 +45,6 @@ static phys_addr_t hyp_idmap_vector;
>  
>  static unsigned long io_map_base;
>  
> -#define S2_PGD_SIZE	(PTRS_PER_S2_PGD * sizeof(pgd_t))
>  #define hyp_pgd_order get_order(PTRS_PER_PGD * sizeof(pgd_t))
>  
>  #define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
> @@ -150,20 +149,20 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
>  
>  static void clear_stage2_pgd_entry(struct kvm *kvm, pgd_t *pgd, phys_addr_t addr)
>  {
> -	pud_t *pud_table __maybe_unused = stage2_pud_offset(pgd, 0UL);
> -	stage2_pgd_clear(pgd);
> +	pud_t *pud_table __maybe_unused = stage2_pud_offset(kvm, pgd, 0UL);
> +	stage2_pgd_clear(kvm, pgd);
>  	kvm_tlb_flush_vmid_ipa(kvm, addr);
> -	stage2_pud_free(pud_table);
> +	stage2_pud_free(kvm, pud_table);
>  	put_page(virt_to_page(pgd));
>  }
>  
>  static void clear_stage2_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
>  {
> -	pmd_t *pmd_table __maybe_unused = stage2_pmd_offset(pud, 0);
> -	VM_BUG_ON(stage2_pud_huge(*pud));
> -	stage2_pud_clear(pud);
> +	pmd_t *pmd_table __maybe_unused = stage2_pmd_offset(kvm, pud, 0);
> +	VM_BUG_ON(stage2_pud_huge(kvm, *pud));
> +	stage2_pud_clear(kvm, pud);
>  	kvm_tlb_flush_vmid_ipa(kvm, addr);
> -	stage2_pmd_free(pmd_table);
> +	stage2_pmd_free(kvm, pmd_table);
>  	put_page(virt_to_page(pud));
>  }
>  
> @@ -219,7 +218,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
>  		}
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  
> -	if (stage2_pte_table_empty(start_pte))
> +	if (stage2_pte_table_empty(kvm, start_pte))
>  		clear_stage2_pmd_entry(kvm, pmd, start_addr);
>  }
>  
> @@ -229,9 +228,9 @@ static void unmap_stage2_pmds(struct kvm *kvm, pud_t *pud,
>  	phys_addr_t next, start_addr = addr;
>  	pmd_t *pmd, *start_pmd;
>  
> -	start_pmd = pmd = stage2_pmd_offset(pud, addr);
> +	start_pmd = pmd = stage2_pmd_offset(kvm, pud, addr);
>  	do {
> -		next = stage2_pmd_addr_end(addr, end);
> +		next = stage2_pmd_addr_end(kvm, addr, end);
>  		if (!pmd_none(*pmd)) {
>  			if (pmd_thp_or_huge(*pmd)) {
>  				pmd_t old_pmd = *pmd;
> @@ -248,7 +247,7 @@ static void unmap_stage2_pmds(struct kvm *kvm, pud_t *pud,
>  		}
>  	} while (pmd++, addr = next, addr != end);
>  
> -	if (stage2_pmd_table_empty(start_pmd))
> +	if (stage2_pmd_table_empty(kvm, start_pmd))
>  		clear_stage2_pud_entry(kvm, pud, start_addr);
>  }
>  
> @@ -258,14 +257,14 @@ static void unmap_stage2_puds(struct kvm *kvm, pgd_t *pgd,
>  	phys_addr_t next, start_addr = addr;
>  	pud_t *pud, *start_pud;
>  
> -	start_pud = pud = stage2_pud_offset(pgd, addr);
> +	start_pud = pud = stage2_pud_offset(kvm, pgd, addr);
>  	do {
> -		next = stage2_pud_addr_end(addr, end);
> -		if (!stage2_pud_none(*pud)) {
> -			if (stage2_pud_huge(*pud)) {
> +		next = stage2_pud_addr_end(kvm, addr, end);
> +		if (!stage2_pud_none(kvm, *pud)) {
> +			if (stage2_pud_huge(kvm, *pud)) {
>  				pud_t old_pud = *pud;
>  
> -				stage2_pud_clear(pud);
> +				stage2_pud_clear(kvm, pud);
>  				kvm_tlb_flush_vmid_ipa(kvm, addr);
>  				kvm_flush_dcache_pud(old_pud);
>  				put_page(virt_to_page(pud));
> @@ -275,7 +274,7 @@ static void unmap_stage2_puds(struct kvm *kvm, pgd_t *pgd,
>  		}
>  	} while (pud++, addr = next, addr != end);
>  
> -	if (stage2_pud_table_empty(start_pud))
> +	if (stage2_pud_table_empty(kvm, start_pud))
>  		clear_stage2_pgd_entry(kvm, pgd, start_addr);
>  }
>  
> @@ -299,7 +298,7 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>  	assert_spin_locked(&kvm->mmu_lock);
>  	WARN_ON(size & ~PAGE_MASK);
>  
> -	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
> +	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
>  	do {
>  		/*
>  		 * Make sure the page table is still active, as another thread
> @@ -308,8 +307,8 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>  		 */
>  		if (!READ_ONCE(kvm->arch.pgd))
>  			break;
> -		next = stage2_pgd_addr_end(addr, end);
> -		if (!stage2_pgd_none(*pgd))
> +		next = stage2_pgd_addr_end(kvm, addr, end);
> +		if (!stage2_pgd_none(kvm, *pgd))
>  			unmap_stage2_puds(kvm, pgd, addr, next);
>  		/*
>  		 * If the range is too large, release the kvm->mmu_lock
> @@ -338,9 +337,9 @@ static void stage2_flush_pmds(struct kvm *kvm, pud_t *pud,
>  	pmd_t *pmd;
>  	phys_addr_t next;
>  
> -	pmd = stage2_pmd_offset(pud, addr);
> +	pmd = stage2_pmd_offset(kvm, pud, addr);
>  	do {
> -		next = stage2_pmd_addr_end(addr, end);
> +		next = stage2_pmd_addr_end(kvm, addr, end);
>  		if (!pmd_none(*pmd)) {
>  			if (pmd_thp_or_huge(*pmd))
>  				kvm_flush_dcache_pmd(*pmd);
> @@ -356,11 +355,11 @@ static void stage2_flush_puds(struct kvm *kvm, pgd_t *pgd,
>  	pud_t *pud;
>  	phys_addr_t next;
>  
> -	pud = stage2_pud_offset(pgd, addr);
> +	pud = stage2_pud_offset(kvm, pgd, addr);
>  	do {
> -		next = stage2_pud_addr_end(addr, end);
> -		if (!stage2_pud_none(*pud)) {
> -			if (stage2_pud_huge(*pud))
> +		next = stage2_pud_addr_end(kvm, addr, end);
> +		if (!stage2_pud_none(kvm, *pud)) {
> +			if (stage2_pud_huge(kvm, *pud))
>  				kvm_flush_dcache_pud(*pud);
>  			else
>  				stage2_flush_pmds(kvm, pud, addr, next);
> @@ -376,10 +375,10 @@ static void stage2_flush_memslot(struct kvm *kvm,
>  	phys_addr_t next;
>  	pgd_t *pgd;
>  
> -	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
> +	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
>  	do {
> -		next = stage2_pgd_addr_end(addr, end);
> -		if (!stage2_pgd_none(*pgd))
> +		next = stage2_pgd_addr_end(kvm, addr, end);
> +		if (!stage2_pgd_none(kvm, *pgd))
>  			stage2_flush_puds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
> @@ -869,7 +868,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  	}
>  
>  	/* Allocate the HW PGD, making sure that each page gets its own refcount */
> -	pgd = alloc_pages_exact(S2_PGD_SIZE, GFP_KERNEL | __GFP_ZERO);
> +	pgd = alloc_pages_exact(stage2_pgd_size(kvm), GFP_KERNEL | __GFP_ZERO);
>  	if (!pgd)
>  		return -ENOMEM;
>  
> @@ -958,7 +957,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>  
>  	spin_lock(&kvm->mmu_lock);
>  	if (kvm->arch.pgd) {
> -		unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
> +		unmap_stage2_range(kvm, 0, kvm_phys_size(kvm));
>  		pgd = READ_ONCE(kvm->arch.pgd);
>  		kvm->arch.pgd = NULL;
>  	}
> @@ -966,7 +965,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>  
>  	/* Free the HW pgd, one page at a time */
>  	if (pgd)
> -		free_pages_exact(pgd, S2_PGD_SIZE);
> +		free_pages_exact(pgd, stage2_pgd_size(kvm));
>  }
>  
>  static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> @@ -975,16 +974,16 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
>  	pgd_t *pgd;
>  	pud_t *pud;
>  
> -	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
> -	if (stage2_pgd_none(*pgd)) {
> +	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
> +	if (stage2_pgd_none(kvm, *pgd)) {
>  		if (!cache)
>  			return NULL;
>  		pud = mmu_memory_cache_alloc(cache);
> -		stage2_pgd_populate(pgd, pud);
> +		stage2_pgd_populate(kvm, pgd, pud);
>  		get_page(virt_to_page(pgd));
>  	}
>  
> -	return stage2_pud_offset(pgd, addr);
> +	return stage2_pud_offset(kvm, pgd, addr);
>  }
>  
>  static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
> @@ -997,15 +996,15 @@ static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
>  	if (!pud)
>  		return NULL;
>  
> -	if (stage2_pud_none(*pud)) {
> +	if (stage2_pud_none(kvm, *pud)) {
>  		if (!cache)
>  			return NULL;
>  		pmd = mmu_memory_cache_alloc(cache);
> -		stage2_pud_populate(pud, pmd);
> +		stage2_pud_populate(kvm, pud, pmd);
>  		get_page(virt_to_page(pud));
>  	}
>  
> -	return stage2_pmd_offset(pud, addr);
> +	return stage2_pmd_offset(kvm, pud, addr);
>  }
>  
>  static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
> @@ -1159,8 +1158,9 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  		if (writable)
>  			pte = kvm_s2pte_mkwrite(pte);
>  
> -		ret = mmu_topup_memory_cache(&cache, KVM_MMU_CACHE_MIN_PAGES,
> -						KVM_NR_MEM_OBJS);
> +		ret = mmu_topup_memory_cache(&cache,
> +					     kvm_mmu_cache_min_pages(kvm),
> +					     KVM_NR_MEM_OBJS);
>  		if (ret)
>  			goto out;
>  		spin_lock(&kvm->mmu_lock);
> @@ -1248,19 +1248,21 @@ static void stage2_wp_ptes(pmd_t *pmd, phys_addr_t addr, phys_addr_t end)
>  
>  /**
>   * stage2_wp_pmds - write protect PUD range
> + * kvm:		kvm instance for the VM
>   * @pud:	pointer to pud entry
>   * @addr:	range start address
>   * @end:	range end address
>   */
> -static void stage2_wp_pmds(pud_t *pud, phys_addr_t addr, phys_addr_t end)
> +static void stage2_wp_pmds(struct kvm *kvm, pud_t *pud,
> +			   phys_addr_t addr, phys_addr_t end)
>  {
>  	pmd_t *pmd;
>  	phys_addr_t next;
>  
> -	pmd = stage2_pmd_offset(pud, addr);
> +	pmd = stage2_pmd_offset(kvm, pud, addr);
>  
>  	do {
> -		next = stage2_pmd_addr_end(addr, end);
> +		next = stage2_pmd_addr_end(kvm, addr, end);
>  		if (!pmd_none(*pmd)) {
>  			if (pmd_thp_or_huge(*pmd)) {
>  				if (!kvm_s2pmd_readonly(pmd))
> @@ -1280,18 +1282,19 @@ static void stage2_wp_pmds(pud_t *pud, phys_addr_t addr, phys_addr_t end)
>    *
>    * Process PUD entries, for a huge PUD we cause a panic.
>    */
> -static void  stage2_wp_puds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
> +static void  stage2_wp_puds(struct kvm *kvm, pgd_t *pgd,
> +			    phys_addr_t addr, phys_addr_t end)
>  {
>  	pud_t *pud;
>  	phys_addr_t next;
>  
> -	pud = stage2_pud_offset(pgd, addr);
> +	pud = stage2_pud_offset(kvm, pgd, addr);
>  	do {
> -		next = stage2_pud_addr_end(addr, end);
> -		if (!stage2_pud_none(*pud)) {
> +		next = stage2_pud_addr_end(kvm, addr, end);
> +		if (!stage2_pud_none(kvm, *pud)) {
>  			/* TODO:PUD not supported, revisit later if supported */
> -			BUG_ON(stage2_pud_huge(*pud));
> -			stage2_wp_pmds(pud, addr, next);
> +			BUG_ON(stage2_pud_huge(kvm, *pud));
> +			stage2_wp_pmds(kvm, pud, addr, next);
>  		}
>  	} while (pud++, addr = next, addr != end);
>  }
> @@ -1307,7 +1310,7 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  	pgd_t *pgd;
>  	phys_addr_t next;
>  
> -	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
> +	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
>  	do {
>  		/*
>  		 * Release kvm_mmu_lock periodically if the memory region is
> @@ -1321,9 +1324,9 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  		cond_resched_lock(&kvm->mmu_lock);
>  		if (!READ_ONCE(kvm->arch.pgd))
>  			break;
> -		next = stage2_pgd_addr_end(addr, end);
> -		if (stage2_pgd_present(*pgd))
> -			stage2_wp_puds(pgd, addr, next);
> +		next = stage2_pgd_addr_end(kvm, addr, end);
> +		if (stage2_pgd_present(kvm, *pgd))
> +			stage2_wp_puds(kvm, pgd, addr, next);
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> @@ -1472,7 +1475,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	up_read(&current->mm->mmap_sem);
>  
>  	/* We need minimum second+third level pages */
> -	ret = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
> +	ret = mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm),
>  				     KVM_NR_MEM_OBJS);
>  	if (ret)
>  		return ret;
> @@ -1715,7 +1718,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	}
>  
>  	/* Userspace should not be able to register out-of-bounds IPAs */
> -	VM_BUG_ON(fault_ipa >= KVM_PHYS_SIZE);
> +	VM_BUG_ON(fault_ipa >= kvm_phys_size(vcpu->kvm));
>  
>  	if (fault_status == FSC_ACCESS) {
>  		handle_access_fault(vcpu, fault_ipa);
> @@ -2019,7 +2022,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  	 * space addressable by the KVM guest IPA space.
>  	 */
>  	if (memslot->base_gfn + memslot->npages >=
> -	    (KVM_PHYS_SIZE >> PAGE_SHIFT))
> +	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
>  		return -EFAULT;
>  
>  	down_read(&current->mm->mmap_sem);
> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
> index 6ada243..114dce9 100644
> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
> @@ -25,7 +25,7 @@
>  int vgic_check_ioaddr(struct kvm *kvm, phys_addr_t *ioaddr,
>  		      phys_addr_t addr, phys_addr_t alignment)
>  {
> -	if (addr & ~KVM_PHYS_MASK)
> +	if (addr & ~kvm_phys_mask(kvm))
>  		return -E2BIG;
>  
>  	if (!IS_ALIGNED(addr, alignment))
> 

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
