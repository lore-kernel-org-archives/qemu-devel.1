Received: from eggs.gnu.org ([2001:4830:134:3::10]:60285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhbOw-0003ay-Ls
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhbOr-0004Nk-UV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:01:26 -0400
Date: Mon, 23 Jul 2018 16:00:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723160058.42db6bdb@redhat.com>
In-Reply-To: <20180704124923.32483-6-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
	<20180704124923.32483-6-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] virt-acpi-build: add PPTT table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, wei@redhat.com, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed,  4 Jul 2018 14:49:22 +0200
Andrew Jones <drjones@redhat.com> wrote:

> The ACPI PPTT table supports topology descriptions for ACPI
> guests. Note, while a DT boot Linux guest with a non-flat CPU
> topology will see socket and core IDs being sequential integers
> starting from zero, e.g. with -smp 4,sockets=2,cores=2,threads=1
> 
> a DT boot produces
> 
>  cpu:  0 package_id:  0 core_id:  0
>  cpu:  1 package_id:  0 core_id:  1
>  cpu:  2 package_id:  1 core_id:  0
>  cpu:  3 package_id:  1 core_id:  1
> 
> an ACPI boot produces
> 
>  cpu:  0 package_id: 36 core_id:  0
>  cpu:  1 package_id: 36 core_id:  1
>  cpu:  2 package_id: 96 core_id:  2
>  cpu:  3 package_id: 96 core_id:  3
> 
> This is due to several reasons:
> 
>  1) DT cpu nodes do not have an equivalent field to what the PPTT
>     ACPI Processor ID must be, i.e. something equal to the MADT CPU
>     UID or equal to the UID of an ACPI processor container. In both
>     ACPI cases those are platform dependant IDs assigned by the
>     vendor.
> 
>  2) While QEMU is the vendor for a guest, if the topology specifies
>     SMT (> 1 thread), then, with ACPI, it is impossible to assign a
>     core-id the same value as a package-id, thus it is not possible
>     to have package-id=0 and core-id=0. This is because package and
>     core containers must be in the same ACPI namespace and therefore
>     must have unique UIDs.
> 
>  3) ACPI processor containers are not required for PPTT tables to
>     be used and, due to the limitations of which IDs are selected
>     described above in (2), they are not helpful for QEMU, so we
>     don't build them with this patch. In the absence of them, Linux
>     assigns its own unique IDs. The maintainers have chosen not to use
>     counters from zero, but rather ACPI table offsets, which explains
>     why the numbers are so much larger than with DT.
> 
>  4) When there is no SMT (threads=1) the core IDs for ACPI boot guests
>     match the logical CPU IDs, because these IDs must be equal to the
>     MADT CPU UID (as no processor containers are present), and QEMU
>     uses the logical CPU ID for these MADT IDs.
> 
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/acpi/aml-build.c         | 50 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    |  5 ++++
>  include/hw/acpi/aml-build.h |  2 ++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736de9..37e8f5182ae9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -24,6 +24,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "qemu/bswap.h"
>  #include "qemu/bitops.h"
> +#include "sysemu/cpus.h"
>  #include "sysemu/numa.h"
>  
>  static GArray *build_alloc_array(void)
> @@ -1679,6 +1680,55 @@ void build_slit(GArray *table_data, BIOSLinker *linker)
>                   table_data->len - slit_start, 1, NULL, NULL);
>  }
>  
> +/*
> + * ACPI 6.2 Processor Properties Topology Table (PPTT)
ACPI 6.2: 5.2.29.1 Processor hierarchy node structure (Type 0)

> + */
> +static void build_cpu_hierarchy(GArray *tbl, uint32_t flags,
> +                                uint32_t parent, uint32_t id)
build_processor_hierarchy_node()

> +{
> +    build_append_byte(tbl, 0);  /* Type 0 - processor */
> +    build_append_byte(tbl, 20); /* Length, no private resources */
> +    build_append_int_noprefix(tbl, 0, 2);           /* Reserved */
> +    build_append_int_noprefix(tbl, flags, 4); 
just being pedantic, even for obvious fields add a comment that matches
field name in spec, like:

  build_append_int_noprefix(tbl, flags, 4); /* Parent */


> +    build_append_int_noprefix(tbl, parent, 4);
> +    build_append_int_noprefix(tbl, id, 4);
> +    build_append_int_noprefix(tbl, 0, 4); /* Num private resources */
put comment on new line if it doesn't fit into 80limit but use full
field name from spec

> +}
> +
> +void build_pptt(GArray *table_data, BIOSLinker *linker, int possible_cpus)
> +{
> +    int pptt_start = table_data->len;
> +    int uid = 0, cpus = 0, socket;
> +
> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    for (socket = 0; cpus < possible_cpus; socket++) {
probably should use possible_cpus->cpus[] here to iterate over
cpus and maybe socket_id... from there as well

> +        uint32_t socket_offset = table_data->len - pptt_start;
> +        int core;
> +
> +        build_cpu_hierarchy(table_data, 1, 0, socket);

build_cpu_hierarchy(table_data, ACPI_PROC_HEIRARHY_PACKAGE, 0 /* no parent */ , socket);
> +
> +        for (core = 0; core < smp_cores; core++) {
> +            uint32_t core_offset = table_data->len - pptt_start;
> +            int thread;
> +
> +            if (smp_threads > 1) {
> +                build_cpu_hierarchy(table_data, 0, socket_offset, core);
> +                for (thread = 0; thread < smp_threads; thread++) {
maybe set/use core_id and thread_id from possible_cpus instead of
making up ID numbers here?

> +                    build_cpu_hierarchy(table_data, 2, core_offset, uid++);
> +                }
> +             } else {
> +                build_cpu_hierarchy(table_data, 2, socket_offset, uid++);
> +             }
> +        }
> +        cpus += smp_cores * smp_threads;
> +    }
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + pptt_start), "PPTT",
> +                 table_data->len - pptt_start, 1, NULL, NULL);
> +}
> +
>  /* build rev1/rev3/rev5.1 FADT */
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1d1fc824da6f..aa77e1f018d9 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -832,6 +832,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, vms);
>  
> +    if (!vmc->ignore_cpu_topology) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_pptt(tables_blob, tables->linker, possible_cpus(vms));
> +    }
> +
>      acpi_add_table(table_offsets, tables_blob);
>      build_gtdt(tables_blob, tables->linker, vms);
>  
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 6c36903c0a5d..2b0fde6bd417 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -414,6 +414,8 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>  
>  void build_slit(GArray *table_data, BIOSLinker *linker);
>  
> +void build_pptt(GArray *table_data, BIOSLinker *linker, int possible_cpus);
> +
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id);
>  #endif
