Received: from eggs.gnu.org ([2001:4830:134:3::10]:57218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eKnN8-0007z3-Jh
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eKnN5-0002Rs-Dj
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:37:02 -0500
Date: Thu, 30 Nov 2017 16:09:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171130160929.7fb2b027@t450s.home>
In-Reply-To: <431ee02e-a73e-70c8-185d-43223c52c693@ozlabs.ru>
References: <20171005055037.7767-1-aik@ozlabs.ru>
	<20171005055037.7767-2-aik@ozlabs.ru>
	<431ee02e-a73e-70c8-185d-43223c52c693@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5 1/2] memory/iommu/vfio: Define
 add_vfio_group() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 1 Dec 2017 08:56:42 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 05/10/17 16:50, Alexey Kardashevskiy wrote:
> > The new callback will be called when a new VFIO IOMMU group is added.
> > 
> > This should cause no behavioral change, the next patch will.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
> 
> 
> What about this one,  any conclusion yet?

Patchew reported that if failed to build and you never replied with an
explanation, so I haven't looked at it.

> > ---
> > 
> > This could be at the higher level - in MemoryRegionOps, makes sense?
> > 
> > ---
> >  include/exec/memory.h |  4 ++++
> >  hw/vfio/common.c      | 15 +++++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 5ed4042f87..64e0b4fc96 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -210,6 +210,10 @@ typedef struct IOMMUMemoryRegionClass {
> >                                  IOMMUNotifierFlag new_flags);
> >      /* Set this up to provide customized IOMMU replay function */
> >      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
> > +
> > +    /* Notifies IOMMUMR about attached VFIO IOMMU group */
> > +    void (*add_vfio_group)(IOMMUMemoryRegion *iommu_mr, int vfio_kvm_fd,
> > +                           int groupfd);

If there's an "add" why is there no remove?

Clearly a vfio specific callback is pretty much a failure as far as
abstraction and layering is concerned.

> >  } IOMMUMemoryRegionClass;
> >  
> >  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 7b2924c0ef..9e861e0393 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -481,6 +481,21 @@ static void vfio_listener_region_add(MemoryListener *listener,
> >          VFIOGuestIOMMU *giommu;
> >          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> >  
> > +#ifdef CONFIG_KVM
> > +        if (kvm_enabled()) {
> > +            VFIOGroup *group;
> > +            IOMMUMemoryRegionClass *imrc =
> > +                IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> > +
> > +            QLIST_FOREACH(group, &container->group_list, container_next) {
> > +                if (imrc->add_vfio_group) {
> > +                    imrc->add_vfio_group(iommu_mr, vfio_kvm_device_fd,
> > +                                         group->fd);
> > +                }
> > +            }
> > +        }
> > +#endif
> > +
> >          trace_vfio_listener_region_add_iommu(iova, end);
> >          /*
> >           * FIXME: For VFIO iommu types which have KVM acceleration to
> >   
> 
> 
