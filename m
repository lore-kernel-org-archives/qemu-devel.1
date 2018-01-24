Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eeMZn-0000pV-L9
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 10:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eeMZi-0003kF-RA
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 10:02:59 -0500
Date: Wed, 24 Jan 2018 08:02:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180124080230.580c28c6@w520.home>
In-Reply-To: <bd0063fa-6c2d-cfce-d255-400cb9e4cf0a@redhat.com>
References: <20180123012207.43459-1-aik@ozlabs.ru>
	<424c3873-7368-5fbe-95bf-3040c2bec73a@redhat.com>
	<20180123125531.0de84de2@w520.home>
	<bd0063fa-6c2d-cfce-d255-400cb9e4cf0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 24 Jan 2018 15:13:06 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> On 23/01/18 20:55, Alex Williamson wrote:
> > On Tue, 23 Jan 2018 16:34:34 +0100
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Alexey,
> >> On 23/01/18 02:22, Alexey Kardashevskiy wrote:  
> >>> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
> >>> which tells that a region with MSIX data can be mapped entirely, i.e.
> >>> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
> >>>
> >>> With this change, all BARs are mapped in a single chunk and MSIX vectors
> >>> are emulated on top unless the machine requests not to by defining and
> >>> enabling a new "vfio-no-msix-emulation" property. At the moment only
> >>> sPAPR machine does so - it prohibits MSIX emulation and does not allow
> >>> enabling it as it does not define the "set" callback for the new property;
> >>> the new property also does not appear in "-machine pseries,help".
> >>>
> >>> If MSIX vectors section is not aligned to the page size, the KVM memory
> >>> listener does not register it with the KVM as a memory slot and MSIX is
> >>> emulated by QEMU as before. This may create MMIO RAM memory sections with
> >>> an address or/and a size not aligned which will make vfio_dma_map() fail;
> >>> to address this, this makes treats such failures as non-fatal.
> >>>
> >>> This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
> >>> for the new capability: https://www.spinics.net/lists/kvm/msg160282.html
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> ---
> >>> Changes:
> >>> v3:
> >>> * vfio_listener_region_add() won't make qemu exit if failed on MMIO MR
> >>>
> >>> ---
> >>>  include/hw/vfio/vfio-common.h |  1 +
> >>>  linux-headers/linux/vfio.h    |  5 +++++
> >>>  hw/ppc/spapr.c                |  7 +++++++
> >>>  hw/vfio/common.c              | 19 +++++++++++++++++++
> >>>  hw/vfio/pci.c                 | 10 ++++++++++
> >>>  5 files changed, 42 insertions(+)
> >>>
> >>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >>> index f3a2ac9..927d600 100644
> >>> --- a/include/hw/vfio/vfio-common.h
> >>> +++ b/include/hw/vfio/vfio-common.h
> >>> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
> >>>                           struct vfio_region_info **info);
> >>>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
> >>>                               uint32_t subtype, struct vfio_region_info **info);
> >>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region);
> >>>  #endif
> >>>  extern const MemoryListener vfio_prereg_listener;
> >>>  
> >>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> >>> index 4312e96..b45182e 100644
> >>> --- a/linux-headers/linux/vfio.h
> >>> +++ b/linux-headers/linux/vfio.h
> >>> @@ -301,6 +301,11 @@ struct vfio_region_info_cap_type {
> >>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> >>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> >>>  
> >>> +/*
> >>> + * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped.
> >>> + */
> >>> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> >>> +
> >>>  /**
> >>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> >>>   *				    struct vfio_irq_info)
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index d1acfe8..5ff43ce 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -2789,6 +2789,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
> >>>      spapr->use_hotplug_event_source = value;
> >>>  }
> >>>  
> >>> +static bool spapr_get_msix_emulation(Object *obj, Error **errp)
> >>> +{
> >>> +    return true;
> >>> +}
> >>> +
> >>>  static char *spapr_get_resize_hpt(Object *obj, Error **errp)
> >>>  {
> >>>      sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> >>> @@ -2870,6 +2875,8 @@ static void spapr_instance_init(Object *obj)
> >>>      object_property_set_description(obj, "vsmt",
> >>>                                      "Virtual SMT: KVM behaves as if this were"
> >>>                                      " the host's SMT mode", &error_abort);
> >>> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
> >>> +                             spapr_get_msix_emulation, NULL, NULL);
> >>>  }
> >>>  
> >>>  static void spapr_machine_finalizefn(Object *obj)
> >>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>> index b77be3a..842c5b2 100644
> >>> --- a/hw/vfio/common.c
> >>> +++ b/hw/vfio/common.c
> >>> @@ -530,6 +530,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
> >>>      return;
> >>>  
> >>>  fail:
> >>> +    if (memory_region_is_ram_device(section->mr)) {
> >>> +        error_report("failed to vfio_dma_map. pci p2p may not work");
> >>> +        return;
> >>> +    }    
> >>
> >> I don't think this is an acceptable solution as it produces plenty of
> >> errors such as
> >>
> >> qemu-system-aarch64: VFIO_MAP_DMA: -22
> >> qemu-system-aarch64: vfio_dma_map(0x30a7ab90, 0x8000000000, 0x2000,
> >> 0xfffd79a00000) = -22 (Invalid argument)  
> > 
> > This much of the error above could be avoided by looking at the type1
> > page size bitmap before trying to perform the mapping.
> >   
> >> qemu-system-aarch64: failed to vfio_dma_map. pci p2p may not work  
> > 
> > This of course is still valid though we can continue to discuss if it's
> > worthwhile user information.
> >    
> >> testing context is: aarch64 + Mellanox CX-4 PF where we still try to map
> >> the BAR0 area [0 - 0x2000] before the MSI-X table which is not aligned
> >> with the host 64kB page.
> >>
> >> Region 0: Memory at 80400000000 (64-bit, prefetchable) [size=32M]
> >> Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
> >> 		Vector table: BAR=0 offset=00002000
> >> 		PBA: BAR=0 offset=00003000
> >>
> >>
> >> To me a kind of mmaps region fixup looks required?  
> > 
> > I don't think so.  vfio is now telling us that we can mmap the entire
> > BAR, this is true.  The type1 info is telling us that the minimum DMA
> > mapping granularity, PAGE_SIZE on the host (64K in your case).  The
> > MSI-X offset on this device introduces an 8K range that type1 cannot
> > map and QEMU already has all the information it needs to know this.  The
> > solutions are either to move MSI-X elsewhere or to extend type1 to
> > allow DMA mappings down to the IOMMU minimum granularity.
> > 
> > The MSI-X fixup that is now bypassed avoided this not generating an
> > mmap over the vector table, which meant this 8K region wasn't covered
> > by a memory slot and therefore never got passed through region_add.  So
> > p2p dma was silently disabled.  Now we do mmap the entire BAR, but we
> > add the MSI-X region on top of it so that when it gets flattened we end
> > up with these sub-page slots.  Skipping them at region_add has the same
> > overall effect.
> > 
> > Before:
> > 
> >   |-| <-- MSI-X vector emulation MR
> > +
> >          |---PAGE_SIZE aligned mmap MR----|
> > +
> > |------------slow mapped BAR M------------|
> > 
> > =
> > 
> >          |----Resulting region_add--------| (PAGE_SIZE aligned)
> > 
> > After:
> > 
> >   |-| <-- MSI-X vector emulation MR
> > +
> > |------------PAGE_SIZE aligned mmap MR----|
> > +
> > |------------slow mapped BAR M------------|
> > 
> > =
> > 
> > |-| |----Resulting region_add-------------| (Gap no longer PAGE_SIZE aligned)
> > 
> > So doesn't it make sense that region_add would now filter these out?
> > Should we continue to silently skip unmapped MMIO?  Thanks,  
> 
> I am confused because I don't see the vfio_region_read/write for
> segments whose mmap failed. Nevertheless the assignment looks to work
> properly.

Segments whose mmap failed or whose dma map failed?  When we have the
"after" case above, the ram_device mmap covers the entire direct access
range to the device, therefore the flattened view will hit those
MemoryRegion.ops first, which will be ram_device_mem_ops.  We'll only
get to vfio_region_ops in the "before" case where the flattened map
exposes the slow MR.  Thanks,

Alex
