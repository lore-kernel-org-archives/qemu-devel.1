Received: from eggs.gnu.org ([2001:4830:134:3::10]:55763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOdiV-000419-Bz
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOdiS-00043g-D5
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:06:59 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eOdiR-000438-4M
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 01:06:56 -0500
Received: by mail-it0-x242.google.com with SMTP id d16so21622687itj.1
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 22:06:55 -0800 (PST)
References: <20171212052131.24649-1-aik@ozlabs.ru>
	<20171211225411.6fd08ff8@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <60d96072-55c2-93fd-3cf7-011abf4926e1@ozlabs.ru>
Date: Tue, 12 Dec 2017 17:06:49 +1100
MIME-Version: 1.0
In-Reply-To: <20171211225411.6fd08ff8@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 12/12/17 16:54, Alex Williamson wrote:
> On Tue, 12 Dec 2017 16:21:31 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
>> which tells that a region with MSIX data can be mapped entirely, i.e.
>> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
>>
>> This adds a "msix-no-mmap" property to the vfio-pci device, it is "true"
>> by default and "false" for pseries-2.12+ machines.
>>
>> This requites kernel's "vfio-pci: Allow mapping MSIX BAR"
>> https://www.spinics.net/lists/kvm/msg160282.html
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This is an RFC as it requires kernel headers update which is not there yet.
>>
>> I'd like to make it "msix-mmap" (without "no") but could not find a way
>> of enabling a device property for machine versions newer than some value.
>>
>> I changed 2.11 machine just for the demonstration purpose.
>>
>>
>> ---
>>  hw/vfio/pci.h                 |  1 +
>>  include/hw/vfio/vfio-common.h |  1 +
>>  linux-headers/linux/vfio.h    |  5 +++++
>>  hw/ppc/spapr.c                | 10 +++++++++-
>>  hw/vfio/common.c              | 15 +++++++++++++++
>>  hw/vfio/pci.c                 | 11 +++++++++++
>>  6 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index a8fb3b3..53912ef 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
>>      bool no_kvm_intx;
>>      bool no_kvm_msi;
>>      bool no_kvm_msix;
>> +    bool msix_no_mmap;
>>  } VFIOPCIDevice;
>>  
>>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index f3a2ac9..927d600 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>>                           struct vfio_region_info **info);
>>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>>                               uint32_t subtype, struct vfio_region_info **info);
>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region);
>>  #endif
>>  extern const MemoryListener vfio_prereg_listener;
>>  
>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>> index 4e7ab4c..bce9baf 100644
>> --- a/linux-headers/linux/vfio.h
>> +++ b/linux-headers/linux/vfio.h
>> @@ -300,6 +300,11 @@ struct vfio_region_info_cap_type {
>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>>  
>> +/*
>> + * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped.
>> + */
>> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
>> +
>>  /**
>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
>>   *				    struct vfio_irq_info)
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 9de63f0..1dfc386 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3742,13 +3742,21 @@ static const TypeInfo spapr_machine_info = {
>>  /*
>>   * pseries-2.11
>>   */
>> +#define SPAPR_COMPAT_2_11                                             \
>> +    HW_COMPAT_2_10                                                    \
>> +    {                                                                 \
>> +        .driver = "vfio-pci",                                         \
>> +        .property = "msix-no-mmap",                                   \
>> +        .value    = "on",                                             \
>> +    },                                                                \
>> +
>>  static void spapr_machine_2_11_instance_options(MachineState *machine)
>>  {
>>  }
>>  
>>  static void spapr_machine_2_11_class_options(MachineClass *mc)
>>  {
>> -    /* Defaults for the latest behaviour inherited from the base class */
>> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>>  }
>>  
>>  DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index ed7717d..593514c 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1408,6 +1408,21 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>>      return -ENODEV;
>>  }
>>  
>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, int region)
>> +{
>> +        struct vfio_region_info *info = NULL;
>> +        bool ret = false;
>> +
>> +        if (!vfio_get_region_info(vbasedev, region, &info)) {
>> +            if (vfio_get_region_info_cap(info, cap_type)) {
>> +                ret = true;
>> +            }
>> +            g_free(info);
>> +        }
>> +
>> +        return ret;
>> +}
>> +
>>  /*
>>   * Interfaces for IBM EEH (Enhanced Error Handling)
>>   */
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index c977ee3..d9aeae8 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1289,6 +1289,12 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>>      off_t start, end;
>>      VFIORegion *region = &vdev->bars[vdev->msix->table_bar].region;
>>  
>> +    if (!vdev->msix_no_mmap &&
>> +        vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MSIX_MAPPABLE,
>> +                            vdev->msix->table_bar)) {
>> +        return;
>> +    }
>> +
>>      /*
>>       * We expect to find a single mmap covering the whole BAR, anything else
>>       * means it's either unsupported or already setup.
>> @@ -1473,6 +1479,10 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>>       */
>>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
>>  
>> +    if (!vdev->msix_no_mmap) {
>> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
>> +    }
> 
> No, you're conflating issues.  There's (a) can we mmap over the MSI-X
> vector table and (b) do we require QEMU emulation of the MSI-X vector
> table.  (a) does NOT imply (b).  AFAICT, (a) should be enabled any time
> the kernel supports it,

This is the default setting, or you do not want it to be a property so the
user cannot shoot himself in a foot?

> (b) should never be enabled on ppc, regardless
> of (a).  Thanks,


The intention is to have a property - msix_no_mmap=true, except a single
case - ppc-pseries, I just do not know how to enforce it for a specific
machine type. It could also be a machine property, like "kernel_irqchip".



> 
> Alex
> 
>> +
>>      return 0;
>>  }
>>  
>> @@ -2986,6 +2996,7 @@ static Property vfio_pci_dev_properties[] = {
>>      DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>> +    DEFINE_PROP_BOOL("msix-no-mmap", VFIOPCIDevice, msix_no_mmap, true),
>>      DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>>      DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>>      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
> 


-- 
Alexey
