Received: from eggs.gnu.org ([2001:4830:134:3::10]:53588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ePmoH-0004Jw-3J
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ePmoC-0006Np-78
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:01:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ePmoB-0006MP-Uh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:01:36 -0500
Date: Fri, 15 Dec 2017 11:01:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171215110107.10e7faa4@redhat.com>
In-Reply-To: <20171214152010.GA4380@work-vm>
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-2-dgilbert@redhat.com>
	<20171214153028.25c12b0e@redhat.com>
	<20171214152010.GA4380@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vhost: Move log_dirty check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

On Thu, 14 Dec 2017 15:20:10 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > On Wed, 13 Dec 2017 18:08:02 +0000
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> >   
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Move the log_dirty check into vhost_section.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  hw/virtio/trace-events |  3 +++
> > >  hw/virtio/vhost.c      | 20 +++++++++++++-------
> > >  2 files changed, 16 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > > index 775461ae98..4a493bcd46 100644
> > > --- a/hw/virtio/trace-events
> > > +++ b/hw/virtio/trace-events
> > > @@ -1,5 +1,8 @@
> > >  # See docs/devel/tracing.txt for syntax documentation.
> > >  
> > > +# hw/virtio/vhost.c
> > > +vhost_section(const char *name, int r) "%s:%d"
> > > +
> > >  # hw/virtio/virtio.c
> > >  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
> > >  virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "vq %p elem %p len %u idx %u"
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index e4290ce93d..e923219e63 100644
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
> > > @@ -567,18 +568,12 @@ static void vhost_set_memory(MemoryListener *listener,
> > >                                           memory_listener);
> > >      hwaddr start_addr = section->offset_within_address_space;
> > >      ram_addr_t size = int128_get64(section->size);
> > > -    bool log_dirty =
> > > -        memory_region_get_dirty_log_mask(section->mr) & ~(1 << DIRTY_MEMORY_MIGRATION);
> > >      int s = offsetof(struct vhost_memory, regions) +
> > >          (dev->mem->nregions + 1) * sizeof dev->mem->regions[0];
> > >      void *ram;
> > >  
> > >      dev->mem = g_realloc(dev->mem, s);
> > >  
> > > -    if (log_dirty) {
> > > -        add = false;
> > > -    }
> > > -
> > >      assert(size);
> > >  
> > >      /* Optimize no-change case. At least cirrus_vga does this a lot at this time. */
> > > @@ -611,8 +606,19 @@ static void vhost_set_memory(MemoryListener *listener,
> > >  
> > >  static bool vhost_section(MemoryRegionSection *section)
> > >  {
> > > -    return memory_region_is_ram(section->mr) &&
> > > +    bool result;
> > > +    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
> > > +                     ~(1 << DIRTY_MEMORY_MIGRATION);
> > > +    result = memory_region_is_ram(section->mr) &&
> > >          !memory_region_is_rom(section->mr);
> > > +
> > > +    /* Vhost doesn't handle any block which is doing dirty-tracking other
> > > +     * than migration; this typically fires on VGA areas.
> > > +     */
> > > +    result &= !log_dirty;  
> > before patch even if log_dirty, vhost_set_memory will still proceed
> > and may remove dirty section from memmap and set memory_changed = true
> > 
> > but with this patch it will just ignore such section,
> > I'm not sure it's right (it might be right with new approach add/nop
> > but then this patch should go after new code in place and old one
> > if gone).  
> 
> I thought about that, but then I came to the conclusion that the whole
> idea is that we're supposed to be ignoring these regions - so why
> should they cause any change to the behaviour of vhost at all?
> Thus this way seems safer.
Could it happen that, while being deleted section could become dirty
at the same time? if that could happen then region_del won't process
section and won't call unref on it either.

one more reason to operate on tmp_mem_sections and then
unconditionally unref old mem_sections at commit time at
the right time (after set mem table).

> 
> Dave
> 
> > > +
> > > +    trace_vhost_section(section->mr->name, result);
> > > +    return result;
> > >  }
> > >  
> > >  static void vhost_begin(MemoryListener *listener)  
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
