Received: from eggs.gnu.org ([209.51.188.92]:51980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3Na4-00067W-2k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3Na1-0003pX-LI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:15:11 -0400
Date: Mon, 11 Mar 2019 10:14:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190311101457.23237b84@x1.home>
In-Reply-To: <20190308014420.29178-1-aik@ozlabs.ru>
References: <20190308014420.29178-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5] spapr: Support NVIDIA V100 GPU
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?UTF-8?B?R3Vp?= =?UTF-8?B?bWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

On Fri,  8 Mar 2019 12:44:20 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
> space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driver
> implements special regions for such GPUs and emulates an NVLink bridge.
> NVLink2-enabled POWER9 CPUs also provide address translation services
> which includes an ATS shootdown (ATSD) register exported via the NVLink
> bridge device.
> 
> This adds a quirk to VFIO to map the GPU memory and create an MR;
> the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
> this to get the MR and map it to the system address space.
> Another quirk does the same for ATSD.
> 
> This adds additional steps to sPAPR PHB setup:
> 
> 1. Search for specific GPUs and NPUs, collect findings in
> sPAPRPHBState::nvgpus, manage system address space mappings;
> 
> 2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
> "memory-block", "link-speed" to advertise the NVLink2 function to
> the guest;
> 
> 3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;
> 
> 4. Add new memory blocks (with extra "linux,memory-usable" to prevent
> the guest OS from accessing the new memory until it is onlined) and
> npuphb# nodes representing an NPU unit for every vPHB as the GPU driver
> uses it for link discovery.
> 
> This allocates space for GPU RAM and ATSD like we do for MMIOs by
> adding 2 new parameters to the phb_placement() hook. Older machine types
> set these to zero.
> 
> This puts new memory nodes in a separate NUMA node to replicate the host
> system setup as the GPU driver relies on this.
> 
> This adds requirement similar to EEH - one IOMMU group per vPHB.
> The reason for this is that ATSD registers belong to a physical NPU
> so they cannot invalidate translations on GPUs attached to another NPU.
> It is guaranteed by the host platform as it does not mix NVLink bridges
> or GPUs from different NPU in the same IOMMU group. If more than one
> IOMMU group is detected on a vPHB, this disables ATSD support for that
> vPHB and prints a warning.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> This is based on David's ppc-for-4.0 +
> applied but not pushed "iommu replay": https://patchwork.ozlabs.org/patch/1052644/
> acked "vfio_info_cap public": https://patchwork.ozlabs.org/patch/1052645/
> 
> 
> Changes:
> v5:
> * converted MRs to VFIOQuirk - this fixed leaks
> 
> v4:
> * fixed ATSD placement
> * fixed spapr_phb_unrealize() to do nvgpu cleanup
> * replaced warn_report() with Error*
> 
> v3:
> * moved GPU RAM above PCI MMIO limit
> * renamed QOM property to nvlink2-tgt
> * moved nvlink2 code to its own file
> 
> ---
> 
> The example command line for redbud system:
> 
> pbuild/qemu-aiku1804le-ppc64/ppc64-softmmu/qemu-system-ppc64 \
> -nodefaults \
> -chardev stdio,id=STDIO0,signal=off,mux=on \
> -device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
> -mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
> -enable-kvm -m 384G \
> -chardev socket,id=SOCKET0,server,nowait,host=localhost,port=40000 \
> -mon chardev=SOCKET0,mode=control \
> -smp 80,sockets=1,threads=4 \
> -netdev "tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0" \
> -device "virtio-net-pci,id=vnet0,mac=52:54:00:12:34:56,netdev=TAP0" \
> img/vdisk0.img \
> -device "vfio-pci,id=vfio0004_04_00_0,host=0004:04:00.0" \
> -device "vfio-pci,id=vfio0006_00_00_0,host=0006:00:00.0" \
> -device "vfio-pci,id=vfio0006_00_00_1,host=0006:00:00.1" \
> -device "vfio-pci,id=vfio0006_00_00_2,host=0006:00:00.2" \
> -device "vfio-pci,id=vfio0004_05_00_0,host=0004:05:00.0" \
> -device "vfio-pci,id=vfio0006_00_01_0,host=0006:00:01.0" \
> -device "vfio-pci,id=vfio0006_00_01_1,host=0006:00:01.1" \
> -device "vfio-pci,id=vfio0006_00_01_2,host=0006:00:01.2" \
> -device spapr-pci-host-bridge,id=phb1,index=1 \
> -device "vfio-pci,id=vfio0035_03_00_0,host=0035:03:00.0" \
> -device "vfio-pci,id=vfio0007_00_00_0,host=0007:00:00.0" \
> -device "vfio-pci,id=vfio0007_00_00_1,host=0007:00:00.1" \
> -device "vfio-pci,id=vfio0007_00_00_2,host=0007:00:00.2" \
> -device "vfio-pci,id=vfio0035_04_00_0,host=0035:04:00.0" \
> -device "vfio-pci,id=vfio0007_00_01_0,host=0007:00:01.0" \
> -device "vfio-pci,id=vfio0007_00_01_1,host=0007:00:01.1" \
> -device "vfio-pci,id=vfio0007_00_01_2,host=0007:00:01.2" -snapshot \
> -machine pseries \
> -L /home/aik/t/qemu-ppc64-bios/ -d guest_errors
> 
> Note that QEMU attaches PCI devices to the last added vPHB so first
> 8 devices - 4:04:00.0 till 6:00:01.2 - go to the default vPHB, and
> 35:03:00.0..7:00:01.2 to the vPHB with id=phb1.
> ---
>  hw/ppc/Makefile.objs        |   2 +-
>  hw/vfio/pci.h               |   2 +
>  include/hw/pci-host/spapr.h |  45 ++++
>  include/hw/ppc/spapr.h      |   3 +-
>  hw/ppc/spapr.c              |  29 ++-
>  hw/ppc/spapr_pci.c          |  19 ++
>  hw/ppc/spapr_pci_nvlink2.c  | 441 ++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci-quirks.c        | 132 +++++++++++
>  hw/vfio/pci.c               |  14 ++
>  hw/vfio/trace-events        |   4 +
>  10 files changed, 686 insertions(+), 5 deletions(-)
>  create mode 100644 hw/ppc/spapr_pci_nvlink2.c
> 

> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b1ae4c07549a..706c30443617 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -194,6 +194,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                 struct vfio_region_info *info,
>                                 Error **errp);
> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
>  
>  void vfio_display_reset(VFIOPCIDevice *vdev);
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index ab0e3a0a6f72..912fb36807ee 100644

> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 40a12001f580..99d4180a5479 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -2180,3 +2180,135 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
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
> +    struct vfio_region_info *nv2reg = NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_nvlink2_ssatgt *cap;
> +    VFIOQuirk *quirk;
> +
> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_NVIDIA,
> +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
> +                                   &nv2reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    hdr = vfio_get_region_info_cap(nv2reg, VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (!hdr) {
> +        ret = -ENODEV;
> +        goto free_exit;
> +    }
> +    cap = (void *) hdr;
> +
> +    p = mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +             MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
> +
> +    if (!p) {

NULL is not the proper test here, mmap(2) needs to test against
MAP_FAILED for error:

RETURN VALUE
       On success, mmap() returns a pointer to the mapped area.  On error, the
       value  MAP_FAILED  (that is, (void *) -1) is returned, and errno is set
       to indicate the cause of the error.


So this should test:

    if (p == MAP_FAILED) {

It's arguable whether we should be setting this up as a proper region
with vfio_region_setup() and vfio_region_mmap(), and torn down with
vfio_region_exit() and vfio_region_finalize(), but I guess the quirk is
sufficient for now.  This would improve the discontinuity David noted
in using a quirk on an arbitrary, unrelated BAR for managing the
lifecycle, but we'd need somewhere to call the tear down functions
rather than piggy backing on the VFIOQuirks on BARs infrastructure.

> +        ret = -errno;
> +        goto free_exit;
> +    }
> +
> +    quirk = vfio_quirk_alloc(1);
> +    memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev), "nvlink2-mr",
> +                               nv2reg->size, p);
> +    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> +
> +    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> +                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                        (void *) cap->tgt, NULL);
> +    trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
> +                                          nv2reg->size);
> +free_exit:
> +    g_free(nv2reg);
> +
> +    return ret;
> +}
> +
> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *atsdreg = NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_nvlink2_ssatgt *captgt;
> +    struct vfio_region_info_cap_nvlink2_lnkspd *capspeed;
> +    VFIOQuirk *quirk;
> +
> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_IBM,
> +                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
> +                                   &atsdreg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    hdr = vfio_get_region_info_cap(atsdreg,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (!hdr) {
> +        ret = -ENODEV;
> +        goto free_exit;
> +    }
> +    captgt = (void *) hdr;
> +
> +    hdr = vfio_get_region_info_cap(atsdreg,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
> +    if (!hdr) {
> +        ret = -ENODEV;
> +        goto free_exit;
> +    }
> +    capspeed = (void *) hdr;
> +
> +    /* Some NVLink bridges may not have assigned ATSD */
> +    if (atsdreg->size) {
> +        p = mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +                 MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
> +        if (!p) {

Same here.

With mmap return value testing fixed, for the vfio portions:

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> +            ret = -errno;
> +            goto free_exit;
> +        }
> +
> +        quirk = vfio_quirk_alloc(1);
> +        memory_region_init_ram_device_ptr(&quirk->mem[0], OBJECT(vdev),
> +                                          "nvlink2-atsd-mr", atsdreg->size, p);
> +        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> +    }
> +
> +    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> +                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                        (void *) captgt->tgt, NULL);
> +    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captgt->tgt,
> +                                              atsdreg->size);
> +
> +    object_property_add(OBJECT(vdev), "nvlink2-link-speed", "uint32",
> +                        vfio_pci_nvlink2_get_link_speed, NULL, NULL,
> +                        (void *) (uint64_t) capspeed->link_speed, NULL);
> +    trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
> +                                              capspeed->link_speed);
> +free_exit:
> +    g_free(atsdreg);
> +
> +    return ret;
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
