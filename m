Received: from eggs.gnu.org ([2001:4830:134:3::10]:37301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fnWrS-0007VG-P5
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 18:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fnWrP-0007kT-Hm
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 18:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fnWrP-0007jE-8Z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 18:23:19 -0400
Date: Wed, 8 Aug 2018 16:23:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180808162304.42d3fecc@t450s.home>
In-Reply-To: <20180808034543.GC24415@xz-mi>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807224033-mutt-send-email-mst@kernel.org>
	<20180807135303.3938b3a2@t450s.home>
	<20180808004929-mutt-send-email-mst@kernel.org>
	<20180808034543.GC24415@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Wed, 8 Aug 2018 11:45:43 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Aug 08, 2018 at 12:58:32AM +0300, Michael S. Tsirkin wrote:
> > At least with VTD, it seems entirely possible to change e.g. a PMD
> > atomically to point to a different set of PTEs, then flush.
> > That will allow removing memory at high granularity for
> > an arbitrary device without mdev or PASID dependency.  
> 
> My understanding is that the guest driver should prohibit this kind of
> operation (say, modifying PMD).

There's currently no need for this sort of operation within the dma api
and the iommu api doesn't offer it either.

> Actually I don't see how it can
> happen in Linux if the kernel drivers always call the IOMMU API since
> there are only map/unmap APIs rather than this atomic-modify API.

Exactly, the vfio dma mapping api is just an extension of the iommu api
and there's only map and unmap.  Furthermore, unmap can currently return
more than requested if the original mapping made use of superpages in
the iommu, so the only way to achieve page level granularity is to make
only page size mappings.  Otherwise we're talking about new apis
across the board.
 
> The thing is that IMHO it's the guest driver's responsibility to make
> sure the pages will never be used by the device before it removes the
> entry (including modifying the PMD since that actually removes all the
> entries on the old PMD).  If not, I would see it a guest kernel bug
> instead of the bug in the emulation code.

This is why there is no atomic modify in the dma api, we have drivers
that directly manage the buffers for a device and know when it's in use
and when it's not.  There's never a need, currently, to replace the iova
mapping for a single page within a larger buffer.  Maybe the dma api
could also find use for it, but it seems more unique to the iommu api
that we have a "buffer", which happens to be a contiguous RAM region
for the VM, where we do want to change the mapping of a single page.
That single page might currently be mapped by a 2MB or 1GB page in the
case of Intel, or by an arbitrary page size in the case of AMD.  vfio
is the driver managing these mappings, but versus the dma api, we don't
have any insight to the device behavior, including inflight dma.  We can
stop all dma for the device, but not without interfering and potentially
breaking the behavior of the device.

So again, I think this comes down to new iommu driver support and new
iommu apis and new vfio apis to enable some sort of atomic update
interface, or sacrificing performance and adding bloat by forcing page
size mappings.  Thanks,

Alex
