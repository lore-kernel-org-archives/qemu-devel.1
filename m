Received: from eggs.gnu.org ([2001:4830:134:3::10]:43579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHDMv-0005Wp-EI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHDMr-0002wC-Qj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:38:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHDMl-0002uL-Dj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:38:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so10019601wrs.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:38:23 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-13-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9eb872d7-5677-5bca-2a88-eac99089e33a@redhat.com>
Date: Mon, 29 Oct 2018 20:38:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-13-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/19] hw: i386: Make the hotpluggable
 memory size property more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/10/18 18:01, Samuel Ortiz wrote:
> This property is currently defined under i386/pc while it only describes
> a region size that's eventually fetched from the AML ACPI code.
> 
> We can make it more generic and shareable across machine types by moving
> it to memory-device.h instead.

It makes sens if the next patch is accepted, which i'm not sure it will.

> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/i386/acpi-build.c           | 2 +-
>   hw/i386/pc.c                   | 3 ++-
>   include/hw/i386/pc.h           | 1 -
>   include/hw/mem/memory-device.h | 2 ++
>   4 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 414a6c4c4e..dfc02a8a85 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1630,7 +1630,7 @@ build_srat(GArray *table_data, BIOSLinker *linker,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
>       ram_addr_t hotplugabble_address_space_size =
> -        object_property_get_int(OBJECT(machine), PC_MACHINE_DEVMEM_REGION_SIZE,
> +        object_property_get_int(OBJECT(machine), MEMORY_DEVICE_REGION_SIZE,
>                                   NULL);
>   
>       srat_start = table_data->len;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bd4a77b856..1dcbbd5139 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -67,6 +67,7 @@
>   #include "hw/boards.h"
>   #include "acpi-build.h"
>   #include "hw/mem/pc-dimm.h"
> +#include "hw/mem/memory-device.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "qapi/visitor.h"
> @@ -2442,7 +2443,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       nc->nmi_monitor_handler = x86_nmi;
>       mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
>   
> -    object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> +    object_class_property_add(oc, MEMORY_DEVICE_REGION_SIZE, "int",
>           pc_machine_get_device_memory_region_size, NULL,
>           NULL, NULL, &error_abort);
>   
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index da0bd39741..7d177cd207 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -62,7 +62,6 @@ struct PCMachineState {
>   };
>   
>   #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
> -#define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
>   #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
>   #define PC_MACHINE_VMPORT           "vmport"
>   #define PC_MACHINE_SMM              "smm"
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index e904e194d5..d9a4fc7c3e 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -97,6 +97,8 @@ typedef struct MemoryDeviceClass {
>                                MemoryDeviceInfo *info);
>   } MemoryDeviceClass;
>   
> +#define MEMORY_DEVICE_REGION_SIZE "memory-device-region-size"
> +
>   MemoryDeviceInfoList *qmp_memory_device_list(void);
>   uint64_t get_plugged_memory_size(void);
>   void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
> 
