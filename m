Received: from eggs.gnu.org ([209.51.188.92]:58957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gvteI-0001g5-4k
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gvteC-0008A1-Pz
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:52:38 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gvteB-0007uP-Ed
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:52:32 -0500
Received: by mail-pf1-x442.google.com with SMTP id s22so9367261pfh.4
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 16:52:22 -0800 (PST)
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214052144.59541-5-aik@ozlabs.ru>
	<20190215032203.GE4573@umbus.fritz.box>
	<ba647108-77ef-c2fc-211c-22c41bca95ea@ozlabs.ru>
	<20190215053020.GM4573@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7b6dff23-d5c6-256e-37d1-f2f45c1c7a59@ozlabs.ru>
Date: Tue, 19 Feb 2019 11:52:14 +1100
MIME-Version: 1.0
In-Reply-To: <20190215053020.GM4573@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 4/4] spapr: Support NVIDIA V100 GPU
 with NVLink2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>



On 15/02/2019 16:30, David Gibson wrote:
> On Fri, Feb 15, 2019 at 03:42:56PM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 15/02/2019 14:22, David Gibson wrote:
>>> On Thu, Feb 14, 2019 at 04:21:44PM +1100, Alexey Kardashevskiy wrote:
>>>> NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
>>>> space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driver
>>>> implements special regions for such GPUs and emulates an NVLink bridge.
>>>> NVLink2-enabled POWER9 CPUs also provide address translation services
>>>> which includes an ATS shootdown (ATSD) register exported via the NVLink
>>>> bridge device.
>>>>
>>>> This adds a quirk to VFIO to map the GPU memory and create an MR;
>>>> the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
>>>> this to get the MR and map it to the system address space.
>>>> Another quirk does the same for ATSD.
>>>>
>>>> This adds 4 additional steps to the FDT builder in spapr-pci:
>>>>
>>>> 1. Search for specific GPUs and NPUs and collect findings in
>>>> sPAPRPHBState::nvgpus;
>>>>
>>>> 2. Add properties in the device tree such as "ibm,npu", "ibm,gpu",
>>>> "memory-block" and others to advertise the NVLink2 function to the guest;
>>>>
>>>> 3. Add new memory blocks with an extra "linux,memory-usable" to prevent
>>>> the guest OS from accessing the new memory until it is online by the GPU
>>>> driver in the guest;
>>>>
>>>> 4. Add a npuphb# node representing an NPU unit for every vPHB as
>>>> the GPU driver uses it to detect NPU2 hardware and discover links; this
>>>> is not backed by any QEMU device as it does need to.
>>>>
>>>> This allocates space for GPU RAM and ATSD like we do for MMIOs by
>>>> adding 2 new parameters to the phb_placement() hook. Older machine types
>>>> set these to zero.
>>>>
>>>> This puts new memory nodes in a separate NUMA node to replicate the host
>>>> system setup as the GPU driver relies on this.
>>>>
>>>> This adds requirement similar to EEH - one IOMMU group per vPHB.
>>>> The reason for this is that ATSD registers belong to a physical NPU
>>>> so they cannot invalidate translations on GPUs attached to another NPU.
>>>> It is guaranteed by the host platform as it does not mix NVLink bridges
>>>> or GPUs from different NPU in the same IOMMU group. If more than one
>>>> IOMMU group is detected on a vPHB, this disables ATSD support for that
>>>> vPHB and prints a warning.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>
>>>> The example command line for redbud system:
>>>>
>>>> pbuild/qemu-aiku1804le-ppc64/ppc64-softmmu/qemu-system-ppc64 \
>>>> -nodefaults \
>>>> -chardev stdio,id=STDIO0,signal=off,mux=on \
>>>> -device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
>>>> -mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
>>>> -enable-kvm -m 384G \
>>>> -chardev socket,id=SOCKET0,server,nowait,host=localhost,port=40000 \
>>>> -mon chardev=SOCKET0,mode=control \
>>>> -smp 80,sockets=1,threads=4 \
>>>> -netdev "tap,id=TAP0,helper=/home/aik/qemu-bridge-helper --br=br0" \
>>>> -device "virtio-net-pci,id=vnet0,mac=52:54:00:12:34:56,netdev=TAP0" \
>>>> img/vdisk0.img \
>>>> -device "vfio-pci,id=vfio0004_04_00_0,host=0004:04:00.0" \
>>>> -device "vfio-pci,id=vfio0006_00_00_0,host=0006:00:00.0" \
>>>> -device "vfio-pci,id=vfio0006_00_00_1,host=0006:00:00.1" \
>>>> -device "vfio-pci,id=vfio0006_00_00_2,host=0006:00:00.2" \
>>>> -device "vfio-pci,id=vfio0004_05_00_0,host=0004:05:00.0" \
>>>> -device "vfio-pci,id=vfio0006_00_01_0,host=0006:00:01.0" \
>>>> -device "vfio-pci,id=vfio0006_00_01_1,host=0006:00:01.1" \
>>>> -device "vfio-pci,id=vfio0006_00_01_2,host=0006:00:01.2" \
>>>> -device spapr-pci-host-bridge,id=phb1,index=1 \
>>>> -device "vfio-pci,id=vfio0035_03_00_0,host=0035:03:00.0" \
>>>> -device "vfio-pci,id=vfio0007_00_00_0,host=0007:00:00.0" \
>>>> -device "vfio-pci,id=vfio0007_00_00_1,host=0007:00:00.1" \
>>>> -device "vfio-pci,id=vfio0007_00_00_2,host=0007:00:00.2" \
>>>> -device "vfio-pci,id=vfio0035_04_00_0,host=0035:04:00.0" \
>>>> -device "vfio-pci,id=vfio0007_00_01_0,host=0007:00:01.0" \
>>>> -device "vfio-pci,id=vfio0007_00_01_1,host=0007:00:01.1" \
>>>> -device "vfio-pci,id=vfio0007_00_01_2,host=0007:00:01.2" -snapshot \
>>>> -machine pseries \
>>>> -L /home/aik/t/qemu-ppc64-bios/ -d guest_errors
>>>>
>>>> Note that QEMU attaches PCI devices to the last added vPHB so first
>>>> 8 devices - 4:04:00.0 till 6:00:01.2 - go to the default vPHB, and
>>>> 35:03:00.0..7:00:01.2 to the vPHB with id=phb1.
>>>> ---
>>>>  hw/vfio/pci.h               |   2 +
>>>>  include/hw/pci-host/spapr.h |   9 +
>>>>  include/hw/ppc/spapr.h      |   3 +-
>>>>  hw/ppc/spapr.c              |  25 ++-
>>>>  hw/ppc/spapr_pci.c          | 333 +++++++++++++++++++++++++++++++++++-
>>>>  hw/vfio/pci-quirks.c        | 120 +++++++++++++
>>>>  hw/vfio/pci.c               |  14 ++
>>>>  hw/vfio/trace-events        |   4 +
>>>>  8 files changed, 506 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>>> index b1ae4c0..706c304 100644
>>>> --- a/hw/vfio/pci.h
>>>> +++ b/hw/vfio/pci.h
>>>> @@ -194,6 +194,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>>>>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>>>>                                 struct vfio_region_info *info,
>>>>                                 Error **errp);
>>>> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
>>>> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
>>>>  
>>>>  void vfio_display_reset(VFIOPCIDevice *vdev);
>>>>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>>>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>>>> index 51d81c4..4a665cb 100644
>>>> --- a/include/hw/pci-host/spapr.h
>>>> +++ b/include/hw/pci-host/spapr.h
>>>> @@ -87,6 +87,9 @@ struct sPAPRPHBState {
>>>>      uint32_t mig_liobn;
>>>>      hwaddr mig_mem_win_addr, mig_mem_win_size;
>>>>      hwaddr mig_io_win_addr, mig_io_win_size;
>>>> +    hwaddr nv2_gpa_win_addr;
>>>> +    hwaddr nv2_atsd_win_addr;
>>>> +    struct spapr_phb_pci_nvgpu_config *nvgpus;
>>>>  };
>>>>  
>>>>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
>>>> @@ -105,6 +108,12 @@ struct sPAPRPHBState {
>>>>  
>>>>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
>>>>  
>>>> +#define SPAPR_PCI_NV2RAM64_WIN_BASE  0x10000000000ULL /* 1 TiB */
>>>
>>> This is not a good choice - we have POWER machines with well over 1
>>> TiB RAM, and so it's also plausible we can get guests with over 1 TiB
>>> RAM which will collide with this.  Especially likely with the sort of
>>> giant HPC guests that are most likely to have the GPUs passed through
>>> to them.
>>
>>>
>>> This is why we already moved the main PCI MMIO windows up to 32 TiB
>>> from the lower address they used to have.
>>
>>
>> How much space do you want to leave for the guest RAM ideally? Or it is
>> that 32TiB and I better move GPU RAM above that?
> 
> Yeah, I wouldn't reduce it below the 32TiB limit we have already
> because of the PCI MMIO spaces.  I'd put the NVLink RAM up higher.
> 
>>>> +
>>>> +#define SPAPR_PCI_NV2ATSD_WIN_BASE   SPAPR_PCI_LIMIT
>>>> +#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (16 * 0x10000)
>>>> +
>>>>  static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
>>>>  {
>>>>      sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index cbd276e..d9edf23 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -112,7 +112,8 @@ struct sPAPRMachineClass {
>>>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>>>>                            uint64_t *buid, hwaddr *pio, 
>>>>                            hwaddr *mmio32, hwaddr *mmio64,
>>>> -                          unsigned n_dma, uint32_t *liobns, Error **errp);
>>>> +                          unsigned n_dma, uint32_t *liobns, hwaddr *nv2gpa,
>>>> +                          hwaddr *nv2atsd, Error **errp);
>>>>      sPAPRResizeHPT resize_hpt_default;
>>>>      sPAPRCapabilities default_caps;
>>>>      sPAPRIrq *irq;
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index b967024..d18834c 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -3844,7 +3844,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
>>>>  static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
>>>>                                  uint64_t *buid, hwaddr *pio,
>>>>                                  hwaddr *mmio32, hwaddr *mmio64,
>>>> -                                unsigned n_dma, uint32_t *liobns, Error **errp)
>>>> +                                unsigned n_dma, uint32_t *liobns,
>>>> +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
>>>>  {
>>>>      /*
>>>>       * New-style PHB window placement.
>>>> @@ -3889,6 +3890,9 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
>>>>      *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
>>>>      *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
>>>>      *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
>>>> +
>>>> +    *nv2gpa = SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64_WIN_SIZE;
>>>> +    *nv2atsd = SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_WIN_SIZE;
>>>>  }
>>>>  
>>>>  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
>>>> @@ -4090,6 +4094,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>>>>  /*
>>>>   * pseries-3.1
>>>>   */
>>>> +static void phb_placement_3_1(sPAPRMachineState *spapr, uint32_t index,
>>>> +                              uint64_t *buid, hwaddr *pio,
>>>> +                              hwaddr *mmio32, hwaddr *mmio64,
>>>> +                              unsigned n_dma, uint32_t *liobns,
>>>> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
>>>> +{
>>>> +    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma, liobns,
>>>> +                        nv2gpa, nv2atsd, errp);
>>>> +    *nv2gpa = 0;
>>>> +    *nv2atsd = 0;
>>>> +}
>>>> +
>>>>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>>  {
>>>>      sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>>>> @@ -4098,6 +4114,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>>      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>>>>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>>>      smc->update_dt_enabled = false;
>>>> +    smc->phb_placement = phb_placement_3_1;
>>>>  }
>>>>  
>>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>>>> @@ -4229,7 +4246,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
>>>>  static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
>>>>                                uint64_t *buid, hwaddr *pio,
>>>>                                hwaddr *mmio32, hwaddr *mmio64,
>>>> -                              unsigned n_dma, uint32_t *liobns, Error **errp)
>>>> +                              unsigned n_dma, uint32_t *liobns,
>>>> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **errp)
>>>>  {
>>>>      /* Legacy PHB placement for pseries-2.7 and earlier machine types */
>>>>      const uint64_t base_buid = 0x800000020000000ULL;
>>>> @@ -4273,6 +4291,9 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
>>>>       * fallback behaviour of automatically splitting a large "32-bit"
>>>>       * window into contiguous 32-bit and 64-bit windows
>>>>       */
>>>> +
>>>> +    *nv2gpa = 0;
>>>> +    *nv2atsd = 0;
>>>>  }
>>>>  
>>>>  static void spapr_machine_2_7_class_options(MachineClass *mc)
>>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>>> index c3fb0ac..04a679e 100644
>>>> --- a/hw/ppc/spapr_pci.c
>>>> +++ b/hw/ppc/spapr_pci.c
>>>> @@ -50,6 +50,46 @@
>>>>  #include "sysemu/hostmem.h"
>>>>  #include "sysemu/numa.h"
>>>>  
>>>> +#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
>>>> +                                     (((phb)->index) << 16) | ((pdev)->devfn))
>>>> +#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
>>>> +                                     (((phb)->index) << 16))
>>>> +/* NVLink2 wants a separate NUMA node for its RAM */
>>>> +#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)))
>>>
>>> IIUC this gives you non zero-based indices for the associtivity
>>> property.  That's going to make a real mess of
>>> ibm,max-associativity-domains.
>>
>>
>> ? It does not on the host which I mimic here. And a bunch of CUDA tests
>> actually rely on node numbers (which is not a huge deal but it will be
>> annoying for the users).
> 
> Does the host even use ibm,max-associativity-domains? 

Not much, since 2017, in this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a346137e9142b0

> I'm pretty sure
> at least parts of the PAPR code assume that nodes (at a given level of
> the heirarchy) will be encoded as 0..(max) as given in
> max-associativity domains.

Nodes number does have to be equal to the biggest node id. Seems working
at the moment just fine:

aik@u1804kvm:/sys/devices/system/node$ ls
has_cpu  has_memory  has_normal_memory  node0  node250  node251  node252
 online  possible  power  uevent



>>>> +#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
>>>> +                                     ((gn) << 4) | (nn))
>>>> +
>>>> +/* Max number of these GPUs per a physical box */
>>>> +#define NVGPU_MAX_NUM                6
>>>> +
>>>> +/* Max number of NVLinks per GPU in any physical box */
>>>> +#define NVGPU_MAX_LINKS              3
>>>> +
>>>> +/*
>>>> + * One NVLink bridge provides one ATSD register so it should be 18.
>>>> + * In practice though since we allow only one group per vPHB
>>>
>>> Uh.. we do?  Do you mean iommu group here?  We used to enforce one per
>>> vPHB, but that's no longer the case.  Or have you reintroduced that
>>> restriction?
>>
>>
>> Sort of. This is for ATSD (invalidation registers), these are advertised
>> to the guest via a PHB's property:
>> /sys/firmware/devicetree/base/pciex@6230200000000/ibm\,mmio-atsd
>>
>> where /sys/firmware/devicetree/base/pciex@6230200000000 is a node for
>> that skiboot emulated "IBM Device 04ea" bridge which represents nvlinks.
>>
>> We have 2 of these bridges per a machine. ATSD registers from one NPU
>> cannot work on another NPU. Hence the limitation.
>>
>> I mean it is still possible to put GPUs in whatever combination but if
>> this happens, ATSD will be disabled (i.e. not advertised). Which is not
>> extremely useful though.
>>
>>
>>
>>>> which equals
>>>> + * to an NPU2 which has maximum 6 NVLink bridges.
>>>> + */
>>>> +#define NVGPU_MAX_ATSD               6
>>>> +
>>>> +struct spapr_phb_pci_nvgpu_config {
>>>> +    uint64_t nv2_ram_current;
>>>> +    uint64_t nv2_atsd_current;
>>>> +    int num; /* number of valid entries in gpus[] */
>>>> +    int gpunum; /* number of entries in gpus[] with gpdev!=NULL */
>>>> +    struct {
>>>> +        int links;
>>>> +        uint64_t tgt;
>>>> +        uint64_t gpa;
>>>> +        PCIDevice *gpdev;
>>>> +        uint64_t atsd_gpa[NVGPU_MAX_LINKS];
>>>> +        PCIDevice *npdev[NVGPU_MAX_LINKS];
>>>> +        uint32_t link_speed[NVGPU_MAX_LINKS];
>>>> +    } gpus[NVGPU_MAX_NUM];
>>>> +    uint64_t atsd_prop[NVGPU_MAX_ATSD]; /* Big Endian for DT */
>>>> +    int atsd_num;
>>>> +};
>>>> +
>>>>  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
>>>>  #define RTAS_QUERY_FN           0
>>>>  #define RTAS_CHANGE_FN          1
>>>> @@ -1255,6 +1295,7 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
>>>>  static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>>>>                                         sPAPRPHBState *sphb)
>>>>  {
>>>> +    int i, j;
>>>>      ResourceProps rp;
>>>>      bool is_bridge = false;
>>>>      int pci_status;
>>>> @@ -1355,6 +1396,60 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>>>>      if (sphb->pcie_ecs && pci_is_express(dev)) {
>>>>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
>>>>      }
>>>> +
>>>> +    if (sphb->nvgpus) {
>>>> +        for (i = 0; i < sphb->nvgpus->num; ++i) {
>>>
>>> So, if nvgpus->num is the number of valid entries in the table..
>>>
>>>> +            PCIDevice *gpdev = sphb->nvgpus->gpus[i].gpdev;
>>>> +
>>>> +            if (!gpdev) {
>>>
>>> ..but you can also have gaps, couldn't you miss some if the table is sparse?
>>
>>
>> Well, nvgpus->num is the number of partially populated entries. Some
>> might have only GPUs, some only NPUs - whatever a creative user passed,
>> I just advertise it all to the guest.
> 
> Oh, ok.  So the gpus array only contains some of the relevant devices,
> but the number space is global?  That is, a given "slot" (value of i,
> here) can contain either a GPU, an NPU or both?


Almost. It should be a GPU or GPU+NPU or GPU+NPUs but not alone NPU.


>> Perhaps some sanity checking won't hurt but I cannot do much more here
>> than just making sure that we only properly advertise NPU bridges which
>> have a GPU attached as any other config is quite valid (like a GPU with
>> no nvlink or with just one nvlink).
>>
>>
>>>
>>>> +                continue;
>>>> +            }
>>>> +            if (dev == gpdev) {
>>>> +                uint32_t npus[sphb->nvgpus->gpus[i].links];
>>>> +
>>>> +                for (j = 0; j < sphb->nvgpus->gpus[i].links; ++j) {
>>>> +                    PCIDevice *npdev = sphb->nvgpus->gpus[i].npdev[j];
>>>> +
>>>> +                    npus[j] = cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
>>>> +                }
>>>> +                _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
>>>> +                                 j * sizeof(npus[0])));
>>>> +                _FDT((fdt_setprop_cell(fdt, offset, "phandle",
>>>> +                                       PHANDLE_PCIDEV(sphb, dev))));
>>>> +                continue;
>>>> +            }
>>>> +            for (j = 0; j < sphb->nvgpus->gpus[i].links; ++j) {
>>>> +                if (dev != sphb->nvgpus->gpus[i].npdev[j]) {
>>>> +                    continue;
>>>> +                }
>>>> +
>>>> +                _FDT((fdt_setprop_cell(fdt, offset, "phandle",
>>>> +                                       PHANDLE_PCIDEV(sphb, dev))));
>>>> +
>>>> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
>>>> +                                      PHANDLE_PCIDEV(sphb, gpdev)));
>>>> +
>>>> +                _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
>>>> +                                       PHANDLE_NVLINK(sphb, i, j))));
>>>> +
>>>> +                /*
>>>> +                 * If we ever want to emulate GPU RAM at the same location as on
>>>> +                 * the host - here is the encoding GPA->TGT:
>>>> +                 *
>>>> +                 * gta  = ((sphb->nv2_gpa >> 42) & 0x1) << 42;
>>>> +                 * gta |= ((sphb->nv2_gpa >> 45) & 0x3) << 43;
>>>> +                 * gta |= ((sphb->nv2_gpa >> 49) & 0x3) << 45;
>>>> +                 * gta |= sphb->nv2_gpa & ((1UL << 43) - 1);
>>>> +                 */
>>>> +                _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
>>>> +                                      PHANDLE_GPURAM(sphb, i)));
>>>> +                _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
>>>> +                                     sphb->nvgpus->gpus[i].tgt));
>>>> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
>>>> +                                      sphb->nvgpus->gpus[i].link_speed[j]));
>>>> +            }
>>>> +        }
>>>> +    }
>>>>  }
>>>>  
>>>>  /* create OF node for pci device and required OF DT properties */
>>>> @@ -1596,7 +1691,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>>>>          smc->phb_placement(spapr, sphb->index,
>>>>                             &sphb->buid, &sphb->io_win_addr,
>>>>                             &sphb->mem_win_addr, &sphb->mem64_win_addr,
>>>> -                           windows_supported, sphb->dma_liobn, &local_err);
>>>> +                           windows_supported, sphb->dma_liobn,
>>>> +                           &sphb->nv2_gpa_win_addr,
>>>> +                           &sphb->nv2_atsd_win_addr, &local_err);
>>>>          if (local_err) {
>>>>              error_propagate(errp, local_err);
>>>>              return;
>>>> @@ -1843,6 +1940,8 @@ static Property spapr_phb_properties[] = {
>>>>                       pre_2_8_migration, false),
>>>>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
>>>>                       pcie_ecs, true),
>>>> +    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
>>>> +    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),
>>>
>>> Now that index is mandatory it's probably not essential to have these
>>> properties, although I guess they don't hurt.
>>>
>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>  };
>>>>  
>>>> @@ -2069,6 +2168,80 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
>>>>  
>>>>  }
>>>>  
>>>> +static void spapr_phb_pci_find_nvgpu(PCIBus *bus, PCIDevice *pdev, void *opaque)
>>>> +{
>>>> +    struct spapr_phb_pci_nvgpu_config *nvgpus = opaque;
>>>> +    PCIBus *sec_bus;
>>>> +    Object *mr_gpu, *mr_npu;
>>>> +    uint64_t tgt = 0, gpa, atsd = 0;
>>>> +    int i;
>>>> +
>>>> +    mr_gpu = object_property_get_link(OBJECT(pdev), "nvlink2-mr[0]", NULL);
>>>> +    mr_npu = object_property_get_link(OBJECT(pdev), "nvlink2-atsd-mr[0]", NULL);
>>>> +    if (mr_gpu) {
>>>> +        gpa = nvgpus->nv2_ram_current;
>>>> +        nvgpus->nv2_ram_current += memory_region_size(MEMORY_REGION(mr_gpu));
>>>
>>> Hrm.  Changing persistent state in a function called "find" makes me
>>> nervous.
>>
>>
>> "Gather"? "Collect"? "Scan"?
> 
> Collect or scan would both be fine.
> 
>>
>>
>>>> +    } else if (mr_npu) {
>>>> +        if (nvgpus->atsd_num == ARRAY_SIZE(nvgpus->atsd_prop)) {
>>>> +            warn_report("Found too many ATSD registers per vPHB");
>>>> +        } else {
>>>> +            atsd = nvgpus->nv2_atsd_current;
>>>> +            nvgpus->atsd_prop[nvgpus->atsd_num] = cpu_to_be64(atsd);
>>>> +            ++nvgpus->atsd_num;
>>>> +            nvgpus->nv2_atsd_current +=
>>>> +                memory_region_size(MEMORY_REGION(mr_npu));
>>>> +        }
>>>> +    }
>>>> +
>>>> +    tgt = object_property_get_uint(OBJECT(pdev), "tgt", NULL);
>>>
>>> It seems like you ought to have an object_dynamic_cast() up the top of
>>> here to see if is a device you care about.  I guess you'd get away
>>> with it in practice because other devices won't have the properties
>>> you test for, but I'd prefer not to rely on that (especially since
>>> "tgt" is such a brief, generic name, which come to think of it might
>>> be a good idea to change anyway).
>>> This would probably also be clearer if you have the recursing over
>>> bridges in one function and the handling of a single specific device
>>> you're interested in delegated to a another function.
>>>
>>>> +    if (tgt) {
>>>> +        for (i = 0; i < nvgpus->num; ++i) {
>>>> +            if (nvgpus->gpus[i].tgt == tgt) {
>>>> +                break;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        if (i == nvgpus->num) {
>>>> +            if (nvgpus->num == ARRAY_SIZE(nvgpus->gpus)) {
>>>> +                warn_report("Found too many NVLink bridges per GPU");
>>>> +                return;
>>>> +            }
>>>> +            ++nvgpus->num;
>>>> +        }
>>>> +
>>>> +        nvgpus->gpus[i].tgt = tgt;
>>>> +        if (mr_gpu) {
>>>> +            g_assert(!nvgpus->gpus[i].gpdev);
>>>> +            nvgpus->gpus[i].gpdev = pdev;
>>>> +            nvgpus->gpus[i].gpa = gpa;
>>>> +            ++nvgpus->gpunum;
>>>> +        } else {
>>>> +            int j = nvgpus->gpus[i].links;
>>>> +
>>>> +            ++nvgpus->gpus[i].links;
>>>> +
>>>> +            g_assert(!nvgpus->gpus[i].npdev[j]);
>>>> +            nvgpus->gpus[i].npdev[j] = pdev;
>>>> +            nvgpus->gpus[i].atsd_gpa[j] = atsd;
>>>> +            nvgpus->gpus[i].link_speed[j] =
>>>> +                    object_property_get_uint(OBJECT(pdev), "link_speed", NULL);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
>>>> +         PCI_HEADER_TYPE_BRIDGE)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>>>> +    if (!sec_bus) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
>>>> +                        spapr_phb_pci_find_nvgpu, opaque);
>>>> +}
>>>> +
>>>>  int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
>>>>                            uint32_t nr_msis)
>>>>  {
>>>> @@ -2187,6 +2360,69 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
>>>>      spapr_phb_pci_enumerate(phb);
>>>>      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
>>>>  
>>>> +    /* If there are existing NVLink2 MRs, unmap those before recreating */
>>>
>>> Unmapping regions shouldn't be in a function that's about populating
>>> the dt, it probably wants to be part of the reset path.
>>>
>>>> +    if (phb->nvgpus) {
>>>> +        for (i = 0; i < phb->nvgpus->num; ++i) {
>>>> +            PCIDevice *gpdev = phb->nvgpus->gpus[i].gpdev;
>>>> +            Object *nv_mrobj = object_property_get_link(OBJECT(gpdev),
>>>> +                                                        "nvlink2-mr[0]", NULL);
>>>> +
>>>> +            if (nv_mrobj) {
>>>> +                memory_region_del_subregion(get_system_memory(),
>>>> +                                            MEMORY_REGION(nv_mrobj));
>>>> +            }
>>>> +            for (j = 0; j < phb->nvgpus->gpus[i].links; ++j) {
>>>> +                PCIDevice *npdev = phb->nvgpus->gpus[i].npdev[j];
>>>> +                Object *atsd_mrobj;
>>>> +                atsd_mrobj = object_property_get_link(OBJECT(npdev),
>>>> +                                                         "nvlink2-atsd-mr[0]",
>>>> +                                                         NULL);
>>>> +                if (atsd_mrobj) {
>>>> +                    memory_region_del_subregion(get_system_memory(),
>>>> +                                                MEMORY_REGION(atsd_mrobj));
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +        g_free(phb->nvgpus);
>>>> +        phb->nvgpus = NULL;
>>>> +    }
>>>> +
>>>> +    /* Search for GPUs and NPUs */
>>>> +    if (phb->nv2_gpa_win_addr && phb->nv2_atsd_win_addr) {
>>>> +        phb->nvgpus = g_new0(struct spapr_phb_pci_nvgpu_config, 1);
>>>
>>> Likewise creating this internal state shouldn't be in a dt creation
>>> function.
>>>
>>>> +        phb->nvgpus->nv2_ram_current = phb->nv2_gpa_win_addr;
>>>> +        phb->nvgpus->nv2_atsd_current = phb->nv2_atsd_win_addr;
>>>> +
>>>> +        pci_for_each_device(bus, pci_bus_num(bus),
>>>> +                            spapr_phb_pci_find_nvgpu, phb->nvgpus);
>>>> +
>>>> +        if (!phb->nvgpus->gpunum) {
>>>> +            /* We did not find any interesting GPU */
>>>> +            g_free(phb->nvgpus);
>>>> +            phb->nvgpus = NULL;
>>>> +        } else {
>>>> +            /*
>>>> +             * ibm,mmio-atsd contains ATSD registers; these belong to an NPU PHB
>>>> +             * which we do not emulate as a separate device. Instead we put
>>>> +             * ibm,mmio-atsd to the vPHB with GPU and make sure that we do not
>>>> +             * put GPUs from different IOMMU groups to the same vPHB to ensure
>>>> +             * that the guest will use ATSDs from the corresponding NPU.
>>>> +             */
>>>> +            if (!spapr_phb_eeh_available(phb)) {
>>>
>>> That's making assumptions about what spapr_phb_eeh_available() tests
>>> which might not always be warranted.
>>
>>
>> Correct. I could globally rename these helpers to "is_single_iommugroup"
>> to test if there is just a single IOMMU group per vPHB unless there is a
>> better idea may be?
> 
> So what's the actual barrier to supporting multiple IOMMU groups here?


ATSD MMIO register presentation to linux via the dt. I could fix the NPU
code in the kernel to look for these elsewhere, for example, in NVLink
bridges, although it would not be entirely correct as there registers
actually belong to an NPU.



>>>> +                warn_report("ATSD requires a separate vPHB per GPU IOMMU group");
>>>> +            } else if (!phb->nvgpus->atsd_num) {
>>>> +                warn_report("No ATSD registers found");
>>>> +            } else if (phb->nvgpus->atsd_num > 8) {
>>>> +                warn_report("Bogus ATSD configuration is found");
>>>> +            } else {
>>>> +                _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd",
>>>> +                                  phb->nvgpus->atsd_prop,
>>>> +                                  phb->nvgpus->atsd_num *
>>>> +                                  sizeof(phb->nvgpus->atsd_prop[0]))));
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>>      /* Populate tree nodes with PCI devices attached */
>>>>      s_fdt.fdt = fdt;
>>>>      s_fdt.node_off = bus_off;
>>>> @@ -2201,6 +2437,101 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, void *fdt,
>>>>          return ret;
>>>>      }
>>>>  
>>>> +    if (phb->nvgpus) {
>>>> +        /* Add memory nodes for GPU RAM and mark them unusable */
>>>> +        for (i = 0; i < phb->nvgpus->num; ++i) {
>>>> +            PCIDevice *gpdev = phb->nvgpus->gpus[i].gpdev;
>>>> +            Object *nv_mrobj = object_property_get_link(OBJECT(gpdev),
>>>> +                                                        "nvlink2-mr[0]", NULL);
>>>> +            char *mem_name;
>>>> +            int off;
>>>> +            uint32_t at = cpu_to_be32(GPURAM_ASSOCIATIVITY(phb, i));
>>>> +            uint32_t associativity[] = { cpu_to_be32(0x4), at, at, at, at };
>>>
>>> Putting at at every level of the associativity property seems bogus.
>>>
>>> I mean it's kind of bogus we have 4 or 5 levels of associativity
>>> anyway (I think that was just copied from a PowerVM setup).  At
>>> present level 4 is the qemu node, and the ones above it are always 0.
>>>
>>> Possibly it would make sense for one of the higher levels to indicate
>>> system vs. NVLink RAM (0 or 1), then a single value for which NVLink
>>> node at level 4.
>>
>>
>> The only reason I did this in this way was the existing powernv config.
>> Perhaps the nvidia driver can cope with what you proposed, I'll give it
>> a try.
> 
> Yeah, raw copying a powernv associativity structure to PAPR doesn't
> really make sense - it has to fit in with the associativity node
> structure we're already advertising.


There are no resources visible to QEMU to associate with QEMU's NUMA
config so how else can I present these nodes to the guest then?


>>
>>
>>>
>>>> +            uint64_t nv2_size = object_property_get_uint(nv_mrobj,
>>>> +                                                         "size", NULL);
>>>> +            uint64_t mem_reg_property[2] = {
>>>
>>> If there's a newline here..
>>>
>>>> +                cpu_to_be64(phb->nvgpus->gpus[i].gpa), cpu_to_be64(nv2_size) };
>>>
>>> ..there should be one here ...................................................^
>>>
>>>> +
>>>> +            mem_name = g_strdup_printf("memory@%lx", phb->nvgpus->gpus[i].gpa);
>>>> +            off = fdt_add_subnode(fdt, 0, mem_name);
>>>> +            _FDT(off);
>>>> +            _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
>>>> +            _FDT((fdt_setprop(fdt, off, "reg", mem_reg_property,
>>>> +                              sizeof(mem_reg_property))));
>>>> +            _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
>>>> +                              sizeof(associativity))));
>>>> +
>>>> +            _FDT((fdt_setprop_string(fdt, off, "compatible",
>>>> +                                     "ibm,coherent-device-memory")));
>>>> +            mem_reg_property[1] = 0;
>>>> +            _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg_property,
>>>> +                              sizeof(mem_reg_property))));
>>>> +            _FDT((fdt_setprop_cell(fdt, off, "phandle",
>>>> +                                   PHANDLE_GPURAM(phb, i))));
>>>> +
>>>> +            g_free(mem_name);
>>>> +        }
>>>> +
>>>> +        /* Add NPUs with links underneath */
>>>> +        if (phb->nvgpus->num) {
>>>> +            char *npuname = g_strdup_printf("npuphb%d", phb->index);
>>>> +            int npuoff = fdt_add_subnode(fdt, 0, npuname);
>>>> +            int linkidx = 0;
>>>> +
>>>> +            _FDT(npuoff);
>>>> +            _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
>>>> +            _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
>>>> +            /* Advertise NPU as POWER9 so the guest can enable NPU2 contexts */
>>>> +            _FDT((fdt_setprop_string(fdt, npuoff, "compatible",
>>>> +                                     "ibm,power9-npu")));
>>>> +            g_free(npuname);
>>>> +
>>>> +            for (i = 0; i < phb->nvgpus->num; ++i) {
>>>> +                for (j = 0; j < phb->nvgpus->gpus[i].links; ++j) {
>>>
>>> Here you assume that every entry up to nvgpus->num is populated, which
>>> you didn't elsewhere in the code.
>>
>> Populated or half populated. Here I expose one NVLink per one passed
>> through IBM bridge, this ignores whether or not there is a GPU. There
>> should be a GPU and if there is none, then skiboot won't create the
>> bridges so I can have additional tests here but they won't fail and not
>> having them won't break things apart.
> 
> Ah, ok, I think I misunderstood this.
> 
>>>
>>>> +                    char *linkname = g_strdup_printf("link@%d", linkidx);
>>>> +                    int off = fdt_add_subnode(fdt, npuoff, linkname);
>>>> +
>>>> +                    _FDT(off);
>>>> +                    _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx)));
>>>
>>> Generally it's better to base 'reg' off some absolute property rather
>>> than arbitrary index.  Could you derive linkidx from i & j instead?
>>
>> I can probably just ditch this one.
>>
>>>
>>>> +                    _FDT((fdt_setprop_string(fdt, off, "compatible",
>>>> +                                             "ibm,npu-link")));
>>>> +                    _FDT((fdt_setprop_cell(fdt, off, "phandle",
>>>> +                                           PHANDLE_NVLINK(phb, i, j))));
>>>> +                    _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index",
>>>> +                                           linkidx)));
>>>> +                    g_free(linkname);
>>>> +                    ++linkidx;
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +
>>>> +        /* Finally, when we finished with the device tree, map subregions */
>>>
>>> Shouldn't be in a device tree function.
>>>
>>>> +        for (i = 0; i < phb->nvgpus->num; ++i) {
>>>> +            PCIDevice *gpdev = phb->nvgpus->gpus[i].gpdev;
>>>> +            Object *nv_mrobj = object_property_get_link(OBJECT(gpdev),
>>>> +                                                        "nvlink2-mr[0]", NULL);
>>>> +
>>>> +            if (nv_mrobj) {
>>>> +                memory_region_add_subregion(get_system_memory(),
>>>> +                                            phb->nvgpus->gpus[i].gpa,
>>>> +                                            MEMORY_REGION(nv_mrobj));
>>>> +            }
>>>> +            for (j = 0; j < phb->nvgpus->gpus[i].links; ++j) {
>>>> +                PCIDevice *npdev = phb->nvgpus->gpus[i].npdev[j];
>>>> +                Object *atsd_mrobj;
>>>> +                atsd_mrobj = object_property_get_link(OBJECT(npdev),
>>>> +                                                    "nvlink2-atsd-mr[0]",
>>>> +                                                    NULL);
>>>> +                if (atsd_mrobj) {
>>>> +                    hwaddr atsd_gpa = phb->nvgpus->gpus[i].atsd_gpa[j];
>>>> +
>>>> +                    memory_region_add_subregion(get_system_memory(), atsd_gpa,
>>>> +                                                MEMORY_REGION(atsd_mrobj));
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +    } /* if (phb->nvgpus) */
>>>> +
>>>>      return 0;
>>>>  }
>>>>  
>>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>>> index 40a1200..faeb9c5 100644
>>>> --- a/hw/vfio/pci-quirks.c
>>>> +++ b/hw/vfio/pci-quirks.c
>>>> @@ -2180,3 +2180,123 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>>>>  
>>>>      return 0;
>>>>  }
>>>> +
>>>> +static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
>>>> +                                     const char *name,
>>>> +                                     void *opaque, Error **errp)
>>>> +{
>>>> +    uint64_t tgt = (uint64_t) opaque;
>>>> +    visit_type_uint64(v, name, &tgt, errp);
>>>> +}
>>>> +
>>>> +static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
>>>> +                                                 const char *name,
>>>> +                                                 void *opaque, Error **errp)
>>>> +{
>>>> +    uint32_t link_speed = (uint32_t)(uint64_t) opaque;
>>>> +    visit_type_uint32(v, name, &link_speed, errp);
>>>> +}
>>>> +
>>>> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
>>>> +{
>>>> +    int ret;
>>>> +    void *p;
>>>> +    struct vfio_region_info *nv2region = NULL;
>>>> +    struct vfio_info_cap_header *hdr;
>>>> +    MemoryRegion *nv2mr = g_malloc0(sizeof(*nv2mr));
>>>> +
>>>> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
>>>> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
>>>> +                                   PCI_VENDOR_ID_NVIDIA,
>>>> +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM,
>>>> +                                   &nv2region);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    p = mmap(NULL, nv2region->size, PROT_READ | PROT_WRITE | PROT_EXEC,
>>>> +             MAP_SHARED, vdev->vbasedev.fd, nv2region->offset);
>>>> +
>>>> +    if (!p) {
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    memory_region_init_ram_ptr(nv2mr, OBJECT(vdev), "nvlink2-mr",
>>>> +                               nv2region->size, p);
>>>> +
>>>> +    hdr = vfio_get_region_info_cap(nv2region,
>>>> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
>>>> +    if (hdr) {
>>>> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap = (void *) hdr;
>>>> +
>>>> +        object_property_add(OBJECT(vdev), "tgt", "uint64",
>>>> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>>> +                            (void *) cap->tgt, NULL);
>>>> +        trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
>>>> +                                              nv2region->size);
>>>> +    }
>>>> +    g_free(nv2region);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
>>>> +{
>>>> +    int ret;
>>>> +    void *p;
>>>> +    struct vfio_region_info *atsd_region = NULL;
>>>> +    struct vfio_info_cap_header *hdr;
>>>> +
>>>> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
>>>> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
>>>> +                                   PCI_VENDOR_ID_IBM,
>>>> +                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
>>>> +                                   &atsd_region);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    /* Some NVLink bridges come without assigned ATSD, skip MR part */
>>>> +    if (atsd_region->size) {
>>>> +        MemoryRegion *atsd_mr = g_malloc0(sizeof(*atsd_mr));
>>>> +
>>>> +        p = mmap(NULL, atsd_region->size, PROT_READ | PROT_WRITE | PROT_EXEC,
>>>
>>> PROT_EXEC ?
>>
>> Yes, why? We can execute from that memory (nothing does now or probably
>> ever will but still can).
> 
> Hm, ok.
> 
>>>> +                 MAP_SHARED, vdev->vbasedev.fd, atsd_region->offset);
>>>> +
>>>> +        if (!p) {
>>>> +            return -errno;
>>>> +        }
>>>> +
>>>> +        memory_region_init_ram_device_ptr(atsd_mr, OBJECT(vdev),
>>>> +                                          "nvlink2-atsd-mr",
>>>> +                                          atsd_region->size,
>>>> +                                          p);
>>>> +    }
>>>> +
>>>> +    hdr = vfio_get_region_info_cap(atsd_region,
>>>> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
>>>> +    if (hdr) {
>>>> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap = (void *) hdr;
>>>> +
>>>> +        object_property_add(OBJECT(vdev), "tgt", "uint64",
>>>> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>>> +                            (void *) cap->tgt, NULL);
>>>> +        trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, cap->tgt,
>>>> +                                                  atsd_region->size);
>>>> +    }
>>>> +
>>>> +    hdr = vfio_get_region_info_cap(atsd_region,
>>>> +                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
>>>> +    if (hdr) {
>>>> +        struct vfio_region_info_cap_nvlink2_lnkspd *cap = (void *) hdr;
>>>> +
>>>> +        object_property_add(OBJECT(vdev), "link_speed", "uint32",
>>>> +                            vfio_pci_nvlink2_get_link_speed, NULL, NULL,
>>>> +                            (void *) (uint64_t) cap->link_speed, NULL);
>>>> +        trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
>>>> +                                                  cap->link_speed);
>>>> +    }
>>>> +    g_free(atsd_region);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index dd12f36..07aa141 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3069,6 +3069,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>>          goto out_teardown;
>>>>      }
>>>>  
>>>> +    if (vdev->vendor_id == PCI_VENDOR_ID_NVIDIA) {
>>>
>>> Surely we should be checking device id as well as vendor.  nVidia
>>> makes a lot of cards and most of them don't do nvlink2.
>>
>> If they do not - the host driver will return an error, end of story. Why
>> is this approach exactly bad?
> 
> I guess.  In that case why not just call the probe unconditionally?


Because vendor id is lot more stable than a device id. I'd like to
filter my target devices somehow here and only do probing for what has a
chance to support coherent memory but there is nothing related in the
config space either.


>>>> +        ret = vfio_pci_nvidia_v100_ram_init(vdev, errp);
>>>> +        if (ret && ret != -ENODEV) {
>>>> +            error_report("Failed to setup NVIDIA V100 GPU RAM");
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (vdev->vendor_id == PCI_VENDOR_ID_IBM) {
>>>
>>> And IBM makes even more.
>>
>> Same here - the driver just errors out.
>>
>>
>> I'll fix the rest of the comments. Thanks,
>>
>>
>>>
>>>> +        ret = vfio_pci_nvlink2_init(vdev, errp);
>>>> +        if (ret && ret != -ENODEV) {
>>>> +            error_report("Failed to setup NVlink2 bridge");
>>>> +        }
>>>> +    }
>>>> +
>>>>      vfio_register_err_notifier(vdev);
>>>>      vfio_register_req_notifier(vdev);
>>>>      vfio_setup_resetfn_quirk(vdev);
>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>> index 579be19..6866884 100644
>>>> --- a/hw/vfio/trace-events
>>>> +++ b/hw/vfio/trace-events
>>>> @@ -87,6 +87,10 @@ vfio_pci_igd_opregion_enabled(const char *name) "%s"
>>>>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>>>>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
>>>>  
>>>> +vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
>>>> +vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
>>>> +vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
>>>> +
>>>>  # hw/vfio/common.c
>>>>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>>>>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>>>
>>
> 

-- 
Alexey
