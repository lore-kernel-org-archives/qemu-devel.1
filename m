Received: from eggs.gnu.org ([2001:4830:134:3::10]:54198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fZxj5-0007D5-Gp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fZxj2-0005pe-80
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:14:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fZxj2-0005pX-1Y
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:14:36 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-10-git-send-email-suzuki.poulose@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <65475ac0-d156-c16e-bd91-438377326143@redhat.com>
Date: Mon, 2 Jul 2018 14:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-10-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/20] kvm: arm64: Make stage2 page
 table layout dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> So far we had a static stage2 page table handling code, based on a
> fixed IPA of 40bits. As we prepare for a configurable IPA size per
> VM, make our stage2 page table code dynamic, to do the right thing
> for a given VM. We ensure the existing condition is always true even
> when we lift the limit on the IPA. i.e,
> 
> 	page table levels in stage1 >= page table levels in stage2
> 
> Support for the IPA size configuration needs other changes in the way
> we configure the EL2 registers (VTTBR and VTCR). So, the IPA is still
> fixed to 40bits. The patch also moves the kvm_page_empty() in asm/kvm_mmu.h
> to the top, before including the asm/stage2_pgtable.h to avoid a forward
> declaration.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2
>  - Restrict the stage2 page table to allow reusing the host page table
>    helpers for now, until we get stage1 independent page table helpers.
I would move this up in the commit msg to motivate the fact we enforce
the able condition.
> ---
>  arch/arm64/include/asm/kvm_mmu.h              |  14 +-
>  arch/arm64/include/asm/stage2_pgtable-nopmd.h |  42 ------
>  arch/arm64/include/asm/stage2_pgtable-nopud.h |  39 -----
>  arch/arm64/include/asm/stage2_pgtable.h       | 207 +++++++++++++++++++-------
>  4 files changed, 159 insertions(+), 143 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopmd.h
>  delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopud.h

with my very limited knowledge of S2 page table walkers I fail to
understand why we now can get rid of stage2_pgtable-nopmd.h and
stage2_pgtable-nopud.h and associated FOLDED config. Please could you
explain it in the commit message?
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index dbaf513..a351722 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -21,6 +21,7 @@
>  #include <asm/page.h>
>  #include <asm/memory.h>
>  #include <asm/cpufeature.h>
> +#include <asm/kvm_arm.h>
>  
>  /*
>   * As ARMv8.0 only has the TTBR0_EL2 register, we cannot express
> @@ -147,6 +148,13 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>  #define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))
>  #define kvm_vttbr_baddr_mask(kvm)	VTTBR_BADDR_MASK
>  
> +static inline bool kvm_page_empty(void *ptr)
> +{
> +	struct page *ptr_page = virt_to_page(ptr);
> +
> +	return page_count(ptr_page) == 1;
> +}
> +
>  #include <asm/stage2_pgtable.h>
>  
>  int create_hyp_mappings(void *from, void *to, pgprot_t prot);
> @@ -237,12 +245,6 @@ static inline bool kvm_s2pmd_exec(pmd_t *pmdp)
>  	return !(READ_ONCE(pmd_val(*pmdp)) & PMD_S2_XN);
>  }
>  
> -static inline bool kvm_page_empty(void *ptr)
> -{
> -	struct page *ptr_page = virt_to_page(ptr);
> -	return page_count(ptr_page) == 1;
> -}
> -
>  #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
>  
>  #ifdef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/arm64/include/asm/stage2_pgtable-nopmd.h b/arch/arm64/include/asm/stage2_pgtable-nopmd.h
> deleted file mode 100644
> index 0280ded..0000000
> --- a/arch/arm64/include/asm/stage2_pgtable-nopmd.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/*
> - * Copyright (C) 2016 - ARM Ltd
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#ifndef __ARM64_S2_PGTABLE_NOPMD_H_
> -#define __ARM64_S2_PGTABLE_NOPMD_H_
> -
> -#include <asm/stage2_pgtable-nopud.h>
> -
> -#define __S2_PGTABLE_PMD_FOLDED
> -
> -#define S2_PMD_SHIFT		S2_PUD_SHIFT
> -#define S2_PTRS_PER_PMD		1
> -#define S2_PMD_SIZE		(1UL << S2_PMD_SHIFT)
> -#define S2_PMD_MASK		(~(S2_PMD_SIZE-1))
> -
> -#define stage2_pud_none(kvm, pud)		(0)
> -#define stage2_pud_present(kvm, pud)		(1)
> -#define stage2_pud_clear(kvm, pud)		do { } while (0)
> -#define stage2_pud_populate(kvm, pud, pmd)	do { } while (0)
> -#define stage2_pmd_offset(kvm, pud, address)	((pmd_t *)(pud))
> -
> -#define stage2_pmd_free(kvm, pmd)		do { } while (0)
> -
> -#define stage2_pmd_addr_end(kvm, addr, end)	(end)
> -
> -#define stage2_pud_huge(kvm, pud)		(0)
> -#define stage2_pmd_table_empty(kvm, pmdp)	(0)
> -
> -#endif
> diff --git a/arch/arm64/include/asm/stage2_pgtable-nopud.h b/arch/arm64/include/asm/stage2_pgtable-nopud.h
> deleted file mode 100644
> index cd6304e..0000000
> --- a/arch/arm64/include/asm/stage2_pgtable-nopud.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/*
> - * Copyright (C) 2016 - ARM Ltd
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#ifndef __ARM64_S2_PGTABLE_NOPUD_H_
> -#define __ARM64_S2_PGTABLE_NOPUD_H_
> -
> -#define __S2_PGTABLE_PUD_FOLDED
> -
> -#define S2_PUD_SHIFT		S2_PGDIR_SHIFT
> -#define S2_PTRS_PER_PUD		1
> -#define S2_PUD_SIZE		(_AC(1, UL) << S2_PUD_SHIFT)
> -#define S2_PUD_MASK		(~(S2_PUD_SIZE-1))
> -
> -#define stage2_pgd_none(kvm, pgd)		(0)
> -#define stage2_pgd_present(kvm, pgd)		(1)
> -#define stage2_pgd_clear(kvm, pgd)		do { } while (0)
> -#define stage2_pgd_populate(kvm, pgd, pud)	do { } while (0)
> -
> -#define stage2_pud_offset(kvm, pgd, address)	((pud_t *)(pgd))
> -
> -#define stage2_pud_free(kvm, x)			do { } while (0)
> -
> -#define stage2_pud_addr_end(kvm, addr, end)	(end)
> -#define stage2_pud_table_empty(kvm, pmdp)	(0)
> -
> -#endif
> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> index 057a405..ffc37cc 100644
> --- a/arch/arm64/include/asm/stage2_pgtable.h
> +++ b/arch/arm64/include/asm/stage2_pgtable.h
> @@ -19,8 +19,12 @@
>  #ifndef __ARM64_S2_PGTABLE_H_
>  #define __ARM64_S2_PGTABLE_H_
>  
> +#include <linux/hugetlb.h>
>  #include <asm/pgtable.h>
>  
> +/* The PGDIR shift for a given page table with "n" levels. */
> +#define pt_levels_pgdir_shift(n)	ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (n))
> +
>  /*
>   * The hardware supports concatenation of up to 16 tables at stage2 entry level
>   * and we use the feature whenever possible.
> @@ -29,118 +33,209 @@
>   * On arm64, the smallest PAGE_SIZE supported is 4k, which means
>   *             (PAGE_SHIFT - 3) > 4 holds for all page sizes.
Trying to understand that comment. Why do we compare to 4?
>   * This implies, the total number of page table levels at stage2 expected
> - * by the hardware is actually the number of levels required for (KVM_PHYS_SHIFT - 4)
> + * by the hardware is actually the number of levels required for (IPA_SHIFT - 4)
although understandable, is IPA_SHIFT defined somewhere?
>   * in normal translations(e.g, stage1), since we cannot have another level in
> - * the range (KVM_PHYS_SHIFT, KVM_PHYS_SHIFT - 4).
> + * the range (IPA_SHIFT, IPA_SHIFT - 4).
I fail to understand the above comment. Could you give a pointer to the
spec?
>   */
> -#define STAGE2_PGTABLE_LEVELS		ARM64_HW_PGTABLE_LEVELS(KVM_PHYS_SHIFT - 4)
> +#define stage2_pt_levels(ipa_shift)	ARM64_HW_PGTABLE_LEVELS((ipa_shift) - 4)
>  
>  /*
> - * With all the supported VA_BITs and 40bit guest IPA, the following condition
> - * is always true:
> + * With all the supported VA_BITs and guest IPA, the following condition
> + * must be always true:
>   *
> - *       STAGE2_PGTABLE_LEVELS <= CONFIG_PGTABLE_LEVELS
> + *       stage2_pt_levels <= CONFIG_PGTABLE_LEVELS
>   *
>   * We base our stage-2 page table walker helpers on this assumption and
>   * fall back to using the host version of the helper wherever possible.
>   * i.e, if a particular level is not folded (e.g, PUD) at stage2, we fall back
>   * to using the host version, since it is guaranteed it is not folded at host.
>   *
> - * If the condition breaks in the future, we can rearrange the host level
> - * definitions and reuse them for stage2. Till then...
> + * If the condition breaks in the future, we need completely independent
> + * page table helpers. Till then...
>   */
> -#if STAGE2_PGTABLE_LEVELS > CONFIG_PGTABLE_LEVELS
> +
> +#if stage2_pt_levels(KVM_PHYS_SHIFT) > CONFIG_PGTABLE_LEVELS
>  #error "Unsupported combination of guest IPA and host VA_BITS."
>  #endif
>  
> -/* S2_PGDIR_SHIFT is the size mapped by top-level stage2 entry */
> -#define S2_PGDIR_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - STAGE2_PGTABLE_LEVELS)
> -#define S2_PGDIR_SIZE			(_AC(1, UL) << S2_PGDIR_SHIFT)
> -#define S2_PGDIR_MASK			(~(S2_PGDIR_SIZE - 1))
> -
>  /*
>   * The number of PTRS across all concatenated stage2 tables given by the
>   * number of bits resolved at the initial level.
>   */
> -#define PTRS_PER_S2_PGD			(1 << (KVM_PHYS_SHIFT - S2_PGDIR_SHIFT))
> +#define __s2_pgd_ptrs(pa, lvls)	(1 << ((pa) - pt_levels_pgdir_shift((lvls))))
> +#define __s2_pgd_size(pa, lvls)	(__s2_pgd_ptrs((pa), (lvls)) * sizeof(pgd_t))
> +
> +#define kvm_stage2_levels(kvm)		stage2_pt_levels(kvm_phys_shift(kvm))
> +#define stage2_pgdir_shift(kvm)	\
> +		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
> +#define stage2_pgdir_size(kvm)		(_AC(1, UL) << stage2_pgdir_shift((kvm)))
> +#define stage2_pgdir_mask(kvm)		(~(stage2_pgdir_size((kvm)) - 1))
> +#define stage2_pgd_ptrs(kvm)	\
> +	__s2_pgd_ptrs(kvm_phys_shift(kvm), kvm_stage2_levels(kvm))
> +
> +#define stage2_pgd_size(kvm)	__s2_pgd_size(kvm_phys_shift(kvm), kvm_stage2_levels(kvm))
>  
>  /*
>   * kvm_mmmu_cache_min_pages is the number of stage2 page table translation
>   * levels in addition to the PGD.
>   */
> -#define kvm_mmu_cache_min_pages(kvm)	(STAGE2_PGTABLE_LEVELS - 1)
> +#define kvm_mmu_cache_min_pages(kvm)	(kvm_stage2_levels(kvm) - 1)
>  
>  
> -#if STAGE2_PGTABLE_LEVELS > 3
> +/* PUD/PMD definitions if present */
> +#define __S2_PUD_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
> +#define __S2_PUD_SIZE			(_AC(1, UL) << __S2_PUD_SHIFT)
> +#define __S2_PUD_MASK			(~(__S2_PUD_SIZE - 1))
>  
> -#define S2_PUD_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
> -#define S2_PUD_SIZE			(_AC(1, UL) << S2_PUD_SHIFT)
> -#define S2_PUD_MASK			(~(S2_PUD_SIZE - 1))
> +#define __S2_PMD_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
> +#define __S2_PMD_SIZE			(_AC(1, UL) << __S2_PMD_SHIFT)
> +#define __S2_PMD_MASK			(~(__S2_PMD_SIZE - 1))
Is this renaming mandatory?
>  
> -#define stage2_pgd_none(kvm, pgd)		pgd_none(pgd)
> -#define stage2_pgd_clear(kvm, pgd)		pgd_clear(pgd)
> -#define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
> -#define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
> -#define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
> -#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
> +#define __s2_pud_index(addr) \
> +	(((addr) >> __S2_PUD_SHIFT) & (PTRS_PER_PTE - 1))
> +#define __s2_pmd_index(addr) \
> +	(((addr) >> __S2_PMD_SHIFT) & (PTRS_PER_PTE - 1))
>  
> -#define stage2_pud_table_empty(kvm, pudp)	kvm_page_empty(pudp)
> +#define __kvm_has_stage2_levels(kvm, min_levels)	\
> +  ((CONFIG_PGTABLE_LEVELS >= min_levels) && (kvm_stage2_levels(kvm) >= min_levels))
kvm_stage2_levels <= CONFIG_PGTABLE_LEVELS so you should just need to
check kvm_stage2_levels?
> +
> +#define kvm_stage2_has_pgd(kvm)	__kvm_has_stage2_levels(kvm, 4)
> +#define kvm_stage2_has_pud(kvm) __kvm_has_stage2_levels(kvm, 3)
> +
> +static inline int stage2_pgd_none(struct kvm *kvm, pgd_t pgd)
> +{
> +	return kvm_stage2_has_pgd(kvm) ? pgd_none(pgd) : 0;
> +}
> +
> +static inline void stage2_pgd_clear(struct kvm *kvm, pgd_t *pgdp)
> +{
> +	if (kvm_stage2_has_pgd(kvm))
> +		pgd_clear(pgdp);
> +}
> +
> +static inline int stage2_pgd_present(struct kvm *kvm, pgd_t pgd)
> +{
> +	return kvm_stage2_has_pgd(kvm) ? pgd_present(pgd) : 1;
> +}
> +
> +static inline void stage2_pgd_populate(struct kvm *kvm, pgd_t *pgdp, pud_t *pud)
> +{
> +	if (kvm_stage2_has_pgd(kvm))
> +		pgd_populate(NULL, pgdp, pud);
> +	else
> +		BUG();
> +}
> +
> +static inline pud_t *stage2_pud_offset(struct kvm *kvm,
> +				       pgd_t *pgd, unsigned long address)
> +{
> +	if (kvm_stage2_has_pgd(kvm)) {
> +		phys_addr_t pud_phys = pgd_page_paddr(*pgd);
> +
> +		pud_phys += __s2_pud_index(address) * sizeof(pud_t);
> +		return __va(pud_phys);
> +	}
> +	return (pud_t *)pgd;
> +}
> +
> +static inline void stage2_pud_free(struct kvm *kvm, pud_t *pud)
> +{
> +	if (kvm_stage2_has_pgd(kvm))
> +		pud_free(NULL, pud);
> +}
> +
> +static inline int stage2_pud_table_empty(struct kvm *kvm, pud_t *pudp)
> +{
> +	return kvm_stage2_has_pgd(kvm) && kvm_page_empty(pudp);
> +}
>  
>  static inline phys_addr_t
>  stage2_pud_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
> -	phys_addr_t boundary = (addr + S2_PUD_SIZE) & S2_PUD_MASK;
> +	if (kvm_stage2_has_pgd(kvm)) {
> +		phys_addr_t boundary = (addr + __S2_PUD_SIZE) & __S2_PUD_MASK;
>  
> -	return (boundary - 1 < end - 1) ? boundary : end;
> +		return (boundary - 1 < end - 1) ? boundary : end;
> +	}
> +	return end;
>  }
>  
> -#endif		/* STAGE2_PGTABLE_LEVELS > 3 */
> +static inline int stage2_pud_none(struct kvm *kvm, pud_t pud)
> +{
> +	return kvm_stage2_has_pud(kvm) ? pud_none(pud) : 0;
> +}
>  
> +static inline void stage2_pud_clear(struct kvm *kvm, pud_t *pudp)
> +{
> +	if (kvm_stage2_has_pud(kvm))
> +		pud_clear(pudp);
> +}
>  
> -#if STAGE2_PGTABLE_LEVELS > 2
> +static inline int stage2_pud_present(struct kvm *kvm, pud_t pud)
> +{
> +	return kvm_stage2_has_pud(kvm) ? pud_present(pud) : 1;
> +}
>  
> -#define S2_PMD_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
> -#define S2_PMD_SIZE			(_AC(1, UL) << S2_PMD_SHIFT)
> -#define S2_PMD_MASK			(~(S2_PMD_SIZE - 1))
> +static inline void stage2_pud_populate(struct kvm *kvm, pud_t *pudp, pmd_t *pmd)
> +{
> +	if (kvm_stage2_has_pud(kvm))
> +		pud_populate(NULL, pudp, pmd);
> +	else
> +		BUG();
> +}
>  
> -#define stage2_pud_none(kvm, pud)		pud_none(pud)
> -#define stage2_pud_clear(kvm, pud)		pud_clear(pud)
> -#define stage2_pud_present(kvm, pud)		pud_present(pud)
> -#define stage2_pud_populate(kvm, pud, pmd)	pud_populate(NULL, pud, pmd)
> -#define stage2_pmd_offset(kvm, pud, address)	pmd_offset(pud, address)
> -#define stage2_pmd_free(kvm, pmd)		pmd_free(NULL, pmd)
> +static inline pmd_t *stage2_pmd_offset(struct kvm *kvm,
> +					 pud_t *pud, unsigned long address)
> +{
> +	if (kvm_stage2_has_pud(kvm)) {
> +		phys_addr_t pmd_phys = pud_page_paddr(*pud);
>  
> -#define stage2_pud_huge(kvm, pud)		pud_huge(pud)
> -#define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
> +		pmd_phys += __s2_pmd_index(address) * sizeof(pmd_t);
> +		return __va(pmd_phys);
> +	}
> +	return (pmd_t *)pud;
> +}
> +
> +static inline void stage2_pmd_free(struct kvm *kvm, pmd_t *pmd)
> +{
> +	if (kvm_stage2_has_pud(kvm))
> +		pmd_free(NULL, pmd);
> +}
> +
> +static inline int stage2_pmd_table_empty(struct kvm *kvm, pmd_t *pmdp)
> +{
> +	return kvm_stage2_has_pud(kvm) && kvm_page_empty(pmdp);
> +}
>  
>  static inline phys_addr_t
>  stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
> -	phys_addr_t boundary = (addr + S2_PMD_SIZE) & S2_PMD_MASK;
> +	if (kvm_stage2_has_pud(kvm)) {
> +		phys_addr_t boundary = (addr + __S2_PMD_SIZE) & __S2_PMD_MASK;
>  
> -	return (boundary - 1 < end - 1) ? boundary : end;
> +		return (boundary - 1 < end - 1) ? boundary : end;
> +	}
> +	return end;
>  }
>  
> -#endif		/* STAGE2_PGTABLE_LEVELS > 2 */
> +static inline int stage2_pud_huge(struct kvm *kvm, pud_t pud)
> +{
> +	return kvm_stage2_has_pud(kvm) ? pud_huge(pud) : 0;
> +}
>  
>  #define stage2_pte_table_empty(kvm, ptep)	kvm_page_empty(ptep)
>  
> -#if STAGE2_PGTABLE_LEVELS == 2
> -#include <asm/stage2_pgtable-nopmd.h>
> -#elif STAGE2_PGTABLE_LEVELS == 3
> -#include <asm/stage2_pgtable-nopud.h>
> -#endif
> -
> -#define stage2_pgd_size(kvm)	(PTRS_PER_S2_PGD * sizeof(pgd_t))
> -
> -#define stage2_pgd_index(kvm, addr) \
> -	(((addr) >> S2_PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
> +static inline unsigned long stage2_pgd_index(struct kvm *kvm, phys_addr_t addr)
> +{
> +	return (addr >> stage2_pgdir_shift(kvm)) & (stage2_pgd_ptrs(kvm) - 1);
> +}
>  
>  static inline phys_addr_t
>  stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  {
> -	phys_addr_t boundary = (addr + S2_PGDIR_SIZE) & S2_PGDIR_MASK;
> +	phys_addr_t boundary;
>  
> +	boundary = (addr + stage2_pgdir_size(kvm)) & stage2_pgdir_mask(kvm);
>  	return (boundary - 1 < end - 1) ? boundary : end;
>  }
>  
> 

Globally this patch is pretty hard to review. I don't know if it is
possible to split into 2. 1) Addition of some helper macros. 2) removal
of nopud and nopmd and implementation of the corresponding macros?

Thanks

Eric
