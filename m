Received: from eggs.gnu.org ([2001:4830:134:3::10]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHXe8-0007nA-T4
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHXe8-0007D0-1t
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:08:36 -0500
Date: Thu, 15 Dec 2016 16:08:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161215160822.79151aec@nial.brq.redhat.com>
In-Reply-To: <20161213214522.25548-10-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
	<20161213214522.25548-10-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/11] hw/arm/virt-acpi-build: don't save
 VirtGuestInfo on AcpiBuildState
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

On Tue, 13 Dec 2016 22:45:20 +0100
Andrew Jones <drjones@redhat.com> wrote:

> We can get to VirtMachineState without the need for saving a pointer
> on AcpiBuildState. This is the mach-virt equivalent to "acpi: Don't save
> PcGuestInfo on AcpiBuildState"
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7a1efd0dc538..137781646bec 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -706,7 +706,6 @@ struct AcpiBuildState {
>      MemoryRegion *linker_mr;
>      /* Is table patched? */
>      bool patched;
> -    VirtGuestInfo *guest_info;
>  } AcpiBuildState;
>  
>  static
> @@ -779,6 +778,8 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
>  
>  static void virt_acpi_build_update(void *build_opaque)
>  {
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    VirtMachineState *vms = VIRT_MACHINE(machine);
>      AcpiBuildState *build_state = build_opaque;
>      AcpiBuildTables tables;
>  
> @@ -790,8 +791,7 @@ static void virt_acpi_build_update(void *build_opaque)
>  
>      acpi_build_tables_init(&tables);
>  
> -    virt_acpi_build(container_of(build_state->guest_info,
> -                                 VirtMachineState, acpi_guest_info), &tables);
> +    virt_acpi_build(vms, &tables);

virt_acpi_build(VIRT_MACHINE(qdev_get_machine()), &tables);

or even better do it inside of virt_acpi_build(&tables);


>  
>      acpi_ram_update(build_state->table_mr, tables.table_data);
>      acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
> @@ -841,7 +841,6 @@ void virt_acpi_setup(VirtMachineState *vms)
>      }
>  
>      build_state = g_malloc0(sizeof *build_state);
> -    build_state->guest_info = guest_info;
>  
>      acpi_build_tables_init(&tables);
>      virt_acpi_build(vms, &tables);
