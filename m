Received: from eggs.gnu.org ([2001:4830:134:3::10]:52250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1cfp1x-0000Z7-HB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1cfp1u-000254-Ak
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:33:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.vnet.ibm.com>)
	id 1cfp1u-00024w-1n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:33:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KESYNx092420
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:33:26 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pp6mt6gx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:33:24 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 14:33:18 -0000
References: <0f8f3bd3-04d2-7213-2afb-ea75507eced6@linux.vnet.ibm.com>
	<04c71d8f-a923-0d66-1c4e-9a24eaf1971c@redhat.com>
From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Mon, 20 Feb 2017 15:33:15 +0100
MIME-Version: 1.0
In-Reply-To: <04c71d8f-a923-0d66-1c4e-9a24eaf1971c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <5959e40a-ea71-8a26-30d3-cff4d857e3d3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] Error handling for KVM_GET_DIRTY_LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

On 20.02.2017 14:46, Paolo Bonzini wrote:
> 
> 
> On 16/02/2017 15:51, Janosch Frank wrote:
>> While trying to fix a bug in the s390 migration code, I noticed that
>> QEMU ignores practically all errors returned from that VM ioctl. QEMU
>> behaves as specified in the KVM api and only processes -1 (-EPERM) as an
>> error.
>>
>> Unfortunately the documentation is wrong/old and KVM may return -EFAULT,
>> -EINVAL, -ENOTSUPP (BookE) and -ENOENT. This bugs me, as I found a case
>> where I want to return -EFAULT because of guest memory problems and QEMU
>> will still happily migrate the VM.
> 
> Guest memory problems should not return EFAULT, which corresponds to a
> wrong address passed to KVM_GET_DIRTY_LOG.  In fact, EFAULT is probably
> the only case where an assertion is warranted---just like you passed a
> wrong pointer to KVM_GET_DIRTY_LOG, who knows who else is going to get
> that pointer.
> 
> ENOENT and EINVAL should not kill the source guest, though they should
> terminate migration.  But then I would like to know more about this
> case, because they should never happen unless KVMMemoryListener is buggy.

It is currently possible to start a hugetlbfs guest on s390 although we
don't have any huge page support. When QEMU starts the VM, it will get a
lot of errors back and pause the VM. When this VM is then migrated, the
host will do pte dirty handling on huge pages in
kvm_s390_sync_dirty_log/test_and_clear_guest_dirty

Running into such a huge page would be a guest memory error, so EINVAL
it is.

I'll post the patches in a bit to give a bit more context.

> 
> Paolo
> 
>> I currently don't see a reason why we continue to migrate on EFAULT and
>> EINVAL. But returning -error from kvm_physical_sync_dirty_bitmap might
>> also a bit hard, as it kills QEMU.
>>
>> Do we want to fix this and if, how do we want it done?
>> If not we at least have a definitive mail to point to when the next one
>> comes around. I also have a KVM patch to update the api documentation if
>> wanted (maybe we should dust that off a bit anyhow).
>>
>>
>> This has been brought up in 2009 [1] the first time and was more or less
>> fixed and then reverted in 2014 [2].
>>
>> The reason in [1] was that PPC hadn't settled yet on a valid return code.
>>
>> In [2] it was too close to the v2 to handle it properly.
>>
>>
>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2009-07/msg01772.html
>>
>> [2] https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg01993.html
>>
>>
>> Cheers,
>> Janosch
>>
> 
