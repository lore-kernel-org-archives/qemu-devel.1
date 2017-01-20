Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUQhQ-0006Gv-KU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 23:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUQhN-0007GN-Dn
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 23:21:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cUQhN-0007FW-4w
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 23:21:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5B0883F3E
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:21:12 +0000 (UTC)
Date: Thu, 19 Jan 2017 21:21:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170119212110.3406d921@t450s.home>
In-Reply-To: <20170120034328.GG4914@pxdev.xzpeter.org>
References: <1484817932-14452-1-git-send-email-peterx@redhat.com>
	<20170119105437.5b17d979@t450s.home>
	<20170120034328.GG4914@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] vfio: allow to notify unmap for
 very big region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 20 Jan 2017 11:43:28 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Jan 19, 2017 at 10:54:37AM -0700, Alex Williamson wrote:
> > On Thu, 19 Jan 2017 17:25:29 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> >   
> > > This requirement originates from the VT-d vfio series:
> > > 
> > >   https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03495.html
> > > 
> > > The goal of this series is to allow IOMMU to notify unmap with very
> > > big IOTLB range, for example, with base=0 and size=2^63-1 (to unmap
> > > the whole address space).
> > > 
> > > The first patch is a good to have, for traces.
> > > 
> > > The second one is a cleanup of existing code, only.  
> > 
> > Sort of, it does add some overhead to the unmap path, but you remove
> > that and more in the third patch.  
> 
> Hmm, yes, I tried to get the ram pointer even for unmap. I should
> remove the ending "only".
> 
> >    
> > > The third one moves the further RAM translation and check into map
> > > operation logic, so that it'll free unmap operations.
> > > 
> > > The series is marked as RFC since I am not sure whether this is a
> > > workable way. Anyway, please review to help confirm it.  
> > 
> > It seems reasonable to me,  
> 
> Good to know that you didn't disagree on this. :) Then let me take
> these patches along with that series in the next post (since that
> series will depend on this one, so I'll keep them together, though
> please maintainers decide on how you'll merge them when you want to),
> 
> > except for the example here of using 2^63-1,
> > which I expect is to work around the vfio {un}map API bug as we
> > discussed on irc.  
> 
> Actually not only for that one, I don't know whether we have problem
> here:
> 
> (I mentioned this in IRC, in case you missed that, I paste it here as
>  well)
> 
> static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
> 				      dma_addr_t start, size_t size)
> {
> 	struct rb_node *node = iommu->dma_list.rb_node;
> 
> 	while (node) {
> 		struct vfio_dma *dma = rb_entry(node, struct vfio_dma, node);
> 
> 		if (start + size <= dma->iova)
> 			node = node->rb_left;
> 		else if (start >= dma->iova + dma->size)
>                           ^^^^^^^^^^^^^^^^^^^^^
>                           Could it overflow here? <--------------
> 			node = node->rb_right;
> 		else
> 			return dma;
> 	}
> 
> 	return NULL;
> }
> 
> I used 2^63-1 to try to avoid both cases.


Perhaps I'm not seeing the overflow you're trying to identify,
but dma->iova + dma->size cannot overflow, these are existing DMA
mappings and the DMA mapping path does test for overflow.  I think we
can consider those sanitized.  I am wondering if the test above it is
suspect though, start + size doesn't seem to be checked for overflow on
the unmap path.  It seems pretty easy to avoid from the user side
though, but maybe we should add a test for it in the kernel.

 
> > For everyone, the root of the problem is that the
> > ioctls use:
> > 
> >         __u64   iova;                           /* IO virtual address */
> >         __u64   size;                           /* Size of mapping (bytes) */
> > 
> > So we can only express a size of 2^64-1 and we have an off-by-one error
> > trying to perform a map/unmap of an entire 64-bit space.  Note when
> > designing an API, use start/end rather than base/size to avoid this.  
> 
> Lesson learned.
> 
> > 
> > What I don't want to see is for this API bug to leak out into the rest
> > of the QEMU code such that intel_iommu code, or iommu code in general
> > subtly avoids it by artificially using a smaller range.  VT-d hardware
> > has an actual physical address space of either 2^39 or 2^48 bits, so if
> > you want to make the iommu address space match the device we're trying
> > to emulate, that's perfectly fine.  AIUI, AMD-Vi does actually have a
> > 64-bit address space on the IOMMU, so to handle that case I'd expect
> > the simplest solution would be to track the and mapped iova high water
> > mark per container in vfio and truncate unmaps to that high water end
> > address.  Realistically we're probably not going to see iovas at the end
> > of the 64-bit address space, but we can come up with some other
> > workaround in the vfio code or update the kernel API if we do.  Thanks,  
> 
> Agree that high watermark can be a good solution for VT-d. I'll use
> that instead of 2^63-1. Though for AMD, if it supports 64bits, we may
> still need to solve existing issues in the future, since in that case
> the high watermark can be (hwaddr)-1 as well if guest specifies it.
> 
> (Though anyway I'm not sure when AMD vIOMMUs will be ready for device
>  assignment, so I don't think that's a big issue at least for now)

Even with a true 64bit address space, it seems very unlikely we'd have
iovas at the very top of that address space.  If we do, another idea
would be that iommus often have a reserved iova range for MSI mapping,
both VT-d and AMD-Vi do.  We know there would be no user iovas within
those ranges, so it would make a clean point to split a full 64-bit
unmap in two.  Hopefully we'll have reporting of that reserved range up
through vfio should/when we need something like that.  We could
also simply track both the start and end of that mapping that sets the
high water mark, unmapping all except that, then that alone as two
separate ioctls.  I'm not too concerned that we'll be able to work
around it if we need to.  Thanks,

Alex
