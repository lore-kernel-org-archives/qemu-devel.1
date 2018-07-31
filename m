Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkWFj-0002m2-7A
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkWFb-0006Sz-Fu
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:07:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fkWFb-0006SK-AZ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:07:51 -0400
Date: Tue, 31 Jul 2018 16:07:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180731150746.GH2476@work-vm>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<20180731152716-mutt-send-email-mst@kernel.org>
	<20180731084414.52e560fa@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731084414.52e560fa@t450s.home>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, david@redhat.com

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Tue, 31 Jul 2018 15:29:17 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 30, 2018 at 05:13:26PM -0600, Alex Williamson wrote:
> > > v2:
> > >  - Use atomic ops for balloon inhibit counter (Peter)
> > >  - Allow endpoint driver opt-in for ballooning, vfio-ccw opt-in by
> > >    default, vfio-pci opt-in by device option, only allowed for mdev
> > >    devices, no support added for platform as there are no platform
> > >    mdev devices.
> > > 
> > > See patch 3/4 for detailed explanation why ballooning and device
> > > assignment typically don't mix.  If this eventually changes, flags
> > > on the iommu info struct or perhaps device info struct can inform
> > > us for automatic opt-in.  Thanks,
> > > 
> > > Alex  
> > 
> > So this patch seems to block ballooning when vfio is added.
> > But what if balloon is added and inflated first?
> 
> Good point.
>  
> > I'd suggest making qemu_balloon_inhibit fail in that case,
> > and then vfio realize will fail as well.
> 
> That might be the correct behavior for vfio, but I wonder about the
> existing postcopy use case.  Dave Gilbert, what do you think?  We might
> need a separate interface for callers that cannot tolerate existing
> ballooned pages.  Of course we'll also need another atomic counter to
> keep a tally of ballooned pages.  Thanks,

For postcopy, preinflation isn't a problem; our only issue is ballooning
during the postcopy phase itself.

Dave

> Alex
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
