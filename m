Received: from eggs.gnu.org ([2001:4830:134:3::10]:42635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDtVI-0006AH-MT
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDtVD-0000pz-Pw
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dDtVD-0000pS-K3
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:12:35 -0400
References: <1495604922-4496-1-git-send-email-ann.zhuangyanying@huawei.com>
	<20170524143418.GA7778@potion>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2dd7b4c5-de6c-a4c9-0fc3-45d9e3af9405@redhat.com>
Date: Thu, 25 May 2017 16:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170524143418.GA7778@potion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Zhuangyanying <ann.zhuangyanying@huawei.com>
Cc: herongguang.he@huawei.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, oscar.zhangbo@huawei.com, kvm@vger.kernel.org



On 24/05/2017 16:34, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
>> -	if (atomic_read(&vcpu->arch.nmi_queued))
>> +	if (vcpu->arch.nmi_pending ||
>> +	    atomic_read(&vcpu->arch.nmi_queued))
>>  		return true;
> Hm, I think we've been missing '&& kvm_x86_ops->nmi_allowed(vcpu)'.
>=20
> The undesired resume if we have suppressed NMI is not making it much
> worse, but wouldn't "kvm_test_request(KVM_REQ_NMI, vcpu)" also work
> here?

Yes, it would be fine (maybe better considering that we have a
KVM_REQ_SMI check just below).  Ying, please use it for v2.

Thanks,

Paolo
