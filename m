Received: from eggs.gnu.org ([2001:4830:134:3::10]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1d5Zwj-0004AR-S8
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.morse@arm.com>) id 1d5Zwi-0004fz-LN
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:42:37 -0400
Message-ID: <5908A8C5.2020407@arm.com>
Date: Tue, 02 May 2017 16:41:57 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<1493530677-4919-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1493530677-4919-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] arm/arm64: signal SIBGUS and inject
 SEA Error
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
> when happen SEA, deliver signal bus and handle the ioctl that
> inject SEA abort to guest, so that guest can handle the SEA error.

> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 105b6ab..a96594f 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -20,8 +20,10 @@
> @@ -1238,6 +1240,36 @@ static void coherent_cache_guest_page(struct kvm_vcpu *vcpu, kvm_pfn_t pfn,
>  	__coherent_cache_guest_page(vcpu, pfn, size);
>  }
>  
> +static void kvm_send_signal(unsigned long address, bool hugetlb, bool hwpoison)
> +{
> +	siginfo_t info;
> +
> +	info.si_signo   = SIGBUS;
> +	info.si_errno   = 0;
> +	if (hwpoison)
> +		info.si_code    = BUS_MCEERR_AR;
> +	else
> +		info.si_code    = 0;
> +
> +	info.si_addr    = (void __user *)address;
> +	if (hugetlb)
> +		info.si_addr_lsb = PMD_SHIFT;
> +	else
> +		info.si_addr_lsb = PAGE_SHIFT;
> +
> +	send_sig_info(SIGBUS, &info, current);
> +}
> +

Punit reviewed the other version of this patch, this PMD_SHIFT is not the right
thing to do, it needs a more accurate set of calls and shifts as there may be
hugetlbfs pages other than PMD_SIZE.

https://www.spinics.net/lists/arm-kernel/msg568919.html

I haven't posted a new version of that patch because I was still hunting a bug
in the hugepage/hwpoison code, even with Punit's fixes series I see -EFAULT
returned to userspace instead of this hwpoison code being invoked.

Please avoid duplicating functionality between patches, it wastes reviewers
time, especially when we know there are problems with this approach.


> +static void kvm_handle_bad_page(unsigned long address,
> +					bool hugetlb, bool hwpoison)
> +{
> +	/* handle both hwpoison and other synchronous external Abort */
> +	if (hwpoison)
> +		kvm_send_signal(address, hugetlb, true);
> +	else
> +		kvm_send_signal(address, hugetlb, false);
> +}

Why the extra level of indirection? We only want to signal userspace like this
from KVM for hwpoison. Signals for RAS related reasons should come from the bits
of the kernel that decoded the error.

(hwpoison for KVM is a corner case as Qemu's memory effectively has two users,
Qemu and KVM. This isn't the example of how user-space gets signalled.)


> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index b37446a..780e3c4 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -277,6 +277,13 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>  	return -EINVAL;
>  }
>  
> +int kvm_vcpu_ioctl_sea(struct kvm_vcpu *vcpu)
> +{
> +	kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> +
> +	return 0;
> +}

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index bb02909..1d2e2e7 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1306,6 +1306,7 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
>  /* Available with KVM_CAP_X86_SMM */
>  #define KVM_SMI                   _IO(KVMIO,   0xb7)
> +#define KVM_ARM_SEA               _IO(KVMIO,   0xb8)
>  
>  #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
>  #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
> 

Why do we need a userspace API for SEA? It can also be done by using
KVM_{G,S}ET_ONE_REG to change the vcpu registers. The advantage of doing it this
way is you can choose which ESR value to use.

Adding a new API call to do something you could do with an old one doesn't look
right.


Thanks,

James
