Received: from eggs.gnu.org ([2001:4830:134:3::10]:51810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g09aR-0007nr-7R
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g09aN-0002wu-0f
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1g09aM-0002t5-Ms
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:09:54 -0400
Date: Wed, 12 Sep 2018 12:09:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180912120951.124e12db@t450s.home>
In-Reply-To: <20180912132714-mutt-send-email-mst@kernel.org>
References: <20180726144539.740acf4d@t450s.home>
	<20180727015805.GA11247@debian>
	<20180727140300.022d9872@t450s.home>
	<20180730081003.GA10680@debian>
	<20180730121704-mutt-send-email-mst@kernel.org>
	<20180912080400.GA9173@fbsd1.sh.intel.com>
	<20180912121306-mutt-send-email-mst@kernel.org>
	<20180912103443.3dd703a6@t450s.home>
	<20180912124233-mutt-send-email-mst@kernel.org>
	<20180912111532.5bfd1766@t450s.home>
	<20180912132714-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/3] vhost-user: support programming VFIO
 group in master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, jasowang@redhat.com, qemu-devel@nongnu.org

On Wed, 12 Sep 2018 13:29:33 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Sep 12, 2018 at 11:15:32AM -0600, Alex Williamson wrote:
> > On Wed, 12 Sep 2018 12:44:15 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Wed, Sep 12, 2018 at 10:34:43AM -0600, Alex Williamson wrote:  
> > > > On Wed, 12 Sep 2018 12:14:44 -0400
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >     
> > > > > On Wed, Sep 12, 2018 at 04:04:00PM +0800, Tiwei Bie wrote:    
> > > > > > On Mon, Jul 30, 2018 at 12:30:58PM +0300, Michael S. Tsirkin wrote:
> > > > > > [...]      
> > > > > > > 
> > > > > > > I generally wonder how are restarts of the backend handled
> > > > > > > with this approach: closing the VFIO device tends to reset
> > > > > > > the whole device.      
> > > > > > 
> > > > > > Hi Michael,
> > > > > > 
> > > > > > I missed this comment previously.. This is a good point!
> > > > > > In this RFC, before sending the VFIO group fd to QEMU,
> > > > > > backend needs to close the VFIO device and unset the VFIO
> > > > > > container first. Otherwise, QEMU won't be able to set the
> > > > > > VFIO container for the VFIO group.
> > > > > > 
> > > > > > Another option is to share the container fd instead of
> > > > > > the group fd to QEMU. In this case, backend won't need
> > > > > > to close any fd. But there is one problem that, it's
> > > > > > hard to unmap the old mappings, especially when QEMU
> > > > > > crashes.      
> > > > > 
> > > > > What are these old mappings and who creates them?
> > > > > If you want to just reset everything the way it was
> > > > > on open, surely it would be easy to add such a reset ioctl.
> > > > >     
> > > > > > Do you have any suggestions? Thanks!
> > > > > > 
> > > > > > Best regards,
> > > > > > Tiwei Bie      
> > > > > 
> > > > > Donnu. Alex, any thoughts? Which approach would you prefer?    
> > > > 
> > > > The existing UNMAP_DMA ioctl for the vfio type1 IOMMU only requires
> > > > that an unmap does not bisect previous mappings, ie. a previous mapping
> > > > cannot be partially unmapped.  Therefore you can already dump the
> > > > entire IOVA space for a container with one UNMAP_DMA call, iova = 0,
> > > > size = (u64)-1.  Thanks,
> > > > 
> > > > Alex    
> > > 
> > > Hmm this would exclude the last byte (address (u64)-1).
> > > VTD does not support such iova values for now but something
> > > to keep in mind e.g. for virtio-iommu with nested virt
> > > which does.  
> > 
> > Yes, technically you'd need another ioctl to get the last byte,  
> 
> It will violate the requirement of not unmapping part of a region,
> won't it? So it won't work.

Yes, in theory it's more complicated, but in practice it's not because
Intel only supports up to 48-bits of IOVA space (modulo round down by
a page, not a byte).  It would also be deterministic if we could ever
get past the RMRR issues with IGD to implement an IOVA list as every
IOMMU (AFAIK) has some reserved ranges that cannot be mapped and would
bisect the IOVA space somewhere.
 
> > the
> > ioctls should have used start and end rather than start and size, but
> > it's too late to change.  Thanks,
> > 
> > Alex  
> 
> At some point we'll have to fix above issue in some way. Maybe when we
> add support for atomic remaps.

"Patches welcome".  Thanks,

Alex
