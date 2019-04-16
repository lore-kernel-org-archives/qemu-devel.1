Received: from eggs.gnu.org ([209.51.188.92]:39795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hGVpZ-0008FV-LW
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hGVpX-0000E4-No
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 17:41:29 -0400
Date: Tue, 16 Apr 2019 21:41:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190416214118.6gzdjgexqbamzodt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190415070307.13668-1-richardw.yang@linux.intel.com>
	<20190415070307.13668-5-richardw.yang@linux.intel.com>
	<c791df00-77fb-81b4-d351-58cf8fead676@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c791df00-77fb-81b4-d351-58cf8fead676@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/acpi: Extract build_mcfg to pci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe Mathieu-Daud?? <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, yang.zhong@intel.com, peter.maydell@linaro.org, imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com

On Mon, Apr 15, 2019 at 03:01:28PM +0200, Philippe Mathieu-Daud?? wrote:
>Hi Wei,
>
>On 4/15/19 9:03 AM, Wei Yang wrote:
>> Now we have two identical build_mcfg function.
>> 
>> Extract them to pci.c.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> 
>> ---
>> v2:
>>   * put it to dedicated file pci.c
>> ---
>>  default-configs/arm-softmmu.mak  |  1 +
>>  default-configs/i386-softmmu.mak |  1 +
>>  hw/acpi/Kconfig                  |  4 +++
>>  hw/acpi/Makefile.objs            |  1 +
>>  hw/acpi/pci.c                    | 46 ++++++++++++++++++++++++++++++++
>>  hw/arm/virt-acpi-build.c         | 18 +------------
>>  hw/i386/acpi-build.c             | 19 ++-----------
>>  include/hw/acpi/pci.h            |  5 ++++
>>  8 files changed, 61 insertions(+), 34 deletions(-)
>>  create mode 100644 hw/acpi/pci.c
>>  create mode 100644 include/hw/acpi/pci.h
>> 
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index 613d19a06d..8f2796e195 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -144,6 +144,7 @@ CONFIG_XIO3130=y
>>  CONFIG_IOH3420=y
>>  CONFIG_I82801B11=y
>>  CONFIG_ACPI=y
>> +CONFIG_ACPI_PCI=y
>>  CONFIG_ARM_VIRT=y
>>  CONFIG_SMBIOS=y
>>  CONFIG_ASPEED_SOC=y
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>> index ba3fb3ff50..cd5ea391e8 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -25,3 +25,4 @@
>>  CONFIG_ISAPC=y
>>  CONFIG_I440FX=y
>>  CONFIG_Q35=y
>> +CONFIG_ACPI_PCI=y
>> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>> index eca3beed75..7265843cc3 100644
>> --- a/hw/acpi/Kconfig
>> +++ b/hw/acpi/Kconfig
>> @@ -23,6 +23,10 @@ config ACPI_NVDIMM
>>      bool
>>      depends on ACPI
>>  
>> +config ACPI_PCI
>> +    bool
>> +    depends on ACPI
>> +
>>  config ACPI_VMGENID
>>      bool
>>      default y
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index ba93c5b64a..9bb2101e3b 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>>  common-obj-y += acpi_interface.o
>>  common-obj-y += bios-linker-loader.o
>>  common-obj-y += aml-build.o utils.o
>> +common-obj-$(CONFIG_ACPI_PCI) += pci.o
>>  common-obj-$(CONFIG_TPM) += tpm.o
>>  
>>  common-obj-$(CONFIG_IPMI) += ipmi.o
>> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>> new file mode 100644
>> index 0000000000..fa0fa30bb9
>> --- /dev/null
>> +++ b/hw/acpi/pci.c
>> @@ -0,0 +1,46 @@
>> +/*
>> + * Support for generating PCI related ACPI tables and passing them to Guests
>> + *
>> + * Copyright (C) 2006 Fabrice Bellard
>> + * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
>> + * Copyright (C) 2013-2019 Red Hat Inc
>> + * Copyright (C) 2019 Intel Corporation
>> + *
>> + * Author: Wei Yang <richardw.yang@linux.intel.com>
>> + * Author: Michael S. Tsirkin <mst@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> +
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>
>Here you correctly added the copyright boilerplate, ...
>
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/pci.h"
>> +#include "hw/pci/pcie_host.h"
>> +
>> +void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>> +{
>> +    AcpiTableMcfg *mcfg;
>> +    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>> +
>> +    mcfg = acpi_data_push(table_data, len);
>> +    mcfg->allocation[0].address = cpu_to_le64(info->base);
>> +
>> +    /* Only a single allocation so no need to play with segments */
>> +    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>> +    mcfg->allocation[0].start_bus_number = 0;
>> +    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>> +
>> +    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>> +}
>> +
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 7350f207b5..e3353de9e4 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -40,6 +40,7 @@
>>  #include "hw/hw.h"
>>  #include "hw/acpi/aml-build.h"
>>  #include "hw/acpi/utils.h"
>> +#include "hw/acpi/pci.h"
>>  #include "hw/pci/pcie_host.h"
>>  #include "hw/pci/pci.h"
>>  #include "hw/arm/virt.h"
>> @@ -545,23 +546,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>>  }
>>  
>> -static void
>> -build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>> -{
>> -    AcpiTableMcfg *mcfg;
>> -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>> -
>> -    mcfg = acpi_data_push(table_data, len);
>> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
>> -
>> -    /* Only a single allocation so no need to play with segments */
>> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>> -    mcfg->allocation[0].start_bus_number = 0;
>> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>> -
>> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>> -}
>> -
>>  /* GTDT */
>>  static void
>>  build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 7613b245cf..29980bb3f4 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -58,6 +58,7 @@
>>  
>>  #include "hw/acpi/aml-build.h"
>>  #include "hw/acpi/utils.h"
>> +#include "hw/acpi/pci.h"
>>  
>>  #include "qom/qom-qobject.h"
>>  #include "hw/i386/amd_iommu.h"
>> @@ -2392,22 +2393,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>                   table_data->len - srat_start, 1, NULL, NULL);
>>  }
>>  
>> -static void
>> -build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>> -{
>> -    AcpiTableMcfg *mcfg;
>> -    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>> -
>> -    mcfg = acpi_data_push(table_data, len);
>> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
>> -    /* Only a single allocation so no need to play with segments */
>> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>> -    mcfg->allocation[0].start_bus_number = 0;
>> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>> -
>> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>> -}
>> -
>>  /*
>>   * VT-d spec 8.1 DMA Remapping Reporting Structure
>>   * (version Oct. 2014 or later)
>> @@ -2677,7 +2662,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>      }
>>      if (acpi_get_mcfg(&mcfg)) {
>>          acpi_add_table(table_offsets, tables_blob);
>> -        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
>> +        build_mcfg(tables_blob, tables->linker, &mcfg);
>>      }
>>      if (x86_iommu_get_default()) {
>>          IommuType IOMMUType = x86_iommu_get_type();
>> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
>> new file mode 100644
>> index 0000000000..6f94ac4926
>> --- /dev/null
>> +++ b/include/hw/acpi/pci.h
>> @@ -0,0 +1,5 @@
>> +#ifndef HW_ACPI_PCI_H
>> +#define HW_ACPI_PCI_H
>
>But here you missed it :(
>

Ah, ok, I will add the copyright. Thanks :-)

>> +
>> +void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info);
>> +#endif
>> 
>
>With the same copyright notice in the header:
>Reviewed-by: Philippe Mathieu-Daud?? <philmd@redhat.com>
>
>Regards,
>
>Phil.

-- 
Wei Yang
Help you, Help me
