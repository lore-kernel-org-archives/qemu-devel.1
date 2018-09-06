Received: from eggs.gnu.org ([2001:4830:134:3::10]:57368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxoAR-0006D2-23
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxoAN-0004NY-14
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:53:26 -0400
Date: Thu, 6 Sep 2018 14:53:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180906065312.GD16937@xz-x1>
References: <20180905113158.23734-1-peterx@redhat.com>
	<20180905085550.5a84b540@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905085550.5a84b540@t450s.home>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: do address space switching
 when reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>

On Wed, Sep 05, 2018 at 08:55:50AM -0600, Alex Williamson wrote:
> On Wed,  5 Sep 2018 19:31:58 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > We will drop all the mappings when system reset, however we'll still
> > keep the existing memory layouts.  That'll be problematic since if IOMMU
> > is enabled in the guest and then reboot the guest, SeaBIOS will try to
> > drive a device that with no page mapped there.  What we need to do is to
> > rebuild the GPA->HPA mapping when system resets, hence ease SeaBIOS.
> > 
> > Without this patch, a guest that boots on an assigned NVMe device might
> > fail to find the boot device after a system reboot/reset and we'll be
> > able to observe SeaBIOS errors if turned on:
> > 
> >   WARNING - Timeout at nvme_wait:144!
> > 
> > With the patch applied, the guest will be able to find the NVMe drive
> > and bootstrap there even after multiple reboots or system resets.
> > 
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1625173
> > CC: QEMU Stable <qemu-stable@nongnu.org>
> > Tested-by: Cong Li <coli@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 3dfada19a6..d3eb068d43 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -3231,6 +3231,14 @@ static void vtd_reset(DeviceState *dev)
> >       * When device reset, throw away all mappings and external caches
> >       */
> >      vtd_address_space_unmap_all(s);
> > +
> > +    /*
> > +     * Switch address spaces if needed (e.g., when reboot from a
> > +     * kernel that has IOMMU enabled, we should switch address spaces
> > +     * to rebuild the GPA->HPA mappings otherwise SeaBIOS might
> > +     * encounter DMA errors when running with e.g. a NVMe card).
> > +     */
> > +    vtd_switch_address_space_all(s);
> >  }
> >  
> >  static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
> 
> I'm curious why these aren't part of vtd_init().  vtd_init is where
> GCMD is set back to it's power-on state, which disables translation, so
> logically we should reset the address space at that point.  Similarly,
> the root entry is reset, so it would make sense to throw away all the
> mappings there too.  Thanks,

vtd_init() is only called when realize() or reset, and AFAIU it's not
called by GCMD operations.  However I think I get the point that
logically we should do similar things in e.g. vtd_handle_gcmd_srtp()
when the enable bit switches.

My understanding is that if other things happened rather than the
system reboot (e.g., when root pointer is replaced, or during the
guest running the guest driver turns DMAR from on to off) the guest
will be responsible to do the rest of invalidations first before doing
that switch, so we'll possibly do the unmap_all() and address space
switches in other places (e.g., in vtd_context_global_invalidate, or
per device invalidations).

But maybe it's better to do it in all the places.  I'll draft another
version soon.

Thanks,

-- 
Peter Xu
