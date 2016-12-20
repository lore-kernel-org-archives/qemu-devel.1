Received: from eggs.gnu.org ([2001:4830:134:3::10]:34059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJBMB-0001rD-Sw
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 22:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJBM8-0006Xn-Pp
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 22:44:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJBM8-0006WV-Iq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 22:44:48 -0500
Date: Tue, 20 Dec 2016 11:44:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161220034441.GA19964@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<20161219095650.0a3ac113@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161219095650.0a3ac113@t450s.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

On Mon, Dec 19, 2016 at 09:56:50AM -0700, Alex Williamson wrote:
> On Mon, 19 Dec 2016 22:41:26 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > This is preparation work to finally enabled dynamic switching ON/OFF for
> > VT-d protection. The old VT-d codes is using static IOMMU region, and
> > that won't satisfy vfio-pci device listeners.
> > 
> > Let me explain.
> > 
> > vfio-pci devices depend on the memory region listener and IOMMU replay
> > mechanism to make sure the device mapping is coherent with the guest
> > even if there are domain switches. And there are two kinds of domain
> > switches:
> > 
> >   (1) switch from domain A -> B
> >   (2) switch from domain A -> no domain (e.g., turn DMAR off)
> > 
> > Case (1) is handled by the context entry invalidation handling by the
> > VT-d replay logic. What the replay function should do here is to replay
> > the existing page mappings in domain B.
> > 
> > However for case (2), we don't want to replay any domain mappings - we
> > just need the default GPA->HPA mappings (the address_space_memory
> > mapping). And this patch helps on case (2) to build up the mapping
> > automatically by leveraging the vfio-pci memory listeners.
> > 
> > Another important thing that this patch does is to seperate
> > IR (Interrupt Remapping) from DMAR (DMA Remapping). IR region should not
> > depend on the DMAR region (like before this patch). It should be a
> > standalone region, and it should be able to be activated without
> > DMAR (which is a common behavior of Linux kernel - by default it enables
> > IR while disabled DMAR).
> 
> 
> This seems like an improvement, but I will note that there are existing
> locked memory accounting issues inherent with VT-d and vfio.  With
> VT-d, each device has a unique AddressSpace.  This requires that each
> is managed via a separate vfio container.  Each container is accounted
> for separately for locked pages.  libvirt currently only knows that if
> any vfio devices are attached that the locked memory limit for the
> process needs to be set sufficient for the VM memory.  When VT-d is
> involved, we either need to figure out how to associate otherwise
> independent vfio containers to share locked page accounting or teach
> libvirt that the locked memory requirement needs to be multiplied by
> the number of attached vfio devices.  The latter seems far less
> complicated but reduces the containment of QEMU a bit since the
> process has the ability to lock potentially many multiples of the VM
> address size.  Thanks,

Yes, this patch just tried to move VT-d forward a bit, rather than do
it once and for all. I think we can do better than this in the future,
for example, one address space per guest IOMMU domain (as you have
mentioned before). However I suppose that will need more work (which I
still can't estimate on the amount of work). So I am considering to
enable the device assignments functionally first, then we can further
improve based on a workable version. Same thoughts apply to the IOMMU
replay RFC series.

Regarding to the locked memory accounting issue: do we have existing
way to do the accounting? If so, would you (or anyone) please
elaborate a bit? If not, is that an ongoing/planned work?

Thanks,

-- peterx
