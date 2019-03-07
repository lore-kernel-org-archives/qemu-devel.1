Received: from eggs.gnu.org ([209.51.188.92]:38663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2167-0005D1-U4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2166-0003kU-5M
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:02:39 -0500
Date: Thu, 7 Mar 2019 15:02:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190307150232.7384b7ce@w520.home>
In-Reply-To: <20190307050518.64968-4-aik@ozlabs.ru>
References: <20190307050518.64968-1-aik@ozlabs.ru>
	<20190307050518.64968-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 3/3] spapr: Support NVIDIA V100 GPU
 with NVLink2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

On Thu,  7 Mar 2019 16:05:18 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 40a12001f580..15ec0b4c2723 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -2180,3 +2180,123 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>  
>      return 0;
>  }
> +
> +static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
> +                                     const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    uint64_t tgt = (uint64_t) opaque;
> +    visit_type_uint64(v, name, &tgt, errp);
> +}
> +
> +static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
> +                                                 const char *name,
> +                                                 void *opaque, Error **errp)
> +{
> +    uint32_t link_speed = (uint32_t)(uint64_t) opaque;
> +    visit_type_uint32(v, name, &link_speed, errp);
> +}
> +
> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *nv2region = NULL;
> +    struct vfio_info_cap_header *hdr;
> +    MemoryRegion *nv2mr = g_malloc0(sizeof(*nv2mr));

This is leaked in the below error paths and there's no cleanup on
finalize.  I assume these devices don't support hotplug, but they could
at least use the existing quirk infrastructure so as not to set a bad
precedent. 

> +
> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_NVIDIA,
> +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
> +                                   &nv2region);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    p = mmap(NULL, nv2region->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +             MAP_SHARED, vdev->vbasedev.fd, nv2region->offset);
> +
> +    if (!p) {
> +        return -errno;
> +    }

I think the above suggestion requires simply defining a quirk above:

VFIOQuirk *quirk;

Initializing it with one MemoryRegion here:

quirk = vfio_quirk_alloc(1);

> +
> +    memory_region_init_ram_ptr(nv2mr, OBJECT(vdev), "nvlink2-mr",

s/nv2mr/quirk->mem/

> +                               nv2region->size, p);

Then adding it to the device, for instance assuming there's always a
BAR0, attach it there:

QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);

At least then it pretends to support cleanup.

> +
> +    hdr = vfio_get_region_info_cap(nv2region,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (hdr) {
> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap = (void *) hdr;
> +
> +        object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                            (void *) cap->tgt, NULL);
> +        trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
> +                                              nv2region->size);
> +    }
> +    g_free(nv2region);
> +
> +    return 0;
> +}
> +
> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *atsd_region = NULL;
> +    struct vfio_info_cap_header *hdr;
> +
> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_IBM,
> +                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
> +                                   &atsd_region);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /* Some NVLink bridges come without assigned ATSD, skip MR part */
> +    if (atsd_region->size) {
> +        MemoryRegion *atsd_mr = g_malloc0(sizeof(*atsd_mr));
> +
> +        p = mmap(NULL, atsd_region->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +                 MAP_SHARED, vdev->vbasedev.fd, atsd_region->offset);
> +
> +        if (!p) {
> +            return -errno;

Leaks atsd_mr.  This could similarly use the existing VFIOQuirk
infrastructure.

> +        }
> +
> +        memory_region_init_ram_device_ptr(atsd_mr, OBJECT(vdev),
> +                                          "nvlink2-atsd-mr",
> +                                          atsd_region->size,
> +                                          p);
> +    }
> +
> +    hdr = vfio_get_region_info_cap(atsd_region,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (hdr) {
> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap = (void *) hdr;
> +
> +        object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                            (void *) cap->tgt, NULL);
> +        trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, cap->tgt,
> +                                                  atsd_region->size);
> +    }
> +
> +    hdr = vfio_get_region_info_cap(atsd_region,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
> +    if (hdr) {
> +        struct vfio_region_info_cap_nvlink2_lnkspd *cap = (void *) hdr;
> +
> +        object_property_add(OBJECT(vdev), "nvlink2-link-speed", "uint32",
> +                            vfio_pci_nvlink2_get_link_speed, NULL, NULL,
> +                            (void *) (uint64_t) cap->link_speed, NULL);
> +        trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
> +                                                  cap->link_speed);
> +    }
> +    g_free(atsd_region);
> +
> +    return 0;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dd12f363915d..07aa141aabe6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3069,6 +3069,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto out_teardown;
>      }
>  
> +    if (vdev->vendor_id == PCI_VENDOR_ID_NVIDIA) {
> +        ret = vfio_pci_nvidia_v100_ram_init(vdev, errp);
> +        if (ret && ret != -ENODEV) {
> +            error_report("Failed to setup NVIDIA V100 GPU RAM");
> +        }
> +    }
> +
> +    if (vdev->vendor_id == PCI_VENDOR_ID_IBM) {
> +        ret = vfio_pci_nvlink2_init(vdev, errp);
> +        if (ret && ret != -ENODEV) {
> +            error_report("Failed to setup NVlink2 bridge");
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index cf1e8868182b..88841e9a61da 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -87,6 +87,10 @@ vfio_pci_igd_opregion_enabled(const char *name) "%s"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
>  
> +vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
> +vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
> +vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
> +
>  # hw/vfio/common.c
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
