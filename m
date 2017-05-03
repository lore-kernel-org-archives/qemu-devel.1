Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5vcc-0004V9-Q8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d5vcX-0002pa-Re
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:51:18 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d5vcG-0002kl-0E
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:51:13 -0400
Received: by mail-pf0-x242.google.com with SMTP id b23so4679755pfc.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 07:50:55 -0700 (PDT)
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
Date: Wed, 3 May 2017 22:50:55 +0800
MIME-Version: 1.0
In-Reply-To: <e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/03/2017 08:28 PM, Paolo Bonzini wrote:
> So if I understand correctly this relies on userspace doing:
> 
> 	1) KVM_GET_DIRTY_LOG without write protect
> 	2) KVM_WRITE_PROTECT_ALL_MEM
> 	<only look now at the dirty log snapshot>
> 
> Writes may happen between 1 and 2; they are not represented in the live
> dirty bitmap but it's okay because they are in the snapshot and will
> only be used after 2.  This is similar to what the dirty page ring
> buffer patches do; in fact, the KVM_WRITE_PROTECT_ALL_MEM ioctl is very
> similar to KVM_RESET_DIRTY_PAGES in those patches.
> 

You are right. After 1) and 2), the page which has been modified either
in the bitmap returned to userspace or in the bitmap of memslot, i.e,
there is no dirty page lost.

> On 03/05/2017 12:52, guangrong.xiao@gmail.com wrote:
>> Comparing with the ordinary algorithm which
>> write protects last level sptes based on the rmap one by one,
>> it just simply updates the generation number to ask all vCPUs
>> to reload its root page table, particularly, it can be done out
>> of mmu-lock, so that it does not hurt vMMU's parallel.
> 
> This is clever.
> 
> For processors that have PML, write protecting is only done on large
> pages and only for splitting purposes; not for dirty page tracking
> process at 4k granularity.  In this case, I think that you should do
> nothing in the new write-protect-all ioctl?

Good point, thanks for you pointing it out.
Doing nothing in write-protect-all() is not acceptable as it breaks
its semantic. :(

Furthermore, userspace has no knowledge about if PML is enable (it
can be required from sysfs, but it is a good way in QEMU), so it is
difficult for the usespace to know when to use write-protect-all.
Maybe we can make KVM_CAP_X86_WRITE_PROTECT_ALL_MEM return false if
PML is enabled?

> 
> Also, I wonder how the alternative write protection mechanism would
> affect performance of the dirty page ring buffer patches.  You would do
> the write protection of all memory at the end of
> kvm_vm_ioctl_reset_dirty_pages.  You wouldn't even need a separate
> ioctl, which is nice.  On the other hand, checkpoints would be more
> frequent and most pages would be write-protected, so it would be more
> expensive to rebuild the shadow page tables...

Yup, write-protect-all can improve reset_dirty_pages indeed, i will
apply your idea after reset_dirty_pages is merged.

However, we still prefer to have a separate ioctl for write-protect-all
which cooperates with KVM_GET_DIRTY_LOG to improve live migration that
should not always depend on checkpoint.

> 
> Thanks,
> 
> Paolo
> 
>> @@ -490,6 +511,7 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
>>           memset(d.dirty_bitmap, 0, allocated_size);
>>   
>>           d.slot = mem->slot | (kml->as_id << 16);
>> +        d.flags = kvm_write_protect_all ? KVM_DIRTY_LOG_WITHOUT_WRITE_PROTECT : 0;
>>           if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
>>               DPRINTF("ioctl failed %d\n", errno);
>>               ret = -1;
> 
> How would this work when kvm_physical_sync_dirty_bitmap is called from
> memory_region_sync_dirty_bitmap rather than
> memory_region_global_dirty_log_sync?

You are right, we did not consider the full cases carefully, will fix it
when push it to QEMU formally.

Thank you, Paolo!
