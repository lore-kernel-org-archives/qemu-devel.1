Received: from eggs.gnu.org ([2001:4830:134:3::10]:60594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHXIN-00084Q-S5
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHXIM-0005ra-TT
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:46:07 -0500
Date: Thu, 15 Dec 2016 15:45:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161215154555.6137b8f7@nial.brq.redhat.com>
In-Reply-To: <20161213214522.25548-8-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
	<20161213214522.25548-8-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/11] hw/arm/virt: pass VirtMachineState
 instead of VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, ehabkost@redhat.com, zhaoshenglong@huawei.com

On Tue, 13 Dec 2016 22:45:18 +0100
Andrew Jones <drjones@redhat.com> wrote:

> Only two functions take VirtGuestInfo parameters. Now that guest-info
> is part of VirtMachineState, and VirtMachineState is defined in the
> virt header, pass that instead.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 3 ++-
>  hw/arm/virt.c            | 8 ++++----
>  include/hw/arm/virt.h    | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index db44e2dd5f12..f7ce6aeed307 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -822,8 +822,9 @@ static const VMStateDescription vmstate_virt_acpi_build = {
>      },
>  };
>  
> -void virt_acpi_setup(VirtGuestInfo *guest_info)
> +void virt_acpi_setup(VirtMachineState *vms)
>  {
> +    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
>      AcpiBuildTables tables;
>      AcpiBuildState *build_state;
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7860fade52f1..bcf8a2954c16 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1156,9 +1156,9 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>      return board->fdt;
>  }
>  
> -static void virt_build_smbios(VirtGuestInfo *guest_info)
> +static void virt_build_smbios(VirtMachineState *vms)
Looks like all it needs is 'fw_cfg'
If there aren't plans to use more data from VirtMachineState,
just passing fw_cfg should be enough.

>  {
> -    FWCfgState *fw_cfg = guest_info->fw_cfg;
> +    FWCfgState *fw_cfg = vms->acpi_guest_info.fw_cfg;
>      uint8_t *smbios_tables, *smbios_anchor;
>      size_t smbios_tables_len, smbios_anchor_len;
>      const char *product = "QEMU Virtual Machine";
> @@ -1191,8 +1191,8 @@ void virt_machine_done(Notifier *notifier, void *data)
>      VirtMachineState *vms = container_of(notifier, VirtMachineState,
>                                           machine_done);
>  
> -    virt_acpi_setup(&vms->acpi_guest_info);
> -    virt_build_smbios(&vms->acpi_guest_info);
> +    virt_acpi_setup(vms);
> +    virt_build_smbios(vms);
>  }
>  
>  static void machvirt_init(MachineState *machine)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 77d25dbddb62..cbedc682ae99 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -128,6 +128,6 @@ typedef struct {
>      OBJECT_CLASS_CHECK(VirtMachineClass, klass, TYPE_VIRT_MACHINE)
>  
>  
> -void virt_acpi_setup(VirtGuestInfo *guest_info);
> +void virt_acpi_setup(VirtMachineState *vms);
>  
>  #endif /* QEMU_ARM_VIRT_H */
