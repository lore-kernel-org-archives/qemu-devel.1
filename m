Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa4Gx-0000BV-7D
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fa4Gt-0005y2-SQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:14:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fa4Gt-0005wa-KI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:13:59 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-13-git-send-email-suzuki.poulose@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c8091c05-b7ea-92fa-6d04-917619691381@redhat.com>
Date: Mon, 2 Jul 2018 21:13:54 +0200
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-13-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/20] kvm: arm64: Add helper for
 loading the stage2 setting for a VM
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
> We load the stage2 context of a guest for different operations,
> including running the guest and tlb maintenance on behalf of the
> guest. As of now only the vttbr is private to the guest, but this
> is about to change with IPA per VM. Add a helper to load the stage2
> configuration for a VM, which could do the right thing with the
> future changes.
> 
> Cc: Christoffer Dall <cdall@kernel.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> Changes since v2:
>  - New patch
> ---
>  arch/arm64/include/asm/kvm_hyp.h | 6 ++++++
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  arch/arm64/kvm/hyp/tlb.c         | 4 ++--
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 384c343..82f9994 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -155,5 +155,11 @@ void deactivate_traps_vhe_put(void);
>  u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
>  void __noreturn __hyp_do_panic(unsigned long, ...);
>  
> +/* Must be called from hyp code running at EL2 */
> +static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
> +{
> +	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +}
> +
>  #endif /* __ARM64_KVM_HYP_H__ */
>  
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index d496ef5..355fb25 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -195,7 +195,7 @@ void deactivate_traps_vhe_put(void)
>  
>  static void __hyp_text __activate_vm(struct kvm *kvm)
>  {
> -	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +	__load_guest_stage2(kvm);
>  }
>  
>  static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index 131c777..4dbd9c6 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -30,7 +30,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
>  	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
>  	 * let's flip TGE before executing the TLB operation.
>  	 */
> -	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +	__load_guest_stage2(kvm);
>  	val = read_sysreg(hcr_el2);
>  	val &= ~HCR_TGE;
>  	write_sysreg(val, hcr_el2);
> @@ -39,7 +39,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
>  
>  static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
>  {
> -	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +	__load_guest_stage2(kvm);
>  	isb();
>  }
>  
> 
