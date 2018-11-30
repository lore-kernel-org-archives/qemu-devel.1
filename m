Received: from eggs.gnu.org ([2001:4830:134:3::10]:46773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSfeE-0006ed-S2
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSfeB-0006nb-B9
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:03:46 -0500
Date: Fri, 30 Nov 2018 11:03:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181130110317.08192149@redhat.com>
In-Reply-To: <20181129132428.333-8-sameo@linux.intel.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-8-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/8] hw: acpi: Export and share the ARM
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>

On Thu, 29 Nov 2018 14:24:27 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Now that build_rsdp() supports building both legacy and current RSDP
> tables, we can move it to a generic folder (hw/acpi) and have the i386
> ACPI code reuse it in order to reduce code duplication.
>=20
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
with nit below fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 50 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 50 -------------------------------------
>  hw/i386/acpi-build.c        | 39 +++++++----------------------
>  4 files changed, 61 insertions(+), 80 deletions(-)
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
> index 1e43cd736d..3d5f77e02b 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1589,6 +1589,56 @@ void acpi_build_tables_cleanup(AcpiBuildTables *ta=
bles, bool mfre)
>      g_array_free(tables->vmgenid, mfre);
>  }
> =20
> +/* RSDP */
> +void
> +build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> +{
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
> +        bios_linker_loader_add_pointer(linker,
> +                                       ACPI_BUILD_RSDP_FILE, 16, 4,
> +                                       ACPI_BUILD_TABLE_FILE,
> +                                       *rsdp_data->rsdt_tbl_offset);
> +    }
> +
> +    /* Checksum to be filled by guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +                                    0, 20, /* ACPI rev 1.0 RSDP size */
> +                                    8);
> +
> +    if (rsdp_data->revision =3D=3D 0) {
> +        /* ACPI 1.0 RSDP, we're done */
> +        return;
> +    }
> +
> +    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
> +    g_assert(rsdp_data->xsdt_tbl_offset !=3D NULL);
> +
> +    build_append_int_noprefix(tbl, 36, 4); /* Length */
> +
> +    /* XSDT address to be filled by guest linker */
> +    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE, 24, 8,
> +                                   ACPI_BUILD_TABLE_FILE,
> +                                   *rsdp_data->xsdt_tbl_offset);
> +
> +    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
> +    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
> +
> +    /* Extended checksum to be filled by Guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +                                    0, 36, /* ACPI rev 2.0 RSDP size */
> +                                    32);
> +}
> +
>  /* Build rsdt table */
>  void
>  build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e1338b6f5a..95fad6f0ce 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -366,56 +366,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }
> =20
> -/* RSDP */
I'd make comment more descriptive, see build_slit() for example

> -static void
> -build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> -{
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
> -        bios_linker_loader_add_pointer(linker,
> -                                       ACPI_BUILD_RSDP_FILE, 16, 4,
> -                                       ACPI_BUILD_TABLE_FILE,
> -                                       *rsdp_data->rsdt_tbl_offset);
> -    }
> -
> -    /* Checksum to be filled by guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -                                    0, 20, /* ACPI rev 1.0 RSDP size */
> -                                    8);
> -
> -    if (rsdp_data->revision =3D=3D 0) {
> -        /* ACPI 1.0 RSDP, we're done */
> -        return;
> -    }
> -
> -    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
> -    g_assert(rsdp_data->xsdt_tbl_offset !=3D NULL);
> -
> -    build_append_int_noprefix(tbl, 36, 4); /* Length */
> -
> -    /* XSDT address to be filled by guest linker */
> -    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
> -    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE, 24, 8,
> -                                   ACPI_BUILD_TABLE_FILE,
> -                                   *rsdp_data->xsdt_tbl_offset);
> -
> -    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
> -    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
> -
> -    /* Extended checksum to be filled by Guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -                                    0, 36, /* ACPI rev 2.0 RSDP size */
> -                                    32);
> -}
> -
>  static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index fb877648ac..528a5fd4ed 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2547,35 +2547,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *li=
nker)
>                   "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
>  }
> =20
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
> -    AcpiRsdpDescriptor *rsdp =3D acpi_data_push(rsdp_table, sizeof *rsdp=
);
> -    unsigned rsdt_pa_size =3D sizeof(rsdp->rsdt_physical_address);
> -    unsigned rsdt_pa_offset =3D
> -        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
> -
> -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 1=
6,
> -                             true /* fseg memory */);
> -
> -    memcpy(&rsdp->signature, "RSD PTR ", 8);
> -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
> -    /* Address to be filled by Guest linker */
> -    bios_linker_loader_add_pointer(linker,
> -        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
> -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
> -
> -    /* Checksum to be filled by Guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
> -        (char *)&rsdp->checksum - rsdp_table->data);
> -}
> -
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
> +    }
> =20
>      /* We'll expose it all to Guest so we want to reduce
>       * chance of size changes.
