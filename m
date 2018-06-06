Received: from eggs.gnu.org ([2001:4830:134:3::10]:40332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQYwg-00009l-AL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQYwd-0000eQ-8P
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fQYwd-0000e5-2B
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:47 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
Date: Wed, 6 Jun 2018 15:57:42 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 06/06/2018 15:28, Gonglei (Arei) wrote:
> gonglei********: mem.slot: 3, mem.guest_phys_addr=0xc0000,
> mem.userspace_addr=0x7fc343ec0000, mem.flags=0, memory_size=0x0 
> gonglei********: mem.slot: 3, mem.guest_phys_addr=0xc0000,
> mem.userspace_addr=0x7fc343ec0000, mem.flags=0, memory_size=0x9000
> 
> When the memory region is cleared, the KVM will tell the slot to be 
> invalid (which it is set to KVM_MEMSLOT_INVALID).
> 
> If SeaBIOS accesses this memory and cause page fault, it will find an
> invalid value according to gfn (by __gfn_to_pfn_memslot), and finally
> it will return an invalid value, and finally it will return a
> failure.
> 
> So, My questions are:
> 
> 1) Why don't we hold kvm->slots_lock during page fault processing?

Because it's protected by SRCU.  We don't need kvm->slots_lock on the
read side.

> 2) How do we assure that vcpus will not access the corresponding 
> region when deleting an memory slot?

We don't.  It's generally a guest bug if they do, but the problem here
is that QEMU is splitting a memory region in two parts and that is not
atomic.

One fix could be to add a KVM_SET_USER_MEMORY_REGIONS ioctl that
replaces the entire memory map atomically.

Paolo
