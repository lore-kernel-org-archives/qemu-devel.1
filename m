Received: from eggs.gnu.org ([2001:4830:134:3::10]:47549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaIj1-0007mR-2Q
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaIiw-00018Y-9h
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 06:12:15 -0500
Date: Fri, 21 Dec 2018 12:12:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221121202.2fefa757.cohuck@redhat.com>
In-Reply-To: <20181219092800.654fcc21@x1.home>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<d3442c5d-06e9-d87a-3bc3-903f40b0cedf@linux.ibm.com>
	<20181218182400.6305b061.cohuck@redhat.com>
	<20181219092800.654fcc21@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org

On Wed, 19 Dec 2018 09:28:00 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 18 Dec 2018 18:24:00 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Mon, 17 Dec 2018 16:53:34 -0500
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> > > On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> > > 
> > > ...snip...
> > >     
> > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > > index 813102810f53..565669f95534 100644
> > > > --- a/include/uapi/linux/vfio.h
> > > > +++ b/include/uapi/linux/vfio.h
> > > > @@ -297,6 +297,7 @@ struct vfio_region_info_cap_type {
> > > >   
> > > >   #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE	(1 << 31)
> > > >   #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> > > > +#define VFIO_REGION_TYPE_CCW			(1 << 30)      
> > > 
> > > Oof.  So the existing VFIO_REGION_TYPE_PCI_VENDOR_TYPE gets OR'd with 
> > > another value (e.g., 8086).  But in 4.20, there was a 
> > > VFIO_REGION_TYPE_GFX is added as simply "1" ... Which direction are 
> > > these definitions being added from?  I guess asked another way, is 
> > > _TYPE_CCW going to be OR'd with anything else that necessitates its 
> > > presence as an identifier with some Other Thing, or should this follow 
> > > the TYPE_GFX enumeration?  Perhaps the type field needs to be tidied up 
> > > to help this sit more cleanly now?  (Sorry!)    
> > 
> > The semantics of that type stuff are really a bit unclear to me :(
> > 
> > I don't think we'll ever do any fancy mask handling for ccw. It is
> > probably enough to have any kind of uniqueness within the different
> > types, so maybe counting up would be indeed enough...  
> 
> Just to confirm, this is the intended usage, simply reserve a new type
> following the GFX region example.  We can define VFIO_REGION_TYPE_CCW
> as 2 and then there's a whole address space of sub-types to fill in
> within that.  I might have over-engineered PCI a bit with the address
> space split, but it seemed like a good idea at the time to pre-define a
> type address space for each vendor, such that they only need to define
> the sub-types and we can avoid namespace collisions.  Unfortunately
> this implicit definition for each PCI vendor also contributes to the
> confusion here.  Sorry.  Thanks,
> 
> Alex

Thanks for the explanation. I'm simply switching VFIO_REGION_TYPE_CCW
to 2 in the next version.
