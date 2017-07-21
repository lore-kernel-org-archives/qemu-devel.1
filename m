Received: from eggs.gnu.org ([2001:4830:134:3::10]:53850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYboG-0008KD-7a
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYboB-0004SJ-6M
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:33:52 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dYboB-0004S9-0T
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:33:47 -0400
Received: by mail-io0-x243.google.com with SMTP id f66so3932412iof.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 10:33:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
Date: Fri, 21 Jul 2017 13:33:43 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <871947DA-2383-46A9-9638-B4360D4B069F@gmail.com>
References: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <lists@philjordan.eu>, "Michael S. Tsirkin" <mst@redhat.com>


> On Jul 21, 2017, at 5:32 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> w2k used to boot on QEMU until we bumped revision of FADT to rev3
> (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to =
improve guest OS support.)
>=20
> Considering that w2k is ancient and long time EOLed, leave default
> rev3 but make pc-i440fx-2.9 and older machine types to force rev1
> so old setups won't break (w2k could boot).
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Programmingkid <programmingkidx@gmail.com>
> CC: Phil Dennis-Jordan <lists@philjordan.eu>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> Only compile test since I don't have w2k to test with
>=20
> ---
> include/hw/i386/pc.h |  1 +
> hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
> hw/i386/pc_piix.c    |  2 ++
> 3 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d80859b..d6f65dd 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -122,6 +122,7 @@ struct PCMachineClass {
>     bool rsdp_in_ram;
>     int legacy_acpi_table_size;
>     unsigned acpi_data_size;
> +    bool force_rev1_fadt;
>=20
>     /* SMBIOS compat: */
>     bool smbios_defaults;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade..227f9ad 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -272,7 +272,7 @@ build_facs(GArray *table_data, BIOSLinker *linker)
> }
>=20
> /* Load chipset information in FADT */
> -static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
> +static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm, =
bool rev1)
> {
>     fadt->model =3D 1;
>     fadt->reserved1 =3D 0;
> @@ -304,6 +304,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 =
*fadt, AcpiPmInfo *pm)
>         fadt->flags |=3D cpu_to_le32(1 << =
ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
>     }
>     fadt->century =3D RTC_CENTURY;
> +    if (rev1) {
> +        return;
> +    }
>=20
>     fadt->flags |=3D cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
>     fadt->reset_value =3D 0xf;
> @@ -335,6 +338,7 @@ static void fadt_setup(AcpiFadtDescriptorRev3 =
*fadt, AcpiPmInfo *pm)
> /* FADT */
> static void
> build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
> +           MachineState *machine,
>            unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
>            const char *oem_id, const char *oem_table_id)
> {
> @@ -342,6 +346,9 @@ build_fadt(GArray *table_data, BIOSLinker *linker, =
AcpiPmInfo *pm,
>     unsigned fw_ctrl_offset =3D (char *)&fadt->firmware_ctrl - =
table_data->data;
>     unsigned dsdt_entry_offset =3D (char *)&fadt->dsdt - =
table_data->data;
>     unsigned xdsdt_entry_offset =3D (char *)&fadt->x_dsdt - =
table_data->data;
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(machine);
> +    int fadt_size =3D sizeof(*fadt);
> +    int rev =3D 3;
>=20
>     /* FACS address to be filled by Guest linker */
>     bios_linker_loader_add_pointer(linker,
> @@ -349,16 +356,21 @@ build_fadt(GArray *table_data, BIOSLinker =
*linker, AcpiPmInfo *pm,
>         ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
>=20
>     /* DSDT address to be filled by Guest linker */
> -    fadt_setup(fadt, pm);
> +    fadt_setup(fadt, pm, pcmc->force_rev1_fadt);
>     bios_linker_loader_add_pointer(linker,
>         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> -    bios_linker_loader_add_pointer(linker,
> -        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, =
sizeof(fadt->x_dsdt),
> -        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> +    if (pcmc->force_rev1_fadt) {
> +        rev =3D 1;
> +        fadt_size =3D offsetof(typeof(*fadt), reset_register);
> +    } else {
> +        bios_linker_loader_add_pointer(linker,
> +            ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, =
sizeof(fadt->x_dsdt),
> +            ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> +    }
>=20
>     build_header(linker, table_data,
> -                 (void *)fadt, "FACP", sizeof(*fadt), 3, oem_id, =
oem_table_id);
> +                 (void *)fadt, "FACP", fadt_size, rev, oem_id, =
oem_table_id);
> }
>=20
> void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
> @@ -2667,7 +2679,7 @@ void acpi_build(AcpiBuildTables *tables, =
MachineState *machine)
>     /* ACPI tables pointed to by RSDT */
>     fadt =3D tables_blob->len;
>     acpi_add_table(table_offsets, tables_blob);
> -    build_fadt(tables_blob, tables->linker, &pm, facs, dsdt,
> +    build_fadt(tables_blob, tables->linker, &pm, machine, facs, dsdt,
>                slic_oem.id, slic_oem.table_id);
>     aml_len +=3D tables_blob->len - fadt;
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 11b4336..bc61332 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -449,9 +449,11 @@ DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", =
NULL,
>=20
> static void pc_i440fx_2_9_machine_options(MachineClass *m)
> {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
>     pc_i440fx_2_10_machine_options(m);
>     m->is_default =3D 0;
>     m->alias =3D NULL;
> +    pcmc->force_rev1_fadt =3D true;
>     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
> }
>=20
> --=20
> 2.7.4
>=20

Windows 2000 boots for me when I use the =E2=80=9C-machine =
pc-i440fx-2.9=E2=80=9D option.
Windows XP boots as well with the option.

tested-by: John Arbuckle <programmingkidx@gmail.com>

I do have one suggestion. When the user runs "qemu-system-i386 -machine =
?=E2=80=9D, do you think we could add a note about how APCI 1.0 is used.=20=


pc-i440fx-2.9        Standard PC (i440FX + PIIX + APCI 1.0, 1996).

pc-i440fx-2.10       Standard PC (i440FX + PIIX + APCI 2.0, 1996) =
(default)
