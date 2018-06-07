Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQsId-0001gK-Hn
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQsIa-0001eY-Ea
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:37:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fQsIa-0001dU-3Y
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:37:44 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <77604174-3c15-a8d3-3ea3-53a1759cd885@redhat.com>
Date: Thu, 7 Jun 2018 12:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 06.06.2018 15:57, Paolo Bonzini wrote:
> On 06/06/2018 15:28, Gonglei (Arei) wrote:
>> gonglei********: mem.slot: 3, mem.guest_phys_addr=0xc0000,
>> mem.userspace_addr=0x7fc343ec0000, mem.flags=0, memory_size=0x0 
>> gonglei********: mem.slot: 3, mem.guest_phys_addr=0xc0000,
>> mem.userspace_addr=0x7fc343ec0000, mem.flags=0, memory_size=0x9000
>>
>> When the memory region is cleared, the KVM will tell the slot to be 
>> invalid (which it is set to KVM_MEMSLOT_INVALID).
>>
>> If SeaBIOS accesses this memory and cause page fault, it will find an
>> invalid value according to gfn (by __gfn_to_pfn_memslot), and finally
>> it will return an invalid value, and finally it will return a
>> failure.
>>
>> So, My questions are:
>>
>> 1) Why don't we hold kvm->slots_lock during page fault processing?
> 
> Because it's protected by SRCU.  We don't need kvm->slots_lock on the
> read side.
> 
>> 2) How do we assure that vcpus will not access the corresponding 
>> region when deleting an memory slot?
> 
> We don't.  It's generally a guest bug if they do, but the problem here
> is that QEMU is splitting a memory region in two parts and that is not
> atomic.
> 
> One fix could be to add a KVM_SET_USER_MEMORY_REGIONS ioctl that
> replaces the entire memory map atomically.
> 
> Paolo
> 

Hi Paolo,

I have a related requirement, which would be to atomically grow a
memory regions. So instead of region_del(old)+region_add(new), I would
have to do it in one shot (atomically).

AFAICS an atomic replace of the memory map would work for this, too.
However I am not sure how we want to handle all kinds of tracking data
that is connected to e.g. x86 memory slots (e.g. rmap, dirty bitmap ...).

And for a generic KVM_SET_USER_MEMORY_REGIONS, we would have to handle
this somehow.

-- 

Thanks,

David / dhildenb
