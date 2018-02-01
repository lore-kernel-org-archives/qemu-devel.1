Received: from eggs.gnu.org ([2001:4830:134:3::10]:51597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehDhN-000344-1g
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehDhH-0005pi-6M
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:10:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehDhH-0005p3-0c
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:10:31 -0500
Date: Thu, 1 Feb 2018 10:10:09 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180201121009.GR26425@localhost.localdomain>
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-2-marcel@redhat.com>
	<20180131204059.GG21702@localhost.localdomain>
	<20180131230607-mutt-send-email-mst@kernel.org>
	<20180131233422.GP26425@localhost.localdomain>
	<20180201040608-mutt-send-email-mst@kernel.org>
	<8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dbc7c99-84f6-0023-526b-359fdf2b5162@redhat.com>
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

On Thu, Feb 01, 2018 at 07:36:50AM +0200, Marcel Apfelbaum wrote:
> On 01/02/2018 4:22, Michael S. Tsirkin wrote:
> > On Wed, Jan 31, 2018 at 09:34:22PM -0200, Eduardo Habkost wrote:
[...]
> >> BTW, what's the root cause for requiring HVAs in the buffer?
> > 
> > It's a side effect of the kernel/userspace API which always wants
> > a single HVA/len pair to map memory for the application.
> > 
> > 
> 
> Hi Eduardo and Michael,
> 
> >>  Can
> >> this be fixed?
> > 
> > I think yes.  It'd need to be a kernel patch for the RDMA subsystem
> > mapping an s/g list with actual memory. The HVA/len pair would then just
> > be used to refer to the region, without creating the two mappings.
> > 
> > Something like splitting the register mr into
> > 
> > mr = create mr (va/len) - allocate a handle and record the va/len
> > 
> > addmemory(mr, offset, hva, len) - pin memory
> > 
> > register mr - pass it to HW
> > 
> > As a nice side effect we won't burn so much virtual address space.
> >
> 
> We would still need a contiguous virtual address space range (for post-send)
> which we don't have since guest contiguous virtual address space
> will always end up as non-contiguous host virtual address space.
> 
> I am not sure the RDMA HW can handle a large VA with holes.

I'm confused.  Why would the hardware see and care about virtual
addresses?  How exactly does the hardware translates VAs to
PAs?  What if the process page tables change?

> 
> An alternative would be 0-based MR, QEMU intercepts the post-send
> operations and can substract the guest VA base address.
> However I didn't see the implementation in kernel for 0 based MRs
> and also the RDMA maintainer said it would work for local keys
> and not for remote keys.

This is also unexpected: are GVAs visible to the virtual RDMA
hardware?  Where does the QEMU pvrdma code translates GVAs to
GPAs?

> 
> > This will fix rdma with hugetlbfs as well which is currently broken.
> > 
> > 
> 
> There is already a discussion on the linux-rdma list:
>     https://www.spinics.net/lists/linux-rdma/msg60079.html
> But it will take some (actually a lot of) time, we are currently talking about
> a possible API. And it does not solve the re-mapping...
> 
> Thanks,
> Marcel
> 
> >> -- 
> >> Eduardo
> 

-- 
Eduardo
