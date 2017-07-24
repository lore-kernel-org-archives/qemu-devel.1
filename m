Received: from eggs.gnu.org ([2001:4830:134:3::10]:36583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dZfia-0006nA-SM
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dZfiX-0005iQ-0W
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:56:24 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:38807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dZfiW-0005hc-Ri
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:56:20 -0400
Received: by mail-it0-x241.google.com with SMTP id h199so2911696ith.5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:56:19 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1500904220-29338-1-git-send-email-imammedo@redhat.com>
Date: Mon, 24 Jul 2017 11:56:16 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E0B7A7E-0B0A-4641-9966-A6507FE9E555@gmail.com>
References: <1500904220-29338-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] pc: acpi: force FADT rev1 for 440fx
 based machine types
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


> On Jul 24, 2017, at 9:50 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> w2k used to boot on QEMU until revision of FADT has
> been bumped to rev3
> (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to =
improve guest OS support.)
>=20
> Keep PC machine at rev1 to remain compatible and Q35
> at rev3 where w2k isn't supported anyway so OSX could
> run as well.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   - make pc rev1 and q35 rev3.
>       "Michael S. Tsirkin" <mst@redhat.com>
>=20
> PS:
> Only compile tested.
>=20
>=20
> CC: Programmingkid <programmingkidx@gmail.com>
> CC: Phil Dennis-Jordan <lists@philjordan.eu>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> ---
> hw/i386/acpi-build.c | 22 ++++++++++++++++++----
> 1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade..b9c245c 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -90,6 +90,7 @@ typedef struct AcpiMcfgInfo {
> } AcpiMcfgInfo;
>=20
> typedef struct AcpiPmInfo {
> +    bool force_rev1_fadt;
>     bool s3_disabled;
>     bool s4_disabled;
>     bool pcihp_bridge_en;
> @@ -129,10 +130,13 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>     Object *obj =3D NULL;
>     QObject *o;
>=20
> +    pm->force_rev1_fadt =3D false;
>     pm->cpu_hp_io_base =3D 0;
>     pm->pcihp_io_base =3D 0;
>     pm->pcihp_io_len =3D 0;
>     if (piix) {
> +        /* w2k requires FADT(rev1) or it won't boot, keep PC =
compatible */
> +        pm->force_rev1_fadt =3D true;
>         obj =3D piix;
>         pm->cpu_hp_io_base =3D PIIX4_CPU_HOTPLUG_IO_BASE;
>         pm->pcihp_io_base =3D
> @@ -304,6 +308,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 =
*fadt, AcpiPmInfo *pm)
>         fadt->flags |=3D cpu_to_le32(1 << =
ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
>     }
>     fadt->century =3D RTC_CENTURY;
> +    if (pm->force_rev1_fadt) {
> +        return;
> +    }
>=20
>     fadt->flags |=3D cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
>     fadt->reset_value =3D 0xf;
> @@ -342,6 +349,8 @@ build_fadt(GArray *table_data, BIOSLinker *linker, =
AcpiPmInfo *pm,
>     unsigned fw_ctrl_offset =3D (char *)&fadt->firmware_ctrl - =
table_data->data;
>     unsigned dsdt_entry_offset =3D (char *)&fadt->dsdt - =
table_data->data;
>     unsigned xdsdt_entry_offset =3D (char *)&fadt->x_dsdt - =
table_data->data;
> +    int fadt_size =3D sizeof(*fadt);
> +    int rev =3D 3;
>=20
>     /* FACS address to be filled by Guest linker */
>     bios_linker_loader_add_pointer(linker,
> @@ -353,12 +362,17 @@ build_fadt(GArray *table_data, BIOSLinker =
*linker, AcpiPmInfo *pm,
>     bios_linker_loader_add_pointer(linker,
>         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> -    bios_linker_loader_add_pointer(linker,
> -        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, =
sizeof(fadt->x_dsdt),
> -        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
> +    if (pm->force_rev1_fadt) {
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
> --=20
> 2.7.4
>=20

Just booted up Windows 2000 with your patch. Thank you.

Tested-By: John Arbuckle <programmingkidx@gmail.com>
