Received: from eggs.gnu.org ([2001:4830:134:3::10]:50340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehJDd-00089h-Fb
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehJDX-0006rd-CO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:04:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehJDX-0006rC-4B
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:04:11 -0500
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-2-marcel@redhat.com>
	<20180131204059.GG21702@localhost.localdomain>
	<20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201135340.GU26425@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <db40e5ca-9a15-4faf-4675-f29b0ee4ab22@redhat.com>
Date: Thu, 1 Feb 2018 20:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180201135340.GU26425@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On 01/02/2018 15:53, Eduardo Habkost wrote:
> On Thu, Feb 01, 2018 at 02:29:25PM +0200, Marcel Apfelbaum wrote:
>> On 01/02/2018 14:10, Eduardo Habkost wrote:
>>> On Thu, Feb 01, 2018 at 07:36:50AM +0200, Marcel Apfelbaum wrote:
>>>> On 01/02/2018 4:22, Michael S. Tsirkin wrote:
>>>>> On Wed, Jan 31, 2018 at 09:34:22PM -0200, Eduardo Habkost wrote:
>>> [...]
>>>>>> BTW, what's the root cause for requiring HVAs in the buffer?
>>>>>
>>>>> It's a side effect of the kernel/userspace API which always wants
>>>>> a single HVA/len pair to map memory for the application.
>>>>>
>>>>>
>>>>
>>>> Hi Eduardo and Michael,
>>>>
>>>>>>  Can
>>>>>> this be fixed?
>>>>>
>>>>> I think yes.  It'd need to be a kernel patch for the RDMA subsystem
>>>>> mapping an s/g list with actual memory. The HVA/len pair would then just
>>>>> be used to refer to the region, without creating the two mappings.
>>>>>
>>>>> Something like splitting the register mr into
>>>>>
>>>>> mr = create mr (va/len) - allocate a handle and record the va/len
>>>>>
>>>>> addmemory(mr, offset, hva, len) - pin memory
>>>>>
>>>>> register mr - pass it to HW
>>>>>
>>>>> As a nice side effect we won't burn so much virtual address space.
>>>>>
>>>>
>>>> We would still need a contiguous virtual address space range (for post-send)
>>>> which we don't have since guest contiguous virtual address space
>>>> will always end up as non-contiguous host virtual address space.
>>>>
>>>> I am not sure the RDMA HW can handle a large VA with holes.
>>>
>>> I'm confused.  Why would the hardware see and care about virtual
>>> addresses? 
>>
>> The post-send operations bypasses the kernel, and the process
>> puts in the work request GVA addresses.
>>
>>> How exactly does the hardware translates VAs to
>>> PAs? 
>>
>> The HW maintains a page-directory like structure different form MMU
>> VA -> phys pages
>>
>>> What if the process page tables change?
>>>
>>
>> Since the page tables the HW uses are their own, we just need the phys
>> page to be pinned.
> 
> So there's no hardware-imposed requirement that the hardware VAs
> (mapped by the HW page directory) match the VAs in QEMU
> address-space, right? 

Actually there is. Today it works exactly as you described.

> If the RDMA API is updated to remove this
> requirement, couldn't you just use the untranslated guest VAs
> directly?
> 

When the RDMA API will be decided we will still need to pass
some kind of VA to the HW, but if we succeed to remove the
phys page registration from the VA, yes, it will be possible.


Thanks,
Marcel
