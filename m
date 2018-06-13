Received: from eggs.gnu.org ([2001:4830:134:3::10]:45212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fT8AK-0002Lb-SM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fT8AG-0003Ys-HJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:58:32 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fT8AG-0003Wn-6N
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:58:28 -0400
Received: by mail-wm0-x244.google.com with SMTP id e16-v6so5648343wmd.0
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 08:58:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1526462314-19720-1-git-send-email-zhaoshenglong@huawei.com>
	<25094a6a-df4e-3dbb-ef69-e478edb46ff3@redhat.com>
	<5B207E41.3080209@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdd4182f-6f7c-16ae-e800-3219bf1d09e9@redhat.com>
Date: Wed, 13 Jun 2018 17:58:18 +0200
MIME-Version: 1.0
In-Reply-To: <5B207E41.3080209@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: Delete the slot only when
 KVM_MEM_READONLY flag is changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, guangrong.xiao@gmail.com
Cc: shannon.zhaosl@gmail.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org

On 13/06/2018 04:15, Shannon Zhao wrote:
> 
> 
> On 2018/6/12 20:17, Paolo Bonzini wrote:
>> On 16/05/2018 11:18, Shannon Zhao wrote:
>>> According to KVM commit 75d61fbc, it needs to delete the slot before
>>> changing the KVM_MEM_READONLY flag. But QEMU commit 235e8982 only check
>>> whether KVM_MEM_READONLY flag is set instead of changing. It doesn't
>>> need to delete the slot if the KVM_MEM_READONLY flag is not changed.
>>>
>>> This fixes a issue that migrating a VM at the OVMF startup stage and
>>> VM is executing the codes in rom. Between the deleting and adding the
>>> slot in kvm_set_user_memory_region, there is a chance that guest access
>>> rom and trap to KVM, then KVM can't find the corresponding memslot.
>>> While KVM (on ARM) injects an abort to guest due to the broken hva, then
>>> guest will get stuck.
>>>
>>> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
>>
>> I'm a bit worried about old_flags not being set on all paths to
>> kvm_set_user_memory_region.  This would lead to extra
>> KVM_SET_USER_MEMORY_REGION calls.  It should not be a problem but
>> it is ugly.  Does something like the additional changes below work for you?
>>
> I test below patch. It works for our testcase.
> Do I need to fold them into one and resend?

No need to, thanks!

Paolo
