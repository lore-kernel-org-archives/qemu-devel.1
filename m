Received: from eggs.gnu.org ([2001:4830:134:3::10]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8kWD-0003LZ-3b
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8kW9-0001hH-1Q
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8kW8-0001h4-Oz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:36:16 -0400
Date: Thu, 11 May 2017 17:36:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170511093603.GJ28293@pxdev.xzpeter.org>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-5-git-send-email-peterx@redhat.com>
	<20170511015637.GF14408@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511015637.GF14408@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v3 04/12] memory: fix
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, May 11, 2017 at 11:56:38AM +1000, David Gibson wrote:
> On Wed, May 10, 2017 at 04:01:47PM +0800, Peter Xu wrote:
> > This function has an assumption that we will definitely call translate()
> > once (or say, the addr will be located inside one IOMMU memory region),
> > otherwise an empty IOTLB will be returned. Nevertheless, this is not
> > what we want. When there is no IOMMU memory region, we should build up a
> > static mapping for the caller, instead of an invalid IOTLB.
> > 
> > We won't trigger this path before VT-d passthrough mode. When
> > passthrough mode for a vhost device is setup, VT-d is possible to
> > disable the IOMMU region for that device. Without current patch, we'll
> > get a vhost boot failure, and it'll be failed over to virtio userspace
> > mode.
> 
> This doesn't look right to me.  You're assuming the target is
> address_space_memory, which might not be the case - and you should be
> able to check from the MR you do hit.  Furthermore it doesn't look
> like you're accounting for the trivial translation if the section's
> offset in the address space is different from its offset in the MR.

Do you mean this line?

        addr = addr - section->offset_within_address_space
               + section->offset_within_region;

I thought it was calculating the relative address against that memory
region. That should only be useful if we want to do further
translate(), right? For the path that this patch tries to handle (when
there is no translate() call), then this "addr" is useless here?

Regarding to the address space assignment - do you mean, e.g., I
should use section->address_space here instead of
&system_address_space? If so, I can do the switch. But after all, for
now address_space_get_iotlb_entry() is only used by vhost codes, and
it only check against iotlb.target_as == NULL, so the address space
didn't count too much here...

Another reason I used &address_space_memory is that in
vfio_iommu_map_notify() we have a check against it:

    if (iotlb->target_as != &address_space_memory) {
        error_report("Wrong target AS \"%s\", only system memory is allowed",
                     iotlb->target_as->name ? iotlb->target_as->name : "none");
        return;
    }

Or say, we have some assumptions (not only in this patch) that assumes
this iotlb.target_as should be system_address_space.

Thanks,

> 
> I think for the fallback path you're going to want something based on
> address_space_translate() instead.
> 
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  exec.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index 072de5d..5cfdacd 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -463,12 +463,13 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
> >  }
> >  
> >  /* Called from RCU critical section */
> > -IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
> > +IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr iova,
> >                                              bool is_write)
> >  {
> >      IOMMUTLBEntry iotlb = {0};
> >      MemoryRegionSection *section;
> >      MemoryRegion *mr;
> > +    hwaddr addr = iova, psize;
> >  
> >      for (;;) {
> >          AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
> > @@ -478,6 +479,23 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
> >          mr = section->mr;
> >  
> >          if (!mr->iommu_ops) {
> > +            /*
> > +             * We didn't translate() but reached here. It possibly
> > +             * means it's a static mapping. If so (it should be RAM),
> > +             * we set the IOTLB up.
> > +             */
> > +            if (!iotlb.target_as && memory_region_is_ram(mr) &&
> > +                !memory_region_is_rom(mr)) {
> > +                psize = mr->ram_block->page_size;
> > +                iova &= ~(psize - 1);
> > +                iotlb = (IOMMUTLBEntry) {
> > +                    .target_as = &address_space_memory,
> > +                    .iova = iova,
> > +                    .translated_addr = iova,
> > +                    .addr_mask = psize - 1,
> > +                    .perm = IOMMU_RW,
> > +                };
> > +            }
> >              break;
> >          }
> >  
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Peter Xu
