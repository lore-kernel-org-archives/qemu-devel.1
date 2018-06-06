Received: from eggs.gnu.org ([2001:4830:134:3::10]:46658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQZM7-00058R-Ke
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fQZM3-0006UH-RI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:24:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fQZM3-0006U1-LL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:24:03 -0400
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
	<7CECC2DFC21538489F72729DF5EFB4D9C1D8F1@dggemm501-mbs.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86fe2845-0804-ff48-cf1b-3bf7e4ff3310@redhat.com>
Date: Wed, 6 Jun 2018 16:23:59 +0200
MIME-Version: 1.0
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D9C1D8F1@dggemm501-mbs.china.huawei.com>
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
To: xuyandong <xuyandong2@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 06/06/2018 16:18, xuyandong wrote:
>> We don't.  It's generally a guest bug if they do, but the problem here is that
>> QEMU is splitting a memory region in two parts and that is not atomic.
>> 	
>> One fix could be to add a KVM_SET_USER_MEMORY_REGIONS ioctl that
>> replaces the entire memory map atomically.
>>
>> Paolo
> After we add a KVM_SET_USER_MEMORY_REGIONS ioctl that replaces the entire
> memory map atomically, how to use it in address_space_update_topology?
> Shall we checkout the spilt memory region before 
> " address_space_update_topology_pass(as, old_view, new_view, false); 
> address_space_update_topology_pass(as, old_view, new_view, true);

You would add the regions to an array in kvm_region_add, and send the
ioctl in the .commit callback of MemoryListener.

kvm_region_del would disappear.  The .commit callback would also look at
the array from the previous execution, and call memory_region_unref on
the regions in there.

Paolo
