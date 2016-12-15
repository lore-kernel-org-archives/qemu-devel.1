Received: from eggs.gnu.org ([2001:4830:134:3::10]:52910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHWms-00081q-VQ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHWmr-0000Y2-VI
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:13:34 -0500
Date: Thu, 15 Dec 2016 15:13:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161215151324.2b4e6b74@nial.brq.redhat.com>
In-Reply-To: <20161213214522.25548-5-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
	<20161213214522.25548-5-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/11] hw/arm/virt: eliminate struct
 VirtGuestInfoState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, ehabkost@redhat.com

On Tue, 13 Dec 2016 22:45:15 +0100
Andrew Jones <drjones@redhat.com> wrote:

> Instead of allocating a new struct just for VirtGuestInfo and the
> machine_done Notifier, place them inside VirtMachineState. This
> is the mach-virt equivalent of "pc: Eliminate struct
> PcGuestInfoState"
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c                    | 20 +++++++++++---------
>  include/hw/arm/virt-acpi-build.h |  6 ------
>  2 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 18aa3672739d..0657f9ae8722 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -76,6 +76,8 @@ typedef struct {
>  
>  typedef struct {
>      MachineState parent;
> +    VirtGuestInfo acpi_guest_info;
> +    Notifier machine_done;
>      bool secure;
>      bool highmem;
>      bool virt;
> @@ -1222,12 +1224,13 @@ static void virt_build_smbios(VirtGuestInfo *guest_info)
>  }
>  
>  static
> -void virt_guest_info_machine_done(Notifier *notifier, void *data)
> +void virt_machine_done(Notifier *notifier, void *data)
>  {
> -    VirtGuestInfoState *guest_info_state = container_of(notifier,
> -                                              VirtGuestInfoState, machine_done);
> -    virt_acpi_setup(&guest_info_state->info);
> -    virt_build_smbios(&guest_info_state->info);
> +    VirtMachineState *vms = container_of(notifier, VirtMachineState,
> +                                         machine_done);
> +
> +    virt_acpi_setup(&vms->acpi_guest_info);
> +    virt_build_smbios(&vms->acpi_guest_info);
>  }
>  
>  static void machvirt_init(MachineState *machine)
> @@ -1240,8 +1243,7 @@ static void machvirt_init(MachineState *machine)
>      int n, virt_max_cpus;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      const char *cpu_model = machine->cpu_model;
> -    VirtGuestInfoState *guest_info_state = g_malloc0(sizeof *guest_info_state);
> -    VirtGuestInfo *guest_info = &guest_info_state->info;
> +    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
>      char **cpustr;
>      ObjectClass *oc;
>      const char *typename;
> @@ -1459,8 +1461,8 @@ static void machvirt_init(MachineState *machine)
>      guest_info->use_highmem = vms->highmem;
>      guest_info->gic_version = vms->gic_version;
>      guest_info->no_its = vmc->no_its;
> -    guest_info_state->machine_done.notify = virt_guest_info_machine_done;
> -    qemu_add_machine_init_done_notifier(&guest_info_state->machine_done);
> +    vms->machine_done.notify = virt_machine_done;
> +    qemu_add_machine_init_done_notifier(&vms->machine_done);
>  
>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
> diff --git a/include/hw/arm/virt-acpi-build.h b/include/hw/arm/virt-acpi-build.h
> index f5ec749b8fea..d74d7a1af650 100644
> --- a/include/hw/arm/virt-acpi-build.h
> +++ b/include/hw/arm/virt-acpi-build.h
> @@ -36,12 +36,6 @@ typedef struct VirtGuestInfo {
>      bool no_its;
>  } VirtGuestInfo;
>  
> -
> -typedef struct VirtGuestInfoState {
> -    VirtGuestInfo info;
> -    Notifier machine_done;
> -} VirtGuestInfoState;
> -
>  void virt_acpi_setup(VirtGuestInfo *guest_info);
>  
>  #endif
