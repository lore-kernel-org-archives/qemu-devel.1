Received: from eggs.gnu.org ([2001:4830:134:3::10]:35178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsrjg-0000eT-Na
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsrjd-0007uI-Jt
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dsrjd-0007tD-E5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:36:49 -0400
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
	<f3b0b14e-4ea1-6c4e-f9c6-cb86e78c6104@de.ibm.com>
	<c2195ec9-a3d7-eb14-c204-d5c0e6239811@redhat.com>
	<129fdced-8f83-e408-b37a-26c6ba8bb48f@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <169bbaaf-3212-ce1d-a0db-6edede5b481d@redhat.com>
Date: Fri, 15 Sep 2017 16:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <129fdced-8f83-e408-b37a-26c6ba8bb48f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>

On 29.03.2017 16:25, Christian Borntraeger wrote:
> On 03/29/2017 04:21 PM, Thomas Huth wrote:
>> On 24.03.2017 10:39, Christian Borntraeger wrote:
>>> On 03/24/2017 10:26 AM, Thomas Huth wrote:
>>>> When running QEMU with KVM under z/VM, the memory for the guest
>>>> is allocated via legacy_s390_alloc() since the KVM_CAP_S390_COW
>>>> extension is not supported on z/VM. legacy_s390_alloc() then uses
>>>> mmap(... PROT_EXEC ...) for the guest memory - but this does not
>>>> work when running with SELinux enabled, mmap() fails and QEMU aborts
>>>> with the following error message:
>>>>
>>>>  cannot set up guest memory 's390.ram': Permission denied
>>>>
>>>> Looking at the other allocator function qemu_anon_ram_alloc(), it
>>>> seems like PROT_EXEC is normally not needed for allocating the
>>>> guest RAM, and indeed, the guest also starts successfully under
>>>> z/VM when we remove the PROT_EXEC from the legacy_s390_alloc()
>>>> function. So let's get rid of that flag here to be able to run
>>>> with SELinux under z/VM, too.
>>>
>>> Older z/VM versions do not provide the enhanced suppression on protection
>>> facility, which would result in guest failures as soon as the kernel
>>> starts dirty pages tracking by write protecting the pages via the page
>>> table. Some kernel release back (last time I checked) the PROT_EXEC was 
>>> necessary to prevent the dirty pages tracking from taking place. So this
>>> patch would break KVM in that case.
>>>
>>> Newer z/VMs (e.g. 6.3) do provide ESOP. SO the question is,
>>> why is KVM_CAP_S390_COW not set?
>>
>> I now had another look at this, and seems like the ESOP bit is indeed
>> not set in S390_lowcore.machine_flags here. According to /proc/sysinfo,
>> z/VM is version 6.1.0 here, so I guess that's just too old for ESOP?
> 
> Yes, this was introduced with z/VM 6.3

FWIW, the last version without ESOP, z/VM 6.2, is now end of life,
according to: http://www.vm.ibm.com/techinfo/lpmigr/vmleos.html
... so I guess we could remove the legacy_s390_alloc() function now?

 Thomas
