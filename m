Received: from eggs.gnu.org ([2001:4830:134:3::10]:60276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fZy8M-00027x-Bn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fZy8I-0002dn-Cb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:40:46 -0400
Received: from mail-he1eur01on0120.outbound.protection.outlook.com
	([104.47.0.120]:16563
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fZy8H-0002dA-0V
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:40:42 -0400
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180702112308.GO2455@xz-mi>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <e935a3ea-6714-8f92-fe67-9f820646efc3@virtuozzo.com>
Date: Mon, 2 Jul 2018 15:40:31 +0300
MIME-Version: 1.0
In-Reply-To: <20180702112308.GO2455@xz-mi>
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



On 02.07.2018 14:23, Peter Xu wrote:
> On Fri, Jun 29, 2018 at 11:03:13AM +0300, Denis Plotnikov wrote:
>> The patch set adds the ability to make external snapshots while VM is running.
> 
> Hi, Denis,
> 
> This work is interesting, though I have a few questions to ask in
> general below.
> 
>>
>> The workflow to make a snapshot is the following:
>> 1. Pause the vm
>> 2. Make a snapshot of block devices using the scheme of your choice
> 
> Here you explicitly took the snapshot for the block device, then...
> 
>> 3. Turn on background-snapshot migration capability
>> 4. Start the migration using the destination (migration stream) of your choice.
> 
> ... here you started the VM snapshot.  How did you make sure that the
> VM snapshot (e.g., the RAM data) and the block snapshot will be
> aligned?
As the VM has been paused before making an image(disk) snapshot, there 
should be no requests to the original image done ever since. All the 
later request's goes to the disk snapshot.

At the point we have a disk image and its snapshot.
In the image we have kind of checkpoint-ed state which won't (shouldn't) 
be changed because all the writing requests should go to the image snapshot.

Then we start the background snapshot which marks all the memory as 
read-only and writing the part of VM state to the VM snapshot file.
By making the memory read-only we kind of freeze the state of the RAM.

At that point we have an original image and the VM memory content which 
corresponds to each other because the VM isn't running.

Then, the background snapshot thread continues VM execution with the 
read-only-marked memory which is being written to the external VM 
snapshot file. All the write accesses to the memory are intercepted and 
the memory pages being accessed are written to the VM snapshot (VM 
state) file in priority. Having marked as read-write right after the 
writing, the memory pages aren't tracked for later accesses.

This is how we guarantee that the VM snapshot (state) file has the 
memory content corresponding to the moment when the disk snapshot is 
created.

When the writing ends, we have the VM snapshot (VM state) file which has 
the memory content saved by the moment of the image snapshot creating.

So, to restore the VM from "the snapshot" we need to use the original 
image disk (not the disk snapshot) and the VM snapshot (VM state with 
saved memory) file.

> 
> For example, in current save_snapshot() we'll quiesce disk IOs before
> migrating the last pieces of RAM data to make sure they are aligned.
> I didn't figure out myself on how that's done in this work.
> 
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
> 
> Just to make sure I fully understand here: so this is some extra KVM
> work just to make sure the mprotect() trick will work even for KVM
> vcpu threads, am I right?

That's correct!
> 
> Meanwhile, I see that you only modified EPT violation code, then how
> about the legacy hardwares and softmmu case?

Didn't check thoroughly but the scheme works in TCG mode.


Thanks,
Denis

> 
> Thanks,
> 
>>
>> The patch to KVM can be sent if the patch set approved
>>
>> Denis Plotnikov (7):
>>    migration: add background snapshot capability
>>    bitops: add some atomic versions of bitmap operations
>>    threads: add infrastructure to process sigsegv
>>    migration: add background snapshot infrastructure
>>    kvm: add failed memeory access exit reason
>>    kvm: add vCPU failed memeory access processing
>>    migration: add background snapshotting
>>
>>   include/exec/ram_addr.h   |   7 +
>>   include/exec/ramlist.h    |   4 +-
>>   include/qemu/bitops.h     |  24 +++
>>   include/qemu/thread.h     |   5 +
>>   linux-headers/linux/kvm.h |   5 +
>>   migration/migration.c     | 141 +++++++++++++++-
>>   migration/migration.h     |   1 +
>>   migration/ram.c           | 333 ++++++++++++++++++++++++++++++++++++--
>>   migration/ram.h           |  11 +-
>>   migration/savevm.c        |  91 ++++++-----
>>   migration/savevm.h        |   2 +
>>   qapi/migration.json       |   6 +-
>>   target/i386/kvm.c         |  18 +++
>>   util/qemu-thread-posix.c  |  50 ++++++
>>   14 files changed, 635 insertions(+), 63 deletions(-)
>>
>> -- 
>> 2.17.0
>>
>>
> 
