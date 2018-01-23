Received: from eggs.gnu.org ([2001:4830:134:3::10]:32841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ee0b3-0001La-Hf
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ee0az-0005Xo-Fd
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:34:49 -0500
References: <20180123012207.43459-1-aik@ozlabs.ru>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <424c3873-7368-5fbe-95bf-3040c2bec73a@redhat.com>
Date: Tue, 23 Jan 2018 16:34:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180123012207.43459-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=windows-1252
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

Hi Alexey,
On 23/01/18 02:22, Alexey Kardashevskiy wrote:
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
> If MSIX vectors section is not aligned to the page size, the KVM memory
> listener does not register it with the KVM as a memory slot and MSIX is
> emulated by QEMU as before. This may create MMIO RAM memory sections with
> an address or/and a size not aligned which will make vfio_dma_map() fail;
> to address this, this makes treats such failures as non-fatal.
> 
> This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
> for the new capability: https://www.spinics.net/lists/kvm/msg160282.html
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * vfio_listener_region_add() won't make qemu exit if failed on MMIO MR
> 
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  linux-headers/linux/vfio.h    |  5 +++++
>  hw/ppc/spapr.c                |  7 +++++++
>  hw/vfio/common.c              | 19 +++++++++++++++++++
>  hw/vfio/pci.c                 | 10 ++++++++++
>  5 files changed, 42 insertions(+)
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
> index d1acfe8..5ff43ce 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2789,6 +2789,11 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
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
> @@ -2870,6 +2875,8 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "vsmt",
>                                      "Virtual SMT: KVM behaves as if this were"
>                                      " the host's SMT mode", &error_abort);
> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
> +                             spapr_get_msix_emulation, NULL, NULL);
>  }
>  
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b77be3a..842c5b2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -530,6 +530,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      return;
>  
>  fail:
> +    if (memory_region_is_ram_device(section->mr)) {
> +        error_report("failed to vfio_dma_map. pci p2p may not work");
> +        return;
> +    }

I don't think this is an acceptable solution as it produces plenty of
errors such as

qemu-system-aarch64: VFIO_MAP_DMA: -22
qemu-system-aarch64: vfio_dma_map(0x30a7ab90, 0x8000000000, 0x2000,
0xfffd79a00000) = -22 (Invalid argument)
qemu-system-aarch64: failed to vfio_dma_map. pci p2p may not work


testing context is: aarch64 + Mellanox CX-4 PF where we still try to map
the BAR0 area [0 - 0x2000] before the MSI-X table which is not aligned
with the host 64kB page.

Region 0: Memory at 80400000000 (64-bit, prefetchable) [size=32M]
Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000


To me a kind of mmaps region fixup looks required?

Thanks

Eric


>      /*
>       * On the initfn path, store the first error in the container so we
>       * can gracefully fail.  Runtime, there's not much we can do other
> @@ -1387,6 +1391,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>      return -ENODEV;
>  }
>  
> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region)
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
> index 359a8f1..a96ece6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1289,6 +1289,11 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>      off_t start, end;
>      VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
>  
> +    if (vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE,
> +                            vdev->msix->table_bar)) {
> +        return;
> +    }
> +
>      /*
>       * We expect to find a single mmap covering the whole BAR, anything else
>       * means it's either unsupported or already setup.
> @@ -1569,6 +1574,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       */
>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
>  
> +    if (object_property_get_bool(OBJECT(qdev_get_machine()),
> +                                 "vfio-no-msix-emulation", NULL)) {
> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
> +    }
> +
>      return 0;
>  }
>  
> 
