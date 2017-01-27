Received: from eggs.gnu.org ([2001:4830:134:3::10]:43908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cXBLV-00061W-0z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cXBLT-0006Ga-UR
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:34:01 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1485443388-27253-3-git-send-email-armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-3-git-send-email-armbru@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 27 Jan 2017 10:33:28 -0800
Message-ID: <CAKmqyKMhptS+ntt-PQjY4rsO+mEUf079N0AhYiKF4XRfeKLZHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/8] hw/arm/cubieboard
 hw/arm/xlnx-ep108: Fix units_per_default_bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 26, 2017 at 7:09 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Machine types cubieboard, xlnx-ep108, xlnx-zcu102 have an onboard AHCI
> controller, but neglect to set their MachineClass member
> units_per_default_bus = 1.  This permits -drive if=ide,unit=1, which
> makes no sense for AHCI.  It also screws up index=N for odd N, because
> it gets desugared to unit=1,bus=N/2
>
> Doesn't really matter, because these machine types fail to honor
> -drive if=ide.  Add the missing units_per_default_bus = 1 anyway,
> along with a TODO comment on what needs to be done for -drive if=ide.
>
> Also set block_default_type = IF_IDE explicitly.  It's currently the
> default, but the next commit will change it to something more
> sensible, and we want to keep the IF_IDE default for these three
> machines.  See also the previous commit.
>
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Looks fine to me.

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  hw/arm/cubieboard.c | 4 ++++
>  hw/arm/xlnx-ep108.c | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index dd19ba3..b98e1c4 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -71,6 +71,8 @@ static void cubieboard_init(MachineState *machine)
>      memory_region_add_subregion(get_system_memory(), AW_A10_SDRAM_BASE,
>                                  &s->sdram);
>
> +    /* TODO create and connect IDE devices for ide_drive_get() */
> +
>      cubieboard_binfo.ram_size = machine->ram_size;
>      cubieboard_binfo.kernel_filename = machine->kernel_filename;
>      cubieboard_binfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -82,6 +84,8 @@ static void cubieboard_machine_init(MachineClass *mc)
>  {
>      mc->desc = "cubietech cubieboard";
>      mc->init = cubieboard_init;
> +    mc->block_default_type = IF_IDE;
> +    mc->units_per_default_bus = 1;
>  }
>
>  DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
> diff --git a/hw/arm/xlnx-ep108.c b/hw/arm/xlnx-ep108.c
> index 4ec590a..860780a 100644
> --- a/hw/arm/xlnx-ep108.c
> +++ b/hw/arm/xlnx-ep108.c
> @@ -106,6 +106,8 @@ static void xlnx_ep108_init(MachineState *machine)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.spi[i]), 1, cs_line);
>      }
>
> +    /* TODO create and connect IDE devices for ide_drive_get() */
> +
>      xlnx_ep108_binfo.ram_size = ram_size;
>      xlnx_ep108_binfo.kernel_filename = machine->kernel_filename;
>      xlnx_ep108_binfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -118,6 +120,8 @@ static void xlnx_ep108_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Xilinx ZynqMP EP108 board";
>      mc->init = xlnx_ep108_init;
> +    mc->block_default_type = IF_IDE;
> +    mc->units_per_default_bus = 1;
>  }
>
>  DEFINE_MACHINE("xlnx-ep108", xlnx_ep108_machine_init)
> @@ -126,6 +130,8 @@ static void xlnx_zcu102_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Xilinx ZynqMP ZCU102 board";
>      mc->init = xlnx_ep108_init;
> +    mc->block_default_type = IF_IDE;
> +    mc->units_per_default_bus = 1;
>  }
>
>  DEFINE_MACHINE("xlnx-zcu102", xlnx_zcu102_machine_init)
> --
> 2.7.4
>
>
