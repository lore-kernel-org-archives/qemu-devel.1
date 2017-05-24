Received: from eggs.gnu.org ([2001:4830:134:3::10]:50404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dDXMq-0004lP-Kz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dDXMm-0006Ty-Kc
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:34:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dDXMm-0006Td-De
	for qemu-devel@nongnu.org; Wed, 24 May 2017 10:34:24 -0400
Date: Wed, 24 May 2017 16:34:19 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170524143418.GA7778@potion>
References: <1495604922-4496-1-git-send-email-ann.zhuangyanying@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495604922-4496-1-git-send-email-ann.zhuangyanying@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] Fix nmi injection failure when vcpu got
 blocked
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

Please use tags in patches.
We usually begin the subject with "KVM: x86:" when touching
arch/x86/kvm/x86.c.

2017-05-24 13:48+0800, Zhuangyanying:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -8394,7 +8394,8 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
>  	if (vcpu->arch.pv.pv_unhalted)
>  		return true;
>  
> -	if (atomic_read(&vcpu->arch.nmi_queued))
> +	if (vcpu->arch.nmi_pending ||
> +	    atomic_read(&vcpu->arch.nmi_queued))
>  		return true;

Hm, I think we've been missing '&& kvm_x86_ops->nmi_allowed(vcpu)'.

The undesired resume if we have suppressed NMI is not making it much
worse, but wouldn't "kvm_test_request(KVM_REQ_NMI, vcpu)" also work
here?

>  	if (kvm_test_request(KVM_REQ_SMI, vcpu))

Thanks.
