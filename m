Received: from eggs.gnu.org ([2001:4830:134:3::10]:56357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fn4xB-0001Xh-0f
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 12:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fn4x6-0000tS-Oe
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 12:35:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fn4x6-0000t7-63
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 12:35:20 -0400
Date: Tue, 7 Aug 2018 10:35:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180807103505.4c182f4d@t450s.home>
In-Reply-To: <20180807131021.GF7265@xz-mi>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<153299246170.14411.6197545037372422542.stgit@gimli.home>
	<20180807131021.GF7265@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] vfio: Inhibit ballooning based on
 group attachment to a container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, cohuck@redhat.com, mst@redhat.com, david@redhat.com

On Tue, 7 Aug 2018 21:10:21 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Jul 30, 2018 at 05:14:21PM -0600, Alex Williamson wrote:
> > We use a VFIOContainer to associate an AddressSpace to one or more
> > VFIOGroups.  The VFIOContainer represents the DMA context for that
> > AdressSpace for those VFIOGroups and is synchronized to changes in
> > that AddressSpace via a MemoryListener.  For IOMMU backed devices,
> > maintaining the DMA context for a VFIOGroup generally involves
> > pinning a host virtual address in order to create a stable host
> > physical address and then mapping a translation from the associated
> > guest physical address to that host physical address into the IOMMU.
> > 
> > While the above maintains the VFIOContainer synchronized to the QEMU
> > memory API of the VM, memory ballooning occurs outside of that API.
> > Inflating the memory balloon (ie. cooperatively capturing pages from
> > the guest for use by the host) simply uses MADV_DONTNEED to "zap"
> > pages from QEMU's host virtual address space.  The page pinning and
> > IOMMU mapping above remains in place, negating the host's ability to
> > reuse the page, but the host virtual to host physical mapping of the
> > page is invalidated outside of QEMU's memory API.
> > 
> > When the balloon is later deflated, attempting to cooperatively
> > return pages to the guest, the page is simply freed by the guest
> > balloon driver, allowing it to be used in the guest and incurring a
> > page fault when that occurs.  The page fault maps a new host physical
> > page backing the existing host virtual address, meanwhile the
> > VFIOContainer still maintains the translation to the original host
> > physical address.  At this point the guest vCPU and any assigned
> > devices will map different host physical addresses to the same guest
> > physical address.  Badness.
> > 
> > The IOMMU typically does not have page level granularity with which
> > it can track this mapping without also incurring inefficiencies in
> > using page size mappings throughout.  MMU notifiers in the host
> > kernel also provide indicators for invalidating the mapping on
> > balloon inflation, not for updating the mapping when the balloon is
> > deflated.  For these reasons we assume a default behavior that the
> > mapping of each VFIOGroup into the VFIOContainer is incompatible
> > with memory ballooning and increment the balloon inhibitor to match
> > the attached VFIOGroups.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/vfio/common.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index fb396cf00ac4..4881b691a659 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -32,6 +32,7 @@
> >  #include "hw/hw.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/range.h"
> > +#include "sysemu/balloon.h"
> >  #include "sysemu/kvm.h"
> >  #include "trace.h"
> >  #include "qapi/error.h"
> > @@ -1049,6 +1050,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> >              group->container = container;
> >              QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> >              vfio_kvm_device_add_group(group);
> > +            qemu_balloon_inhibit(true);  
> 
> [1]
> 
> >              return 0;
> >          }
> >      }
> > @@ -1198,6 +1200,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> >      }
> >  
> >      vfio_kvm_device_add_group(group);
> > +    qemu_balloon_inhibit(true);  
> 
> AFAIU there is a very critical information that this
> qemu_balloon_inhibit() call must be before the call to:
> 
>     memory_listener_register(&container->listener, container->space->as);
> 
> Since the memory listener registeration is the point when we do the
> pinning of the pages.  So to make sure we won't have stale pages we
> must call qemu_balloon_inhibit() before memory_listener_register()
> (which is what this patch does).  However this is not that obvious,
> not sure whether that might worth a comment.
> 
> Considering this, not sure whether we can just do this per-container
> instead of per-group, then we also don't need to bother with extra
> group-add paths like [1].
> 
> No matter what, this patch looks good to me (and it is correct AFAIK),
> so I'm leaving r-b and I'll leave Alex to decide:

Thanks Peter.  I agree, I'll add more commentary.  A minor correction,
we won't have "stale" pages at the time we pin, the act of pinning will
make those valid (same as I discussed in reply to mst why we don't need
to worry about pages ballooned before the device is added), but once a
page is pinned, we need to make sure it's not madvised dontneed, so we
need to be sure there's no possible race there, which effectively means
inhibiting before the memory listener can do any pinning.

The reason I chose to inhibit per group is that it becomes easier to
allow endpoint drivers to opt-in.  For instance if we could have ccw
and vfio-pci in the same VM, they would by default share a container.
If ccw releases the inhibit, we'd need to somehow reinstate it for the
vfio-pci device and remember which did what if one is hot unplugged.
Doing the inhibit at the group level resolves this, the ccw group adds
an inhibit by default, then releases it, the vfio-pci group adds an
inhibit and maintains it so long as attached.  I struggled with whether
this should actually be a per-device inhibit, but then there's a gap
that the container listener is active before the device is retrieved,
so again the per-group inhibit was a better fit.  Thanks,

Alex
