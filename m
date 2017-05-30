Received: from eggs.gnu.org ([2001:4830:134:3::10]:39257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dFhJn-0005ZW-OG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dFhJj-0000gQ-Dg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:36:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dFhJj-0000gC-7D
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:36:11 -0400
Date: Tue, 30 May 2017 15:36:05 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170530133605.GA18926@potion>
References: <1495775808-10396-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495775808-10396-1-git-send-email-ann.zhuangyanying@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3] KVM: x86: Fix nmi injection failure
 when vcpu got blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: pbonzini@redhat.com, herongguang.he@huawei.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, oscar.zhangbo@huawei.com, kvm@vger.kernel.org

2017-05-26 13:16+0800, Zhuangyanying:
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
> Add checking nmi_pending, and testing KVM_REQ_NMI replaces nmi_queued
> in vm_vcpu_has_events().
> 
> Do the same change for SMIs.
> 
> Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
> ---
> v1->v2
>   - simplify message. The complete description is here:
>     http://www.spinics.net/lists/kvm/msg150380.html
>   - Testing KVM_REQ_NMI replaces nmi_pending.
>   - Add Testing kvm_x86_ops->nmi_allowed(vcpu).
> v2->v3
>   - Testing KVM_REQ_NMI replaces nmi_queued, not nmi_pending.
>   - Do the same change for SMIs. 
> ---
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -8394,10 +8394,13 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.pv.pv_unhalted)
>  		return true;
>  
> -	if (atomic_read(&vcpu->arch.nmi_queued))
> +	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
> +	    (vcpu->arch.nmi_pending &&

I think the logic should be

  	if ((kvm_test_request(KVM_REQ_NMI, vcpu) || vcpu->arch.nmi_pending) &&
  			kvm_x86_ops->nmi_allowed(vcpu))

because there is no reason to resume the VCPU if we cannot inject.

> +	     kvm_x86_ops->nmi_allowed(vcpu)))
>  		return true;
>  
> -	if (kvm_test_request(KVM_REQ_SMI, vcpu))
> +	if (kvm_test_request(KVM_REQ_SMI, vcpu) ||
> +	    (vcpu->arch.smi_pending && !is_smm(vcpu)))

Ditto.

>  		return true;
>  
>  	if (kvm_arch_interrupt_allowed(vcpu) &&

We'll then be consistent with other interrupts,

Thanks.
