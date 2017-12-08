Received: from eggs.gnu.org ([2001:4830:134:3::10]:47326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNJr0-0001hc-OR
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNJqx-0008Jd-HM
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eNJqx-0008JU-74
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:42:15 -0500
Date: Fri, 8 Dec 2017 15:42:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171208154209.7e01a88d@redhat.com>
In-Reply-To: <20171207181750.GE2439@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<1512138175-185428-1-git-send-email-imammedo@redhat.com>
	<20171207181750.GE2439@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] vhost: check if ring mapping is still valid
 when building memmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, groug@kaod.org, stefanha@gmail.com

On Thu, 7 Dec 2017 18:17:51 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > vhost_verify_ring_mappings() were used to verify that
> > rings are still accessible and related memory hasn't
> > been moved after flatview is updated.
> > 
> > It were doing checks by mapping ring's GPA+len and
> > checking that HVA hasn't changed with new memory map.
> > To avoid maybe expensive mapping call, we were
> > identifying address range that changed and were doing
> > mapping only if ring were in changed range.
> > 
> > However it's no neccessary to perform ringi's GPA
> > mapping as we already have it's current HVA and all
> > we need is to verify that ring's GPA translates to
> > the same HVA in updated flatview.
> > 
> > That could be done during time when we are building
> > vhost memmap where vhost_update_mem_cb() already maps
> > every RAM MemoryRegionSection to get section HVA. This
> > fact can be used to check that ring belongs to the same
> > MemoryRegion in the same place, like this:
> > 
> >   hva_ring_offset = GPA(ring) - GPA(MemoryRegionSection)
> >   ring_hva == HVA(MemoryRegionSection) + hva_ring_offset
> > 
> > Doing this would allow us to drop ~100LOC of code which
> > figures out changed memory range and avoid calling not
> > needed reverse vhost_memory_map(is_write=true) which is
> > overkill for the task at hand.  
> 
> There are a few things about this I don't understand; however if
> it's right I agree that it means we can kill off my comparison
> code.
> 
> 
> First, can I check what constraints 'verify_ring' needs to check;
> if I'm understanding the original code it's checking that :
>     a) If a queue falls within a region, that the whole queue can
>        be mapped
         see vhost_verify_ring_part_mapping():

             p = vhost_memory_map(dev, part_addr, &l, 1);                                 
             if (!p || l != part_size) 
                  error_out
             
         1st: (!p) requested part_addr must be mapped
              i.e. be a part of MemorySection in flatview
         AND
         2nd: (l != part_size) mapped range size must match what we asked for
              i.e. mapped as continuous range so that
                 [GPA, GPA + part_size) could directly correspond to [HVA, HVA + part_size)
              and that's is possible only withing 1 MemorySection && 1 MeoryRegion
              if I read address_space_map() correctly
                     flatview_translate() -> GPA's MemorySection
                     flatview_extend_translation() -> 1:1 GPA->HVA range size
              
         So answer in case of RAM memory region that we are interested in, would be:
         queue falls within a MemorySection and whole queue fits in to it

>     b) And the start of the queue corresponds to where we thought
>        it used to be (in GPA?)
         that cached at vq->desc queue HVA hasn't changed after flatview change
            if (p != part)
               error_out
> 
> 
>    so that doesn't have any constraint on the ordering of the regions
>    or whether the region is the same size or anything.
>   Also I don't think it would spot if there was a qeueue that had no
>   region associated with it at all.
> 
> Now, comments on your code below:
> 
> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS:
> >    should be applied on top of David's series
> > 
> > ---
> >  include/hw/virtio/vhost.h |   2 -
> >  hw/virtio/vhost.c         | 195 ++++++++++++++--------------------------------
> >  2 files changed, 57 insertions(+), 140 deletions(-)
> > 
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 467dc77..fc4af5c 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -68,8 +68,6 @@ struct vhost_dev {
> >      uint64_t log_size;
> >      Error *migration_blocker;
> >      bool memory_changed;
> > -    hwaddr mem_changed_start_addr;
> > -    hwaddr mem_changed_end_addr;
> >      const VhostOps *vhost_ops;
> >      void *opaque;
> >      struct vhost_log *log;
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 5b9a7d7..026bac3 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -296,35 +296,43 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
> >      }
> >  }
> >  
> > -static int vhost_verify_ring_part_mapping(struct vhost_dev *dev,
> > -                                          void *part,
> > -                                          uint64_t part_addr,
> > -                                          uint64_t part_size,
> > -                                          uint64_t start_addr,
> > -                                          uint64_t size)
> > +static int vhost_verify_ring_part_mapping(void *ring_hva,
> > +                                          uint64_t ring_gpa,
> > +                                          uint64_t ring_size,
> > +                                          void *reg_hva,
> > +                                          uint64_t reg_gpa,
> > +                                          uint64_t reg_size)
> >  {
> > -    hwaddr l;
> > -    void *p;
> > -    int r = 0;
> > +    uint64_t hva_ring_offset;
> > +    uint64_t ring_last = range_get_last(ring_gpa, ring_size);
> > +    uint64_t reg_last = range_get_last(reg_gpa, reg_size);
> >  
> > -    if (!ranges_overlap(start_addr, size, part_addr, part_size)) {
> > +    /* start check from the end so that the rest of checks
> > +     * are done when whole ring is in merged sections range
> > +     */
> > +    if (ring_last < reg_last || ring_gpa > reg_last) {
> >          return 0;
> >      }  
> 
>   so does that mean if our region never grows to be as big as the ring
> we wont spot the problem?
I think there is mistake here it should be:
   ring_last < reg_gpa || ring_gpa > reg_last

so if ring is out side of continuous region, we do not care => no change

> 
> > -    l = part_size;
> > -    p = vhost_memory_map(dev, part_addr, &l, 1);
> > -    if (!p || l != part_size) {
> > -        r = -ENOMEM;
> > +
> > +    /* check that whole ring's is mapped */
> > +    if (range_get_last(ring_gpa, ring_size) >
> > +        range_get_last(reg_gpa, reg_size)) {
> > +        return -EBUSY;
> >      }  
> 
> can't that be:
>        if (ring_last > reg_last) {
>            return -EBUSY;
>        }
yep 

> > -    if (p != part) {
> > -        r = -EBUSY;
> > +
> > +    /* check that ring's MemoryRegion wasn't replaced */
> > +    hva_ring_offset = ring_gpa - reg_gpa;
> > +    if (ring_hva != reg_hva + hva_ring_offset) {
> > +        return -ENOMEM;
> >      }  
> 
> Is that the same as:
>    if (ring_gpa - reg_gpa != ring_hva - reg_hva) ?
> which seems more symmetrical if true.
it looks more cryptic to me, my more verbose variant should
be easier to read when one forgets how it all works and needs
to figure it out again.


> > -    vhost_memory_unmap(dev, p, l, 0, 0);
> > -    return r;
> > +
> > +    return 0;
> >  }
> >  
> >  static int vhost_verify_ring_mappings(struct vhost_dev *dev,
> > -                                      uint64_t start_addr,
> > -                                      uint64_t size)
> > +                                      void *reg_hva,
> > +                                      uint64_t reg_gpa,
> > +                                      uint64_t reg_size)
> >  {
> >      int i, j;
> >      int r = 0;
> > @@ -338,23 +346,26 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
> >          struct vhost_virtqueue *vq = dev->vqs + i;
> >  
> >          j = 0;
> > -        r = vhost_verify_ring_part_mapping(dev, vq->desc, vq->desc_phys,
> > -                                           vq->desc_size, start_addr, size);
> > -        if (!r) {
> > +        r = vhost_verify_ring_part_mapping(
> > +                vq->desc, vq->desc_phys, vq->desc_size,
> > +                reg_hva, reg_gpa, reg_size);
> > +        if (r) {
> >              break;
> >          }
> >  
> >          j++;
> > -        r = vhost_verify_ring_part_mapping(dev, vq->avail, vq->avail_phys,
> > -                                           vq->avail_size, start_addr, size);
> > -        if (!r) {
> > +        r = vhost_verify_ring_part_mapping(
> > +                vq->desc, vq->desc_phys, vq->desc_size,
> > +                reg_hva, reg_gpa, reg_size);
> > +        if (r) {
> >              break;
> >          }
> >  
> >          j++;
> > -        r = vhost_verify_ring_part_mapping(dev, vq->used, vq->used_phys,
> > -                                           vq->used_size, start_addr, size);
> > -        if (!r) {
> > +        r = vhost_verify_ring_part_mapping(
> > +                vq->desc, vq->desc_phys, vq->desc_size,
> > +                reg_hva, reg_gpa, reg_size);
> > +        if (r) {
> >              break;
> >          }
> >      }
> > @@ -384,24 +395,18 @@ static bool vhost_section(MemoryRegionSection *section)
> >      return result;
> >  }
> >  
> > -static void vhost_begin(MemoryListener *listener)
> > -{
> > -    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> > -                                         memory_listener);
> > -    dev->mem_changed_end_addr = 0;
> > -    dev->mem_changed_start_addr = -1;
> > -}
> > -
> >  struct vhost_update_mem_tmp {
> >      struct vhost_dev   *dev;
> >      uint32_t nregions;
> >      struct vhost_memory_region *regions;
> >  };
> >  
> > +
> >  /* Called for each MRS from vhost_update_mem */
> >  static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
> >  {
> >      struct vhost_update_mem_tmp *vtmp = opaque;
> > +    struct vhost_dev   *dev = vtmp->dev;
> >      struct vhost_memory_region *cur_vmr;
> >      bool need_add = true;
> >      uint64_t mrs_size;
> > @@ -416,8 +421,7 @@ static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
> >      mrs_host = (uintptr_t)memory_region_get_ram_ptr(mrs->mr) +
> >                           mrs->offset_within_region;
> >  
> > -    trace_vhost_update_mem_cb(mrs->mr->name, mrs_gpa, mrs_size,
> > -                              (uint64_t)mrs_host);
> > +    trace_vhost_update_mem_cb(mrs->mr->name, mrs_gpa, mrs_size, mrs_host);
> >  
> >      if (vtmp->nregions) {
> >          /* Since we already have at least one region, lets see if
> > @@ -459,85 +463,19 @@ static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
> >          cur_vmr->flags_padding = 0;
> >      }
> >  
> > -    return 0;
> > -}
> > -
> > -static bool vhost_update_compare_list(struct vhost_dev *dev,
> > -                                      struct vhost_update_mem_tmp *vtmp,
> > -                                      hwaddr *change_start, hwaddr *change_end)
> > -{
> > -    uint32_t oldi, newi;
> > -    *change_start = 0;
> > -    *change_end = 0;
> > -
> > -    for (newi = 0, oldi = 0; newi < vtmp->nregions; newi++) {
> > -        struct vhost_memory_region *newr = &vtmp->regions[newi];
> > -        hwaddr newr_last = range_get_last(newr->guest_phys_addr,
> > -                                          newr->memory_size);
> > -        trace_vhost_update_compare_list_loopn(newi, oldi,
> > -                                        newr->guest_phys_addr,
> > -                                        newr->memory_size);
> > -        bool whole_change = true;
> > -        while (oldi < dev->mem->nregions) {
> > -            struct vhost_memory_region *oldr = &dev->mem->regions[oldi];
> > -            hwaddr oldr_last = range_get_last(oldr->guest_phys_addr,
> > -                                          oldr->memory_size);
> > -            trace_vhost_update_compare_list_loopo(newi, oldi,
> > -                                        oldr->guest_phys_addr,
> > -                                        oldr->memory_size);
> > -            if (newr->guest_phys_addr == oldr->guest_phys_addr &&
> > -                newr->memory_size == oldr->memory_size) {
> > -                /* Match in GPA and size, but it could be different
> > -                 * in host address or flags
> > -                 */
> > -                whole_change = newr->userspace_addr != oldr->userspace_addr ||
> > -                               newr->flags_padding != oldr->flags_padding;
> > -                oldi++;
> > -                break; /* inner old loop */
> > -            }
> > -            /* There's a difference - need to figure out what */
> > -            if (oldr_last < newr->guest_phys_addr) {
> > -                /* There used to be a region before us that's gone */
> > -                *change_start = MIN(*change_start, oldr->guest_phys_addr);
> > -                *change_end = MAX(*change_end, oldr_last);
> > -                oldi++;
> > -                continue; /* inner old loop */
> > -            }
> > -            if (oldr->guest_phys_addr > newr_last) {
> > -                /* We've passed all the old mappings that could have overlapped
> > -                 * this one
> > -                 */
> > -                break; /* Inner old loop */
> > -            }
> > -            /* Overlap case */
> > -            *change_start = MIN(*change_start,
> > -                                MIN(oldr->guest_phys_addr,
> > -                                    newr->guest_phys_addr));
> > -            *change_end = MAX(*change_end,
> > -                                MAX(oldr_last, newr_last));
> > -            whole_change = false;
> > -            /* There might be more old mappings that overlap */
> > -            oldi++;
> > -        }
> > -        if (whole_change) {
> > -            /* No old region to compare against, this must be a change */
> > -            *change_start = MIN(*change_start, newr->guest_phys_addr);
> > -            *change_end = MAX(*change_end, newr_last);
> > -        }
> > +    if (dev->started &&
> > +        vhost_verify_ring_mappings(dev, (void *)mrs_host, mrs_gpa, mrs_size)) {
> > +        abort();
> >      }
> >  
> > -    return *change_start || *change_end;
> > +    return 0;
> >  }
> >  
> >  static int vhost_update_mem(struct vhost_dev *dev)
> >  {
> >      int res;
> > -    struct vhost_update_mem_tmp vtmp;
> > -    hwaddr change_start, change_end;
> > -    bool need_update;
> > -    vtmp.regions = 0;
> > -    vtmp.nregions = 0;
> > -    vtmp.dev = dev;
> > +    size_t mem_size;
> > +    struct vhost_update_mem_tmp vtmp = {.dev = dev};
> >  
> >      res = address_space_iterate(&address_space_memory,
> >                                  vhost_update_mem_cb, &vtmp);
> > @@ -545,24 +483,17 @@ static int vhost_update_mem(struct vhost_dev *dev)
> >          goto out;
> >      }
> >  
> > -    need_update = vhost_update_compare_list(dev, &vtmp,
> > -                                            &change_start, &change_end);
> > -    trace_vhost_update_mem_comparison(need_update,
> > -                                      (uint64_t)change_start,
> > -                                      (uint64_t)change_end);
> > -    if (need_update) {
> > -        /* Update the main regions list from our tmp */
> > -        size_t mem_size = offsetof(struct vhost_memory, regions) +
> > -            (vtmp.nregions + 1) * sizeof dev->mem->regions[0];
> > +    mem_size = offsetof(struct vhost_memory, regions) +
> > +               (vtmp.nregions + 1) * sizeof dev->mem->regions[0];
> >  
> > +    if(vtmp.nregions != dev->mem->nregions ||
> > +       memcmp(vtmp.regions, dev->mem->regions, mem_size)) {
> > +        /* Update the main regions list from our tmp */
> >          dev->mem = g_realloc(dev->mem, mem_size);
> >          dev->mem->nregions = vtmp.nregions;
> >          memcpy(dev->mem->regions, vtmp.regions,
> >                 vtmp.nregions * sizeof dev->mem->regions[0]);
> >          used_memslots = vtmp.nregions;
> > -
> > -        dev->mem_changed_start_addr = change_start;
> > -        dev->mem_changed_end_addr = change_end;
> >      }
> >  
> >  out:
> > @@ -574,8 +505,6 @@ static void vhost_commit(MemoryListener *listener)
> >  {
> >      struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> >                                           memory_listener);
> > -    hwaddr start_addr = 0;
> > -    ram_addr_t size = 0;
> >      uint64_t log_size;
> >      int r;
> >  
> > @@ -585,22 +514,11 @@ static void vhost_commit(MemoryListener *listener)
> >      if (!dev->started) {
> >          return;
> >      }
> > -    if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
> > -        return;
> > -    }  
> 
> This was in the wrong place in the version I posted; this should have
> been after the vhost_update_mem;  I think we still need something
> telling us whether vhost_update_mem found a change, because we want to
> skip the rest of vhost_commit if there's no change at all.
maybe cache memcmp result in dev->memory_changed

> 
> >      if (vhost_update_mem(dev)) {
> >          return;
> >      }
> >  
> > -    if (dev->started) {
> > -        start_addr = dev->mem_changed_start_addr;
> > -        size = dev->mem_changed_end_addr - dev->mem_changed_start_addr + 1;
> > -
> > -        r = vhost_verify_ring_mappings(dev, start_addr, size);
> > -        assert(r >= 0);
> > -    }
> > -
> >      if (!dev->log_enabled) {
> >          r = dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
> >          if (r < 0) {
> > @@ -1235,7 +1153,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >      hdev->features = features;
> >  
> >      hdev->memory_listener = (MemoryListener) {
> > -        .begin = vhost_begin,
> >          .commit = vhost_commit,
> >          .region_add = vhost_region_add,
> >          .region_del = vhost_region_del,
> > @@ -1458,7 +1375,6 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >      /* should only be called after backend is connected */
> >      assert(hdev->vhost_ops);
> >  
> > -    hdev->started = true;
> >      hdev->vdev = vdev;
> >  
> >      r = vhost_dev_set_features(hdev, hdev->log_enabled);
> > @@ -1469,6 +1385,9 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >      if (vhost_update_mem(hdev)) {
> >          goto fail_mem;
> >      }
> > +
> > +    hdev->started = true;
> > +  
> 
> Ah, good spot.
> 
> Dave
> 
> >      if (vhost_dev_has_iommu(hdev)) {
> >          memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
> >      }
> > -- 
> > 2.7.4
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
