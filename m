Received: from eggs.gnu.org ([2001:4830:134:3::10]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZzEB-0007J1-Pl
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZzE6-0004Ob-OZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:50:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40224
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZzE6-0004O6-Ei
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:50:46 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-20-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <8dcb10d8-d0ff-feb9-4ca8-38d7eeb5e6ce@arm.com>
Date: Mon, 2 Jul 2018 14:50:40 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-20-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 19/20] kvm: arm64: Allow IPA size
 supported by the system
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
> So far we have restricted the IPA size of the VM to the default
> value (40bits). Now that we can manage the IPA size per VM and
> support dynamic stage2 page tables, allow VMs to have larger IPA.
> This is done by setting the IPA limit to the one supported by
> the hardware and kernel. This patch also moves the check for
> the default IPA size support to kvm_get_ipa_limit().
> 
> Since the stage2 page table code is dependent on the stage1
> page table, we always ensure that :
> 
>   Number of Levels at Stage1 >= Number of Levels at Stage2
> 
> So we limit the IPA to make sure that the above condition
> is satisfied. This will affect the following combinations
> of VA_BITS and IPA for different page sizes.
> 
>   39bit VA, 4K  - IPA > 43 (Upto 48)
>   36bit VA, 16K - IPA > 40 (Upto 48)
>   42bit VA, 64K - IPA > 46 (Upto 52)

I'm not sure I get it. Are these the IPA sizes that we forbid based on
the host VA size and page size configuration? If so, can you rewrite
this as:

   host configuration | unsupported IPA range
   39bit VA, 4k       | [44, 48]
   36bit VA, 16K      | [41, 48]
   42bit VA, 64k      | [47, 52]

and say that all the other combinations are supported?

> 
> Supporting the above combinations need independent stage2
> page table manipulation code, which would need substantial
> changes. We could purse the solution independently and
> switch the page table code once we have it ready.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Restrict the IPA size to limit the number of page table
>    levels in stage2 to that of stage1 or less.
> ---
>  arch/arm64/include/asm/kvm_host.h |  6 ------
>  arch/arm64/include/asm/kvm_mmu.h  | 37 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 9a15860..e858e49 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -452,13 +452,7 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  
>  static inline void __cpu_init_stage2(void)
>  {
> -	u32 ps;
> -
>  	kvm_call_hyp(__init_stage2_translation);
> -	/* Sanity check for minimum IPA size support */
> -	ps = id_aa64mmfr0_parange_to_phys_shift(read_sysreg(id_aa64mmfr0_el1) & 0x7);
> -	WARN_ONCE(ps < 40,
> -		  "PARange is %d bits, unsupported configuration!", ps);
>  }
>  
>  /* Guest/host FPSIMD coordination helpers */
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index a291cdc..d38f395 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -547,7 +547,42 @@ static inline void *stage2_alloc_pgd(struct kvm *kvm)
>  
>  static inline u32 kvm_get_ipa_limit(void)
>  {
> -	return KVM_PHYS_SHIFT;
> +	unsigned int ipa_max, va_max, parange;
> +
> +	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
> +	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
> +
> +	/* Raise the limit to the default size for backward compatibility */
> +	if (ipa_max < KVM_PHYS_SHIFT) {
> +		WARN_ONCE(1,
> +			  "PARange is %d bits, unsupported configuration!",
> +			  ipa_max);
> +		ipa_max = KVM_PHYS_SHIFT;
> +	}
> +
> +	/* Clamp it to the PA size supported by the kernel */
> +	ipa_max = (ipa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : ipa_max;
> +	/*
> +	 * Since our stage2 table is dependent on the stage1 page table code,
> +	 * we must always honor the following condition:
> +	 *
> +	 *  Number of levels in Stage1 >= Number of levels in Stage2.
> +	 *
> +	 * So clamp the ipa limit further down to limit the number of levels.
> +	 * Since we can concatenate upto 16 tables at entry level, we could
> +	 * go upto 4bits above the maximum VA addressible with the current
> +	 * number of levels.
> +	 */
> +	va_max = PGDIR_SHIFT + PAGE_SHIFT - 3;
> +	va_max += 4;
> +
> +	if (va_max < ipa_max) {
> +		kvm_info("Limiting IPA limit to %dbytes due to host VA bits limitation\n",
> +			 va_max);
> +		ipa_max = va_max;
> +	}
> +
> +	return ipa_max;
>  }
>  
>  static inline void kvm_config_stage2(struct kvm *kvm, u32 ipa_shift)
> 

Otherwise looks good.

	M.
-- 
Jazz is not dead. It just smells funny...
