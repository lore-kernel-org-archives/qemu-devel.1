Received: from eggs.gnu.org ([2001:4830:134:3::10]:44643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa0Ix-0003UJ-LN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa0Iu-0001lK-JX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:59:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fa0Iu-0001kq-E8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:59:48 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-12-git-send-email-suzuki.poulose@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8faab60c-3025-d37f-6dd2-4f26bc32447c@redhat.com>
Date: Mon, 2 Jul 2018 16:59:43 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-12-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/20] kvm: arm64: Helper for computing
 VTCR_EL2.SL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com, Christoffer Dall <cdall@arm.com>, kvmarm@lists.cs.columbia.edu

Hi Suzuki,

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> VTCR_EL2 holds the following key stage2 translation table
> parameters:
>   SL0  - Entry level in the page table lookup.
>   T0SZ - Denotes the size of the memory addressed by the table.
> 
> We have been using fixed values for the SL0 depending on the
> page size as we have a fixed IPA size. But since we are about
> to make it dynamic, we need to calculate the SL0 at runtime
> per VM. This patch adds a helper to comput the value of SL0 for
compute
> a given IPA.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - Part 2 of split from VTCR & VTTBR dynamic configuration
> ---
>  arch/arm64/include/asm/kvm_arm.h | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index c557f45..11a7db0 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -153,7 +153,8 @@
>   * 2 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
> -#define VTTBR_X_TGRAN_MAGIC		38
> +#define VTCR_EL2_TGRAN_SL0_BASE		3UL
> +
>  #elif defined(CONFIG_ARM64_16K_PAGES)
>  /*
>   * Stage2 translation configuration:
> @@ -161,7 +162,7 @@
>   * 2 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
> -#define VTTBR_X_TGRAN_MAGIC		42
> +#define VTCR_EL2_TGRAN_SL0_BASE		3UL
>  #else	/* 4K */
>  /*
>   * Stage2 translation configuration:
> @@ -169,11 +170,39 @@
>   * 3 level page tables (SL = 1)
>   */
>  #define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
> -#define VTTBR_X_TGRAN_MAGIC		37
> +#define VTCR_EL2_TGRAN_SL0_BASE		2UL
>  #endif
>  
>  #define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
>  /*
> + * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
> + * Interestingly, it depends on the page size.
> + * See D.10.2.110, VTCR_EL2, in ARM DDI 0487B.b
update ref to the last one?
> + *
> + *	-----------------------------------------
> + *	| Entry level		|  4K  | 16K/64K |
> + *	------------------------------------------
> + *	| Level: 0		|  2   |   -     |
> + *	------------------------------------------
> + *	| Level: 1		|  1   |   2     |
> + *	------------------------------------------
> + *	| Level: 2		|  0   |   1     |
> + *	------------------------------------------
> + *	| Level: 3		|  -   |   0     |
> + *	------------------------------------------
> + *
> + * That table roughly translates to :
> + *
> + *	SL0(PAGE_SIZE, Entry_level) = SL0_BASE(PAGE_SIZE) - Entry_Level
> + *
> + * Where SL0_BASE(4K) = 2 and SL0_BASE(16K) = 3, SL0_BASE(64K) = 3, provided
> + * we take care of ruling out the unsupported cases and
> + * Entry_Level = 4 - Number_of_levels.
> + *
> + */
> +#define VTCR_EL2_SL0(levels) \
> +	((VTCR_EL2_TGRAN_SL0_BASE - (4 - (levels))) << VTCR_EL2_SL0_SHIFT)
> +/*
>   * ARM VMSAv8-64 defines an algorithm for finding the translation table
>   * descriptors in section D4.2.8 in ARM DDI 0487B.b.
>   *
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
