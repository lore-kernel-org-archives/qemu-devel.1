Received: from eggs.gnu.org ([2001:4830:134:3::10]:60780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQtKf-0004JJ-D6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQtKa-0004b8-EV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:43:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fQtKa-0004af-7c
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:43:52 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<bbb4f800-1d16-3dcc-9abb-8a3024777923@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB012108@dggeml511-mbx.china.huawei.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <08a271a3-3e28-24e6-d37d-fdcc6df964bc@redhat.com>
Date: Thu, 7 Jun 2018 13:43:49 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB012108@dggeml511-mbx.china.huawei.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 07.06.2018 13:13, Gonglei (Arei) wrote:
> 
>> -----Original Message-----
>> From: David Hildenbrand [mailto:david@redhat.com]
>> Sent: Thursday, June 07, 2018 6:40 PM
>> Subject: Re: An emulation failure occurs,if I hotplug vcpus immediately after the
>> VM start
>>
>> On 06.06.2018 15:57, Paolo Bonzini wrote:
>>> On 06/06/2018 15:28, Gonglei (Arei) wrote:
>>>> gonglei********: mem.slot: 3, mem.guest_phys_addr=0xc0000,
>>>> mem.userspace_addr=0x7fc343ec0000, mem.flags=0, memory_size=0x0
>>>> gonglei********: mem.slot: 3, mem.guest_phys_addr=0xc0000,
>>>> mem.userspace_addr=0x7fc343ec0000, mem.flags=0,
>> memory_size=0x9000
>>>>
>>>> When the memory region is cleared, the KVM will tell the slot to be
>>>> invalid (which it is set to KVM_MEMSLOT_INVALID).
>>>>
>>>> If SeaBIOS accesses this memory and cause page fault, it will find an
>>>> invalid value according to gfn (by __gfn_to_pfn_memslot), and finally
>>>> it will return an invalid value, and finally it will return a
>>>> failure.
>>>>
>>>> So, My questions are:
>>>>
>>>> 1) Why don't we hold kvm->slots_lock during page fault processing?
>>>
>>> Because it's protected by SRCU.  We don't need kvm->slots_lock on the
>>> read side.
>>>
>>>> 2) How do we assure that vcpus will not access the corresponding
>>>> region when deleting an memory slot?
>>>
>>> We don't.  It's generally a guest bug if they do, but the problem here
>>> is that QEMU is splitting a memory region in two parts and that is not
>>> atomic.
>>
>> BTW, one ugly (but QEMU-only) fix would be to temporarily pause all
>> VCPUs, do the change and then unpause all VCPUs.
>>
> 
> The updating process of memory region is triggered by vcpu thread, not
> the main process though.

Yes, I also already ran into this problem. Because it involves calling
pause_all_vcpus() from a VCPU thread. I sent a patch for that already,
but we were able to solve the s390x problem differently.

https://patchwork.kernel.org/patch/10331305/

The major problem of pause_all_vcpus() is that it will temporarily drop
the iothread mutex, which can result in "funny" side effects :) Handling
parallel call to pause_all_vcpus() is the smaller issue.

So right now, it can only be used from the main thread.

> 
> Thanks,
> -Gonglei
> 
>>>
>>> One fix could be to add a KVM_SET_USER_MEMORY_REGIONS ioctl that
>>> replaces the entire memory map atomically.
>>>
>>> Paolo
>>>
>>
>>
>> --
>>
>> Thanks,
>>
>> David / dhildenb


-- 

Thanks,

David / dhildenb
