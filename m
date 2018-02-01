Received: from eggs.gnu.org ([2001:4830:134:3::10]:51625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehJH9-0003Of-C6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehJH6-0001Yp-71
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:07:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehJH5-0001YR-UE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:07:52 -0500
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-2-marcel@redhat.com>
	<20180131204059.GG21702@localhost.localdomain>
	<20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201150254-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <eae7cba7-20da-976f-bd47-d7d548ae7457@redhat.com>
Date: Thu, 1 Feb 2018 20:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180201150254-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On 01/02/2018 16:24, Michael S. Tsirkin wrote:
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
> 
> To be more precise, it's the guest supplied IOVA that is sent to the card.
> 
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
>>
>>>>
>>>> An alternative would be 0-based MR, QEMU intercepts the post-send
>>>> operations and can substract the guest VA base address.
>>>> However I didn't see the implementation in kernel for 0 based MRs
>>>> and also the RDMA maintainer said it would work for local keys
>>>> and not for remote keys.
>>>
>>> This is also unexpected: are GVAs visible to the virtual RDMA
>>> hardware? 
>>
>> Yes, explained above
>>
>>> Where does the QEMU pvrdma code translates GVAs to
>>> GPAs?
>>>
>>
>> During reg_mr (memory registration commands)
>> Then it registers the same addresses to the real HW.
>> (as Host virtual addresses)
>>
>> Thanks,
>> Marcel
> 
> 
> The full fix would be to allow QEMU to map a list of
> pages to a guest supplied IOVA.
> 

Agreed, we are trying to influence the RDMA discussion
on the new API in this direction.

Thanks,
Marcel

>>>>
>>>>> This will fix rdma with hugetlbfs as well which is currently broken.
>>>>>
>>>>>
>>>>
>>>> There is already a discussion on the linux-rdma list:
>>>>     https://www.spinics.net/lists/linux-rdma/msg60079.html
>>>> But it will take some (actually a lot of) time, we are currently talking about
>>>> a possible API. And it does not solve the re-mapping...
>>>>
>>>> Thanks,
>>>> Marcel
>>>>
>>>>>> -- 
>>>>>> Eduardo
>>>>
>>>
