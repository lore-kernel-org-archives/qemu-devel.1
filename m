Received: from eggs.gnu.org ([2001:4830:134:3::10]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHEvX-0000F2-Ua
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHEvQ-0006w8-5K
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:18:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHEvO-0006vs-Fu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:18:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so9707903wmc.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 14:18:14 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-19-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f0e52184-3bbf-98e1-260c-ad3c6d577252@redhat.com>
Date: Mon, 29 Oct 2018 22:18:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-19-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 18/19] hw: i386: Export the MADT build
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi Samuel,

On 29/10/18 18:01, Samuel Ortiz wrote:
> It is going to be used by the PC machine type as the MADT table builder
> method and thus needs to be exported outside of acpi-build.c
> 
> Also, now that the generic build_madt() API is exported, we have to
> rename the ARM static one in order to avoid build time conflicts.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/arm/virt-acpi-build.c |  4 ++--
>   hw/i386/acpi-build.c     |  3 ++-
>   include/hw/i386/acpi.h   | 27 +++++++++++++++++++++++++++
>   3 files changed, 31 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/i386/acpi.h
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 353aa55357..0c349e1c60 100644
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
> index 9cb739bf5c..5035dac556 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -62,6 +62,7 @@
>   #include "qom/qom-qobject.h"
>   #include "hw/i386/amd_iommu.h"
>   #include "hw/i386/intel_iommu.h"
> +#include "hw/i386/acpi.h"
>   
>   #include "hw/acpi/ipmi.h"
>   
> @@ -281,7 +282,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>       }
>   }
>   
> -static void
> +void
>   build_madt(GArray *table_data, BIOSLinker *linker,
>              MachineState *ms, AcpiConfiguration *conf)
>   {
> diff --git a/include/hw/i386/acpi.h b/include/hw/i386/acpi.h
> new file mode 100644
> index 0000000000..53bf94c3ca
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
> +#ifndef QEMU_I386_ACPI_H
> +#define QEMU_I386_ACPI_H

Please use HW_I386_ACPI_H.

> +
> +#include "hw/acpi/acpi.h"

Also:

  #include "hw/acpi/bios-linker-loader.h"

> +
> +/* Build methods */

  /* Build the ACPI MADT (Multiple APIC Description Table) methods */

> +void build_madt(GArray *table_data, BIOSLinker *linker,
> +                MachineState *ms, AcpiConfiguration *conf);
> +
> +#endif
> 

With changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
