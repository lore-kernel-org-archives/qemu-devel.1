Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cWSQR-0006sj-OB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cWSQO-0006VB-Mp
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cWSQO-0006Uv-Ge
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:36:04 -0500
Date: Wed, 25 Jan 2017 11:36:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170125113602.1ee76196@t450s.home>
In-Reply-To: <1ae1a5a1-2617-1862-ea1d-53f1383516d8@redhat.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
	<9ef03816-0bef-f54b-63fe-daf27eab4a40@redhat.com>
	<20170125103642.5f4232a9@t450s.home>
	<1ae1a5a1-2617-1862-ea1d-53f1383516d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/18] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, bd.aviv@gmail.com

On Wed, 25 Jan 2017 18:40:56 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 25/01/2017 18:36, Alex Williamson wrote:
> >> You probably should also put a comment about why VFIO does *not* need to
> >> keep a reference between vfio_dma_map and vfio_dma_unmap (which doesn't
> >> sound easy to do either).  Would any well-behaved guest invalidate the
> >> IOMMU page tables before a memory hot-unplug?  
> >
> > Hmm, we do take a reference in vfio_listener_region_add(), but this is
> > of course to the iommu region not to the RAM region we're translating.
> > In the non-vIOMMU case we would be holding a reference to the memory
> > region backing a DMA mapping.  I would expect a well behaved guest to
> > evacuate DMA mappings targeting a hotplug memory region before it gets
> > ejected, but how much do we want to rely on well behaved guests.  
> 
> It depends of what happens if they aren't.  I think it's fine (see other
> message), but taking a reference for each mapping entry isn't so easy
> because the unmap case doesn't know the old memory region.

If we held a reference to the memory region from the mapping path and
walk the IOMMU page table to generate the unmap, then we really should
get to the same original memory region, right?  The vfio iommu notifier
should only be mapping native page sizes of the IOMMU, 4k/2M/1G.  The
problem is that it's a lot of overhead to flush the entire address
space that way vs the single invalidation Peter is trying to enable
here.  It's actually similar to how the type1 iommu works in the kernel
though, we can unmap by iova because we ask the iommu for the iova->pfn
translation in order to unpin the page.

I do agree with your description in the other message about how things
would work for a memory hot-unplug w/o unmap though, which does seem to
imply that we don't need that reference.  Thanks,

Alex
