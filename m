Received: from eggs.gnu.org ([2001:4830:134:3::10]:60320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d5WoL-0005aR-M0
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d5WoH-0005Tl-Lk
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:21:45 -0400
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<1493530677-4919-2-git-send-email-gengdongjiu@huawei.com>
	<20170502080342.GF16940@cbox>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <2117d351-b7d7-c721-e613-457891ce63e9@huawei.com>
Date: Tue, 2 May 2017 20:20:18 +0800
MIME-Version: 1.0
In-Reply-To: <20170502080342.GF16940@cbox>
Content-Type: text/plain; charset="windows-1252"
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
To: Christoffer Dall <cdall@linaro.org>
Cc: james.morse@arm.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, linux-kernel@vger.kernel.org, gengdongjiu <gengdongjiu@huawei.com>

Hello Christoffer.


On 2017/5/2 16:03, Christoffer Dall wrote:
> On Sun, Apr 30, 2017 at 01:37:56PM +0800, Dongjiu Geng wrote:
>> when SError happen, kvm notifies kvmtool to generate GHES table
>> to record the error, then kvmtools inject the SError with specified
> 
> again, is this really specific to kvmtool?  Pleae try to explain this
> mechanism in generic terms.
  It is both for qemu and other userspace application. I will correct it.

> 
>> virtual syndrome. when switch to guest, a virtual SError will happen with
>> this specified syndrome.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  arch/arm64/include/asm/esr.h         |  2 ++
>>  arch/arm64/include/asm/kvm_emulate.h | 10 ++++++++++
>>  arch/arm64/include/asm/kvm_host.h    |  1 +
>>  arch/arm64/include/asm/sysreg.h      |  3 +++
>>  arch/arm64/kvm/handle_exit.c         | 25 +++++++++++++++++++------
>>  arch/arm64/kvm/hyp/switch.c          | 15 ++++++++++++++-
>>  include/uapi/linux/kvm.h             |  5 +++++
>>  7 files changed, 54 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index 22f9c90..d009c99 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -127,6 +127,8 @@
>>  #define ESR_ELx_WFx_ISS_WFE	(UL(1) << 0)
>>  #define ESR_ELx_xVC_IMM_MASK	((1UL << 16) - 1)
>>  
>> +#define VSESR_ELx_IDS_ISS_MASK    ((1UL << 25) - 1)
>> +
>>  /* ESR value templates for specific events */
>>  
>>  /* BRK instruction trap from AArch64 state */
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index f5ea0ba..a3259a9 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -148,6 +148,16 @@ static inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
>>  	return vcpu->arch.fault.esr_el2;
>>  }
>>  
>> +static inline u32 kvm_vcpu_get_vsesr(const struct kvm_vcpu *vcpu)
>> +{
>> +		return vcpu->arch.fault.vsesr_el2;
>> +}
>> +
>> +static inline void kvm_vcpu_set_vsesr(struct kvm_vcpu *vcpu, unsigned long val)
>> +{
>> +		vcpu->arch.fault.vsesr_el2 = val;
>> +}
>> +
>>  static inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
>>  {
>>  	u32 esr = kvm_vcpu_get_hsr(vcpu);
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index e7705e7..84ed239 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -86,6 +86,7 @@ struct kvm_vcpu_fault_info {
>>  	u32 esr_el2;		/* Hyp Syndrom Register */
>>  	u64 far_el2;		/* Hyp Fault Address Register */
>>  	u64 hpfar_el2;		/* Hyp IPA Fault Address Register */
>> +	u32 vsesr_el2;		/* Virtual SError Exception Syndrome Register */
>>  };
>>  
>>  /*
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 32964c7..b6afb7a 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -125,6 +125,9 @@
>>  #define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
>>  #define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
>>  
>> +#define VSESR_EL2			sys_reg(3, 4, 5, 2, 3)
>> +
>> +
>>  #define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |	\
>>  				      (!!x)<<8 | 0x1f)
>>  #define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index c89d83a..3d024a9 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -180,7 +180,11 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>>  
>>  static int kvm_handle_guest_sei(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  {
>> -	unsigned long fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
>> +	unsigned long hva, fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
>> +	struct kvm_memory_slot *memslot;
>> +	int hsr, ret = 1;
>> +	bool writable;
>> +	gfn_t gfn;
>>  
>>  	if (handle_guest_sei((unsigned long)fault_ipa,
>>  				kvm_vcpu_get_hsr(vcpu))) {
>> @@ -190,9 +194,20 @@ static int kvm_handle_guest_sei(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  				(unsigned long)kvm_vcpu_get_hsr(vcpu));
>>  
>>  		kvm_inject_vabt(vcpu);
>> +	} else {
>> +		hsr = kvm_vcpu_get_hsr(vcpu);
>> +
>> +		gfn = fault_ipa >> PAGE_SHIFT;
>> +		memslot = gfn_to_memslot(vcpu->kvm, gfn);
>> +		hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>> +
>> +		run->exit_reason = KVM_EXIT_INTR;
>> +		run->intr.syndrome_info = hsr;
>> +		run->intr.address = hva;
>> +		ret = 0;
>>  	}
>>  
>> -	return 0;
>> +	return ret;
>>  }
>>  
>>  /*
>> @@ -218,8 +233,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>  			*vcpu_pc(vcpu) -= adj;
>>  		}
>>  
>> -		kvm_handle_guest_sei(vcpu, run);
>> -		return 1;
>> +		return kvm_handle_guest_sei(vcpu, run);
>>  	}
>>  
>>  	exception_index = ARM_EXCEPTION_CODE(exception_index);
>> @@ -228,8 +242,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>  	case ARM_EXCEPTION_IRQ:
>>  		return 1;
>>  	case ARM_EXCEPTION_EL1_SERROR:
>> -		kvm_handle_guest_sei(vcpu, run);
>> -		return 1;
>> +		return kvm_handle_guest_sei(vcpu, run);
>>  	case ARM_EXCEPTION_TRAP:
>>  		/*
>>  		 * See ARM ARM B1.14.1: "Hyp traps on instructions
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index aede165..ded6211 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -86,6 +86,13 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>>  		isb();
>>  	}
>>  	write_sysreg(val, hcr_el2);
>> +    /* If virtual System Error or Asynchronous Abort is pending. set
> 
> nit: I think you want a comma after pending, not a dot.
> 
>> +     * the virtual exception syndrome information
>> +     */
> 
> nit: commenting style
> 
>> +	if (cpus_have_cap(ARM64_HAS_RAS_EXTN) &&
>> +			(vcpu->arch.hcr_el2 & HCR_VSE))
>> +		write_sysreg_s(vcpu->arch.fault.vsesr_el2, VSESR_EL2);
>> +
>>  	/* Trap on AArch32 cp15 c15 accesses (EL1 or EL0) */
>>  	write_sysreg(1 << 15, hstr_el2);
>>  	/*
>> @@ -139,9 +146,15 @@ static void __hyp_text __deactivate_traps(struct kvm_vcpu *vcpu)
>>  	 * the crucial bit is "On taking a vSError interrupt,
>>  	 * HCR_EL2.VSE is cleared to 0."
>>  	 */
>> -	if (vcpu->arch.hcr_el2 & HCR_VSE)
>> +	if (vcpu->arch.hcr_el2 & HCR_VSE) {
>>  		vcpu->arch.hcr_el2 = read_sysreg(hcr_el2);
>>  
>> +		if (cpus_have_cap(ARM64_HAS_RAS_EXTN)) {
>> +			/* set vsesr_el2[24:0] with esr_el2[24:0] */
>> +			kvm_vcpu_set_vsesr(vcpu, read_sysreg_el2(esr)
>> +					& VSESR_ELx_IDS_ISS_MASK);
>> +		}
>> +	}
>>  	__deactivate_traps_arch()();
>>  	write_sysreg(0, hstr_el2);
>>  	write_sysreg(0, pmuserenr_el0);
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 27fe556..bb02909 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -360,6 +360,11 @@ struct kvm_run {
>>  		struct {
>>  			__u8 vector;
>>  		} eoi;
>> +		/* KVM_EXIT_INTR */
>> +		struct {
>> +			__u32 syndrome_info;
>> +			__u64 address;
>> +		} intr;
> 
> definitely, not.  KVM_EXIT_INTR is a generic exit code to tell userspace
> that we exited because we needed to deliver a signal or something else
> related to an asynchronous event.  This implies that the syndrome_info
> etc. always has valid values on all architectures when exiting with
> KVM_EXIT_INTR.
> 
> Either document the behavior as the syndrome_info has side-channel
> information on every exit, or on some KVM_EXIT_INTR exits, as we explain
> in the KVM_CAP_ARM_USER_IRQ ABI that was just added, or dedicate an
> access code.
OK.

> 
>>  		/* KVM_EXIT_HYPERV */
>>  		struct kvm_hyperv_exit hyperv;
>>  		/* Fix the size of the union. */
>> -- 
>> 2.10.1
>>
> 
> I'll look at the details of such patches once the ABI is clear and
> well-documented.
  OK.

> 
> Thanks,
> -Christoffer
> 
> .
> 
