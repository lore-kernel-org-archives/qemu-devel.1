Received: from eggs.gnu.org ([2001:4830:134:3::10]:54342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eh7YX-0004V2-JD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 00:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eh7YU-0007uJ-GR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 00:37:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eh7YU-0007td-7t
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 00:37:02 -0500
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-2-marcel@redhat.com>
	<20180131204059.GG21702@localhost.localdomain>
	<20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
Date: Thu, 1 Feb 2018 07:36:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180201040608-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 1/4] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On 01/02/2018 4:22, Michael S. Tsirkin wrote:
> On Wed, Jan 31, 2018 at 09:34:22PM -0200, Eduardo Habkost wrote:
>> On Wed, Jan 31, 2018 at 11:10:07PM +0200, Michael S. Tsirkin wrote:
>>> On Wed, Jan 31, 2018 at 06:40:59PM -0200, Eduardo Habkost wrote:
>>>> On Wed, Jan 17, 2018 at 11:54:18AM +0200, Marcel Apfelbaum wrote:
>>>>> Currently only file backed memory backend can
>>>>> be created with a "share" flag in order to allow
>>>>> sharing guest RAM with other processes in the host.
>>>>>
>>>>> Add the "share" flag also to RAM Memory Backend
>>>>> in order to allow remapping parts of the guest RAM
>>>>> to different host virtual addresses. This is needed
>>>>> by the RDMA devices in order to remap non-contiguous
>>>>> QEMU virtual addresses to a contiguous virtual address range.
>>>>>
>>>>
>>>> Why do we need to make this configurable?  Would anything break
>>>> if MAP_SHARED was always used if possible?
>>>
>>> See Documentation/vm/numa_memory_policy.txt for a list
>>> of complications.
>>
>> Ew.
>>
>>>
>>> Maybe we should more of an effort to detect and report these
>>> issues.
>>
>> Probably.  Having other features breaking silently when using
>> pvrdma doesn't sound good.  We must at least document those
>> problems in the documentation for memory-backend-ram.
>>
>> BTW, what's the root cause for requiring HVAs in the buffer?
> 
> It's a side effect of the kernel/userspace API which always wants
> a single HVA/len pair to map memory for the application.
> 
> 

Hi Eduardo and Michael,

>>  Can
>> this be fixed?
> 
> I think yes.  It'd need to be a kernel patch for the RDMA subsystem
> mapping an s/g list with actual memory. The HVA/len pair would then just
> be used to refer to the region, without creating the two mappings.
> 
> Something like splitting the register mr into
> 
> mr = create mr (va/len) - allocate a handle and record the va/len
> 
> addmemory(mr, offset, hva, len) - pin memory
> 
> register mr - pass it to HW
> 
> As a nice side effect we won't burn so much virtual address space.
>

We would still need a contiguous virtual address space range (for post-send)
which we don't have since guest contiguous virtual address space
will always end up as non-contiguous host virtual address space.

I am not sure the RDMA HW can handle a large VA with holes.

An alternative would be 0-based MR, QEMU intercepts the post-send
operations and can substract the guest VA base address.
However I didn't see the implementation in kernel for 0 based MRs
and also the RDMA maintainer said it would work for local keys
and not for remote keys.

> This will fix rdma with hugetlbfs as well which is currently broken.
> 
> 

There is already a discussion on the linux-rdma list:
    https://www.spinics.net/lists/linux-rdma/msg60079.html
But it will take some (actually a lot of) time, we are currently talking about
a possible API. And it does not solve the re-mapping...

Thanks,
Marcel

>> -- 
>> Eduardo
