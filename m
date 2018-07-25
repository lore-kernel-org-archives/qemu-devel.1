Received: from eggs.gnu.org ([2001:4830:134:3::10]:44962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fiJ7L-0007kN-PD
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fiJ7I-0007by-QM
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:42:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fiJ7I-0007b0-IH
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC068401FF40
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 12:42:07 +0000 (UTC)
Date: Wed, 25 Jul 2018 14:42:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180725144205.67dc24c0@redhat.com>
In-Reply-To: <20180710000024.542612-7-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
	<20180710000024.542612-7-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH hack dontapply v2 6/7] acpi: aml generation
 for _CST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On Tue, 10 Jul 2018 03:01:33 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This adds a method called CCST under CPUS.
> Each CPU will add _CST calling in turn CCST from there.
> 
> As _CST needs to change across migration, we use
> dynamic loading of tables as follows:
> 
> - a special scratch buffer, 4K in size is requested from bios
>   through the loader.
> - each time CCST executes, buffer address is passed to QEMU
>   which will write an SSDT table with the _CST package into the buffer.
> - table is then loaded and a package named \\_SB.CPUS.CSTL is loaded from there.
> - table is unloaded, package is then returned to caller
> 
> In this way, QEMU can change the package across migration.
> It will then notify the OSPM which will re-evaluate
> _CST.
> 
> In this proof of concept patch, package generation itself is
> still a stub, and change notifications are missing.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/acpi/cst.h |   8 ++
>  hw/acpi/cst.c         | 173 ++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/Makefile.objs |   2 +-
>  3 files changed, 182 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/acpi/cst.h
>  create mode 100644 hw/acpi/cst.c
> 
> diff --git a/include/hw/acpi/cst.h b/include/hw/acpi/cst.h
> new file mode 100644
> index 0000000000..2e40e87881
> --- /dev/null
> +++ b/include/hw/acpi/cst.h
> @@ -0,0 +1,8 @@
> +#ifndef HW_ACPI_CST_H
> +#define HW_ACPI_CST_H
> +
> +#include "hw/acpi/bios-linker-loader.h"
> +
> +void cst_build_acpi(GArray *table_data, BIOSLinker *linker, uint16_t ioport);
> +void cst_register(FWCfgState *s, uint16_t ioport);
> +#endif
> diff --git a/hw/acpi/cst.c b/hw/acpi/cst.c
> new file mode 100644
> index 0000000000..20dd80aef8
> --- /dev/null
> +++ b/hw/acpi/cst.c
> @@ -0,0 +1,173 @@
> +#include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/cst.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +#define ACPI_SCRATCH_BUFFER_NAME "etc/scratch"
> +
> +/* Hack! Incomplete! */
> +static Aml *build_cst_package(void)
> +{
> +    int i;
> +    Aml *crs;
> +    Aml *pkg;
> +    int cs_num = 3;
> +
> +    pkg = aml_package(cs_num + 1); /* # of ACPI Cx states + state count */
> +    aml_append(pkg, aml_int(cs_num)); /* # of ACPI Cx states */
> +
> +    for (i = 0; i < cs_num; i++) {
> +        Aml *cstate = aml_package(4);
> +
> +        crs = aml_resource_template();
> +        aml_append(crs, aml_register(AML_AS_SYSTEM_IO,
> +            0x8,
> +            0x0,
> +            0x100,
> +            0x1));
> +        aml_append(cstate, crs);
> +        aml_append(cstate, aml_int(i + 1)); /* Cx ACPI state */
> +        aml_append(cstate, aml_int((i + 1) * 10)); /* Latency */
> +        aml_append(cstate, aml_int(cs_num - i - 1));/* Power */
> +        aml_append(pkg, cstate);
> +    }
> +
> +    return pkg;
> +}
> +
> +static GArray *cst_scratch;
> +
> +/*
> + * Add an SSDT with a dynamic method named CCST. The method uses the specified
> + * ioport to load a table from QEMU, then returns an object named CSTL from
> + * it.
> + * Everything is scoped under \\_SB.CPUS.CSTP.
> + */
> +void cst_build_acpi(GArray *table_data, BIOSLinker *linker, uint16_t ioport)
> +{
> +    Aml *ssdt, *scope, *field, *method;
> +    uint32_t cstp_offset;
> +
> +    /* Put this in a separate SSDT table */
> +    ssdt = init_aml_allocator();
> +
> +    /* Reserve space for header */
> +    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
> +
> +    cstp_offset = table_data->len +
> +        build_append_named_dword(ssdt->buf, "\\_SB.CPUS.CSTP");
> +    scope = aml_scope("\\_SB.CPUS");
> +    {
> +        /* buffer in reserved memory to load the table from */
> +        aml_append(scope, aml_operation_region("CSTB", AML_SYSTEM_MEMORY,
> +                                               aml_name("\\_SB.CPUS.CSTP"),
> +                                               4096));
> +        /* write address here to update the table in memory */
> +        aml_append(scope, aml_operation_region("CSTR", AML_SYSTEM_IO,
> +                                               aml_int(ioport),
> +                                               4));
> +        field = aml_field("CSTR", AML_DWORD_ACC, AML_LOCK,
> +                          AML_WRITE_AS_ZEROS);
> +        {
> +            aml_append(field, aml_named_field("CSTU", 32));
> +        }
> +        aml_append(scope, field);
> +        method = aml_method("CCST", 0, AML_SERIALIZED);
> +        {
> +            Aml *ddbhandle = aml_local(0);
> +            Aml *cst = aml_local(1);
> +            /* Write buffer address to update table in memory. */
> +            aml_append(method, aml_store(aml_name("CSTP"), aml_name("CSTU")));
> +            aml_append(method, aml_load("CSTB", ddbhandle));
> +            aml_append(method, aml_store(aml_name("CSTL"), cst));
> +            aml_append(method, aml_unload(ddbhandle));
> +            aml_append(method, aml_return(cst));
> +        }
> +        aml_append(scope, method);
> +    }
> +    aml_append(ssdt, scope);
> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> +
> +    /* Why page boundary? no special reason right now but seems like
> +     * a good idea for future extensions.      
> +    */
> +    bios_linker_loader_alloc(linker, ACPI_SCRATCH_BUFFER_NAME, cst_scratch,
> +                             4096, false /* page boundary, high memory */);
> +    /* Patch address of allocated memory into the AML so OSPM can retrieve
> +     * and read it.
> +     */
> +    bios_linker_loader_add_pointer(linker,
> +        ACPI_BUILD_TABLE_FILE, cstp_offset, sizeof(uint32_t),
> +        ACPI_SCRATCH_BUFFER_NAME, 0);
> +
> +    //table_data->data[cstp_offset] = 0x8; /* hack */
> +
> +    build_header(linker, table_data,
> +        (void *)(table_data->data + table_data->len - ssdt->buf->len),
> +        "SSDT", ssdt->buf->len, 1, NULL, "CSTSSDT");
> +
> +    free_aml_allocator();
> +}
> +
> +static GArray *cst_ssdt;
> +
> +static void cst_ssdt_setup(void)
> +{
> +    AcpiTableHeader *dyn_ssdt_hdr;
> +    Aml *dyn_ssdt = init_aml_allocator();
> +
> +    /* Reserve space for header */
> +    acpi_data_push(dyn_ssdt->buf, sizeof(AcpiTableHeader));
> +    aml_append(dyn_ssdt, aml_name_decl("\\_SB.CPUS.CSTL", build_cst_package()));
> +
> +    dyn_ssdt_hdr = (AcpiTableHeader *)dyn_ssdt->buf->data;
> +
> +    acpi_init_header(dyn_ssdt_hdr, "SSDT", dyn_ssdt->buf->len, 1, NULL, "DYNSSDT");
> +
> +    dyn_ssdt_hdr->checksum = acpi_checksum((uint8_t *)dyn_ssdt_hdr,
> +                                           dyn_ssdt->buf->len);
> +
> +    /* dyn_ssdt->buf will be freed. copy to cst_ssdt */
> +    cst_ssdt = g_array_new(false, true, 1);
> +    g_array_append_vals(cst_ssdt, dyn_ssdt->buf->data, dyn_ssdt->buf->len);
> +
> +    free_aml_allocator();
> +}
> +
> +/* Update CST in system memory */
> +static void cst_ioport_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
> +{
> +    assert(cst_ssdt);
> +
> +    cpu_physical_memory_write(data, cst_ssdt->data, cst_ssdt->len);
> +}
> +
> +static const MemoryRegionOps cst_ops = {
> +    .write = cst_ioport_write,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static MemoryRegion cst_mr;
> +
> +void cst_register(FWCfgState *s, uint16_t ioport)
> +{
> +    cst_ssdt_setup();
> +
> +    /* Allocate guest scratch memory for the table */
> +    cst_scratch = g_array_new(false, true, 1);
> +    acpi_data_push(cst_scratch, 4096);
> +    fw_cfg_add_file(s, ACPI_SCRATCH_BUFFER_NAME, cst_scratch->data,
> +                    cst_scratch->len);
> +
> +    /* setup io to trigger updates */
> +    memory_region_init_io(&cst_mr, NULL, &cst_ops, NULL, "cst-update-request", 4);
> +    memory_region_add_subregion(get_system_io(), ioport, &cst_mr);
it eats yet another IO port and a 4K page just for CST.
I'd prefer to extend docs/specs/acpi_cpu_hotplug.txt protocol
to support passing _CST values via existing registers instead.


> +}
> +
> +/* TODO: API to notify guest of changes */
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 11c35bcb44..0119367455 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -1,5 +1,5 @@
>  ifeq ($(CONFIG_ACPI),y)
> -common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
> +common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o cst.o
>  common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
