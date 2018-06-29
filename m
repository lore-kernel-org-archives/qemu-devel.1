Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fYujW-0004eS-KJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fYujR-0005BZ-Jt
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fYujR-0005A6-Dx
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:50:41 -0400
From: Auger Eric <eric.auger@redhat.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <163cca54-3e0d-750d-a203-c97b2e3f2f29@redhat.com>
Date: Fri, 29 Jun 2018 16:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-4-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/20] arm64: Add a helper for PARange
 to physical shift conversion
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
> On arm64, ID_AA64MMFR0_EL1.PARange encodes the maximum Physical
> Address range supported by the CPU. Add a helper to decode this
> to actual physical shift. If we hit an unallocated value, return
> the maximum range supported by the kernel.
> This is will be used by the KVM to set the VTCR_EL2.T0SZ, as it
s/is// and s/the KVM/KVM
> is about to move its place. Having this helper keeps the code
> movement cleaner.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Split the patch
>  - Limit the physical shift only for values unrecognized.
> ---
>  arch/arm64/include/asm/cpufeature.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 1717ba1..855cf0e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -530,6 +530,19 @@ void arm64_set_ssbd_mitigation(bool state);
>  static inline void arm64_set_ssbd_mitigation(bool state) {}
>  #endif
>  
> +static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> +{
> +	switch (parange) {
> +	case 0: return 32;
> +	case 1: return 36;
> +	case 2: return 40;
> +	case 3: return 42;
> +	case 4: return 44;
> +	case 5: return 48;
> +	case 6: return 52;
> +	default: return CONFIG_ARM64_PA_BITS;
> +	}
> +}
>  #endif /* __ASSEMBLY__ */
>  
>  #endif
>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
