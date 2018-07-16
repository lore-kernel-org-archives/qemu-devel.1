Received: from eggs.gnu.org ([2001:4830:134:3::10]:55732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff24u-0001Nl-8H
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ff24r-0003tL-3E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:54:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ff24q-0003t6-Pz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:54:05 -0400
Date: Mon, 16 Jul 2018 13:54:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180716135400.4e7f7d7b@redhat.com>
In-Reply-To: <1529421657-14969-2-git-send-email-jingqi.liu@intel.com>
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
	<1529421657-14969-2-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 RESEND 1/6] hmat acpi: Build Memory
 Subsystem Address Range Structure(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>
Cc: ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, armbru@redhat.com, qemu-devel@nongnu.org

On Tue, 19 Jun 2018 23:20:52 +0800
Liu Jingqi <jingqi.liu@intel.com> wrote:

> HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Table (HMAT).
> The specification references below link:
> http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 
> It describes the memory attributes, such as memory side cache
> attributes and bandwidth and latency details, related to the
> System Physical Address (SPA) Memory Ranges. The software is
> expected to use this information as hint for optimization.
> 
> This structure describes the System Physical Address(SPA) range
> occupied by memory subsystem and its associativity with processor
> proximity domain as well as hint for memory usage.
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> ---
>  default-configs/x86_64-softmmu.mak |   1 +
>  hw/acpi/Makefile.objs              |   1 +
>  hw/acpi/hmat.c                     | 139 +++++++++++++++++++++++++++++++++++++
>  hw/acpi/hmat.h                     |  73 +++++++++++++++++++
>  hw/i386/acpi-build.c               | 120 ++++++++++++++++++++------------
>  hw/i386/acpi-build.h               |  10 +++
>  include/sysemu/numa.h              |   2 +
>  numa.c                             |   6 ++
>  8 files changed, 307 insertions(+), 45 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h
> 
> diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> index 0390b43..3b4a37d 100644
> --- a/default-configs/x86_64-softmmu.mak
> +++ b/default-configs/x86_64-softmmu.mak
> @@ -66,3 +66,4 @@ CONFIG_I2C=y
>  CONFIG_SEV=$(CONFIG_KVM)
>  CONFIG_VTD=y
>  CONFIG_AMD_IOMMU=y
> +CONFIG_ACPI_HMAT=y
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 11c35bc..21889fd 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
> +common-obj-$(CONFIG_ACPI_HMAT) += hmat.o
>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>  
>  common-obj-y += acpi_interface.o
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> new file mode 100644
> index 0000000..d4e586d
> --- /dev/null
> +++ b/hw/acpi/hmat.c
> @@ -0,0 +1,139 @@
> +/*
> + * HMAT ACPI Implementation
> + *
> + * Copyright(C) 2018 Intel Corporation.
> + *
> + * Author:
> + *  Liu jingqi <jingqi.liu@linux.intel.com>
> + *
> + * HMAT is defined in ACPI 6.2.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "unistd.h"
> +#include "fcntl.h"
> +#include "qemu/osdep.h"
> +#include "sysemu/numa.h"
> +#include "hw/i386/pc.h"
> +#include "hw/i386/acpi-build.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/hmat.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/acpi/bios-linker-loader.h"
Do all this headers are really needed here?


> +/* Build Memory Subsystem Address Range Structure */
> +static void hmat_build_spa_info(GArray *table_data,
> +                                uint64_t base, uint64_t length, int node)
how about:

s/hmat_build_spa_info/build_hmat_spa/

1st put 'build_" prefix then table "hmat_" prefix and at last entry name
and drop any else.

and similar changes to other function names

> +{
> +    uint16_t flags = 0;
> +
> +    if (numa_info[node].is_initiator) {
> +        flags |= HMAT_SPA_PROC_VALID;
> +    }
> +    if (numa_info[node].is_target) {
> +        flags |= HMAT_SPA_MEM_VALID;
> +    }
SPA entry doesn't care about node at all,
I'd figure flags value in the caller and pass it to hmat_build_spa_info()
as an argument

> +
> +    /* Type */
> +    build_append_int_noprefix(table_data, ACPI_HMAT_SPA, sizeof(uint16_t));
sizeof(type) here and below is rater pointless,
just use hardcoded numbers here, so it would be closer to spec table
also  ACPI_HMAT_SPA is used only once and probably won't be ever reused
so I'd replace it wit a number and comment being verbatim copy from Sspec
like:

   /* Memory Subsystem Address Range Structure */
   build_append_int_noprefix(table_data, 0, 2);



> +    /* Reserved0 */
there is no Reseved0 in spec

> +    build_append_int_noprefix(table_data, 0, sizeof(uint16_t));
> +    /* Length */
> +    build_append_int_noprefix(table_data, sizeof(AcpiHmatSpaRange),
replace sizeof(AcpiHmatSpaRange) with a number from spec and drop 
AcpiHmatSpaRange altogether

> +                              sizeof(uint32_t));
> +    /* Flags */
> +    build_append_int_noprefix(table_data, flags, sizeof(uint16_t));
> +    /* Reserved1 */
s/Reserved1/Reserved/

> +    build_append_int_noprefix(table_data, 0, sizeof(uint16_t));
> +    /* Process Proximity Domain */
> +    build_append_int_noprefix(table_data, node, sizeof(uint32_t));
> +    /* Memory Proximity Domain */
> +    build_append_int_noprefix(table_data, node, sizeof(uint32_t));
> +    /* Reserved2 */
> +    build_append_int_noprefix(table_data, 0, sizeof(uint32_t));
> +    /* System Physical Address Range Base */
> +    build_append_int_noprefix(table_data, base, sizeof(uint64_t));
> +    /* System Physical Address Range Length */
> +    build_append_int_noprefix(table_data, length, sizeof(uint64_t));
> +}
> +
> +static int pc_dimm_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> +        *list = g_slist_append(*list, DEVICE(obj));
> +    }
> +
> +    object_child_foreach(obj, pc_dimm_device_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * The Proximity Domain of System Physical Address ranges defined
> + * in the HMAT, NFIT and SRAT tables shall match each other.
> + */
> +static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
function is used only once, move its body inside of the caller

> +{
> +    GSList *device_list = NULL;
> +    uint64_t mem_base, mem_len;
> +    int i;
> +
> +    if (pcms->numa_nodes && !mem_ranges_number) {
> +        build_mem_ranges(pcms);
> +    }
> +
> +    for (i = 0; i < mem_ranges_number; i++) {
> +        hmat_build_spa_info(table_data, mem_ranges[i].base,
> +                            mem_ranges[i].length, mem_ranges[i].node);
> +    }
> +
> +    /* Build HMAT SPA structures for PC-DIMM devices. */
> +    object_child_foreach(qdev_get_machine(), pc_dimm_device_list, &device_list);
> +
> +    for (; device_list; device_list = device_list->next) {
> +        PCDIMMDevice *dimm = device_list->data;
> +        mem_base = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> +                                            NULL);
> +        mem_len = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
> +                                           NULL);
> +        i = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
> +        hmat_build_spa_info(table_data, mem_base, mem_len, i);
> +    }
> +}
> +
> +static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
the HMAT is not limited to PC, pls make it machine agnostic so
we could reuse it with virt arm machine


> +{
> +    /* Build HMAT Memory Subsystem Address Range. */
> +    hmat_build_spa(hma, pcms);
> +}
> +
> +void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
> +                     MachineState *machine)
> +{
> +    PCMachineState *pcms = PC_MACHINE(machine);
> +    uint64_t hmat_start, hmat_len;
> +
> +    hmat_start = table_data->len;
> +    acpi_data_push(table_data, sizeof(AcpiHmat));
> +
> +    hmat_build_hma(table_data, pcms);
> +    hmat_len = table_data->len - hmat_start;
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + hmat_start),
> +                 "HMAT", hmat_len, 1, NULL, NULL);
> +}
> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
> new file mode 100644
> index 0000000..096415d
> --- /dev/null
> +++ b/hw/acpi/hmat.h
> @@ -0,0 +1,73 @@
> +/*
> + * HMAT ACPI Implementation Header
> + *
> + * Copyright(C) 2018 Intel Corporation.
> + *
> + * Author:
> + *  Liu jingqi <jingqi.liu@linux.intel.com>
> + *
> + * HMAT is defined in ACPI 6.2.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#ifndef HMAT_H
> +#define HMAT_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/acpi-defs.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/acpi/aml-build.h"
make sure the all headers here are really needed

> +
> +#define ACPI_HMAT_SPA               0
> +
> +/* ACPI HMAT sub-structure header */
> +#define ACPI_HMAT_SUB_HEADER_DEF    \
> +    uint16_t  type;                 \
> +    uint16_t  reserved0;            \
> +    uint32_t  length;
> +
> +/* the values of AcpiHmatSpaRange flag */
> +enum {
> +    HMAT_SPA_PROC_VALID = 0x1,
> +    HMAT_SPA_MEM_VALID  = 0x2,
> +    HMAT_SPA_RESERVATION_HINT = 0x4,
> +};
> +
> +/*
> + * HMAT (Heterogeneous Memory Attributes Table)
> + */
> +struct AcpiHmat {
> +    ACPI_TABLE_HEADER_DEF
> +    uint32_t    reserved;
> +} QEMU_PACKED;
> +typedef struct AcpiHmat AcpiHmat;
> +
> +struct AcpiHmatSpaRange {
> +    ACPI_HMAT_SUB_HEADER_DEF
> +    uint16_t    flags;
> +    uint16_t    reserved1;
> +    uint32_t    proc_proximity;
> +    uint32_t    mem_proximity;
> +    uint32_t    reserved2;
> +    uint64_t    spa_base;
> +    uint64_t    spa_length;
> +} QEMU_PACKED;
> +typedef struct AcpiHmatSpaRange AcpiHmatSpaRange;
you aren't supposed to use above 2 structures to build table (drop them)

> +
> +void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
> +                     MachineState *machine);
> +
> +#endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9bc6d97..4cc9cc8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -64,6 +64,7 @@
>  #include "hw/i386/intel_iommu.h"
>  
>  #include "hw/acpi/ipmi.h"
> +#include "hw/acpi/hmat.h"
>  
>  /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
>   * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
> @@ -119,6 +120,14 @@ typedef struct AcpiBuildPciBusHotplugState {
>      bool pcihp_bridge_en;
>  } AcpiBuildPciBusHotplugState;
>  
> +/* The memory contains at least one hole
> + * from 640k-1M and possibly another one from 3.5G-4G.
> + * So far, the number of memory ranges is up to 2
> + * more than the number of numa nodes.
> + */
> +MemoryRange mem_ranges[MAX_NODES + 2];
> +uint32_t mem_ranges_number;
Pls do not introduce globals, allocate it dynamically and free when
it's not needed anymore.


>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>  {
>      uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> @@ -2300,6 +2309,63 @@ static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
>      qapi_free_MemoryDeviceInfoList(info_list);
>  }
>  
> +void build_mem_ranges(PCMachineState *pcms)
> +{
this would be better as a separate generalizing patch.
I'd even go further and introduce MachineClass::get_acpi_ram_map()
hook and implement ARM and PC variants.

It would generate ranges list /initial and dimm memory/
and then generic ACPI code will use that result to build SRAT/HMAT
tables in generic manner. (we probably could reuse it for E820 table
as well, nut that can do myself on top of your patch)

So this hunk should be split into  
 'acpi: unify SRAT table building for Px86/arm targets'

and then you could reuse new hook for HMAT in this patch.


> +    uint64_t mem_len, mem_base, next_base;
> +    int i;
> +
> +    /* the memory map is a bit tricky, it contains at least one hole
> +     * from 640k-1M and possibly another one from 3.5G-4G.
> +     */
> +    mem_ranges_number = 0;
> +    next_base = 0;
> +
> +    for (i = 0; i < pcms->numa_nodes; ++i) {
> +        mem_base = next_base;
> +        mem_len = pcms->node_mem[i];
> +        next_base = mem_base + mem_len;
> +
> +        /* Cut out the 640K hole */
> +        if (mem_base <= HOLE_640K_START &&
> +            next_base > HOLE_640K_START) {
> +            mem_len -= next_base - HOLE_640K_START;
> +            if (mem_len > 0) {
> +                mem_ranges[mem_ranges_number].base = mem_base;
> +                mem_ranges[mem_ranges_number].length = mem_len;
> +                mem_ranges[mem_ranges_number].node = i;
> +                mem_ranges_number++;
> +            }
> +
> +            /* Check for the rare case: 640K < RAM < 1M */
> +            if (next_base <= HOLE_640K_END) {
> +                next_base = HOLE_640K_END;
> +                continue;
> +            }
> +            mem_base = HOLE_640K_END;
> +            mem_len = next_base - HOLE_640K_END;
> +        }
> +
> +        /* Cut out the ACPI_PCI hole */
> +        if (mem_base <= pcms->below_4g_mem_size &&
> +            next_base > pcms->below_4g_mem_size) {
> +            mem_len -= next_base - pcms->below_4g_mem_size;
> +            if (mem_len > 0) {
> +                mem_ranges[mem_ranges_number].base = mem_base;
> +                mem_ranges[mem_ranges_number].length = mem_len;
> +                mem_ranges[mem_ranges_number].node = i;
> +                mem_ranges_number++;
> +            }
> +            mem_base = 1ULL << 32;
> +            mem_len = next_base - pcms->below_4g_mem_size;
> +            next_base = mem_base + mem_len;
> +        }
> +        mem_ranges[mem_ranges_number].base = mem_base;
> +        mem_ranges[mem_ranges_number].length = mem_len;
> +        mem_ranges[mem_ranges_number].node = i;
> +        mem_ranges_number++;
> +    }
> +}
> +
>  static void
>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  {
> @@ -2308,7 +2374,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  
>      int i;
>      int srat_start, numa_start, slots;
> -    uint64_t mem_len, mem_base, next_base;
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
>      PCMachineState *pcms = PC_MACHINE(machine);
> @@ -2348,54 +2413,17 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>          }
>      }
>  
> +    if (pcms->numa_nodes && !mem_ranges_number) {
> +        build_mem_ranges(pcms);
> +    }
>  
> -    /* the memory map is a bit tricky, it contains at least one hole
> -     * from 640k-1M and possibly another one from 3.5G-4G.
> -     */
> -    next_base = 0;
>      numa_start = table_data->len;
> -
> -    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
> -        mem_base = next_base;
> -        mem_len = pcms->node_mem[i - 1];
> -        next_base = mem_base + mem_len;
> -
> -        /* Cut out the 640K hole */
> -        if (mem_base <= HOLE_640K_START &&
> -            next_base > HOLE_640K_START) {
> -            mem_len -= next_base - HOLE_640K_START;
> -            if (mem_len > 0) {
> -                numamem = acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -                                  MEM_AFFINITY_ENABLED);
> -            }
> -
> -            /* Check for the rare case: 640K < RAM < 1M */
> -            if (next_base <= HOLE_640K_END) {
> -                next_base = HOLE_640K_END;
> -                continue;
> -            }
> -            mem_base = HOLE_640K_END;
> -            mem_len = next_base - HOLE_640K_END;
> -        }
> -
> -        /* Cut out the ACPI_PCI hole */
> -        if (mem_base <= pcms->below_4g_mem_size &&
> -            next_base > pcms->below_4g_mem_size) {
> -            mem_len -= next_base - pcms->below_4g_mem_size;
> -            if (mem_len > 0) {
> -                numamem = acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -                                  MEM_AFFINITY_ENABLED);
> -            }
> -            mem_base = 1ULL << 32;
> -            mem_len = next_base - pcms->below_4g_mem_size;
> -            next_base = mem_base + mem_len;
> -        }
> +    for (i = 0; i < mem_ranges_number; i++) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
> -        build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -                          MEM_AFFINITY_ENABLED);
> +        build_srat_memory(numamem, mem_ranges[i].base, mem_ranges[i].length,
> +                          mem_ranges[i].node, MEM_AFFINITY_ENABLED);
>      }
> +
>      slots = (table_data->len - numa_start) / sizeof *numamem;
>      for (; slots < pcms->numa_nodes + 2; slots++) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
> @@ -2713,6 +2741,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>              acpi_add_table(table_offsets, tables_blob);
>              build_slit(tables_blob, tables->linker);
>          }
> +        acpi_add_table(table_offsets, tables_blob);
> +        hmat_build_acpi(tables_blob, tables->linker, machine);
>      }
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 007332e..f17de6a 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -2,6 +2,16 @@
>  #ifndef HW_I386_ACPI_BUILD_H
>  #define HW_I386_ACPI_BUILD_H
>  
> +typedef struct memory_range {
> +    uint64_t base;
> +    uint64_t length;
> +    uint32_t node;
and probably some flags field that could be needed to set attributes in SRAT and
when extra flags for HMAT is necessary added in this patch


> +} MemoryRange;
> +
> +extern MemoryRange mem_ranges[];
> +extern uint32_t mem_ranges_number;
> +
> +void build_mem_ranges(PCMachineState *pcms);
>  void acpi_setup(void);
>  
>  #endif
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 7a0ae75..09a5225 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -13,6 +13,8 @@ struct node_info {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
> +    bool is_initiator;
> +    bool is_target;
these and below hunks appear out of nowhere and do not make sense on it's own.
I'd suggest to reorder
  numa: Extend the command-line to provide memory side cache information
patch before this one, that would introduce these fields with all proper
documentation and then when reviewer would come to this patch he would
already know what is_initiator/is_target mean.


>      uint8_t distance[MAX_NODES];
>  };
>  
> diff --git a/numa.c b/numa.c
> index 33572bf..7098515 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -100,6 +100,10 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          machine_set_cpu_numa_node(ms, &props, &error_fatal);
>      }
>  
> +    if (node->cpus) {
> +        numa_info[nodenr].is_initiator = true;
> +    }
> +
>      if (node->has_mem && node->has_memdev) {
>          error_setg(errp, "cannot specify both mem= and memdev=");
>          return;
> @@ -116,6 +120,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>  
>      if (node->has_mem) {
>          numa_info[nodenr].node_mem = node->mem;
> +        numa_info[nodenr].is_target = true;
>      }
>      if (node->has_memdev) {
>          Object *o;
> @@ -128,6 +133,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          object_ref(o);
>          numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
> +        numa_info[nodenr].is_target = true;
>      }
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
