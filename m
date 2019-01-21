Received: from eggs.gnu.org ([209.51.188.92]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1glaB9-0004XO-PV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1glaB8-0004HM-93
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:03:55 -0500
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-12-eric.auger@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392925E9@lhreml524-mbb.china.huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b766bfce-6d19-393e-8f36-2f9320162150@redhat.com>
Date: Mon, 21 Jan 2019 14:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392925E9@lhreml524-mbb.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 11/16] acpi: move
 build_srat_hotpluggable_memory to generic ACPI source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "kwangwoo.lee@sk.com" <kwangwoo.lee@sk.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "david@redhat.com" <david@redhat.com>
Cc: "drjones@redhat.com" <drjones@redhat.com>, Linuxarm <linuxarm@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Suzuki.Poulose@arm.com" <Suzuki.Poulose@arm.com>

Hi Shameer,

On 1/21/19 12:44 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
> As I informed you earlier, I am working on adding the hot-add support for pc-dimm
> and nvdimm on top of this series using the pl061 GPIO pins as a way to inject
> memory hot add events to the Guest. I came across a problem while testing
> my patches which looks like is related to the way SRAT entries are populated
> in this patch.
> 
> If I boot the Guest without NUMA and hot add dimms, all seems to be 
> working fine. But when I enable NUMA (-numa node,nodeid=0), and hot add
> dimms and perform a reboot, it fails.
> 
> Something like this,
> 
> ./qemu-system-aarch64 \
> -machine virt,kernel_irqchip=on,gic-version=3,nvdimm \
> -m 1G,maxmem=4G,slots=5 \
> -cpu host \
> -kernel Image \
> -bios QEMU_EFI.fd \
> -initrd rootfs-iperf.cpio \
> -numa node,nodeid=0 \
> -net none \
> -nographic -enable-kvm \
> -append "console=ttyAMA0 root=/dev/vda rw acpi=force"
> 
> Qemu Monitor:
> (qemu) object_add memory-backend-ram,id=mem1,size=1G
> (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
> 
> Exit QM and reboot the Guest.
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: Generating empty DTB
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
> [    0.000000] Linux version 4.20.0-rc3-dirty (shameer@shameer-ubuntu) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #21 SMP PREEMPT Wed Jan 16 14:45:58 GMT 2019
> [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
> [    0.000000] printk: bootconsole [pl11] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi:  SMBIOS 3.0=0x7f810000  MEMATTR=0x7c63ca98  MEMRESERVE=0x7bfeb018 
> [    0.000000] cma: Reserved 32 MiB at 0x000000007d000000
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: System description tables not found
> [    0.000000] ACPI: Failed to init ACPI tables
> [    0.000000] ACPI: NUMA: Failed to initialise from firmware
> 
> [...]
> 
> Debug shows that edk2 had a check[1] to verify the table size and it fails on reboot when
> NUMA is enabled(ie, SRAT is present),
> 
> ProcessCmdAddPointer: invalid pointer location or size in "etc/acpi/tables"
> 
> This seems to be related to the below code where SRAT is built,
> 
>> -----Original Message-----
>> From: Eric Auger [mailto:eric.auger@redhat.com]
>> Sent: 18 October 2018 15:31
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
>> qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> kwangwoo.lee@sk.com; imammedo@redhat.com; david@redhat.com
>> Cc: drjones@redhat.com; dgilbert@redhat.com; Suzuki.Poulose@arm.com
>> Subject: [RFC v4 11/16] acpi: move build_srat_hotpluggable_memory to generic
>> ACPI source
>>
>> We plan to reuse build_srat_hotpluggable_memory() for ARM so
>> let's move the function to aml-build.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/acpi/aml-build.c         | 51
>> +++++++++++++++++++++++++++++++++++++
>>  include/hw/acpi/aml-build.h |  3 +++
>>  2 files changed, 54 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 1e43cd736d..167fb6bf3e 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -22,6 +22,7 @@
>>  #include "qemu/osdep.h"
>>  #include <glib/gprintf.h>
>>  #include "hw/acpi/aml-build.h"
>> +#include "hw/mem/memory-device.h"
>>  #include "qemu/bswap.h"
>>  #include "qemu/bitops.h"
>>  #include "sysemu/numa.h"
>> @@ -1802,3 +1803,53 @@ build_hdr:
>>      build_header(linker, tbl, (void *)(tbl->data + fadt_start),
>>                   "FACP", tbl->len - fadt_start, f->rev, oem_id,
>> oem_table_id);
>>  }
>> +
>> +void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
>> +                                    uint64_t len, int default_node)
>> +{
>> +    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
>> +    MemoryDeviceInfoList *info;
>> +    MemoryDeviceInfo *mi;
>> +    PCDIMMDeviceInfo *di;
>> +    uint64_t end = base + len, cur, size;
>> +    bool is_nvdimm;
>> +    AcpiSratMemoryAffinity *numamem;
>> +    MemoryAffinityFlags flags;
>> +
>> +    for (cur = base, info = info_list;
>> +         cur < end;
>> +         cur += size, info = info->next) {
>> +        numamem = acpi_data_push(table_data, sizeof *numamem);
>> +
>> +        if (!info) {
>> +            build_srat_memory(numamem, cur, end - cur, default_node,
>> +                              MEM_AFFINITY_HOTPLUGGABLE |
>> MEM_AFFINITY_ENABLED);
>> +            break;
>> +        }
>> +
>> +        mi = info->value;
>> +        is_nvdimm = (mi->type ==
>> MEMORY_DEVICE_INFO_KIND_NVDIMM);
>> +        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
>> +
>> +        if (cur < di->addr) {
>> +            build_srat_memory(numamem, cur, di->addr - cur,
>> default_node,
>> +                              MEM_AFFINITY_HOTPLUGGABLE |
>> MEM_AFFINITY_ENABLED);
>> +            numamem = acpi_data_push(table_data, sizeof *numamem);
>> +        }
>> +
>> +        size = di->size;
>> +
>> +        flags = MEM_AFFINITY_ENABLED;
>> +        if (di->hotpluggable) {
>> +            flags |= MEM_AFFINITY_HOTPLUGGABLE;
>> +        }
>> +        if (is_nvdimm) {
>> +            flags |= MEM_AFFINITY_NON_VOLATILE;
>> +        }
>> +
>> +        build_srat_memory(numamem, di->addr, size, di->node, flags);
>> +    }
>> +
>> +    qapi_free_MemoryDeviceInfoList(info_list);
>> +}
> 
> The above logic changes the SRAT entries if dimm is hot-added and a reboot is
> performed and as mentioned above, EDK2 seems to be not happy with this.
> 
> I had a look at the pc code and it looks like it only has one SRAT entry for the 
> whole hot-pluggable address space[2] which probable means SRAT remains same
> across reboot even after mem is hot added. Not sure why we are doing this differently
> for ARM.

Initially this code was inpired from x86 code. Then Igor fixed it on x86
 with:
dbb6da8ba7e02105bdbb33b527e088249c9843c8  pc: acpi: revert back to 1
SRAT entry for hotpluggable area

So it looks the same change must be done on ARM.

I am currently busy with this respin. As suggested by David and Igor I
implemented the initial RAM as device memory. I am now looking at NUMA
impacts of that change.

Thanks

Eric
> 
> Please take a look and let me know your thoughts.
> 
> Thanks,
> Shameer
> 
> [1] https://github.com/tianocore/edk2/blob/master/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c#L459
> [2] https://github.com/eauger/qemu/blob/v3.0.0-dimm-2tb-v4/hw/i386/acpi-build.c#L2367
> 
> 
>> +
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index 6c36903c0a..4c2ca134ee 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -416,4 +416,7 @@ void build_slit(GArray *table_data, BIOSLinker *linker);
>>
>>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>>                  const char *oem_id, const char *oem_table_id);
>> +
>> +void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
>> +                                    uint64_t len, int default_node);
>>  #endif
>> --
>> 2.17.1
> 
> 
