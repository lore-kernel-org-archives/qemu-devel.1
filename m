Received: from eggs.gnu.org ([2001:4830:134:3::10]:56510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flf1u-0004d0-Hw
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flf1p-0001xt-Hc
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:42:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flf1p-0001xP-B9
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:42:21 -0400
Date: Fri, 3 Aug 2018 21:42:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803214038-mutt-send-email-mst@kernel.org>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<20180731152716-mutt-send-email-mst@kernel.org>
	<20180731084414.52e560fa@t450s.home>
	<20180731150746.GH2476@work-vm>
	<20180731155030.2d5fd5b7@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731155030.2d5fd5b7@t450s.home>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, david@redhat.com

On Tue, Jul 31, 2018 at 03:50:30PM -0600, Alex Williamson wrote:
> On Tue, 31 Jul 2018 16:07:46 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Alex Williamson (alex.williamson@redhat.com) wrote:
> > > On Tue, 31 Jul 2018 15:29:17 +0300
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Mon, Jul 30, 2018 at 05:13:26PM -0600, Alex Williamson wrote:  
> > > > > v2:
> > > > >  - Use atomic ops for balloon inhibit counter (Peter)
> > > > >  - Allow endpoint driver opt-in for ballooning, vfio-ccw opt-in by
> > > > >    default, vfio-pci opt-in by device option, only allowed for mdev
> > > > >    devices, no support added for platform as there are no platform
> > > > >    mdev devices.
> > > > > 
> > > > > See patch 3/4 for detailed explanation why ballooning and device
> > > > > assignment typically don't mix.  If this eventually changes, flags
> > > > > on the iommu info struct or perhaps device info struct can inform
> > > > > us for automatic opt-in.  Thanks,
> > > > > 
> > > > > Alex    
> > > > 
> > > > So this patch seems to block ballooning when vfio is added.
> > > > But what if balloon is added and inflated first?  
> > > 
> > > Good point.
> > >    
> > > > I'd suggest making qemu_balloon_inhibit fail in that case,
> > > > and then vfio realize will fail as well.  
> > > 
> > > That might be the correct behavior for vfio, but I wonder about the
> > > existing postcopy use case.  Dave Gilbert, what do you think?  We might
> > > need a separate interface for callers that cannot tolerate existing
> > > ballooned pages.  Of course we'll also need another atomic counter to
> > > keep a tally of ballooned pages.  Thanks,  
> > 
> > For postcopy, preinflation isn't a problem; our only issue is ballooning
> > during the postcopy phase itself.
> 
> On further consideration, I think device assignment is in the same
> category.  The balloon inhibitor does not actually stop the guest
> balloon driver from grabbing and freeing pages, it only changes whether
> QEMU releases the pages with madvise DONTNEED.  The problem we have
> with ballooning and device assignment is when we have an existing HPA
> mapping in the IOMMU that isn't invalidated on DONTNEED and becomes
> inconsistent when the page is re-populated.  Zapped pages at the time
> an assigned device is added do not trigger this, those pages will be
> repopulated when pages are pinned for the assigned device.  This is the
> identical scenario to a freshly started VM that doesn't use memory
> preallocation and therefore faults in pages on demand.  When an
> assigned device is attached to such a VM, page pinning will fault in
> and lock all of those pages.

Granted this means memory won't be corrupted, but it is
also highly unlikely to be what the user wanted.

> This is observable behavior, for example if I start a VM with 16GB of
> RAM, booted to a command prompt the VM shows less that 1GB of RAM
> resident in the host.  If I set the balloon to 2048, there's no
> observable change in the QEMU process size on the host.  If I hot-add
> an assigned device while we're ballooned down, the resident memory size
> from the host jumps up to 16GB.  All of the zapped pages have been
> reclaimed.  Adjusting ballooning at this point only changes the balloon
> size in the guest, inflating the balloon no longer zaps pages from the
> process.
> 
> The only oddity I see is the one Dave noted in the commit introducing
> balloon inhibiting (371ff5a3f04c):
> 
>     Queueing the requests until after migration would be nice, but is
>     non-trivial, since the set of inflate/deflate requests have to
>     be compared with the state of the page to know what the final
>     outcome is allowed to be.
> 
> So for this example of a 16GB VM ballooned down to 2GB then an assigned
> device added and subsequently removed, the resident memory remains 16GB
> and I need to deflate the balloon and reinflate it in order to zap them
> from the QEMU process.  Therefore, I think that with respect to this
> inquiry, the series stands as is.  Thanks,
> 
> Alex
