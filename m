Received: from eggs.gnu.org ([2001:4830:134:3::10]:59413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa010-0005hX-VK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa00v-0006mc-Vp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:41:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fa00v-0006mC-Pb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:41:13 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
Date: Mon, 2 Jul 2018 16:41:09 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/20] kvm: arm64: Dynamic configuration
 of VTTBR mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> On arm64 VTTBR_EL2:BADDR holds the base address for the stage2
> translation table. The Arm ARM mandates that the bits BADDR[x-1:0]
> should be 0, where 'x' is defined for a given IPA Size and the
> number of levels for a translation granule size. It is defined
> using some magical constants. This patch is a reverse engineered
> implementation to calculate the 'x' at runtime for a given ipa and
> number of page table levels. See patch for more details.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Part 1 of spilt from VTCR & VTTBR dynamic configuration
> ---
>  arch/arm64/include/asm/kvm_arm.h | 60 +++++++++++++++++++++++++++++++++++++---
>  arch/arm64/include/asm/kvm_mmu.h | 25 ++++++++++++++++-
>  2 files changed, 80 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 3dffd38..c557f45 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -140,8 +140,6 @@
>   * Note that when using 4K pages, we concatenate two first level page tables
>   * together. With 16K pages, we concatenate 16 first level page tables.
>   *
> - * The magic numbers used for VTTBR_X in this patch can be found in Tables
> - * D4-23 and D4-25 in ARM DDI 0487A.b.
Isn't it a pretty old reference? Could you refer to C.a?

>   */
>  
>  #define VTCR_EL2_T0SZ_IPA	VTCR_EL2_T0SZ_40B
> @@ -175,9 +173,63 @@
>  #endif
>  
>  #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
> -#define VTTBR_X				(VTTBR_X_TGRAN_MAGIC - VTCR_EL2_T0SZ_IPA)
> +/*
> + * ARM VMSAv8-64 defines an algorithm for finding the translation table
> + * descriptors in section D4.2.8 in ARM DDI 0487B.b.
another one ;-)
> + *
> + * The algorithm defines the expectations on the BaseAddress (for the page
> + * table) bits resolved at each level based on the page size, entry level
> + * and T0SZ. The variable "x" in the algorithm also affects the VTTBR:BADDR
> + * for stage2 page table.
> + *
> + * The value of "x" is calculated as :
> + *	x = Magic_N - T0SZ
> + *
> + * where Magic_N is an integer depending on the page size and the entry
> + * level of the page table as below:
> + *
> + *	--------------------------------------------
> + *	| Entry level		|  4K    16K   64K |
> + *	--------------------------------------------
> + *	| Level: 0 (4 levels)	| 28   |  -  |  -  |
> + *	--------------------------------------------
> + *	| Level: 1 (3 levels)	| 37   | 31  | 25  |
> + *	--------------------------------------------
> + *	| Level: 2 (2 levels)	| 46   | 42  | 38  |
> + *	--------------------------------------------
> + *	| Level: 3 (1 level)	| -    | 53  | 51  |
> + *	--------------------------------------------
I understand entry level = Lookup level in the table.
But you may want to compute x for BaseAddress matching lookup level 2
with number of levels = 4.
So shouldn't you s/Number of levels/4 - entry_level?
for BADDR we want the BaseAddr of the initial lookup level so
effectively the entry level we are interested in is 4 - number of levels
and we don't care or d) condition. At least this is my understanding ;-)
If correct you may slightly reword the explanation?
> + *
> + * We have a magic formula for the Magic_N below.
> + *
> + *  Magic_N(PAGE_SIZE, Entry_Level) = 64 - ((PAGE_SHIFT - 3) * Number of levels)
> + *
> + * where number of levels = (4 - Entry_Level).
> + *
> + * So, given that T0SZ = (64 - PA_SHIFT), we can compute 'x' as follows:
Isn't it IPA_SHIFT instead?
> + *
> + *	x = (64 - ((PAGE_SHIFT - 3) * Number_of_levels)) - (64 - PA_SHIFT)
> + *	  = PA_SHIFT - ((PAGE_SHIFT - 3) * Number of levels)
> + *
> + * Here is one way to explain the Magic Formula:
> + *
> + *  x = log2(Size_of_Entry_Level_Table)
> + *
> + * Since, we can resolve (PAGE_SHIFT - 3) bits at each level, and another
> + * PAGE_SHIFT bits in the PTE, we have :
> + *
> + *  Bits_Entry_level = PA_SHIFT - ((PAGE_SHIFT - 3) * (n - 1) + PAGE_SHIFT)
> + *		     = PA_SHIFT - (PAGE_SHIFT - 3) * n - 3
> + *  where n = number of levels, and since each pointer is 8bytes, we have:
> + *
> + *  x = Bits_Entry_Level + 3
> + *    = PA_SHIFT - (PAGE_SHIFT - 3) * n
> + *
> + * The only constraint here is that, we have to find the number of page table
> + * levels for a given IPA size (which we do, see stage2_pt_levels())
> + */
> +#define ARM64_VTTBR_X(ipa, levels)	((ipa) - ((levels) * (PAGE_SHIFT - 3)))
>  
> -#define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_X)
>  #define VTTBR_VMID_SHIFT  (UL(48))
>  #define VTTBR_VMID_MASK(size) (_AT(u64, (1 << size) - 1) << VTTBR_VMID_SHIFT)
>  
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index a351722..813a72a 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -146,7 +146,6 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>  #define kvm_phys_shift(kvm)		KVM_PHYS_SHIFT
>  #define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
>  #define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))
> -#define kvm_vttbr_baddr_mask(kvm)	VTTBR_BADDR_MASK
>  
>  static inline bool kvm_page_empty(void *ptr)
>  {
> @@ -503,6 +502,30 @@ static inline int hyp_map_aux_data(void)
>  
>  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
>  
> +/*
> + * Get the magic number 'x' for VTTBR:BADDR of this KVM instance.
> + * With v8.2 LVA extensions, 'x' should be a minimum of 6 with
> + * 52bit IPS.
Link to the spec?
> + */
> +static inline int arm64_vttbr_x(u32 ipa_shift, u32 levels)
> +{
> +	int x = ARM64_VTTBR_X(ipa_shift, levels);
> +
> +	return (IS_ENABLED(CONFIG_ARM64_PA_BITS_52) && x < 6) ? 6 : x;
> +}
> +
> +static inline u64 vttbr_baddr_mask(u32 ipa_shift, u32 levels)
> +{
> +	unsigned int x = arm64_vttbr_x(ipa_shift, levels);
> +
> +	return GENMASK_ULL(PHYS_MASK_SHIFT - 1, x);
> +}
> +
> +static inline u64 kvm_vttbr_baddr_mask(struct kvm *kvm)
> +{
> +	return vttbr_baddr_mask(kvm_phys_shift(kvm), kvm_stage2_levels(kvm));
> +}
> +
>  static inline void *stage2_alloc_pgd(struct kvm *kvm)
>  {
>  	return alloc_pages_exact(stage2_pgd_size(kvm),
> 

Thanks

Eric
