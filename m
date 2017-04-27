Received: from eggs.gnu.org ([2001:4830:134:3::10]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d3ZSM-0003P9-4o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d3ZSJ-0002uE-2m
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:46:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3859
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d3ZSH-0002o8-W0
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:46:55 -0400
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<d45d6e46-32fa-a4f2-53cb-680ca773d609@redhat.com>
From: Yang Hongyang <yanghongyang@huawei.com>
Message-ID: <32a0bbb9-b08f-0cc7-5461-f11ba32cc27b@huawei.com>
Date: Thu, 27 Apr 2017 10:46:05 +0800
MIME-Version: 1.0
In-Reply-To: <d45d6e46-32fa-a4f2-53cb-680ca773d609@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: quintela@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Huangzhichao <huangzhichao@huawei.com>, wangxinxin.wang@huawei.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Hi Paolo, Dave,

On 2017/4/26 23:46, Paolo Bonzini wrote:
> 
> 
> On 24/04/2017 18:42, Dr. David Alan Gilbert wrote:
>> I suppose there's a few questions;
>>   a) Do we actually need the BQL - and if so why

Enable/disable dirty log tracking are operations on memory regions.
That's why they need to be in BQL I think.

>>   b) What actually takes 13s?  It's probably worth figuring
>> out where it goes,  the whole bitmap is only 1GB isn't it
>> even on a 4TB machine, and even the simplest way to fill
>> that takes way less than 13s.

I found two time consuming operations in KVM module,

- one is kvm_mmu_slot_apply_flags(), when enable dirty log tracking
kvm_vm_ioctl_set_memory_region
  |->kvm_set_memory_region
     |->__kvm_set_memory_region
        |->kvm_arch_commit_memory_region
           |->kvm_mmu_slot_apply_flags
              ...

- the other is kvm_mmu_zap_collapsible_sptes(), when disable dirty log tracking
kvm_vm_ioctl_set_memory_region
  |->kvm_set_memory_region
     |->__kvm_set_memory_region
        |->kvm_arch_commit_memory_region
           |->kvm_mmu_zap_collapsible_sptes
              ...

Any ideas that could optimize the time spending for these operations?

> 
> It's more likely that it is the migration_bitmap_sync immediately after
> that.

It's not, it's enable/disable dirty log tracking that costs time.

> 
> I think it is possible to move migration_bitmap_sync outside BQL.  It
> should be simpler to evaluate that after Juan's cleanups go in.
> 
> Paolo
> 

-- 
Thanks,
Yang
