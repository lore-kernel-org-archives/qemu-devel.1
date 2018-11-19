Received: from eggs.gnu.org ([208.118.235.92]:40034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gOc3P-00060e-42
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gOc0n-0003et-SF
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:22:21 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gOc0l-0003d8-UV
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:22:17 -0500
Received: by mail-pf1-x442.google.com with SMTP id u3-v6so11575411pfm.4
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 21:22:14 -0800 (PST)
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-8-aik@ozlabs.ru> <20181119030131.GG23503@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <90383760-2f23-a1d8-5f0e-9666f3ea0f0b@ozlabs.ru>
Date: Mon, 19 Nov 2018 16:22:04 +1100
MIME-Version: 1.0
In-Reply-To: <20181119030131.GG23503@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu RFC 7/7] spapr: Add NVLink2 pass
 through support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>



On 19/11/2018 14:01, David Gibson wrote:
> On Tue, Nov 13, 2018 at 07:31:04PM +1100, Alexey Kardashevskiy wrote:
>> The NVIDIA V100 GPU comes with some on-board RAM which is mapped into
>> the host memory space and accessible as normal RAM via NVLink bus.
>> The VFIO-PCI driver implements special regions for such GPU and emulated
>> NVLink bridge (below referred as NPU). The POWER9 CPU also provides
>> address translation services which includes TLB invalidation register
>> exposes via the NVLink bridge; the feature is called "ATSD".
>>
>> This adds a quirk to VFIO to map the memory and create an MR; the new MR
>> is stored in a GPU as a QOM link. The sPAPR PCI uses this to get the MR
>> and map it to the system address space. Another quirk does the same for
>> ATSD.
>>
>> This adds 3 additional steps to the FDT builder in spapr-pci:
>> 1. Search for specific GPUs and NPUs, collects findings in sPAPRPHBState;
>> 2. Adds several properties in the DT: "ibm,npu", "ibm,gpu", "memory-block",
>> and some other. These are required by the guest platform and GPU driver;
>> this also adds a new made-up compatible type for a PHB to signal
>> a modified guest that this particular PHB needs the default DMA window
>> removed as these GPUs have limited DMA mask size (way lower than usual 59);
>> 3. Adds new memory blocks with one addition - they have
>> "linux,memory-usable" property configured in the way which prevents
>> the guest from onlining it automatically as it needs to be deferred till
>> the guest GPU driver trains NVLink.
>>
>> A couple of notes:
>> - this changes the FDT rendeder as doing 1-2-3 from sPAPRPHBClass::realize
>> impossible - devices are not yet attached;
>> - this does not add VFIO quirk MRs to the system address space as
>> the address is selected in sPAPRPHBState, similar to MMIO.
>>
>> This puts new memory nodes in a separate NUMA node to replicate the host
>> system setup as close as possible (the GPU driver relies on this too).
>>
>> This adds fake NPU nodes to make the guest platform code work,
>> specifically "ibm,npu-link-index".
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/vfio/pci.h               |   2 +
>>  include/hw/pci-host/spapr.h |  28 ++++
>>  include/hw/ppc/spapr.h      |   3 +-
>>  hw/ppc/spapr.c              |  14 +-
>>  hw/ppc/spapr_pci.c          | 256 +++++++++++++++++++++++++++++++++++-
>>  hw/vfio/pci-quirks.c        |  93 +++++++++++++
>>  hw/vfio/pci.c               |  14 ++
>>  hw/vfio/trace-events        |   3 +
>>  8 files changed, 408 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index f4c5fb6..b8954cc 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -195,6 +195,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>>                                 struct vfio_region_info *info,
>>                                 Error **errp);
>> +int vfio_pci_nvlink2_ram_init(VFIOPCIDevice *vdev, Error **errp);
>> +int vfio_pci_npu2_atsd_init(VFIOPCIDevice *vdev, Error **errp);
>>  
>>  void vfio_display_reset(VFIOPCIDevice *vdev);
>>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>> index 7c66c38..1f8ebf3 100644
>> --- a/include/hw/pci-host/spapr.h
>> +++ b/include/hw/pci-host/spapr.h
>> @@ -87,6 +87,24 @@ struct sPAPRPHBState {
>>      uint32_t mig_liobn;
>>      hwaddr mig_mem_win_addr, mig_mem_win_size;
>>      hwaddr mig_io_win_addr, mig_io_win_size;
>> +    hwaddr nv2_gpa_win_addr;
>> +    hwaddr nv2_atsd_win_addr;
>> +
>> +    struct spapr_phb_pci_nvgpu_config {
>> +        uint64_t nv2_ram;
>> +        uint64_t nv2_atsd;
>> +        int num;
>> +        struct {
>> +            int links;
>> +            uint64_t tgt;
>> +            uint64_t gpa;
>> +            PCIDevice *gpdev;
>> +            uint64_t atsd[3];
>> +            PCIDevice *npdev[3];
>> +        } gpus[6];
>> +        uint64_t atsd[64]; /* Big Endian (BE), ready for the DT */
>> +        int atsd_num;
>> +    } nvgpus;
> 
> Is this information always relevant for the PHB, or only for PHBs
> which have an NPU or GPU attached to them?  If the latter I'm
> wondering if we can allocate it only when necessary.


I think I can make it even local, just need to hack
spapr_populate_pci_devices_dt's fdt struct to take the struct.


> 
>>  };
>>  
>>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
>> @@ -104,6 +122,16 @@ struct sPAPRPHBState {
>>  
>>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
>>  
>> +#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
>> +                                     (((phb)->index) << 16) | ((pdev)->devfn))
>> +#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
>> +                                     (((phb)->index) << 16))
>> +#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)))
>> +#define SPAPR_PCI_NV2RAM64_WIN_BASE  0x10000000000ULL /* 1 TiB */
>> +#define SPAPR_PCI_NV2RAM64_WIN_SIZE  0x02000000000ULL
>> +#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
>> +                                     ((gn) << 4) | (nn))
> 
> AFAICT many of these values are only used in spapr_pci.c, so I don't
> see a reason to put them into the header.

Correct, this are leftovers from previous iterations, I will clean that up.



>>  static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
>>  {
>>      sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index f5dcaf4..0ceca47 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -108,7 +108,8 @@ struct sPAPRMachineClass {
>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>>                            uint64_t *buid, hwaddr *pio, 
>>                            hwaddr *mmio32, hwaddr *mmio64,
>> -                          unsigned n_dma, uint32_t *liobns, Error **errp);
>> +                          unsigned n_dma, uint32_t *liobns, hwaddr *nv2gpa,
>> +                          hwaddr *nv2atsd, Error **errp);
>>      sPAPRResizeHPT resize_hpt_default;
>>      sPAPRCapabilities default_caps;
>>      sPAPRIrq *irq;
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 38a8218..760b0b5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3723,7 +3723,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
>>  static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
>>                                  uint64_t *buid, hwaddr *pio,
>>                                  hwaddr *mmio32, hwaddr *mmio64,
>> -                                unsigned n_dma, uint32_t *liobns, Error **errp)
>> +                                unsigned n_dma, uint32_t *liobns,
>> +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
>>  {
>>      /*
>>       * New-style PHB window placement.
>> @@ -3770,6 +3771,11 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
>>      *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
>>      *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
>>      *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
>> +
>> +    *nv2gpa = SPAPR_PCI_NV2RAM64_WIN_BASE +
>> +        (index + 1) * SPAPR_PCI_NV2RAM64_WIN_SIZE;
>> +
>> +    *nv2atsd = SPAPR_PCI_BASE + (index + 8192) * 0x10000;
>>  }
>>  
>>  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
>> @@ -4182,7 +4188,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
>>  static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
>>                                uint64_t *buid, hwaddr *pio,
>>                                hwaddr *mmio32, hwaddr *mmio64,
>> -                              unsigned n_dma, uint32_t *liobns, Error **errp)
>> +                              unsigned n_dma, uint32_t *liobns,
>> +                              hwaddr *nv2_gpa, hwaddr *nv2atsd, Error **errp)
>>  {
>>      /* Legacy PHB placement for pseries-2.7 and earlier machine types */
>>      const uint64_t base_buid = 0x800000020000000ULL;
>> @@ -4226,6 +4233,9 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
>>       * fallback behaviour of automatically splitting a large "32-bit"
>>       * window into contiguous 32-bit and 64-bit windows
>>       */
>> +
>> +    *nv2_gpa = 0;
>> +    *nv2atsd = 0;
>>  }
>>  
>>  static void spapr_machine_2_7_instance_options(MachineState *machine)
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 58afa46..417ea1d 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -1249,6 +1249,7 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
>>  static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>>                                         sPAPRPHBState *sphb)
>>  {
>> +    int i, j;
>>      ResourceProps rp;
>>      bool is_bridge = false;
>>      int pci_status;
>> @@ -1349,6 +1350,56 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>>      if (sphb->pcie_ecs && pci_is_express(dev)) {
>>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
>>      }
>> +
>> +    for (i = 0; i < sphb->nvgpus.num; ++i) {
>> +        PCIDevice *gpdev = sphb->nvgpus.gpus[i].gpdev;
>> +
>> +        if (dev == gpdev) {
>> +            uint32_t npus[sphb->nvgpus.gpus[i].links];
>> +
>> +            for (j = 0; j < sphb->nvgpus.gpus[i].links; ++j) {
>> +                PCIDevice *npdev = sphb->nvgpus.gpus[i].npdev[j];
>> +
>> +                npus[j] = cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
>> +            }
>> +            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
>> +                             j * sizeof(npus[0])));
>> +            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
>> +                                   PHANDLE_PCIDEV(sphb, dev))));
>> +        } else {
>> +            for (j = 0; j < sphb->nvgpus.gpus[i].links; ++j) {
>> +                if (dev != sphb->nvgpus.gpus[i].npdev[j]) {
>> +                    continue;
>> +                }
>> +
>> +                _FDT((fdt_setprop_cell(fdt, offset, "phandle",
>> +                                       PHANDLE_PCIDEV(sphb, dev))));
>> +
>> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
>> +                                      PHANDLE_PCIDEV(sphb, gpdev)));
>> +
>> +                _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
>> +                                       PHANDLE_NVLINK(sphb, i, j))));
>> +
>> +                /*
>> +                 * If we ever want to emulate GPU RAM at the same location as on
>> +                 * the host - here is the encoding GPA->TGT:
>> +                 *
>> +                 * gta  = ((sphb->nv2_gpa >> 42) & 0x1) << 42;
>> +                 * gta |= ((sphb->nv2_gpa >> 45) & 0x3) << 43;
>> +                 * gta |= ((sphb->nv2_gpa >> 49) & 0x3) << 45;
>> +                 * gta |= sphb->nv2_gpa & ((1UL << 43) - 1);
>> +                 */
>> +                _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
>> +                                      PHANDLE_GPURAM(sphb, i)));
>> +                _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
>> +                                     sphb->nvgpus.gpus[i].tgt));
>> +                /* _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink", 0x164)); */
>> +                /* Unknown magic value of 9 */
>> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed", 9));
>> +            }
>> +        }
>> +    }
>>  }
>>  
>>  /* create OF node for pci device and required OF DT properties */
>> @@ -1582,7 +1633,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>          smc->phb_placement(spapr, sphb->index,
>>                             &sphb->buid, &sphb->io_win_addr,
>>                             &sphb->mem_win_addr, &sphb->mem64_win_addr,
>> -                           windows_supported, sphb->dma_liobn, &local_err);
>> +                           windows_supported, sphb->dma_liobn,
>> +                           &sphb->nv2_gpa_win_addr,
>> +                           &sphb->nv2_atsd_win_addr, &local_err);
>>          if (local_err) {
>>              error_propagate(errp, local_err);
>>              return;
>> @@ -1829,6 +1882,8 @@ static Property spapr_phb_properties[] = {
>>                       pre_2_8_migration, false),
>>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
>>                       pcie_ecs, true),
>> +    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
>> +    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> @@ -2068,6 +2123,73 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
>>  
>>  }
>>  
>> +static void spapr_phb_pci_find_nvgpu(PCIBus *bus, PCIDevice *pdev, void *opaque)
>> +{
>> +    struct spapr_phb_pci_nvgpu_config *nvgpus = opaque;
>> +    PCIBus *sec_bus;
>> +    Object *mr_gpu, *mr_npu;
>> +    uint64_t tgt = 0, gpa, atsd;
>> +    int i;
>> +
>> +    mr_gpu = object_property_get_link(OBJECT(pdev), "nvlink2-mr[0]", NULL);
>> +    mr_npu = object_property_get_link(OBJECT(pdev), "nvlink2-atsd-mr[0]", NULL);
>> +    if (mr_gpu) {
>> +        tgt = object_property_get_uint(mr_gpu, "tgt", NULL);
>> +        gpa = nvgpus->nv2_ram;
>> +        nvgpus->nv2_ram += memory_region_size(MEMORY_REGION(mr_gpu));
>> +    } else if (mr_npu) {
>> +        tgt = object_property_get_uint(mr_npu, "tgt", NULL);
>> +        atsd = nvgpus->nv2_atsd;
>> +        nvgpus->atsd[nvgpus->atsd_num] = cpu_to_be64(atsd);
>> +        ++nvgpus->atsd_num;
>> +        nvgpus->nv2_atsd += memory_region_size(MEMORY_REGION(mr_npu));
>> +    }
>> +
>> +    if (tgt) {
> 
> Are you certain 0 can never be a valid tgt value?


Hm. I do not think it can in practice but nothing in the NPU spec which
would guarantee that, I'll use (-1) here.


>> +        for (i = 0; i < nvgpus->num; ++i) {
>> +            if (nvgpus->gpus[i].tgt == tgt) {
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (i == nvgpus->num) {
>> +            if (nvgpus->num == ARRAY_SIZE(nvgpus->gpus)) {
> 
> This means you've run out of space in your array to describe the
> system you're dealing with, yes?  In which case you probably want some
> sort of error message.


True, will add some. I have a dilemma with this code - seeing 4 or even
6 links going to the same CPU is not impossible, although there is no
such hardware yet nor any plans to build it, does it make any sense to
account for this and make every array within struct
spapr_phb_pci_nvgpu_config dynamically allocated, or the hardware is so
unique that we do not want to go that far?



-- 
Alexey
