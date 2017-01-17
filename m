Received: from eggs.gnu.org ([2001:4830:134:3::10]:34824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTc29-0000De-03
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTc28-0004Vc-1P
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:15:16 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1483977924-14522-16-git-send-email-peter.maydell@linaro.org>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<1483977924-14522-16-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Jan 2017 14:14:41 -0800
Message-ID: <CAKmqyKPSVFrgS69KwmJ9TfCM2o8LDDNjsuSn6bzvyDu2Vn7zcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 15/18] hw/arm/virt-acpi-build: use SMC
 if booting in EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrew Jones <drjones@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On Mon, Jan 9, 2017 at 8:05 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> From: Andrew Jones <drjones@redhat.com>
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> [PMM: look at vms->psci_conduit rather than vms->virt
>  to decide whether to use HVC or SMC, and report no
>  PSCI support at all for the 'PSCI disabled' case]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/arm/virt-acpi-build.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 085a611..ec7f83b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -643,16 +643,30 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
> +    uint16_t bootflags;
> +
> +    switch (vms->psci_conduit) {
> +    case QEMU_PSCI_CONDUIT_DISABLED:
> +        bootflags = 0;
> +        break;
> +    case QEMU_PSCI_CONDUIT_HVC:
> +        bootflags = ACPI_FADT_ARM_PSCI_COMPLIANT | ACPI_FADT_ARM_PSCI_USE_HVC;
> +        break;
> +    case QEMU_PSCI_CONDUIT_SMC:
> +        bootflags = ACPI_FADT_ARM_PSCI_COMPLIANT;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
>
> -    /* Hardware Reduced = 1 and use PSCI 0.2+ and with HVC */
> +    /* Hardware Reduced = 1 and use PSCI 0.2+ */
>      fadt->flags = cpu_to_le32(1 << ACPI_FADT_F_HW_REDUCED_ACPI);
> -    fadt->arm_boot_flags = cpu_to_le16(ACPI_FADT_ARM_PSCI_COMPLIANT |
> -                                       ACPI_FADT_ARM_PSCI_USE_HVC);
> +    fadt->arm_boot_flags = cpu_to_le16(bootflags);
>
>      /* ACPI v5.1 (fadt->revision.fadt->minor_revision) */
>      fadt->minor_revision = 0x1;
> @@ -738,7 +752,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>
>      /* FADT MADT GTDT MCFG SPCR pointed to by RSDT */
>      acpi_add_table(table_offsets, tables_blob);
> -    build_fadt(tables_blob, tables->linker, dsdt);
> +    build_fadt(tables_blob, tables->linker, vms, dsdt);
>
>      acpi_add_table(table_offsets, tables_blob);
>      build_madt(tables_blob, tables->linker, vms);
> --
> 2.7.4
>
>
