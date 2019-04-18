Received: from eggs.gnu.org ([209.51.188.92]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH3Z2-0007BR-Ee
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH3Z0-0006Yz-TV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:42:40 -0400
Date: Thu, 18 Apr 2019 11:42:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190418114224.5e1ea137@redhat.com>
In-Reply-To: <20190417014038.26018-5-richardw.yang@linux.intel.com>
References: <20190417014038.26018-1-richardw.yang@linux.intel.com>
	<20190417014038.26018-5-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/6] hw/arm/virt-acpi-build: pass
 AcpiMcfgInfo to build_mcfg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, yang.zhong@intel.com, philmd@redhat.com

On Wed, 17 Apr 2019 09:40:36 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> To build MCFG, two information is necessary:
>=20
>     * bus number
>     * base address
>=20
> Abstract these two information to AcpiMcfgInfo so that build_mcfg and
> build_mcfg_q35 will have the same declaration.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> ---
> v3:
>   * move AcpiMcfgInfo to pci.h
> v2:
>   * for arm platform, construct a AcpiMcfgInfo directly
> ---
>  hw/arm/virt-acpi-build.c | 18 +++++++++++-------
>  hw/i386/acpi-build.c     |  6 +-----
>  include/hw/acpi/pci.h    | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/acpi/pci.h
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e09e7eff8d..ebddcde596 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -40,6 +40,7 @@
>  #include "hw/hw.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/utils.h"
> +#include "hw/acpi/pci.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> @@ -546,21 +547,18 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
>  }
> =20
>  static void
> -build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
>      AcpiTableMcfg *mcfg;
> -    const MemMapEntry *memmap =3D vms->memmap;
> -    int ecam_id =3D VIRT_ECAM_ID(vms->highmem_ecam);
>      int len =3D sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> =20
>      mcfg =3D acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address =3D cpu_to_le64(memmap[ecam_id].base);
> +    mcfg->allocation[0].address =3D cpu_to_le64(info->base);
> =20
>      /* Only a single allocation so no need to play with segments */
>      mcfg->allocation[0].pci_segment =3D cpu_to_le16(0);
>      mcfg->allocation[0].start_bus_number =3D 0;
> -    mcfg->allocation[0].end_bus_number =3D
> -        PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
> +    mcfg->allocation[0].end_bus_number =3D PCIE_MMCFG_BUS(info->size - 1=
);
> =20
>      build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL,=
 NULL);
>  }
> @@ -801,7 +799,13 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
>      build_gtdt(tables_blob, tables->linker, vms);
> =20
>      acpi_add_table(table_offsets, tables_blob);
> -    build_mcfg(tables_blob, tables->linker, vms);
> +    {
> +        AcpiMcfgInfo mcfg =3D {
> +           .base =3D vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].base,
> +           .size =3D vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].size,
> +        };
> +        build_mcfg(tables_blob, tables->linker, &mcfg);
> +    }
> =20
>      acpi_add_table(table_offsets, tables_blob);
>      build_spcr(tables_blob, tables->linker, vms);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f0d27bffd6..c2de7f4b01 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -58,6 +58,7 @@
> =20
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/utils.h"
> +#include "hw/acpi/pci.h"
> =20
>  #include "qom/qom-qobject.h"
>  #include "hw/i386/amd_iommu.h"
> @@ -86,11 +87,6 @@
>  /* Default IOAPIC ID */
>  #define ACPI_BUILD_IOAPIC_ID 0x0
> =20
> -typedef struct AcpiMcfgInfo {
> -    uint64_t base;
> -    uint32_t size;
> -} AcpiMcfgInfo;
> -
>  typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> new file mode 100644
> index 0000000000..124af7d32a
> --- /dev/null
> +++ b/include/hw/acpi/pci.h
> @@ -0,0 +1,33 @@
> +/*
> + * Support for generating PCI related ACPI tables and passing them to Gu=
ests
> + *
> + * Copyright (C) 2006 Fabrice Bellard
> + * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
> + * Copyright (C) 2013-2019 Red Hat Inc
> + * Copyright (C) 2019 Intel Corporation
> + *
> + * Author: Wei Yang <richardw.yang@linux.intel.com>
> + * Author: Michael S. Tsirkin <mst@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef HW_ACPI_PCI_H
> +#define HW_ACPI_PCI_H
> +
> +typedef struct AcpiMcfgInfo {
> +    uint64_t base;
> +    uint32_t size;
> +} AcpiMcfgInfo;
> +
> +#endif
