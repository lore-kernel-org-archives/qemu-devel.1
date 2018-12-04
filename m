Received: from eggs.gnu.org ([2001:4830:134:3::10]:41306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUBGe-0001To-Px
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gUBGb-0003FP-JG
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:01:40 -0500
Date: Tue, 4 Dec 2018 15:01:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181204150118.6d4a1c09@redhat.com>
In-Reply-To: <20181130130032.11835-8-sameo@linux.intel.com>
References: <20181130130032.11835-1-sameo@linux.intel.com>
	<20181130130032.11835-8-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/8] hw: acpi: Export and share the ARM
 RSDP build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On Fri, 30 Nov 2018 14:00:31 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Now that build_rsdp() supports building both legacy and current RSDP
> tables, we can move it to a generic folder (hw/acpi) and have the i386
> ACPI code reuse it in order to reduce code duplication.
>=20
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 68 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 66 -----------------------------------
>  hw/i386/acpi-build.c        | 39 +++++----------------
>  4 files changed, 79 insertions(+), 96 deletions(-)
>=20
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 6c36903c0a..1a563ad756 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -388,6 +388,8 @@ void acpi_add_table(GArray *table_offsets, GArray *ta=
ble_data);
>  void acpi_build_tables_init(AcpiBuildTables *tables);
>  void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
>  void
> +build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data);
> +void
>  build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
>             const char *oem_id, const char *oem_table_id);
>  void
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736d..555c24f21d 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1589,6 +1589,74 @@ void acpi_build_tables_cleanup(AcpiBuildTables *ta=
bles, bool mfre)
>      g_array_free(tables->vmgenid, mfre);
>  }
> =20
> +/*
> + * ACPI spec 5.2.5.3 Root System Description Pointer (RSDP).
> + * (Revision 1.0 or later)
> + */
> +void
> +build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> +{
> +    int tbl_off =3D tbl->len; /* Table offset in the RSDP file */
> +
> +    switch (rsdp_data->revision) {
> +    case 0:
> +        /* With ACPI 1.0, we must have an RSDT pointer */
> +        g_assert(rsdp_data->rsdt_tbl_offset);
> +        break;
> +    case 2:
> +        /* With ACPI 2.0+, we must have an XSDT pointer */
> +        g_assert(rsdp_data->xsdt_tbl_offset);
> +        break;
> +    default:
> +        /* Only revisions 0 (ACPI 1.0) and 2 (ACPI 2.0+) are valid for R=
SDP */
> +        g_assert_not_reached();
> +    }
> +
> +    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
> +                             true /* fseg memory */);
> +
> +    g_array_append_vals(tbl, "RSD PTR ", 8); /* Signature */
> +    build_append_int_noprefix(tbl, 0, 1); /* Checksum */
> +    g_array_append_vals(tbl, rsdp_data->oem_id, 6); /* OEMID */
> +    build_append_int_noprefix(tbl, rsdp_data->revision, 1); /* Revision =
*/
> +    build_append_int_noprefix(tbl, 0, 4); /* RsdtAddress */
> +    if (rsdp_data->rsdt_tbl_offset) {
> +        /* RSDT address to be filled by guest linker */
> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
> +                                       tbl_off + 16, 4,
> +                                       ACPI_BUILD_TABLE_FILE,
> +                                       *rsdp_data->rsdt_tbl_offset);
> +    }
> +
> +    /* Checksum to be filled by guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +                                    tbl_off, 20, /* ACPI rev 1.0 RSDP si=
ze */
> +                                    8);
> +
> +    if (rsdp_data->revision =3D=3D 0) {
> +        /* ACPI 1.0 RSDP, we're done */
> +        return;
> +    }
> +
> +    build_append_int_noprefix(tbl, 36, 4); /* Length */
> +
> +    /* XSDT address to be filled by guest linker */
> +    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
> +    /* We already validated our xsdt pointer */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
> +                                   tbl_off + 24, 8,
> +                                   ACPI_BUILD_TABLE_FILE,
> +                                   *rsdp_data->xsdt_tbl_offset);
> +
> +    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
> +    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
> +
> +    /* Extended checksum to be filled by Guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +                                    tbl_off, 36, /* ACPI rev 2.0 RSDP si=
ze */
> +                                    32);
> +}
> +
>  /* Build rsdt table */
>  void
>  build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 4b212fa44c..95fad6f0ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -366,72 +366,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }
> =20
> -/* RSDP */
> -static void
> -build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> -{
> -
> -    int tbl_off =3D tbl->len; /* Table offset in the RSDP file */
> -
> -    switch (rsdp_data->revision) {
> -    case 0:
> -        /* With ACPI 1.0, we must have an RSDT pointer */
> -        g_assert(rsdp_data->rsdt_tbl_offset);
> -        break;
> -    case 2:
> -        /* With ACPI 2.0+, we must have an XSDT pointer */
> -        g_assert(rsdp_data->xsdt_tbl_offset);
> -        break;
> -    default:
> -        /* Only revisions 0 (ACPI 1.0) and 2 (ACPI 2.0+) are valid for R=
SDP */
> -        g_assert_not_reached();
> -    }
> -
> -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
> -                             true /* fseg memory */);
> -
> -    g_array_append_vals(tbl, "RSD PTR ", 8); /* Signature */
> -    build_append_int_noprefix(tbl, 0, 1); /* Checksum */
> -    g_array_append_vals(tbl, rsdp_data->oem_id, 6); /* OEMID */
> -    build_append_int_noprefix(tbl, rsdp_data->revision, 1); /* Revision =
*/
> -    build_append_int_noprefix(tbl, 0, 4); /* RsdtAddress */
> -    if (rsdp_data->rsdt_tbl_offset) {
> -        /* RSDT address to be filled by guest linker */
> -        bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
> -                                       tbl_off + 16, 4,
> -                                       ACPI_BUILD_TABLE_FILE,
> -                                       *rsdp_data->rsdt_tbl_offset);
> -    }
> -
> -    /* Checksum to be filled by guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -                                    tbl_off, 20, /* ACPI rev 1.0 RSDP si=
ze */
> -                                    8);
> -
> -    if (rsdp_data->revision =3D=3D 0) {
> -        /* ACPI 1.0 RSDP, we're done */
> -        return;
> -    }
[...]

> -static void
> -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_off=
set)
> -{
> -    /* AcpiRsdpDescriptor describes revision 2 RSDP table and as result =
we
> -     * allocate extra 16 bytes for pc/q35 RSDP rev1 as well. Keep extra =
16 bytes
> -     * wasted to make sure we won't breake migration for machine types o=
lder
> -     * than 2.3 due to size mismatch.
> -     */
Removing this part here and not moving it somewhere else doesn't look right.
[...]

>  typedef
>  struct AcpiBuildState {
>      /* Copy of table in RAM (for patching). */
> @@ -2732,7 +2703,15 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
>                 slic_oem.id, slic_oem.table_id);
> =20
>      /* RSDP is in FSEG memory, so allocate it separately */
> -    build_rsdp(tables->rsdp, tables->linker, rsdt);
> +    {
> +        AcpiRsdpData rsdp_data =3D {
> +            .revision =3D 0,
> +            .oem_id =3D ACPI_BUILD_APPNAME6,
> +            .xsdt_tbl_offset =3D NULL,
> +            .rsdt_tbl_offset =3D &rsdt,
> +        };
> +        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
I'd suggest to keep build_rsdp() clean, move comment above comment
and add an extra padding for machine versions 2.2 and older here.
See pc_i440fx_2_2_machine_options() we probably can use pcmc->rsdp_in_ram as
condition for padding.

And test migration (pingpong) from this QEMU build to 2.2 and 2.3 builds,
in case something else was missed.

> +    }
> =20
>      /* We'll expose it all to Guest so we want to reduce
>       * chance of size changes.
