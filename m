Received: from eggs.gnu.org ([2001:4830:134:3::10]:44610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1e48jv-00065r-61
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1e48jq-0007TU-BI
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:59:43 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:36250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1e48jq-0007SZ-3e
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:59:38 -0400
References: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
	<20171013170143.GB3370@work-vm>
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-ID: <26dbfe2b-ee38-c998-9dfc-eb8d9ebfefd3@oracle.com>
Date: Mon, 16 Oct 2017 09:59:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171013170143.GB3370@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] host physical address width issues/questions for
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, Sunit Jain <sunit.jain@oracle.com>, pbonzini@redhat.com, rth@twiddle.net


On 10/13/2017 10:01 AM, Dr. David Alan Gilbert wrote:
> * Prasad Singamsetty (prasad.singamsetty@oracle.com) wrote:
>> Hi,
>>
>> I am new to the alias. I have some questions on this subject
>> and seek some clarifications from the experts in the team.
>> I ran into a couple of issues when I tried with large configuration
>> ( >= 1TB memory, > 255 CPUs) for x86_64 guest machine.
>>
>> 1. QEMU uses the default value of 40 (TCG_PHYS_ADDR_BITS) for address
>>     width if user has not specified phys-bits or host-phys-bits=true
>>     property. The default value is obviously not sufficient and
>>     causing guest kernel to crash if configured with >= 1TB
>>     memory. Depending on the linux kernel version in the guest the
>>     panic was in different code paths. The workaround is for the
>>     user to specify the phys-bits property or set the property
>>     host-phys-bits=true.
>>
>>     QUESTIONS:
>>     1) Could we change the default value to same as the host physcial
>>        address for x86_64 machines?  Are there any side effects on this?
> 
> That's what we do in the RH downstream packages.
> 
> If you did that you wouldn't want to break existing machine-types,
> so you'd have to tie it to a new machine type.

OK.

> There's some fun with MTRRs that have bits set based on the address
> size, and if you migrate between hosts with different physical address sizes; e.g. between
> a non-Xeon (or I think a Xeon-E3) and the bigger boxes you have
> to be careful.  See fcc35e7 and commits around that;  tbh I can't
> remember the details.

Right. The problem with migration between hosts is still there.

> 
>>     2) Adding a check to fail to boot the guest if phys-bits is not
>>        sufficient for the specified maxmem or if it is more than
>>        the host phys bits value. Do you have any objections if I
>>        add a patch for this?
> 
> It's a little more complicated, but good in principal.  You need
> to take account of the allocated address space for hotplug
> and I think the PCI address space;  I can't remember if we
> ever figured out a good way of finding that out.
> I think it might also depend if you're on SeaBIOS or OVMF
> about what they're defaults are for things like where PCI
> gets allocated.

Thanks for the suggestions. I will check with OVMF also.

> 
>> 2. host_address_width in DMAR table structure
>>
>>     In this case, the default value is set to 39
>>     (VTD_HOST_ADDRESS_WIDTH - 1). With interrupt remapping
>>     enabled for the intel iommu and the guest is configured
>>     with > 255 cpus and >= 1TB memory, the guest kernel hangs
>>     during boot up. This need to be fixed.
>>
>>     QUESTION:
>>     The question here again is can we fix this to use the
>>     real address width from the host as the default?
> 
> I don't know DMAR stuff; chatting to Alex (cc'd) it does sound
> like that's an ommission that should be fixed.

Thanks,
--Prasad

> 
>> Please let me know if you have some suggestions in fixing these
>> two problem cases for supporting large config guests. Also, please
>> let me know if there are any other known limitations in the current
>> implementation.
> 
> Dave
> 
>>
>> Thanks.
>> --Prasad
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
