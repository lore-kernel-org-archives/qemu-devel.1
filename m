Received: from eggs.gnu.org ([2001:4830:134:3::10]:39569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1d5Zsm-0003B4-2D
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1d5Zsl-00088Z-3f
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:38:32 -0400
Message-ID: <5908A7CE.7030008@arm.com>
Date: Tue, 02 May 2017 16:37:50 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<1493530677-4919-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1493530677-4919-2-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] arm64: kvm: inject SError with
 virtual syndrome
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com

Hi Dongjiu Geng,

On 30/04/17 06:37, Dongjiu Geng wrote:
> when SError happen, kvm notifies kvmtool to generate GHES table
> to record the error, then kvmtools inject the SError with specified
> virtual syndrome. when switch to guest, a virtual SError will happen with
> this specified syndrome.

GHES records in the HEST (T)able have to be generated before the OS starts as
these are read at boot. Did you mean generate CPER records?


It looks like this is based on the earlier SEI series, please work together and
post a combined series when there are changes. (It also good to summarise the
changes in the cover letter.)

This patch is modifying the world-switch to save/restore VSESR. You should
explain that VSESR is the Virtual SError Syndrome, it becomes the ESR value when
HCR_EL2.VSE injects an SError. This register was added by the RAS Extensions and
needs patching in or guarding.


> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index aede165..ded6211 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -86,6 +86,13 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>  		isb();
>  	}
>  	write_sysreg(val, hcr_el2);
> +    /* If virtual System Error or Asynchronous Abort is pending. set
> +     * the virtual exception syndrome information
> +     */
> +	if (cpus_have_cap(ARM64_HAS_RAS_EXTN) &&

Is cpus_have_cap() safe to use at EL2?
This would be the first user, and it accesses cpu_hwcaps. You probably want
something like the static_branch_unlikely()s in the vgic code elsewhere in this
file.


> +			(vcpu->arch.hcr_el2 & HCR_VSE))
> +		write_sysreg_s(vcpu->arch.fault.vsesr_el2, VSESR_EL2);
> +

I think this would be clearer if you took this out to a helper method called
something like restore_vsesr() and did the if(cap|VSE) stuff there.

(Nit: comment style)


>  	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
>  	write_sysreg(1 << 15, hstr_el2);
>  	/*
> @@ -139,9 +146,15 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
>  	 * the crucial bit is "On taking a vSError interrupt,
>  	 * HCR_EL2.VSE is cleared to 0."
>  	 */
> -	if (vcpu->arch.hcr_el2 & HCR_VSE)
> +	if (vcpu->arch.hcr_el2 & HCR_VSE) {
>  		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
>  
> +		if (cpus_have_cap(ARM64_HAS_RAS_EXTN)) {
> +			/* set vsesr_el2[24:0] with esr_el2[24:0] */
> +			kvm_vcpu_set_vsesr(vcpu, read_sysreg_el2(esr)
> +					& VSESR_ELx_IDS_ISS_MASK);

There is no need for KVM to save the VSESR. It is copied to ESR_EL1 when
HCR_EL2.VSE delivers the SError, after this we don't care what the register
value is. When we switch to a guest we should set the value from KVM whenever
the VSE bit is set. We should never read back the value in hardware.

Why read ESR_EL2? This will give you a completely unrelated value. If EL2 takes
an IRQ or a page fault between pending the SError and delivering it, we
overwrite the value set by KVM or user-space with a stray EL2 value.


... I think you expect an SError to arrive at EL2 and have its ESR recorded in
vcpu->arch.fault.vsesr_el2. Some time later KVM decides to inject an SError into
the guest, and this ESR is reused...

We shouldn't do this. Qemu/kvmtool may want to inject a virtual-SError that
never started as a physical-SError. Qemu/kvmtool may choose to notify the guest
of RAS events via another mechanism, or not at all.

KVM should not give the guest an ESR value of its choice. For SError the ESR
describes whether the error is corrected, correctable or fatal. Qemu/kvmtool
must choose this.

I think we need an API that allows Qemu/kvmtool to inject SError into a guest,
but that isn't quite what you have here.

The VSESR value should always come from user space. The only exception are
SErrors that we know weren't due to RAS: for these we should set the VSESR to
zero to keep the existing behaviour.


Thanks,

James
