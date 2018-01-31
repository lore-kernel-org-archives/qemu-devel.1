Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egxZp-00028P-QY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egxZm-0002vP-Iv
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:57:45 -0500
Date: Wed, 31 Jan 2018 11:57:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180131115735.4097ff96@w520.home>
In-Reply-To: <20180131072445.22783-1-aik@ozlabs.ru>
References: <20180131072445.22783-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu v6] vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Auger Eric <eric.auger@redhat.com>

On Wed, 31 Jan 2018 18:24:45 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
> which tells that a region with MSIX data can be mapped entirely, i.e.
> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
> 
> With this change, all BARs are mapped in a single chunk and MSIX vectors
> are emulated on top unless the machine requests not to by defining and
> enabling a new "vfio-no-msix-emulation" property. At the moment only
> sPAPR machine does so - it prohibits MSIX emulation and does not allow
> enabling it as it does not define the "set" callback for the new property;
> the new property also does not appear in "-machine pseries,help".
> 
> This change may affect machines which are using MSIX emulation and
> mapping MMIO RAM regions for DMA as previously MSIX containing BAR
> would be split in chunks aligned to the system page size and we would
> only see aligned RAM memory sections in vfio_listener_region_add/del.
> As the system page size is usually is equal or bigger than the IOMMU
> page size, vfio_dma_map() did not have a legitimate reason to fail so
> mapping failures were fatal. Note that this behaviour silently skips
> parts of BARs adjacent to the MSIX data.
> 
> With this change, we map entire MSIX BAR and emulate MSIX on top of it
> so vfio_listener_region_add/del may be called with unaligned MMIO RAM
> regions and vfio_dma_map() will fail&exit on these. In order to mitigate
> this, this changes vfio_listener_region_add() not to try vfio_dma_map() if
> the memory section is not aligned to the minimal IOMMU page; an error
> is printed instead. This also treats all errors from vfio_dma_map()
> non fatal when the listener is called on the MMIO RAM region.
> vfio_listener_region_del() is adjusted accordingly.
> 
> If the amount of errors printed is overwhelming, the MSIX relocation
> could be used to avoid excessive error output.
> 
> This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
> for the new capability: https://www.spinics.net/lists/kvm/msg160282.html

Looks like there are at least 3 or 4 patches here:

A) Update linux-headers (gated by v4.16-rc1)
B) vfio_is_cap_present
C) check alignment on region_add/del vs hostwin, non-fatal ram_device
D) platform directed disabling of MSI-X MemoryRegion

 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v6:
> * dropped that stupid p2p property patch
> 
> v5:
> * rebased on top of 'p2p' proposed patch
> 
> v4:
> * silenced dma map errors if unaligned mapping is attempted - they are going
> to fail anyway
> 
> v3:
> * vfio_listener_region_add() won't make qemu exit if failed on MMIO MR
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  linux-headers/linux/vfio.h    |  5 ++++
>  hw/ppc/spapr.c                |  7 +++++
>  hw/vfio/common.c              | 66 +++++++++++++++++++++++++++++++++++++++----
>  hw/vfio/pci.c                 | 10 +++++++
>  5 files changed, 83 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f3a2ac9..927d600 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                           struct vfio_region_info **info);
>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>                               uint32_t subtype, struct vfio_region_info **info);
> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region);
>  #endif
>  extern const MemoryListener vfio_prereg_listener;
>  
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 4312e96..b45182e 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -301,6 +301,11 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>  
> +/*
> + * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped.
> + */
> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> +
>  /**
>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>   *				    struct vfio_irq_info)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 32a876b..6d333e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2830,6 +2830,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
>      spapr->use_hotplug_event_source = value;
>  }
>  
> +static bool spapr_get_msix_emulation(Object *obj, Error **errp)
> +{
> +    return true;
> +}
> +
>  static char *spapr_get_resize_hpt(Object *obj, Error **errp)
>  {
>      sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
> @@ -2911,6 +2916,8 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "vsmt",
>                                      "Virtual SMT: KVM behaves as if this were"
>                                      " the host's SMT mode", &error_abort);
> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
> +                             spapr_get_msix_emulation, NULL, NULL);
>  }
>  
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3d652c8..9100a42 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -508,6 +508,18 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      }
>  
>      /* Here we assume that memory_region_is_ram(section->mr)==true */
> +    if (memory_region_is_ram_device(section->mr)) {
> +        hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
> +
> +        if ((section->offset_within_region & pgmask) ||
> +            (int128_getlo(section->size) & pgmask)) {

Why are we working on section->foo variables when the vfio_dma_map()
we're trying to avoid is based on the calculated iova and llsize?

> +            error_report("Region %"HWADDR_PRIx"..%"HWADDR_PRIx" is not aligned to %"HWADDR_PRIx" and cannot be mapped for DMA",

There's plenty of opportunity to wrap this at a variable.

> +                         section->offset_within_region,
> +                         int128_getlo(section->size),
> +                         pgmask + 1);
> +            return;
> +        }
> +    }
>  
>      vaddr = memory_region_get_ram_ptr(section->mr) +
>              section->offset_within_region +
> @@ -523,6 +535,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
>          error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>                       "0x%"HWADDR_PRIx", %p) = %d (%m)",
>                       container, iova, int128_get64(llsize), vaddr, ret);
> +        if (memory_region_is_ram_device(section->mr)) {
> +            return;
> +        }

So this one is mostly paranoia that it's an MMIO mapping that we think
should have worked, but didn't?

>          goto fail;
>      }
>  
> @@ -550,6 +565,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      hwaddr iova, end;
>      Int128 llend, llsize;
>      int ret;
> +    bool try_unmap = true;
>  
>      if (vfio_listener_skipped_section(section)) {
>          trace_vfio_listener_region_del_skip(
> @@ -602,13 +618,36 @@ static void vfio_listener_region_del(MemoryListener *listener,
>  
>      trace_vfio_listener_region_del(iova, end);
>  
> -    ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> +    if (memory_region_is_ram_device(section->mr)) {
> +        hwaddr pgmask;
> +        VFIOHostDMAWindow *hostwin;
> +        bool hostwin_found;
> +
> +        hostwin_found = false;
> +        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
> +            if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
> +                hostwin_found = true;
> +                break;
> +            }
> +        }
> +        assert(hostwin_found);

And we justify this assert because the region_add path would have
triggered a fatal mapping fault for this condition and therefore
getting here would mean the region_del doesn't match a previous
region_add, right?

> +
> +        pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
> +
> +        try_unmap = !(section->offset_within_region & pgmask) &&
> +            !(int128_getlo(section->size) & pgmask);

Same question as above with iova & llend.

> +    }
> +
> +    if (try_unmap) {
> +        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> +        if (ret) {
> +            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                         "0x%"HWADDR_PRIx") = %d (%m)",
> +                         container, iova, int128_get64(llsize), ret);
> +        }
> +    }
> +
>      memory_region_unref(section->mr);
> -    if (ret) {
> -        error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx") = %d (%m)",
> -                     container, iova, int128_get64(llsize), ret);
> -    }
>  
>      if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>          vfio_spapr_remove_window(container,
> @@ -1386,6 +1425,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>      return -ENODEV;
>  }
>  
> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region)

How about vfio_has_region_cap() and reorder the params to match,
vbasedev, region, cap_type.

> +{
> +    struct vfio_region_info *info = NULL;
> +    bool ret = false;
> +
> +    if (!vfio_get_region_info(vbasedev, region, &info)) {
> +        if (vfio_get_region_info_cap(info, cap_type)) {
> +            ret = true;
> +        }
> +        g_free(info);
> +    }
> +
> +    return ret;
> +}
> +
>  /*
>   * Interfaces for IBM EEH (Enhanced Error Handling)
>   */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2c71295..e23f5cf 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1289,6 +1289,11 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>      off_t start, end;
>      VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
>  
> +    if (vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE,
> +                            vdev->msix->table_bar)) {

It's convenient that BAR# == Region#, but I think the correct reference
is: vdev->bars[vdev->msix->table_bar].region.nr

A comment to explain this region fixup exit would be nice.

> +        return;
> +    }
> +
>      /*
>       * We expect to find a single mmap covering the whole BAR, anything else
>       * means it's either unsupported or already setup.
> @@ -1473,6 +1478,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       */
>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);

A comment here would be nice.
  
> +    if (object_property_get_bool(OBJECT(qdev_get_machine()),
> +                                 "vfio-no-msix-emulation", NULL)) {
> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
> +    }
> +
>      return 0;
>  }
>  
