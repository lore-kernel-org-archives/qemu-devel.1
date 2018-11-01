Received: from eggs.gnu.org ([2001:4830:134:3::10]:55925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIEdz-0005d6-QC
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIEdr-00065S-MK
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:12:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIEdr-000643-4K
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:12:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id h2-v6so1691041wmb.0
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 08:12:13 -0700 (PDT)
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-18-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68eae1f8-ca6a-d096-c9ac-d492e4523c7c@redhat.com>
Date: Thu, 1 Nov 2018 16:12:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181101102303.16439-18-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 17/23] hw: i386: Export the MADT build
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Samuel,

On 1/11/18 11:22, Samuel Ortiz wrote:
> It is going to be used by the PC machine type as the MADT table builder
> method and thus needs to be exported outside of acpi-build.c
> 
> Also, now that the generic build_madt() API is exported, we have to
> rename the ARM static one in order to avoid build time conflicts.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/arm/virt-acpi-build.c |  4 ++--
>   hw/i386/acpi-build.c     |  3 ++-
>   include/hw/i386/acpi.h   | 27 +++++++++++++++++++++++++++
>   3 files changed, 31 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/i386/acpi.h
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f9a60907f1..4a37c5997c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -565,7 +565,7 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   
>   /* MADT */
>   static void
> -build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +virt_build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       int madt_start = table_data->len;
> @@ -746,7 +746,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>       build_fadt_rev5(tables_blob, tables->linker, vms, dsdt);
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    build_madt(tables_blob, tables->linker, vms);
> +    virt_build_madt(tables_blob, tables->linker, vms);
>   
>       acpi_add_table(table_offsets, tables_blob);
>       build_gtdt(tables_blob, tables->linker, vms);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6c9b61cea2..f4afdbcd1a 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -60,6 +60,7 @@
>   #include "qom/qom-qobject.h"
>   #include "hw/i386/amd_iommu.h"
>   #include "hw/i386/intel_iommu.h"
> +#include "hw/i386/acpi.h"
>   
>   #include "hw/acpi/ipmi.h"
>   
> @@ -279,7 +280,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>       }
>   }
>   
> -static void
> +void
>   build_madt(GArray *table_data, BIOSLinker *linker,
>              MachineState *ms, AcpiConfiguration *acpi_conf)
>   {
> diff --git a/include/hw/i386/acpi.h b/include/hw/i386/acpi.h
> new file mode 100644
> index 0000000000..ee1203914a
> --- /dev/null
> +++ b/include/hw/i386/acpi.h
> @@ -0,0 +1,27 @@
> +/*
> + *
> + * Copyright (c) 2018 Intel Corportation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_I386_ACPI_H
> +#define HW_I386_ACPI_H
> +
> +#include "hw/acpi/acpi.h"

You forgot the following header:

#include "hw/acpi/bios-linker-loader.h"

The BIOSLinker is not provided by "acpi/acpi.h", which results in a 
failure when trying to precompile this header.

> +
> +/* ACPI MADT (Multiple APIC Description Table) build method */
> +void build_madt(GArray *table_data, BIOSLinker *linker,
> +                MachineState *ms, AcpiConfiguration *conf);
> +
> +#endif
> 
