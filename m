Received: from eggs.gnu.org ([2001:4830:134:3::10]:48263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPlGk-00043x-8E
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPlEm-0007JA-Nu
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:25:29 -0500
References: <20181109112957.10067-1-eric.auger@redhat.com>
	<20181109112957.10067-16-eric.auger@redhat.com>
	<VI1PR04MB484558FC4BF5E01E9EB35E8F9ADB0@VI1PR04MB4845.eurprd04.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3996db72-00a5-600c-a1d3-1415b2b55ebd@redhat.com>
Date: Thu, 22 Nov 2018 10:25:12 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB484558FC4BF5E01E9EB35E8F9ADB0@VI1PR04MB4845.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v8 15/18] hw/arm/virt: Add virtio-iommu to
 the virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>, "tn@semihalf.com" <tn@semihalf.com>, "peterx@redhat.com" <peterx@redhat.com>

Hi Bharat,

On 11/22/18 10:15 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
> 
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Friday, November 9, 2018 5:00 PM
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
>> mst@redhat.com; jean-philippe.brucker@arm.com
>> Cc: kevin.tian@intel.com; tn@semihalf.com; Bharat Bhushan
>> <bharat.bhushan@nxp.com>; peterx@redhat.com
>> Subject: [RFC v8 15/18] hw/arm/virt: Add virtio-iommu to the virt board
>>
>> Both the virtio-iommu device and its dedicated mmio transport get
>> instantiated when requested.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v6 -> v7:
>> - align to the smmu instantiation code
>>
>> v4 -> v5:
>> - VirtMachineClass no_iommu added in this patch
>> - Use object_resolve_path_type
>> ---
>>  hw/arm/virt.c | 48
>> +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c index a2b8d8f7c2..f2994c4359
>> 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -29,6 +29,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "monitor/qdev.h"
>>  #include "qapi/error.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/arm/arm.h"
>> @@ -49,6 +50,7 @@
>>  #include "qemu/bitops.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/pci-host/gpex.h"
>> +#include "hw/virtio/virtio-pci.h"
>>  #include "hw/arm/sysbus-fdt.h"
>>  #include "hw/platform-bus.h"
>>  #include "hw/arm/fdt.h"
>> @@ -59,6 +61,7 @@
>>  #include "qapi/visitor.h"
>>  #include "standard-headers/linux/input.h"
>>  #include "hw/arm/smmuv3.h"
>> +#include "hw/virtio/virtio-iommu.h"
>>
>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \ @@ -
>> 1085,6 +1088,33 @@ static void create_smmu(const VirtMachineState *vms,
>> qemu_irq *pic,
>>      g_free(node);
>>  }
>>
>> +static void create_virtio_iommu(VirtMachineState *vms,
>> +                                const char *pciehb_nodename, PCIBus
>> +*bus) {
>> +    const char compat[] = "virtio,pci-iommu";
>> +    uint16_t bdf = 0x8; /* 00:01.0 */
> 
> Why we hardcoded "bdf = 8" ?
> When adding the VFIO support I see virtio-iommu PCI device have bdf = x010.

This hardcoding has been removed. I will send a new version today.

Thanks

Eric
> 
> Thanks
> -Bharat
> 
>> +    DeviceState *dev;
>> +    char *node;
>> +
>> +    dev = qdev_create(BUS(bus), TYPE_VIRTIO_IOMMU_PCI);
>> +    object_property_set_bool(OBJECT(dev), true, "realized",
>> + &error_fatal);
>> +
>> +    node = g_strdup_printf("%s/virtio_iommu@%d", pciehb_nodename,
>> bdf);
>> +    qemu_fdt_add_subnode(vms->fdt, node);
>> +    qemu_fdt_setprop(vms->fdt, node, "compatible", compat,
>> sizeof(compat));
>> +    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg",
>> +                                 1, bdf << 8 /* phys.hi */,
>> +                                 1, 0        /* phys.mid */,
>> +                                 1, 0        /* phys.lo  */,
>> +                                 1, 0        /* size.hi  */,
>> +                                 1, 0        /* size.low */);
>> +
>> +    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
>> +    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms-
>>> iommu_phandle);
>> +    g_free(node);
>> +}
>> +
>> +
>>  static void create_pcie(VirtMachineState *vms, qemu_irq *pic)  {
>>      hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base; @@ -
>> 1205,10 +1235,22 @@ static void create_pcie(VirtMachineState *vms,
>> qemu_irq *pic)
>>      if (vms->iommu) {
>>          vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
>>
>> -        create_smmu(vms, pic, pci->bus);
>> +        switch (vms->iommu) {
>> +        case VIRT_IOMMU_SMMUV3:
>> +            create_smmu(vms, pic, pci->bus);
>> +            qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
>> +                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
>> +            break;
>> +        case VIRT_IOMMU_VIRTIO:
>> +            create_virtio_iommu(vms, nodename, pci->bus);
>> +            qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
>> +                                   0x0, vms->iommu_phandle, 0x0, 0x8,
>> +                                   0x9, vms->iommu_phandle, 0x9, 0xfff7);
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>>
>> -        qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
>> -                               0x0, vms->iommu_phandle, 0x0, 0x10000);
>>      }
>>
>>      g_free(nodename);
>> --
>> 2.17.2
> 
