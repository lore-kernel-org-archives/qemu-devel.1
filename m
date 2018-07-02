Received: from eggs.gnu.org ([2001:4830:134:3::10]:45392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa0Kk-0005KO-DS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa0Kc-0002nI-S1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:01:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fa0Kc-0002mO-M6
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:01:34 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-9-git-send-email-suzuki.poulose@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ac15d082-22eb-54d1-d695-6a0a3ac2d1eb@redhat.com>
Date: Mon, 2 Jul 2018 17:01:31 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-9-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/20] kvm: arm/arm64: Abstract stage2
 pgd table allocation
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

Hi Suzuki

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> Abstract the allocation of stage2 entry level tables for
> given VM, so that later we can choose to fall back to the
> normal page table levels (i.e, avoid entry level table
> concatenation) on arm64.

the justification is not crystal clear to me but it does no harm I think.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - New patch
> ---
>  arch/arm/include/asm/kvm_mmu.h   | 6 ++++++
>  arch/arm64/include/asm/kvm_mmu.h | 6 ++++++
>  virt/kvm/arm/mmu.c               | 2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index f36eb20..b2da5a4 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -372,6 +372,12 @@ static inline int hyp_map_aux_data(void)
>  	return 0;
>  }
>  
> +static inline void *stage2_alloc_pgd(struct kvm *kvm)
> +{
> +	return alloc_pages_exact(stage2_pgd_size(kvm),
> +				 GFP_KERNEL | __GFP_ZERO);
> +}
> +
>  #define kvm_phys_to_vttbr(addr)		(addr)
>  
>  #endif	/* !__ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 5da8f52..dbaf513 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -501,5 +501,11 @@ static inline int hyp_map_aux_data(void)
>  
>  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
>  
> +static inline void *stage2_alloc_pgd(struct kvm *kvm)
> +{
> +	return alloc_pages_exact(stage2_pgd_size(kvm),
> +				 GFP_KERNEL | __GFP_ZERO);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 82dd571..a339e00 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -868,7 +868,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  	}
>  
>  	/* Allocate the HW PGD, making sure that each page gets its own refcount */
> -	pgd = alloc_pages_exact(stage2_pgd_size(kvm), GFP_KERNEL | __GFP_ZERO);
> +	pgd = stage2_alloc_pgd(kvm);
>  	if (!pgd)
>  		return -ENOMEM;
>  
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
