Received: from eggs.gnu.org ([2001:4830:134:3::10]:51017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ff4zv-00009U-W0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ff4zm-0001JQ-ED
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:01:12 -0400
Received: from mail-eopbgr80110.outbound.protection.outlook.com
	([40.107.8.110]:10573
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ff4zl-0001Ic-O8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:01:02 -0400
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180713052051.GC2379@xz-mi>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <ea5a7ab5-920e-8599-3e6c-eb8634ad73b7@virtuozzo.com>
Date: Mon, 16 Jul 2018 18:00:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180713052051.GC2379@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 0/7] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org



On 13.07.2018 08:20, Peter Xu wrote:
> On Fri, Jun 29, 2018 at 11:03:13AM +0300, Denis Plotnikov wrote:
>> The patch set adds the ability to make external snapshots while VM is running.
>>
>> The workflow to make a snapshot is the following:
>> 1. Pause the vm
>> 2. Make a snapshot of block devices using the scheme of your choice
>> 3. Turn on background-snapshot migration capability
>> 4. Start the migration using the destination (migration stream) of your choice.
>>     The migration will resume the vm execution by itself
>>     when it has the devices' states saved  and is ready to start ram writing
>>     to the migration stream.
>> 5. Listen to the migration finish event
>>
>> The feature relies on KVM unapplied ability to report the faulting address.
>> Please find the KVM patch snippet to make the patchset work below:
>>
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -XXXX,X +XXXX,XX @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>>   
>>          vcpu->arch.exit_qualification = exit_qualification;
>>   
>> -       return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
>> +       r = kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
>> +        if (r == -EFAULT) {
>> +               unsigned long hva = kvm_vcpu_gfn_to_hva(vcpu, gpa >> PAGE_SHIFT);
>> +
>> +               vcpu->run->exit_reason = KVM_EXIT_FAIL_MEM_ACCESS;
>> +               vcpu->run->hw.hardware_exit_reason = EXIT_REASON_EPT_VIOLATION;
>> +               vcpu->run->fail_mem_access.hva = hva | (gpa & (PAGE_SIZE-1));
>> +               r = 0;
>> +
>> +       }
>> +       return r;
>>
>> The patch to KVM can be sent if the patch set approved
> 
> Hi, Denis,
> 
> If the work will definitely require KVM to cooperate, AFAIU the thing
> we normally do is that we first propose the kernel counterpart on kvm
> list, then it'll be easier to review the QEMU counterpart (or, propose
> both kvm/qemu changes at the same time, always the QEMU changes can be
> RFC, as a reference to prove the kvm change is valid and useful).  Not
> sure whether you should do this as well for this live snapshot work.
> 
> Since we might have two backends in the future, my major question for
> that counterpart series would be whether we need to support both in
> the future (mprotect, and userfaultfd), and the differences between
> the two methods from kernel's point of view.  I would vaguely guess
> that we can at least firstly have mprotect work then userfaultfd then
> we can automatically choose the backend when both are provided, but I
> guess that discussion might still better happen on the kvm list.  Also
> I would also guess that in that work you'd better consider no-ept case
> as well for Intel, even for AMD.  But not sure we can at least start a
> RFC with the simplest scenario and prove its validity.
> 
> Regards,
> 
Hi, Peter,
I think this is a good idea to go through the KVM path firstly.
When the discussion come to some conclusion further steps may become
more clear.
I'll send the patch there shortly to start the discussion.

Thanks!

Best, Denis
