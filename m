Received: from eggs.gnu.org ([2001:4830:134:3::10]:43583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDtZz-0007AM-PK
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDtZv-0002wH-4u
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:17:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDtZu-0002wA-VA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:17:27 -0400
References: <1495695403-8252-1-git-send-email-ann.zhuangyanying@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4062f7de-0dea-d206-afb9-d2aa1c4d79bd@redhat.com>
Date: Thu, 25 May 2017 16:17:20 +0200
MIME-Version: 1.0
In-Reply-To: <1495695403-8252-1-git-send-email-ann.zhuangyanying@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] KVM: x86: Fix nmi injection failure
 when vcpu got blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>, rkrcmar@redhat.com, herongguang.he@huawei.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, oscar.zhangbo@huawei.com, kvm@vger.kernel.org



On 25/05/2017 08:56, Zhuangyanying wrote:
> From: ZhuangYanying <ann.zhuangyanying@huawei.com>
> 
> When spin_lock_irqsave() deadlock occurs inside the guest, vcpu threads,
> other than the lock-holding one, would enter into S state because of
> pvspinlock. Then inject NMI via libvirt API "inject-nmi", the NMI could
> not be injected into vm.
> 
> The reason is:
> 1 It sets nmi_queued to 1 when calling ioctl KVM_NMI in qemu, and sets
> cpu->kvm_vcpu_dirty to true in do_inject_external_nmi() meanwhile.
> 2 It sets nmi_queued to 0 in process_nmi(), before entering guest, because
> cpu->kvm_vcpu_dirty is true.
> 
> It's not enough just to check nmi_queued to decide whether to stay in
> vcpu_block() or not. NMI should be injected immediately at any situation.
> Add checking KVM_REQ_NMI request plus with nmi_queued in
> vm_vcpu_has_events().
> 
> Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 02363e3..2d15708 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8394,7 +8394,9 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.pv.pv_unhalted)
>  		return true;
>  
> -	if (atomic_read(&vcpu->arch.nmi_queued))
> +	if ((kvm_test_request(KVM_REQ_NMI, vcpu) ||
> +	    atomic_read(&vcpu->arch.nmi_queued)) &&
> +	    kvm_x86_ops->nmi_allowed(vcpu))

It's the other way round; nmi_pending was correct in your v1.

Testing KVM_REQ_NMI replaces nmi_queued, while the bugfix tests
"vcpu->arch.nmi_pending && kvm_x86_ops->nmi_allowed(vcpu)".  The new est
has to match the existing test in inject_pending_event.

In fact, we also need to do the same change for SMIs, i.e.

	kvm_test_request(KVM_REQ_SMI, vcpu) ||
	(vcpu->arch.smi_pending && !is_smm(vcpu))

Thanks,

Paolo

>  		return true;
>  
>  	if (kvm_test_request(KVM_REQ_SMI, vcpu))
> 
