Received: from eggs.gnu.org ([2001:4830:134:3::10]:43224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYbYU-0005CW-8l
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYbXP-0007WR-4R
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:49:50 -0500
Date: Mon, 8 Jan 2018 17:48:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180108174829.GG2462@work-vm>
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-2-dgilbert@redhat.com>
	<20171227125627.5c3affd1@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171227125627.5c3affd1@igors-macbook-pro.local>
Subject: Re: [Qemu-devel] [PATCH v5 1/7] vhost: Build temporary section list
 and deref after commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org, qemu-stable@nongnu.org

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Mon, 18 Dec 2017 20:13:34 +0000
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Igor spotted that there's a race, where a region that's unref'd
> > in a _del callback might be free'd before the set_mem_table call in
> > the _commit callback, and thus the vhost might end up using free memory.
> > 
> > Fix this by building a complete temporary sections list, ref'ing every
> > section (during add and nop) and then unref'ing the whole list right
> > at the end of commit.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> As Michael've suggested it should go into stable (CCed)

OK,

> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks!

Dave

> 
> > ---
> >  hw/virtio/vhost.c         | 73 ++++++++++++++++++++++++++++++-----------------
> >  include/hw/virtio/vhost.h |  2 ++
> >  2 files changed, 49 insertions(+), 26 deletions(-)
> > 
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index e4290ce93d..610bfe6945 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -621,6 +621,8 @@ static void vhost_begin(MemoryListener *listener)
> >                                           memory_listener);
> >      dev->mem_changed_end_addr = 0;
> >      dev->mem_changed_start_addr = -1;
> > +    dev->tmp_sections = NULL;
> > +    dev->n_tmp_sections = 0;
> >  }
> >  
> >  static void vhost_commit(MemoryListener *listener)
> > @@ -629,17 +631,25 @@ static void vhost_commit(MemoryListener *listener)
> >                                           memory_listener);
> >      hwaddr start_addr = 0;
> >      ram_addr_t size = 0;
> > +    MemoryRegionSection *old_sections;
> > +    int n_old_sections;
> > +
> >      uint64_t log_size;
> >      int r;
> >  
> > +    old_sections = dev->mem_sections;
> > +    n_old_sections = dev->n_mem_sections;
> > +    dev->mem_sections = dev->tmp_sections;
> > +    dev->n_mem_sections = dev->n_tmp_sections;
> > +
> >      if (!dev->memory_changed) {
> > -        return;
> > +        goto out;
> >      }
> >      if (!dev->started) {
> > -        return;
> > +        goto out;
> >      }
> >      if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
> > -        return;
> > +        goto out;
> >      }
> >  
> >      if (dev->started) {
> > @@ -656,7 +666,7 @@ static void vhost_commit(MemoryListener *listener)
> >              VHOST_OPS_DEBUG("vhost_set_mem_table failed");
> >          }
> >          dev->memory_changed = false;
> > -        return;
> > +        goto out;
> >      }
> >      log_size = vhost_get_log_size(dev);
> >      /* We allocate an extra 4K bytes to log,
> > @@ -675,6 +685,27 @@ static void vhost_commit(MemoryListener *listener)
> >          vhost_dev_log_resize(dev, log_size);
> >      }
> >      dev->memory_changed = false;
> > +
> > +out:
> > +    /* Deref the old list of sections, this must happen _after_ the
> > +     * vhost_set_mem_table to ensure the client isn't still using the
> > +     * section we're about to unref.
> > +     */
> > +    while (n_old_sections--) {
> > +        memory_region_unref(old_sections[n_old_sections].mr);
> > +    }
> > +    g_free(old_sections);
> > +    return;
> > +}
> > +
> > +static void vhost_add_section(struct vhost_dev *dev,
> > +                              MemoryRegionSection *section)
> > +{
> > +    ++dev->n_tmp_sections;
> > +    dev->tmp_sections = g_renew(MemoryRegionSection, dev->tmp_sections,
> > +                                dev->n_tmp_sections);
> > +    dev->tmp_sections[dev->n_tmp_sections - 1] = *section;
> > +    memory_region_ref(section->mr);
> >  }
> >  
> >  static void vhost_region_add(MemoryListener *listener,
> > @@ -687,36 +718,31 @@ static void vhost_region_add(MemoryListener *listener,
> >          return;
> >      }
> >  
> > -    ++dev->n_mem_sections;
> > -    dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,
> > -                                dev->n_mem_sections);
> > -    dev->mem_sections[dev->n_mem_sections - 1] = *section;
> > -    memory_region_ref(section->mr);
> > +    vhost_add_section(dev, section);
> >      vhost_set_memory(listener, section, true);
> >  }
> >  
> > -static void vhost_region_del(MemoryListener *listener,
> > +static void vhost_region_nop(MemoryListener *listener,
> >                               MemoryRegionSection *section)
> >  {
> >      struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> >                                           memory_listener);
> > -    int i;
> >  
> >      if (!vhost_section(section)) {
> >          return;
> >      }
> >  
> > -    vhost_set_memory(listener, section, false);
> > -    memory_region_unref(section->mr);
> > -    for (i = 0; i < dev->n_mem_sections; ++i) {
> > -        if (dev->mem_sections[i].offset_within_address_space
> > -            == section->offset_within_address_space) {
> > -            --dev->n_mem_sections;
> > -            memmove(&dev->mem_sections[i], &dev->mem_sections[i+1],
> > -                    (dev->n_mem_sections - i) * sizeof(*dev->mem_sections));
> > -            break;
> > -        }
> > +    vhost_add_section(dev, section);
> > +}
> > +
> > +static void vhost_region_del(MemoryListener *listener,
> > +                             MemoryRegionSection *section)
> > +{
> > +    if (!vhost_section(section)) {
> > +        return;
> >      }
> > +
> > +    vhost_set_memory(listener, section, false);
> >  }
> >  
> >  static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > @@ -783,11 +809,6 @@ static void vhost_iommu_region_del(MemoryListener *listener,
> >      }
> >  }
> >  
> > -static void vhost_region_nop(MemoryListener *listener,
> > -                             MemoryRegionSection *section)
> > -{
> > -}
> > -
> >  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> >                                      struct vhost_virtqueue *vq,
> >                                      unsigned idx, bool enable_log)
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 467dc7794b..21f3022499 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -54,6 +54,8 @@ struct vhost_dev {
> >      struct vhost_memory *mem;
> >      int n_mem_sections;
> >      MemoryRegionSection *mem_sections;
> > +    int n_tmp_sections;
> > +    MemoryRegionSection *tmp_sections;
> >      struct vhost_virtqueue *vqs;
> >      int nvqs;
> >      /* the first virtqueue which would be used by this vhost dev */
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
