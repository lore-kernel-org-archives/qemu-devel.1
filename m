Received: from eggs.gnu.org ([2001:4830:134:3::10]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPY4S-0001WY-6r
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPY4R-0007FZ-3v
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:12:52 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:35209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPY4Q-0007FD-Th
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:12:51 -0500
Received: by mail-ua0-x233.google.com with SMTP id y9so81029369uae.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 09:12:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170102200153.28864-16-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
	<20170102200153.28864-16-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 17:12:29 +0000
Message-ID: <CAFEAcA_bdPDyemXcnTAM497RKhXhYRpk5KJNs=h+7OtEkQ+60A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 15/16] hw/arm/virt-acpi-build: use SMC
 if booting in EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhao@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 2 January 2017 at 20:01, Andrew Jones <drjones@redhat.com> wrote:
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index b5e17a680d51..7c00ee683f44 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -643,16 +643,16 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  }
>
>  /* FADT */
> -static void
> -build_fadt(GArray *table_data, BIOSLinker *linker, unsigned dsdt_tbl_offset)
> +static void build_fadt(GArray *table_data, BIOSLinker *linker,
> +                       VirtMachineState *vms, unsigned dsdt_tbl_offset)
>  {
>      AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
>      unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
> +    uint16_t use_hvc = vms->virt ? 0 : ACPI_FADT_ARM_PSCI_USE_HVC;

This is the wrong condition -- you should just check whether
vms->psci_conduit is QEMU_PSCI_CONDUIT_HVC (vs _SMC or _DISABLED), something
like:

    switch (vms->psci_conduit) {
    case QEMU_PSCI_CONDUIT_DISABLED:
        /* XXX should we fail, or boot without the PSCI_COMPLIANT flag? */
        use_hvc = 0;
        break;
    case QEMU_PSCI_CONDUIT_HVC:
        use_hvc = ACPI_FADT_ARM_PSCI_USE_HVC;
        break;
    case QEMU_PSCI_CONDUIT_SMC:
        use_hvc = 0;
        break;
    default:
        g_assert_not_reached();
    }

What should we do in the DISABLED case ?

> -    /* Hardware Reduced = 1 and use PSCI 0.2+ and with HVC */
> +    /* Hardware Reduced = 1 and use PSCI 0.2+ */
>      fadt->flags = cpu_to_le32(1 << ACPI_FADT_F_HW_REDUCED_ACPI);
> -    fadt->arm_boot_flags = cpu_to_le16(ACPI_FADT_ARM_PSCI_COMPLIANT |
> -                                       ACPI_FADT_ARM_PSCI_USE_HVC);
> +    fadt->arm_boot_flags = cpu_to_le16(ACPI_FADT_ARM_PSCI_COMPLIANT | use_hvc);
>
>      /* ACPI v5.1 (fadt->revision.fadt->minor_revision) */
>      fadt->minor_revision = 0x1;
> @@ -738,7 +738,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>
>      /* FADT MADT GTDT MCFG SPCR pointed to by RSDT */
>      acpi_add_table(table_offsets, tables_blob);
> -    build_fadt(tables_blob, tables->linker, dsdt);
> +    build_fadt(tables_blob, tables->linker, vms, dsdt);
>
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, vms);

thanks
-- PMM
