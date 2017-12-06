Received: from eggs.gnu.org ([2001:4830:134:3::10]:53828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMg0Z-00049I-NA
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMg0U-0006Gv-K1
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:09:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eMg0U-0006FN-9u
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:09:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A22EF821C1
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 20:09:24 +0000 (UTC)
Date: Wed, 6 Dec 2017 20:09:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171206200916.GE2540@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<20171129185026.23632-5-dgilbert@redhat.com>
	<20171130122754.167f424a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130122754.167f424a@redhat.com>
Subject: Re: [Qemu-devel] [RFC 4/7] vhost: update_mem_cb implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, mst@redhat.com

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Wed, 29 Nov 2017 18:50:23 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add the meat of update_mem_cb;  this is called for each region,
> > to add a region to our temporary list.
> > Our temporary list is in order we look to see if this
> > region can be merged with the current head of list.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/virtio/trace-events |  2 ++
> >  hw/virtio/vhost.c      | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 4a493bcd46..92fadec192 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -2,6 +2,8 @@
> >  
> >  # hw/virtio/vhost.c
> >  vhost_section(const char *name, int r) "%s:%d"
> > +vhost_update_mem_cb(const char *name, uint64_t gpa, uint64_t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
> > +vhost_update_mem_cb_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx64
> >  
> >  # hw/virtio/virtio.c
> >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index c959a59fb3..7e3c6ae032 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -638,11 +638,64 @@ struct vhost_update_mem_tmp {
> >  /* Called for each MRS from vhost_update_mem */
> >  static int vhost_update_mem_cb(MemoryRegionSection *mrs, void *opaque)
> >  {
> > +    struct vhost_update_mem_tmp *vtmp = opaque;
> > +    struct vhost_memory_region *cur_vmr;
> > +    bool need_add = true;
> > +    uint64_t mrs_size;
> > +    uint64_t mrs_gpa;
> > +    uintptr_t mrs_host;
> > +
> >      if (!vhost_section(mrs)) {
> >          return 0;
> >      }
> > +    mrs_size = int128_get64(mrs->size);
> > +    mrs_gpa  = mrs->offset_within_address_space;
> > +    mrs_host = (uintptr_t)memory_region_get_ram_ptr(mrs->mr) +
> > +                         mrs->offset_within_region;
> > +
> > +    trace_vhost_update_mem_cb(mrs->mr->name, mrs_gpa, mrs_size,
> > +                              (uint64_t)mrs_host);
> > +
> > +    if (vtmp->nregions) {
> What forces you to maintain helper vhost_memory_region array
> instead of MemoryRegionSection array?

I looked at this - neither is nice.
I think I need to keep the real dev->mem->regions to keep vhost
happy.  If I've got to keep that then I've got to produce something
in that format; so producing it here and comparing it at the end
(possibly with your simple memcmp) works nicely.

The other downside of keeping working with the MemoryRegionSections is
that they have the size as an Int128 which is a pain to work with.

Dave

> > +        /* Since we already have at least one region, lets see if
> > +         * this extends it; since we're scanning in order, we only
> > +         * have to look at the last one, and the FlatView that calls
> > +         * us shouldn't have overlaps.
> > +         */
> > +        struct vhost_memory_region *prev_vmr = vtmp->regions +
> > +                                               (vtmp->nregions - 1);
> > +        uint64_t prev_gpa_start = prev_vmr->guest_phys_addr;
> > +        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start,
> > +                                                 prev_vmr->memory_size);
> > +        uint64_t prev_host_start = prev_vmr->userspace_addr;
> > +        uint64_t prev_host_end   = range_get_last(prev_host_start,
> > +                                                  prev_vmr->memory_size);
> > +
> > +        if (prev_gpa_end + 1 == mrs_gpa &&
> > +            prev_host_end + 1 == mrs_host &&
> > +            (!vtmp->dev->vhost_ops->vhost_backend_can_merge ||
> > +                vtmp->dev->vhost_ops->vhost_backend_can_merge(vtmp->dev,
> > +                    mrs_host, mrs_size,
> > +                    prev_host_start, prev_vmr->memory_size))) {
> > +            /* The two regions abut */
> > +            need_add = false;
> > +            mrs_size = mrs_size + prev_vmr->memory_size;
> > +            prev_vmr->memory_size = mrs_size;
> > +            trace_vhost_update_mem_cb_abut(mrs->mr->name, mrs_size);
> > +        }
> > +    }
> > +
> > +    if (need_add) {
> > +        vtmp->nregions++;
> > +        vtmp->regions = g_realloc_n(vtmp->regions, vtmp->nregions,
> > +                                    sizeof(vtmp->regions[0]));
> > +        cur_vmr = &vtmp->regions[vtmp->nregions - 1];
> > +        cur_vmr->guest_phys_addr = mrs_gpa;
> > +        cur_vmr->memory_size     = mrs_size;
> > +        cur_vmr->userspace_addr  = mrs_host;
> > +        cur_vmr->flags_padding = 0;
> > +    }
> >  
> > -    /* TODO */
> >      return 0;
> >  }
> >  
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
