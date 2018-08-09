Received: from eggs.gnu.org ([2001:4830:134:3::10]:37854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fnhx9-0008Ut-1Z
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fnhx4-0008Cz-2m
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:13:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fnhx3-0008Ca-UD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:13:54 -0400
Date: Thu, 9 Aug 2018 13:13:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180809131338-mutt-send-email-mst@kernel.org>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807224033-mutt-send-email-mst@kernel.org>
	<20180807135303.3938b3a2@t450s.home>
	<20180808004929-mutt-send-email-mst@kernel.org>
	<20180808034543.GC24415@xz-mi>
	<20180809122030-mutt-send-email-mst@kernel.org>
	<20180809093758.GB2539@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809093758.GB2539@xz-mi>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Thu, Aug 09, 2018 at 05:37:58PM +0800, Peter Xu wrote:
> On Thu, Aug 09, 2018 at 12:23:43PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Aug 08, 2018 at 11:45:43AM +0800, Peter Xu wrote:
> > > On Wed, Aug 08, 2018 at 12:58:32AM +0300, Michael S. Tsirkin wrote:
> > > > At least with VTD, it seems entirely possible to change e.g. a PMD
> > > > atomically to point to a different set of PTEs, then flush.
> > > > That will allow removing memory at high granularity for
> > > > an arbitrary device without mdev or PASID dependency.
> > > 
> > > My understanding is that the guest driver should prohibit this kind of
> > > operation (say, modifying PMD).
> > 
> > Interesting.  Which part of the VTD spec prohibits this?
> > 
> > > Actually I don't see how it can
> > > happen in Linux if the kernel drivers always call the IOMMU API since
> > > there are only map/unmap APIs rather than this atomic-modify API.
> > 
> > It could happen with a non-Linux guest which might have a different API.
> > 
> > > The thing is that IMHO it's the guest driver's responsibility to make
> > > sure the pages will never be used by the device before it removes the
> > > entry (including modifying the PMD since that actually removes all the
> > > entries on the old PMD).
> > 
> > If you switch PMDs atomically from one set of valid PTEs to another,
> > then flush, then as far as I could see it just works in the hardware
> > VTD, but not in the emulated VTD. So that's a difference in
> > behaviour. Maybe we are lucky and no one does that.
> 
> Yes, but AFAICT that's also the best we can have now since the
> userspace QEMU (or say, the VT-d emulation code) cannot really modify
> a real PMD that the hardware uses - it can only call the VFIO APIs,
> and finally it boils down again to the host kernel IOMMU APIs to do
> map or unmap only.  So it's a impossible task until we provide such an
> interface through the whole IOMMU/VFIO/... stack just like what you
> have discussed in the other thread.
> 
> Thanks,


This would need host kernel support, yes.

> -- 
> Peter Xu
