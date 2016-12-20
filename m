Received: from eggs.gnu.org ([2001:4830:134:3::10]:45279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cJCQ6-0003sC-Qn
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cJCQ3-0007px-NN
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:52:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cJCQ3-0007pq-EH
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:52:55 -0500
Date: Mon, 19 Dec 2016 21:52:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20161219215252.6b0a6e8b@t450s.home>
In-Reply-To: <20161220034441.GA19964@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<20161219095650.0a3ac113@t450s.home>
	<20161220034441.GA19964@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

On Tue, 20 Dec 2016 11:44:41 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Dec 19, 2016 at 09:56:50AM -0700, Alex Williamson wrote:
> > On Mon, 19 Dec 2016 22:41:26 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> >   
> > > This is preparation work to finally enabled dynamic switching ON/OFF for
> > > VT-d protection. The old VT-d codes is using static IOMMU region, and
> > > that won't satisfy vfio-pci device listeners.
> > > 
> > > Let me explain.
> > > 
> > > vfio-pci devices depend on the memory region listener and IOMMU replay
> > > mechanism to make sure the device mapping is coherent with the guest
> > > even if there are domain switches. And there are two kinds of domain
> > > switches:
> > > 
> > >   (1) switch from domain A -> B
> > >   (2) switch from domain A -> no domain (e.g., turn DMAR off)
> > > 
> > > Case (1) is handled by the context entry invalidation handling by the
> > > VT-d replay logic. What the replay function should do here is to replay
> > > the existing page mappings in domain B.
> > > 
> > > However for case (2), we don't want to replay any domain mappings - we
> > > just need the default GPA->HPA mappings (the address_space_memory
> > > mapping). And this patch helps on case (2) to build up the mapping
> > > automatically by leveraging the vfio-pci memory listeners.
> > > 
> > > Another important thing that this patch does is to seperate
> > > IR (Interrupt Remapping) from DMAR (DMA Remapping). IR region should not
> > > depend on the DMAR region (like before this patch). It should be a
> > > standalone region, and it should be able to be activated without
> > > DMAR (which is a common behavior of Linux kernel - by default it enables
> > > IR while disabled DMAR).  
> > 
> > 
> > This seems like an improvement, but I will note that there are existing
> > locked memory accounting issues inherent with VT-d and vfio.  With
> > VT-d, each device has a unique AddressSpace.  This requires that each
> > is managed via a separate vfio container.  Each container is accounted
> > for separately for locked pages.  libvirt currently only knows that if
> > any vfio devices are attached that the locked memory limit for the
> > process needs to be set sufficient for the VM memory.  When VT-d is
> > involved, we either need to figure out how to associate otherwise
> > independent vfio containers to share locked page accounting or teach
> > libvirt that the locked memory requirement needs to be multiplied by
> > the number of attached vfio devices.  The latter seems far less
> > complicated but reduces the containment of QEMU a bit since the
> > process has the ability to lock potentially many multiples of the VM
> > address size.  Thanks,  
> 
> Yes, this patch just tried to move VT-d forward a bit, rather than do
> it once and for all. I think we can do better than this in the future,
> for example, one address space per guest IOMMU domain (as you have
> mentioned before). However I suppose that will need more work (which I
> still can't estimate on the amount of work). So I am considering to
> enable the device assignments functionally first, then we can further
> improve based on a workable version. Same thoughts apply to the IOMMU
> replay RFC series.

I'm not arguing against it, I'm just trying to set expectations for
where this gets us.  An AddressSpace per guest iommu domain seems like
the right model for QEMU, but it has some fundamental issues with
vfio.  We currently tie a QEMU AddressSpace to a vfio container, which
represents the host IOMMU context.  The AddressSpace of a device is
currently assumed to be fixed in QEMU, guest IOMMU domains clearly
are not.  vfio only let's us have access to a device while it's
protected within a container.  Therefore in order to move a device to a
different AddressSpace based on the guest domain configuration, we'd
need to tear down the vfio configuration, including releasing the
device.
 
> Regarding to the locked memory accounting issue: do we have existing
> way to do the accounting? If so, would you (or anyone) please
> elaborate a bit? If not, is that an ongoing/planned work?

As I describe above, there's a vfio container per AddressSpace, each
container is an IOMMU domain in the host.  In the guest, an IOMMU
domain can include multiple AddressSpaces, one for each context entry
that's part of the domain.  When the guest programs a translation for
an IOMMU domain, that maps a guest IOVA to a guest physical address,
for each AddressSpace.  Each AddressSpace is backed by a vfio
container, which needs to pin the pages of that translation in order to
get a host physical address, which then gets programmed into the host
IOMMU domain with the guest-IOVA and host physical address.  The
pinning process is where page accounting is done.  It's done per vfio
context.  The worst case scenario for accounting is thus when VT-d is
present but disabled (or in passthrough mode) as each AddressSpace
duplicates address_space_memory and every page of guest memory is
pinned and accounted for each vfio container.

That's the existing way we do accounting.  There is no current
development that I'm aware of to change this.  As above, the simplest
stop-gap solution is that libvirt would need to be aware when VT-d is
present for a VM and use a different algorithm to set QEMU locked
memory limit, but it's not without its downsides.  Alternatively, a new
IOMMU model would need to be developed for vfio.  The type1 model was
only ever intended to be used for relatively static user mappings and I
expect it to have horrendous performance when backing a dynamic guest
IOMMU domain.  Really the only guest IOMMU usage model that makes any
sort of sense with type1 is to run the guest with passthrough (iommu=pt)
and only pull devices out of passthrough for relatively static mapping
cases within the guest userspace (nested assigned devices or dpdk).  If
the expectation is that we just need this one little bit more code to
make vfio usable in the guest, that may be true, but it really is just
barely usable.  It's not going to be fast for any sort of dynamic
mapping and it's going to have accounting issues that are not
compatible with how libvirt sets locked memory limits for QEMU as soon
as you go beyond a single device.  Thanks,

Alex
