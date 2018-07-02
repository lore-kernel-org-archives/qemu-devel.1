Received: from eggs.gnu.org ([2001:4830:134:3::10]:44139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZz6x-0004h4-7h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZz6u-00009m-45
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:43:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40026
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZz6t-00009C-Tz
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:43:20 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-19-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <ea593baa-a7d8-6328-456c-1ca0476f7d75@arm.com>
Date: Mon, 2 Jul 2018 14:43:14 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-19-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/20] kvm: arm64: Add support for
 handling 52bit IPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Kristina Martsenko <kristina.martsenko@arm.com>

On 29/06/18 12:15, Suzuki K Poulose wrote:
> Add support for handling the 52bit IPA. 52bit IPA
> support needs changes to the following :
> 
>  1) Page-table entries - We use kernel page table helpers for setting
>  up the stage2. Hence we don't explicit changes here
> 
>  2) VTTBR:BADDR - This is already supported with :
>    commit 529c4b05a3cb2f324aa ("arm64: handle 52-bit addresses in TTBR")
> 
>  3) VGIC support for 52bit: Supported with a patch in this series.
> 
> That leaves us with the handling for PAR and HPAR. This patch adds

HPFAR?

> support for handling the 52bit addresses in PAR and HPFAR,
> which are used while handling the permission faults in stage1.

Overall, this is a pretty confusing commit message. Can you just call it:

KVM/arm64: Add 52bit support for PAR to HPFAR conversion

and just describe that it now uses PHYS_MASK_SHIFT instead of a
hardcoded constant?

> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h | 7 +++++++
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 2e90942..cb6a2ee 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -301,6 +301,13 @@
>  
>  /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>  #define HPFAR_MASK	(~UL(0xf))
> +/*
> + * We have
> + *	PAR	[PA_Shift - 1	: 12] = PA	[PA_Shift - 1 : 12]
> + *	HPFAR	[PA_Shift - 9	: 4]  = FIPA	[PA_Shift - 1 : 12]
> + */
> +#define PAR_TO_HPFAR(par)		\
> +	(((par) & GENMASK_ULL(PHYS_MASK_SHIFT - 1, 12)) >> 8)
>  
>  #define kvm_arm_exception_type	\
>  	{0, "IRQ" }, 		\
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 355fb25..fb66320 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -260,7 +260,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  		return false; /* Translation failed, back to guest */
>  
>  	/* Convert PAR to HPFAR format */
> -	*hpfar = ((tmp >> 12) & ((1UL << 36) - 1)) << 4;
> +	*hpfar = PAR_TO_HPFAR(tmp);
>  	return true;
>  }
>  
> 

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
