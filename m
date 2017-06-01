Received: from eggs.gnu.org ([2001:4830:134:3::10]:53353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dGXMN-0004HH-DT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dGXMJ-0007QZ-8A
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dGXMI-0007Pl-V9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:10:19 -0400
Date: Thu, 1 Jun 2017 15:10:16 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170601151016.11f222c7@w520.home>
In-Reply-To: <1496079043-26694-4-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
	<1496079043-26694-4-git-send-email-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/6] vfio: Setup IGD stolen memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhi Wang <zhi.a.wang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, daniel.vetter@ffwll.ch, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, zhiyuan.lv@intel.com, chuanxiao.dong@intel.com, xiong.y.zhang@intel.com

On Tue, 30 May 2017 01:30:33 +0800
Zhi Wang <zhi.a.wang@intel.com> wrote:

> We still keep using VM dedicated memory for isolation to support IGD
> stolen in the guest. Becuase of the PA of the stolen memory can not be
> moved after the system is powered-up, we wish the PA of the guest stolen
> memory can sit in the same PA of host. A new memory region is allocated,
> and the memory region will be marked as reserved in guest E820 table.
> 
> We don't need to take care of GGMS, as the accesses to GGMS from HW bypass
> IOMMU.

:-O  So the device has access to a reserved region of host memory
regardless of the IOMMU.  Should the kernel be doing something to
save/restore that area or scrub that region before we get access to the
device?

 
> Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
> ---
>  hw/vfio/pci-quirks.c | 83 ++++++++++++++++++----------------------------------
>  1 file changed, 29 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index e0a0c13..5a083c1 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -18,6 +18,7 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "intel-platform.h"
> +#include "hw/i386/pc.h"
>  
>  /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
>  static bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
> @@ -1362,9 +1363,10 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      VFIOQuirk *quirk;
>      VFIOIGDQuirk *igd;
>      const struct intel_device_info *info;
> +    void *stolen;
>      PCIDevice *lpc_bridge;
> -    int i, ret, ggms_mb, gms_mb = 0, gen;
> -    uint64_t *bdsm_size;
> +    int i, ret;
> +    uint64_t bdsm_size;
>      uint32_t gmch;
>      uint16_t cmd_orig, cmd;
>      Error *err = NULL;
> @@ -1393,16 +1395,38 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>          return;
>      }
>  
> -    gen = info->gen;
> -
>      /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
>      quirk = g_malloc0(sizeof(*quirk));
> +    quirk->mem = g_new0(MemoryRegion, 1);
> +    quirk->nr_mem = 1;
> +
>      igd = quirk->data = g_malloc0(sizeof(*igd));
>      igd->vdev = vdev;
>      igd->index = ~0;
>      igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
>      igd->bdsm &= ~((1 << 20) - 1); /* 1MB aligned */
>  
> +    /* Setup stolen memory for IGD device. */
> +    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> +    bdsm_size = info->get_stolen_size(gmch);
> +
> +    stolen = qemu_memalign(bdsm_size, bdsm_size);

This only needs to be 1MB aligned, not naturally aligned, right?

> +
> +    memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev),
> +                               "vfio-igd-stolen", bdsm_size, stolen);
> +    memory_region_add_subregion_overlap(get_system_memory(),
> +                                        igd->bdsm, &quirk->mem[0], 1);

We discussed off-list that maybe it's an acceptable solution to waste
VM memory for stolen memory, ie. let QEMU allocate the buffer and map
it into the VM at the same address as the host.  But I'm not really
sure what problem doing that here is solving other than we don't yet
expose IGD stolen memory as a device specific region on the vfio
device.  Is that plan to add that device specific region and do an mmap
of it rather than the above memalign when available?  That way we're
only wasting the memory we're overlapping, which may not even be
allocated yet.

There are also some hotplug issues here.  A) We cannot do this for a
hot-added device, there's a test later in the code for disabling legacy
mode for hot-added devices.  B) Is it possible to do cleanup on
hot-remove or do we need to disable the ability to hot-remove IGD
devices?

> +
> +    e820_add_entry(igd->bdsm, bdsm_size, E820_RESERVED);
> +
> +    /* GMCH is read-only, emulated */
> +    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
> +    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
> +
> +    /* BDSM is read-only, emulated */
> +    pci_set_long(vdev->pdev.wmask + IGD_BDSM, 0);
> +    pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
> +
>      /*
>       * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
>       * can stuff host values into, so if there's already one there and it's not
> @@ -1472,8 +1496,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>          goto out;
>      }
>  
> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> -
>      /*
>       * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
>       * try to enable it.  Probably shouldn't be using legacy mode without VGA,
> @@ -1528,53 +1550,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>  
> -    /* Determine the size of stolen memory needed for GTT */
> -    ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 6) {
> -        ggms_mb = 1 << ggms_mb;
> -    }
> -
> -    /*
> -     * Assume we have no GMS memory, but allow it to be overrided by device
> -     * option (experimental).  The spec doesn't actually allow zero GMS when
> -     * when IVD (IGD VGA Disable) is clear, but the claim is that it's unused,
> -     * so let's not waste VM memory for it.
> -     */
> -    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
> -
> -    if (vdev->igd_gms) {
> -        if (vdev->igd_gms <= 0x10) {
> -            gms_mb = vdev->igd_gms * 32;
> -            gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
> -        } else {
> -            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
> -            vdev->igd_gms = 0;
> -        }
> -    }

The x-igd-gms option should also be removed in this patch as well as
igd_gms.  Is it possible to virtualize the size?  Is it worthwhile?

> -
> -    /*
> -     * Request reserved memory for stolen memory via fw_cfg.  VM firmware
> -     * must allocate a 1MB aligned reserved memory region below 4GB with
> -     * the requested size (in bytes) for use by the Intel PCI class VGA
> -     * device at VM address 00:02.0.  The base address of this reserved
> -     * memory region must be written to the device BDSM regsiter at PCI
> -     * config offset 0x5C.
> -     */
> -    bdsm_size = g_malloc(sizeof(*bdsm_size));
> -    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * 1024 * 1024);
> -    fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
> -                    bdsm_size, sizeof(*bdsm_size));
> -
> -    /* GMCH is read-only, emulated */
> -    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
> -    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
> -    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
> -
> -    /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
> -    pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
> -    pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
> -    pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
> -
>      /*
>       * This IOBAR gives us access to GTTADR, which allows us to write to
>       * the GTT itself.  So let's go ahead and write zero to all the GTT
> @@ -1606,7 +1581,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>                       vdev->vbasedev.name);
>      }
>  
> -    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
> +    trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, bdsm_size >> 20);

This should be moved closer to where we do the setup, this trace would
only occur if the device also uses legacy mode.  Thanks,

Alex

>  
>  out:
>      g_free(rom);
