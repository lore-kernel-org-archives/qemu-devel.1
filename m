Received: from eggs.gnu.org ([2001:4830:134:3::10]:36367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dz16R-0006oH-Ql
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dz16N-0004x5-Mf
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dz16N-0004wA-DQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:49:43 -0400
Date: Mon, 2 Oct 2017 15:49:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171002154924.27c5d7ce@nial.brq.redhat.com>
In-Reply-To: <20170925111954.GA3178@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-31-dgilbert@redhat.com>
	<20170914111832.7edc9268@nial.brq.redhat.com>
	<20170925111954.GA3178@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 30/32] vhost: Merge neighbouring hugepage
 regions where appropriate
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: lvivier@redhat.com, aarcange@redhat.com, mst@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, a.perevalov@samsung.com, maxime.coquelin@redhat.com, felipe@nutanix.com, marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

On Mon, 25 Sep 2017 12:19:55 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > On Thu, 24 Aug 2017 20:27:28 +0100
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> >   
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Where two regions are created with a gap such that when aligned
> > > to hugepage boundaries, the two regions overlap, merge them.  
> > why only hugepage boundaries, it should be applicable any alignment  
> 
> Actually this patch isn't huge-page specific - it just aligns to the
> pagesize; but do we ever hit a case where a region is smaller than a
> normal page and thus is changed by this?
> 
> > I'd say the patch isn't what I've had in mind when we discussed issue,  
> 
> Ah
> 
> > it builds on already existing merging code and complicates
> > code even more.  
> 
> Yes it is a little complex.
> 
> > Have you looked into possibility to rebuild memory map from scratch
> > every time vhost_region_add/vhost_region_del is called or even at
> > vhost_commit() time to reduce rebuild from a set of memory sections
> > that vhost tracks?
> > That should simplify algorithm a lot as memory sections are coming
> > from flat view and never overlap compared to current merged memory
> > map in vhost_dev::mem, so it won't have to deal with first splitting
> > and then merging back every time flatview changes.  
> 
> I hadn't; I was concentrating on changing the existing code rather than
> reworking it - especially since I don't/didn't know much about the
> notifiers.
> 
> Are you suggesting that basically vhost_region_add/del do nothing
> (except maybe set a flag) and the real work gets done in vhost_commit()?
> (I also found I had to call the merge from vhost_dev_start as well as
> vhost_commit - I guess from the first use?)
yep, i.e. build memmap on request.


> If I just did everything in vhost_commit where do I start - is that
> using something like address_space_to_flatview(address_space_memory) to
> get the main FlatView and somehow walk that?
vhost already tracks flat view with vhost_region_add/vhost_region_del
notifiers by saving references to MemoryRegionSection-s.
Memory sections have following properties/behavior:
 1. they never overlap
 2. when we map something over existing memory section.
    notifier first removes former section and then gets several
    region_add calls that add newly split non overlaping sections.

#2 happens multiple times when we start VM (before machine_done)
   and several times during firmware boot when some registers are
   (un)mapped during chip-set initialization.

so currently vhost_set_memory() is called uselessly multiple times
before memmap is actually need/used and it maintains essentially
optimized/sorted version of mem_sections[].
What I suggest is to 
 1. stop rebuilding memap in vhost_set_memory on 'every' flatview
    change and do it only when memmap is actually used
 2. get rid of duplicate data kept in regions[]/complex code that
    maintains it and
      2.1 use mem_sections[] directly to build memap on request.
      2.2 sorting mem_sections[] by start_addr when memmap is
          build could help to merge neighboring/mergable sections on the fly
          without need to resplit/merge regions[] in internally maintained
          memmap.

implementing both points would allow to drop a bunch of complex
code that sort of duplicates what flatview already does and I'd guess
this patch would be much simpler as result.

Optionally there is an idea to allow merging neighboring sections
even if there are gaps between them provided that GVA->HVA distance
for merging sections is the same (i.e sections belong to the same MR
with some holes in flatview punched by MMIO),
it should allow for better memmap compression then we have now.

PS:
refactoring probably should be split into separate series,
that should go in first.

> Dave
> 
> > > I also add quite a few trace events to see what's going on.
> > > 
> > > Note: This doesn't handle all the cases, but does handle the common
> > > case on a PC due to the 640k hole.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > >  hw/virtio/trace-events | 11 +++++++
> > >  hw/virtio/vhost.c      | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 89 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > index 5b599617a1..f98efb39fd 100644
> > > --- a/hw/virtio/trace-events
> > > +++ b/hw/virtio/trace-events
> > > @@ -1,5 +1,16 @@
> > >  # See docs/devel/tracing.txt for syntax documentation.
> > >  
> > > +# hw/virtio/vhost.c
> > > +vhost_dev_assign_memory_merged(int from, int to, uint64_t size, uint64_t start_addr, uint64_t uaddr) "f/t=%d/%d 0x%"PRIx64" @ P: 0x%"PRIx64" U: 0x%"PRIx64
> > > +vhost_dev_assign_memory_not_merged(uint64_t size, uint64_t start_addr, uint64_t uaddr) "0x%"PRIx64" @ P: 0x%"PRIx64" U: 0x%"PRIx64
> > > +vhost_dev_assign_memory_entry(uint64_t size, uint64_t start_addr, uint64_t uaddr) "0x%"PRIx64" @ P: 0x%"PRIx64" U: 0x%"PRIx64
> > > +vhost_dev_assign_memory_exit(uint32_t nregions) "%"PRId32
> > > +vhost_huge_page_stretch_and_merge_entry(uint32_t nregions) "%"PRId32
> > > +vhost_huge_page_stretch_and_merge_can(void) ""
> > > +vhost_huge_page_stretch_and_merge_size_align(int d, uint64_t gpa, uint64_t align) "%d: gpa: 0x%"PRIx64" align: 0x%"PRIx64
> > > +vhost_huge_page_stretch_and_merge_start_align(int d, uint64_t gpa, uint64_t align) "%d: gpa: 0x%"PRIx64" align: 0x%"PRIx64
> > > +vhost_section(const char *name, int r) "%s:%d"
> > > +
> > >  # hw/virtio/vhost-user.c
> > >  vhost_user_postcopy_end_entry(void) ""
> > >  vhost_user_postcopy_end_exit(void) ""
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 6eddb099b0..fb506e747f 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -27,6 +27,7 @@
> > >  #include "hw/virtio/virtio-access.h"
> > >  #include "migration/blocker.h"
> > >  #include "sysemu/dma.h"
> > > +#include "trace.h"
> > >  
> > >  /* enabled until disconnected backend stabilizes */
> > >  #define _VHOST_DEBUG 1
> > > @@ -250,6 +251,8 @@ static void vhost_dev_assign_memory(struct vhost_dev *dev,
> > >  {
> > >      int from, to;
> > >      struct vhost_memory_region *merged = NULL;
> > > +    trace_vhost_dev_assign_memory_entry(size, start_addr, uaddr);
> > > +
> > >      for (from = 0, to = 0; from < dev->mem->nregions; ++from, ++to) {
> > >          struct vhost_memory_region *reg = dev->mem->regions + to;
> > >          uint64_t prlast, urlast;
> > > @@ -293,11 +296,13 @@ static void vhost_dev_assign_memory(struct vhost_dev *dev,
> > >          uaddr = merged->userspace_addr = u;
> > >          start_addr = merged->guest_phys_addr = s;
> > >          size = merged->memory_size = e - s + 1;
> > > +        trace_vhost_dev_assign_memory_merged(from, to, size, start_addr, uaddr);
> > >          assert(merged->memory_size);
> > >      }
> > >  
> > >      if (!merged) {
> > >          struct vhost_memory_region *reg = dev->mem->regions + to;
> > > +        trace_vhost_dev_assign_memory_not_merged(size, start_addr, uaddr);
> > >          memset(reg, 0, sizeof *reg);
> > >          reg->memory_size = size;
> > >          assert(reg->memory_size);
> > > @@ -307,6 +312,7 @@ static void vhost_dev_assign_memory(struct vhost_dev *dev,
> > >      }
> > >      assert(to <= dev->mem->nregions + 1);
> > >      dev->mem->nregions = to;
> > > +    trace_vhost_dev_assign_memory_exit(to);
> > >  }
> > >  
> > >  static uint64_t vhost_get_log_size(struct vhost_dev *dev)
> > > @@ -610,8 +616,12 @@ static void vhost_set_memory(MemoryListener *listener,
> > >  
> > >  static bool vhost_section(MemoryRegionSection *section)
> > >  {
> > > -    return memory_region_is_ram(section->mr) &&
> > > +    bool result;
> > > +    result = memory_region_is_ram(section->mr) &&
> > >          !memory_region_is_rom(section->mr);
> > > +
> > > +    trace_vhost_section(section->mr->name, result);
> > > +    return result;
> > >  }
> > >  
> > >  static void vhost_begin(MemoryListener *listener)
> > > @@ -622,6 +632,68 @@ static void vhost_begin(MemoryListener *listener)
> > >      dev->mem_changed_start_addr = -1;
> > >  }
> > >  
> > > +/* Look for regions that are hugepage backed but not aligned
> > > + * and fix them up to be aligned.
> > > + * TODO: For now this is just enough to deal with the 640k hole
> > > + */
> > > +static bool vhost_huge_page_stretch_and_merge(struct vhost_dev *dev)
> > > +{
> > > +    int i, j;
> > > +    bool result = true;
> > > +    trace_vhost_huge_page_stretch_and_merge_entry(dev->mem->nregions);
> > > +
> > > +    for (i = 0; i < dev->mem->nregions; i++) {
> > > +        struct vhost_memory_region *reg = dev->mem->regions + i;
> > > +        ram_addr_t offset;
> > > +        RAMBlock *rb = qemu_ram_block_from_host((void *)reg->userspace_addr,
> > > +                                                false, &offset);
> > > +        size_t pagesize = qemu_ram_pagesize(rb);
> > > +        uint64_t alignage;
> > > +        alignage = reg->guest_phys_addr & (pagesize - 1);
> > > +        if (alignage) {
> > > +
> > > +            trace_vhost_huge_page_stretch_and_merge_start_align(i,
> > > +                                                (uint64_t)reg->guest_phys_addr,
> > > +                                                alignage);
> > > +            for (j = 0; j < dev->mem->nregions; j++) {
> > > +                struct vhost_memory_region *oreg = dev->mem->regions + j;
> > > +                if (j == i) {
> > > +                    continue;
> > > +                }
> > > +
> > > +                if (oreg->guest_phys_addr ==
> > > +                        (reg->guest_phys_addr - alignage) &&
> > > +                    oreg->userspace_addr ==
> > > +                         (reg->userspace_addr - alignage)) {
> > > +                    struct vhost_memory_region treg = *reg;
> > > +                    trace_vhost_huge_page_stretch_and_merge_can();
> > > +                    vhost_dev_unassign_memory(dev, oreg->guest_phys_addr,
> > > +                                              oreg->memory_size);
> > > +                    vhost_dev_unassign_memory(dev, treg.guest_phys_addr,
> > > +                                              treg.memory_size);
> > > +                    vhost_dev_assign_memory(dev,
> > > +                                            treg.guest_phys_addr - alignage,
> > > +                                            treg.memory_size + alignage,
> > > +                                            treg.userspace_addr - alignage);
> > > +                    return vhost_huge_page_stretch_and_merge(dev);
> > > +                }
> > > +            }
> > > +        }
> > > +        alignage = reg->memory_size & (pagesize - 1);
> > > +        if (alignage) {
> > > +            trace_vhost_huge_page_stretch_and_merge_size_align(i,
> > > +                                               (uint64_t)reg->guest_phys_addr,
> > > +                                               alignage);
> > > +            /* We ignore this if we find something else to merge,
> > > +             * so we only return false if we're left with this
> > > +             */
> > > +            result = false;
> > > +        }
> > > +    }
> > > +
> > > +    return result;
> > > +}
> > > +
> > >  static void vhost_commit(MemoryListener *listener)
> > >  {
> > >      struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> > > @@ -641,6 +713,7 @@ static void vhost_commit(MemoryListener *listener)
> > >          return;
> > >      }
> > >  
> > > +    vhost_huge_page_stretch_and_merge(dev);
> > >      if (dev->started) {
> > >          start_addr = dev->mem_changed_start_addr;
> > >          size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
> > > @@ -1512,6 +1585,10 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> > >          goto fail_features;
> > >      }
> > >  
> > > +    if (!vhost_huge_page_stretch_and_merge(hdev)) {
> > > +        VHOST_OPS_DEBUG("vhost_huge_page_stretch_and_merge failed");
> > > +        goto fail_mem;
> > > +    }
> > >      if (vhost_dev_has_iommu(hdev)) {
> > >          memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
> > >      }  
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
