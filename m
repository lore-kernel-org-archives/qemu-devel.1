Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehJxg-0002PY-Sm
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehJxc-0007Bv-08
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:51:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehJxb-0007AQ-Nl
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:51:47 -0500
Date: Thu, 1 Feb 2018 16:51:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180201185129.GI21702@localhost.localdomain>
References: <20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
	<20180201121009.GR26425@localhost.localdomain>
	<bac4ac10-72ef-679e-69e6-95cdda32d2ab@redhat.com>
	<20180201135340.GU26425@localhost.localdomain>
	<db40e5ca-9a15-4faf-4675-f29b0ee4ab22@redhat.com>
	<20180201182108.GE26425@localhost.localdomain>
	<f87b5810-6d87-bd92-be70-dd620501a29d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87b5810-6d87-bd92-be70-dd620501a29d@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, cohuck@redhat.com, f4bug@amsat.org, yuval.shaia@oracle.com, borntraeger@de.ibm.com, pbonzini@redhat.com, imammedo@redhat.com

On Thu, Feb 01, 2018 at 08:31:09PM +0200, Marcel Apfelbaum wrote:
> On 01/02/2018 20:21, Eduardo Habkost wrote:
> > On Thu, Feb 01, 2018 at 08:03:53PM +0200, Marcel Apfelbaum wrote:
> >> On 01/02/2018 15:53, Eduardo Habkost wrote:
> >>> On Thu, Feb 01, 2018 at 02:29:25PM +0200, Marcel Apfelbaum wrote:
> >>>> On 01/02/2018 14:10, Eduardo Habkost wrote:
> >>>>> On Thu, Feb 01, 2018 at 07:36:50AM +0200, Marcel Apfelbaum wrote:
> >>>>>> On 01/02/2018 4:22, Michael S. Tsirkin wrote:
> >>>>>>> On Wed, Jan 31, 2018 at 09:34:22PM -0200, Eduardo Habkost wrote:
> >>>>> [...]
> >>>>>>>> BTW, what's the root cause for requiring HVAs in the buffer?
> >>>>>>>
> >>>>>>> It's a side effect of the kernel/userspace API which always wants
> >>>>>>> a single HVA/len pair to map memory for the application.
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> Hi Eduardo and Michael,
> >>>>>>
> >>>>>>>>  Can
> >>>>>>>> this be fixed?
> >>>>>>>
> >>>>>>> I think yes.  It'd need to be a kernel patch for the RDMA subsystem
> >>>>>>> mapping an s/g list with actual memory. The HVA/len pair would then just
> >>>>>>> be used to refer to the region, without creating the two mappings.
> >>>>>>>
> >>>>>>> Something like splitting the register mr into
> >>>>>>>
> >>>>>>> mr = create mr (va/len) - allocate a handle and record the va/len
> >>>>>>>
> >>>>>>> addmemory(mr, offset, hva, len) - pin memory
> >>>>>>>
> >>>>>>> register mr - pass it to HW
> >>>>>>>
> >>>>>>> As a nice side effect we won't burn so much virtual address space.
> >>>>>>>
> >>>>>>
> >>>>>> We would still need a contiguous virtual address space range (for post-send)
> >>>>>> which we don't have since guest contiguous virtual address space
> >>>>>> will always end up as non-contiguous host virtual address space.
> >>>>>>
> >>>>>> I am not sure the RDMA HW can handle a large VA with holes.
> >>>>>
> >>>>> I'm confused.  Why would the hardware see and care about virtual
> >>>>> addresses? 
> >>>>
> >>>> The post-send operations bypasses the kernel, and the process
> >>>> puts in the work request GVA addresses.
> >>>>
> >>>>> How exactly does the hardware translates VAs to
> >>>>> PAs? 
> >>>>
> >>>> The HW maintains a page-directory like structure different form MMU
> >>>> VA -> phys pages
> >>>>
> >>>>> What if the process page tables change?
> >>>>>
> >>>>
> >>>> Since the page tables the HW uses are their own, we just need the phys
> >>>> page to be pinned.
> >>>
> >>> So there's no hardware-imposed requirement that the hardware VAs
> >>> (mapped by the HW page directory) match the VAs in QEMU
> >>> address-space, right? 
> >>
> >> Actually there is. Today it works exactly as you described.
> > 
> > Are you sure there's such hardware-imposed requirement?
> > 
> 
> Yes.
> 
> > Why would the hardware require VAs to match the ones in the
> > userspace address-space, if it doesn't use the CPU MMU at all?
> > 
> 
> It works like that:
> 
> 1. We register a buffer from the process address space
>    giving its base address and length.
>    This call goes to kernel which in turn pins the phys pages
>    and registers them with the device *together* with the base
>    address (virtual address!)
> 2. The device builds its own page tables to be able to translate
>    the virtual addresses to actual phys pages.

How would the device be able to do that?  It would require the
device to look at the process page tables, wouldn't it?  Isn't
the HW IOVA->PA translation table built by the OS?


> 3. The process executes post-send requests directly to hw by-passing
>    the kernel giving process virtual addresses in work requests.
> 4. The device uses its own page tables to translate the virtual
>    addresses to phys pages and sending them.
> 
> Theoretically is possible to send any contiguous IOVA instead of
> process's one but is not how is working today.
> 
> Makes sense?

-- 
Eduardo
