Received: from eggs.gnu.org ([2001:4830:134:3::10]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOLri-0001N8-Fl
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOLra-0007fX-9e
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:03:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOLra-0007el-1b
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:03:10 -0500
Date: Mon, 11 Dec 2017 11:03:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171211110259.GB2424@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<1512138175-185428-1-git-send-email-imammedo@redhat.com>
	<20171207181750.GE2439@work-vm>
	<20171208154209.7e01a88d@redhat.com>
	<20171208175155.GS2403@work-vm>
	<20171211103755.2c95f86a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211103755.2c95f86a@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, groug@kaod.org, stefanha@gmail.com

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Fri, 8 Dec 2017 17:51:56 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > On Thu, 7 Dec 2017 18:17:51 +0000
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Igor Mammedov (imammedo@redhat.com) wrote:  
> > > > > vhost_verify_ring_mappings() were used to verify that
> > > > > rings are still accessible and related memory hasn't
> > > > > been moved after flatview is updated.
> > > > > 
> > > > > It were doing checks by mapping ring's GPA+len and
> > > > > checking that HVA hasn't changed with new memory map.
> > > > > To avoid maybe expensive mapping call, we were
> > > > > identifying address range that changed and were doing
> > > > > mapping only if ring were in changed range.
> > > > > 
> > > > > However it's no neccessary to perform ringi's GPA
> > > > > mapping as we already have it's current HVA and all
> > > > > we need is to verify that ring's GPA translates to
> > > > > the same HVA in updated flatview.
> > > > > 
> > > > > That could be done during time when we are building
> > > > > vhost memmap where vhost_update_mem_cb() already maps
> > > > > every RAM MemoryRegionSection to get section HVA. This
> > > > > fact can be used to check that ring belongs to the same
> > > > > MemoryRegion in the same place, like this:
> > > > > 
> > > > >   hva_ring_offset = GPA(ring) - GPA(MemoryRegionSection)
> > > > >   ring_hva == HVA(MemoryRegionSection) + hva_ring_offset
> > > > > 
> > > > > Doing this would allow us to drop ~100LOC of code which
> > > > > figures out changed memory range and avoid calling not
> > > > > needed reverse vhost_memory_map(is_write=true) which is
> > > > > overkill for the task at hand.    
> > > > 
> > > > There are a few things about this I don't understand; however if
> > > > it's right I agree that it means we can kill off my comparison
> > > > code.
> > > > 
> > > > 
> > > > First, can I check what constraints 'verify_ring' needs to check;
> > > > if I'm understanding the original code it's checking that :
> > > >     a) If a queue falls within a region, that the whole queue can
> > > >        be mapped  
> > >          see vhost_verify_ring_part_mapping():
> > > 
> > >              p = vhost_memory_map(dev, part_addr, &l, 1);                                 
> > >              if (!p || l != part_size) 
> > >                   error_out
> > >              
> > >          1st: (!p) requested part_addr must be mapped
> > >               i.e. be a part of MemorySection in flatview
> > >          AND
> > >          2nd: (l != part_size) mapped range size must match what we asked for
> > >               i.e. mapped as continuous range so that
> > >                  [GPA, GPA + part_size) could directly correspond to [HVA, HVA + part_size)
> > >               and that's is possible only withing 1 MemorySection && 1 MeoryRegion
> > >               if I read address_space_map() correctly
> > >                      flatview_translate() -> GPA's MemorySection
> > >                      flatview_extend_translation() -> 1:1 GPA->HVA range size
> > >               
> > >          So answer in case of RAM memory region that we are interested in, would be:
> > >          queue falls within a MemorySection and whole queue fits in to it  
> > 
> > Yes, OK.
> > 
> > > >     b) And the start of the queue corresponds to where we thought
> > > >        it used to be (in GPA?)  
> > >          that cached at vq->desc queue HVA hasn't changed after flatview change
> > >             if (p != part)
> > >                error_out  
> > 
> > OK, so it's the HVA that's not changed based on taking the part_addr
> > which is GPA and checking the map?
> Yes, I think so.
> 
> > > >    so that doesn't have any constraint on the ordering of the regions
> > > >    or whether the region is the same size or anything.
> > > >   Also I don't think it would spot if there was a qeueue that had no
> > > >   region associated with it at all.
> > > > 
> > > > Now, comments on your code below:
> > > > 
> > > >   
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > > PS:
> > > > >    should be applied on top of David's series
> > > > > 
> > > > > ---
> > > > >  include/hw/virtio/vhost.h |   2 -
> > > > >  hw/virtio/vhost.c         | 195 ++++++++++++++--------------------------------
> > > > >  2 files changed, 57 insertions(+), 140 deletions(-)
> > > > > 
> > > > > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > > > > index 467dc77..fc4af5c 100644
> > > > > --- a/include/hw/virtio/vhost.h
> > > > > +++ b/include/hw/virtio/vhost.h
> > > > > @@ -68,8 +68,6 @@ struct vhost_dev {
> > > > >      uint64_t log_size;
> > > > >      Error *migration_blocker;
> > > > >      bool memory_changed;
> > > > > -    hwaddr mem_changed_start_addr;
> > > > > -    hwaddr mem_changed_end_addr;
> > > > >      const VhostOps *vhost_ops;
> > > > >      void *opaque;
> > > > >      struct vhost_log *log;
> > > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > > index 5b9a7d7..026bac3 100644
> > > > > --- a/hw/virtio/vhost.c
> > > > > +++ b/hw/virtio/vhost.c
> > > > > @@ -296,35 +296,43 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
> > > > >      }
> > > > >  }
> > > > >  
> > > > > -static int vhost_verify_ring_part_mapping(struct vhost_dev *dev,
> > > > > -                                          void *part,
> > > > > -                                          uint64_t part_addr,
> > > > > -                                          uint64_t part_size,
> > > > > -                                          uint64_t start_addr,
> > > > > -                                          uint64_t size)
> > > > > +static int vhost_verify_ring_part_mapping(void *ring_hva,
> > > > > +                                          uint64_t ring_gpa,
> > > > > +                                          uint64_t ring_size,
> > > > > +                                          void *reg_hva,
> > > > > +                                          uint64_t reg_gpa,
> > > > > +                                          uint64_t reg_size)
> > > > >  {
> > > > > -    hwaddr l;
> > > > > -    void *p;
> > > > > -    int r = 0;
> > > > > +    uint64_t hva_ring_offset;
> > > > > +    uint64_t ring_last = range_get_last(ring_gpa, ring_size);
> > > > > +    uint64_t reg_last = range_get_last(reg_gpa, reg_size);
> > > > >  
> > > > > -    if (!ranges_overlap(start_addr, size, part_addr, part_size)) {
> > > > > +    /* start check from the end so that the rest of checks
> > > > > +     * are done when whole ring is in merged sections range
> > > > > +     */
> > > > > +    if (ring_last < reg_last || ring_gpa > reg_last) {
> > > > >          return 0;
> > > > >      }    
> > > > 
> > > >   so does that mean if our region never grows to be as big as the ring
> > > > we wont spot the problem?  
> > > I think there is mistake here it should be:
> > >    ring_last < reg_gpa || ring_gpa > reg_last
> > > 
> > > so if ring is out side of continuous region, we do not care => no change  
> > 
> > OK, I don't see how that corresponds to your 'start check from the end'
> > comment - I thought it was doing something smarter to deal with this
> > being called from the _cb routine potentially before another part of the
> > range had been joined onto it.
> > In that case, we can just use ranges_overlap like the original
> > routine did.
> I suppose range check will do as well, the reason for check from the end
> was optimization to make less checks than ranges_overlap(),
> considering we are comparing against vhost_memory_region.

Have a look at the RFC v2 I've posted; I've reworked it a bit so
we call this code aftwards rather than from the _cb.

> But it seems like a bit an overdoing, since by the commit time
> flatview would contain 1:1 mapping of MemorySection:vhost_memory_region
> (modulo sections we are not interested in). It should be unlikely to 
> get 2 MemoryRegions allocated one after another and merge in vhost_memory_region()
> into one vhost_memory_region. Maybe we would be better off with just
> copying MemorySections into vhost_memory_region in vhost_update_mem_cb()
> and drop merging altogether.

Except I need the merging for the hugepage stuff that's coming in the
postcopy world.

> I'd even consider 'non deterministic' merging of 2 MemoryRegions harmful
> to migration, since vhost might see different memory map on target vs source.

I think that's come up before and it was decided it's not a problem
as long as the regions are still mapped; the only consistency required
is between the qemu and the vhost (either the kernel or the vhost-user);
it shouldn't be a guest visibile issue if I understand it correctly.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
