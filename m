Received: from eggs.gnu.org ([2001:4830:134:3::10]:39271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dFis5-000140-Ou
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dFis2-0000Be-Lt
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:15:45 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dFis2-0000BI-Fb
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:15:42 -0400
Received: by mail-wm0-x22f.google.com with SMTP id e127so103622930wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:15:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1495775808-10396-1-git-send-email-ann.zhuangyanying@huawei.com>
	<20170530133605.GA18926@potion>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48bd9449-cb91-c585-49b6-e90e7a696297@redhat.com>
Date: Tue, 30 May 2017 17:15:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170530133605.GA18926@potion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: herongguang.he@huawei.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, oscar.zhangbo@huawei.com, kvm@vger.kernel.org



On 30/05/2017 15:36, Radim Krčmář wrote:
>> -	if (atomic_read(&vcpu->arch.nmi_queued))
>> +	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
>> +	    (vcpu->arch.nmi_pending &&
> I think the logic should be
> 
>   	if ((kvm_test_request(KVM_REQ_NMI, vcpu) || vcpu->arch.nmi_pending) &&
>   			kvm_x86_ops->nmi_allowed(vcpu))
> 
> because there is no reason to resume the VCPU if we cannot inject.

KVM_REQ_NMI would be processed anyway, and would clear nmi_queued.  Of
course, it would very soon go back to sleep.  Even before Yanying's
patch, nmi_queued > 0 would have woken up the vCPU in this manner.  So
I'm applying the patch.  Thanks!

Paolo
