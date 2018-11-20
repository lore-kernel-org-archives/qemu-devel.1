Received: from eggs.gnu.org ([2001:4830:134:3::10]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7WI-0001xt-V1
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7WH-00025q-MU
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:00:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7WH-00025g-Ho
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:00:53 -0500
Received: by mail-ot1-x342.google.com with SMTP id u3so1908324ota.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:00:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541672989-15967-10-git-send-email-gengdongjiu@huawei.com>
References: <1541672989-15967-1-git-send-email-gengdongjiu@huawei.com>
	<1541672989-15967-10-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 15:00:32 +0000
Message-ID: <CAFEAcA_qpWcLULXza_cgB2_vKSBtP1bCwYEhFL0fydkvZ82EmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND v15 09/10] hw/arm/virt: Add RAS
 platform version for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Zheng Xiang <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 November 2018 at 10:29, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> Support this feature since version 2.12, disable it by
> default in the old version.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> Address Shannon's comments to add platform version in [1].
>
> [1]: https://lkml.org/lkml/2017/8/25/821
> ---
>  hw/arm/virt-acpi-build.c | 14 +++++++++-----
>  hw/arm/virt.c            |  4 ++++
>  include/hw/arm/virt.h    |  1 +
>  3 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 19c1b7e..6f50a29 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -836,10 +836,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_spcr(tables_blob, tables->linker, vms);
>
> -    acpi_add_table(table_offsets, tables_blob);
> -    build_hardware_error_table(tables->hardware_errors, tables->linker);
> -    build_apei_hest(tables_blob, tables->hardware_errors, tables->linker);
> -
> +    if (!vmc->no_ras) {
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_hardware_error_table(tables->hardware_errors, tables->linker);
> +        build_apei_hest(tables_blob, tables->hardware_errors, tables->linker);
> +    }

This looks odd. If we need to gate the addition of the table
on whether the machine type asks for it, then we need the
patch which adds the no_ras flag to come first. Otherwise
there's a point in the commit history where we add the tables
even for the older machine types.

>      if (nb_numa_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
> @@ -926,6 +927,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
>
>  void virt_acpi_setup(VirtMachineState *vms)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>
> @@ -957,7 +959,9 @@ void virt_acpi_setup(VirtMachineState *vms)
>      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
>                      acpi_data_len(tables.tcpalog));
>
> -    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
> +    if (!vmc->no_ras) {
> +        ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
> +    }
>
>      build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
>                                                ACPI_BUILD_RSDP_FILE, 0);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a2b8d8f..367306b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1920,6 +1920,10 @@ static void virt_machine_2_11_options(MachineClass *mc)
>      virt_machine_2_12_options(mc);
>      SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
>      vmc->smbios_old_sys_ver = true;
> +    /* Disable memory recovery feature for 2.11 as RAS support was
> +     * introduced with 2.12.
> +     */
> +    vmc->no_ras = true;

RAS support wasn't introduced with QEMU 2.12, or even with 3.0 or
3.1. The earliest this will be added will be 4.0, so we need to
update this code accordingly.

>  }
>  DEFINE_VIRT_MACHINE(2, 11)
>
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 4cc57a7..a4490dd 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -98,6 +98,7 @@ typedef struct {
>      bool disallow_affinity_adjustment;
>      bool no_its;
>      bool no_pmu;
> +    bool no_ras;
>      bool claim_edge_triggered_timers;
>      bool smbios_old_sys_ver;
>      bool no_highmem_ecam;
> --
> 1.8.3.1
>

thanks
-- PMM
