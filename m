Received: from eggs.gnu.org ([2001:4830:134:3::10]:48987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1da7Kh-0001Zi-M7
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1da7Kf-0002bD-Mx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:25:35 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:34065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists@philjordan.eu>) id 1da7Kf-0002Z0-9A
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:25:33 -0400
Received: by mail-vk0-x242.google.com with SMTP id f68so1844350vkg.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 14:25:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Tue, 25 Jul 2017 23:25:10 +0200
Message-ID: <CAGCz3vvyxbe7D2OL08Bo+mzvgP_51c3iPCQ-+PeROC9aZdMo3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, "seabios@seabios.org" <seabios@seabios.org>

Thanks for this, Paolo. Very interesting idea.

I couldn't get things working initially, but with a few fixups on the
SeaBIOS side I can boot both legacy and modern OSes. See comments
inline below for details on changes required.

Successfully booted (only a brief test):
- Windows 2000
- Windows XP (32 bit)
- Windows 7 (32 bit)
- Windows 10 (64 bit, SeaBIOS)
- Windows 10 (64 bit, OVMF)
- macOS 10.12 (patched OVMF)

On Tue, Jul 25, 2017 at 7:10 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 25/07/2017 18:23, Paolo Bonzini wrote:
>> On 25/07/2017 18:14, Laszlo Ersek wrote:
>>>   "No regressions became apparent in tests with a range of Windows
>>>    (XP-10)"
>>>
>>> In theory, w2k falls within that range.
>>
>> Nope, Windows 2000 is like NT 5.0, XP is like NT 5.1. :(
>>
>> One possibility is to fix it in SeaBIOS instead: if you get a 2.0 FADT
>> and an XSDT and no RSDT, it can build an RSDT and a 1.0 FADT itself,
>> patching the RSDT to point to it.
>>
>> It's a hack, but it's the only place I see to make it "just work".  And
>> it could be extended nicely in the future.
>>
>> All QEMU would have to do is to provide an XSDT _instead_ of an RSDT.
>
> Completely untested code follows.  Machine type compatibility code
> should not be necessary because new QEMU always starts with a new BIOS.
>
> Not sure I'll have much time for this in the next few days, so help
> is appreciated.
>
> Paolo
>
> QEMU:
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 36a6cc450e..ea750d54d9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1573,33 +1573,6 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>      g_array_free(tables->vmgenid, mfre);
>  }
>
> -/* Build rsdt table */
> -void
> -build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> -           const char *oem_id, const char *oem_table_id)
> -{
> -    int i;
> -    unsigned rsdt_entries_offset;
> -    AcpiRsdtDescriptorRev1 *rsdt;
> -    const unsigned table_data_len = (sizeof(uint32_t) * table_offsets->len);
> -    const unsigned rsdt_entry_size = sizeof(rsdt->table_offset_entry[0]);
> -    const size_t rsdt_len = sizeof(*rsdt) + table_data_len;
> -
> -    rsdt = acpi_data_push(table_data, rsdt_len);
> -    rsdt_entries_offset = (char *)rsdt->table_offset_entry - table_data->data;
> -    for (i = 0; i < table_offsets->len; ++i) {
> -        uint32_t ref_tbl_offset = g_array_index(table_offsets, uint32_t, i);
> -        uint32_t rsdt_entry_offset = rsdt_entries_offset + rsdt_entry_size * i;
> -
> -        /* rsdt->table_offset_entry to be filled by Guest linker */
> -        bios_linker_loader_add_pointer(linker,
> -            ACPI_BUILD_TABLE_FILE, rsdt_entry_offset, rsdt_entry_size,
> -            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
> -    }
> -    build_header(linker, table_data,
> -                 (void *)rsdt, "RSDT", rsdt_len, 1, oem_id, oem_table_id);
> -}
> -
>  /* Build xsdt table */
>  void
>  build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade183..ad00f6affd 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2557,12 +2557,12 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
>  }
>
>  static GArray *
> -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
> +build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>  {
>      AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> -    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
> -    unsigned rsdt_pa_offset =
> -        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
> +    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
> +    unsigned xsdt_pa_offset =
> +        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
>
>      bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
>                               true /* fseg memory */);
> @@ -2571,8 +2571,8 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
>      memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
>      /* Address to be filled by Guest linker */
>      bios_linker_loader_add_pointer(linker,
> -        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
> -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
> +        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
> +        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
>
>      /* Checksum to be filled by Guest linker */
>      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> @@ -2621,7 +2621,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      PCMachineState *pcms = PC_MACHINE(machine);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      GArray *table_offsets;
> -    unsigned facs, dsdt, rsdt, fadt;
> +    unsigned facs, dsdt, xsdt, fadt;
>      AcpiPmInfo pm;
>      AcpiMiscInfo misc;
>      AcpiMcfgInfo mcfg;
> @@ -2730,12 +2730,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      }
>
>      /* RSDT is pointed to by RSDP */
> -    rsdt = tables_blob->len;
> -    build_rsdt(tables_blob, tables->linker, table_offsets,
> +    xsdt = tables_blob->len;
> +    build_xsdt(tables_blob, tables->linker, table_offsets,
>                 slic_oem.id, slic_oem.table_id);
>
>      /* RSDP is in FSEG memory, so allocate it separately */
> -    build_rsdp(tables->rsdp, tables->linker, rsdt);
> +    build_rsdp(tables->rsdp, tables->linker, xsdt);
>
>      /* We'll expose it all to Guest so we want to reduce
>       * chance of size changes.
>
>
> SeaBIOS:
>
> From 73b0facdb7349f5dbf24dc675647b68eeeec0ff4 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Tue, 25 Jul 2017 18:50:19 +0200
> Subject: [PATCH 1/2] seabios: build RSDT from XSDT
>
> Old operating systems would like to have a v1 FADT, but new
> operating systems would like to have v3.
>
> Since old operating systems do not know about XSDTs, the
> solution is to point the RSDT to a v1 FADT and the XSDT to a
> v3 FADT.
>
> But, OVMF is not able to do that and barfs when it sees the
> second FADT---plus really it's only BIOS operating systems
> such as win2k that complain.  So instead: 1) make QEMU provide
> an XSDT only; 2) build the RSDT and v1 FADT in SeaBIOS.
>
> This patch makes SeaBIOS build an RSDT out of an existing XSDT.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  src/fw/paravirt.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  src/std/acpi.h    | 11 +++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
> index 5b23d78..19a4abe 100644
> --- a/src/fw/paravirt.c
> +++ b/src/fw/paravirt.c
> @@ -25,6 +25,7 @@
>  #include "x86.h" // cpuid
>  #include "xen.h" // xen_biostable_setup
>  #include "stacks.h" // yield
> +#include "std/acpi.h"
>
>  // Amount of continuous ram under 4Gig
>  u32 RamSize;
> @@ -147,6 +148,46 @@ static void msr_feature_control_setup(void)
>          wrmsr_smp(MSR_IA32_FEATURE_CONTROL, feature_control_bits);
>  }
>
> +static void
> +build_compatibility_rsdt(void)
> +{
> +    if (RsdpAddr->rsdt_physical_address)
> +        return;
> +
> +    u64 xsdt_addr = RsdpAddr->xsdt_physical_address;
> +    if (xsdt_addr & ~0xffffffffULL)
> +        return;
> +
> +    struct xsdt_descriptor_rev1 *xsdt = (void*)(u32)xsdt_addr;
> +    void *end = (void*)xsdt + xsdt->length;
> +    struct rsdt_descriptor_rev1 *rsdt;
> +    int rsdt_size = offsetof(struct rsdt_descriptor_rev1, table_offset_entry[0]);
> +    int i;
> +    for (i=0; (void*)&xsdt->table_offset_entry[i] < end; i++) {
> +        u64 tbl_addr = xsdt->table_offset_entry[i];
> +        if (!tbl_addr || (tbl_addr & ~0xffffffffULL))
> +            continue;
> +        rsdt_size += 4;
> +    }
> +
> +    rsdt = malloc_high(rsdt_size);
> +    RsdpAddr->rsdt_physical_address = (u32)rsdt;

Modifying the RSDP like this invalidates both its checksums, so they
need to be adjusted. Something like this:

    RsdpAddr->checksum -= checksum(RsdpAddr, offsetof(struct
rsdp_descriptor, length));
    RsdpAddr->extended_checksum -= checksum(RsdpAddr, sizeof(struct
rsdp_descriptor));

> +
> +    memcpy(rsdt, xsdt, sizeof(struct acpi_table_header));
> +    rsdt->signature = RSDT_SIGNATURE;
> +    rsdt->length = rsdt_size;
> +    rsdt->revision = 1;
> +    int j;
> +    for (i=j=0; (void*)&xsdt->table_offset_entry[i] < end; i++) {
> +        u64 tbl_addr = xsdt->table_offset_entry[i];
> +        if (!tbl_addr || (tbl_addr & ~0xffffffffULL))
> +            continue;
> +        rsdt->table_offset_entry[j++] = (u32)tbl_addr;
> +    }
> +
> +    rsdt->checksum -= checksum(rsdt, rsdt_size);
> +}
> +
>  void
>  qemu_platform_setup(void)
>  {
> @@ -186,8 +227,10 @@ qemu_platform_setup(void)
>
>          RsdpAddr = find_acpi_rsdp();
>
> -        if (RsdpAddr)
> +        if (RsdpAddr) {
> +            build_compatibility_rsdt();
>              return;
> +        }
>
>          /* If present, loader should have installed an RSDP.
>           * Not installed? We might still be able to continue
> diff --git a/src/std/acpi.h b/src/std/acpi.h
> index c2ea707..caf5e7e 100644
> --- a/src/std/acpi.h
> +++ b/src/std/acpi.h
> @@ -133,6 +133,17 @@ struct rsdt_descriptor_rev1
>  } PACKED;
>
>  /*
> + * ACPI 2.0 Root System Description Table (RSDT)
> + */

Comment should be "ACPI 2.0 Extended System Description Table (XSDT)"

> +#define XSDT_SIGNATURE 0x54445358 // RSDT

The signature is "XSDT", that works out to 0x58445358

> +struct xsdt_descriptor_rev1
> +{
> +    ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
> +    u64 table_offset_entry[0];  /* Array of pointers to other */
> +    /* ACPI tables */
> +} PACKED;
> +
> +/*
>   * ACPI 1.0 Firmware ACPI Control Structure (FACS)
>   */
>  #define FACS_SIGNATURE 0x53434146 // FACS
> --
> 2.13.3
>
>
> From 46c7a296d27bd487cfd89a40973b1e61426dfbd0 Mon Sep 17 00:00:00 2001
> From: Paolo Bonzini <pbonzini@redhat.com>
> Date: Tue, 25 Jul 2017 18:59:20 +0200
> Subject: [PATCH 2/2] seabios: create v1 FADT in compatibility RSDT
>
> This patch presents a v1 FADT inside the compatibility RSDT, so
> that old operating systems are not broken.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  src/fw/paravirt.c | 18 +++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
> index 19a4abe..a9b9e80 100644
> --- a/src/fw/paravirt.c
> +++ b/src/fw/paravirt.c
> @@ -148,6 +148,18 @@ static void msr_feature_control_setup(void)
>          wrmsr_smp(MSR_IA32_FEATURE_CONTROL, feature_control_bits);
>  }
>
> +static void*
> +build_rev1_fadt(struct fadt_descriptor_rev1 *fadt_v3)
> +{
> +    struct fadt_descriptor_rev1 *fadt_v1 = malloc_high(sizeof *fadt_v1);
> +
> +    memcpy(fadt_v1, fadt_v3, sizeof *fadt_v1);
> +    fadt_v1->length = sizeof *fadt_v1;
> +    fadt_v1->revision = 1;

We should mask out the flags bits that are reserved in ACPI 1.0 as
they refer to fields not present in this revision's FADT. e.g.

    // upper 23 bits reserved in rev1 FADT
    fadt_v1->flags &= 0x1ff;


> +    fadt_v1->checksum -= checksum(fadt_v1, fadt_v1->length);
> +    return fadt_v1;
> +}
> +
>  static void
>  build_compatibility_rsdt(void)
>  {
> @@ -182,6 +194,12 @@ build_compatibility_rsdt(void)
>          u64 tbl_addr = xsdt->table_offset_entry[i];
>          if (!tbl_addr || (tbl_addr & ~0xffffffffULL))
>              continue;
> +        struct acpi_table_header *tbl = (void*)(u32)tbl_addr;
> +        /* The RSDT should only have an ACPI 1.0 FADT according to
> +         * the spec.
> +         */
> +        if (tbl->signature == FACP_SIGNATURE && tbl->revision > 1)
> +            tbl_addr = (u32)build_rev1_fadt((void *)tbl);
>          rsdt->table_offset_entry[j++] = (u32)tbl_addr;
>      }
>
> --
> 2.13.3
>
>

With these changes:

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
