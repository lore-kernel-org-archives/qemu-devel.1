Received: from eggs.gnu.org ([2001:4830:134:3::10]:54169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eOdXz-00072l-G9
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eOdXu-0006K3-QE
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:56:07 -0500
Message-ID: <5A2F6F44.8050602@huawei.com>
Date: Tue, 12 Dec 2017 13:55:16 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/virt: Add another UART to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Shannon Zhao <shannon.zhao@linaro.org>



On 2017/12/8 23:02, Peter Maydell wrote:
> Currently we only provide one non-secure UART on the virt
> board. This is OK for most purposes, but there are some
> use cases where having a second UART would be useful (like
> bare-metal testing where you don't really want to have to
> probe and set up a PCI device just to have a second comms
> channel).
> 
> Add a second NS UART to the virt board. This will be the
> second serial device if 'secure=no' (the default), and the
> third serial device if 'secure=yes'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/virt.h |  2 ++
>  hw/arm/virt.c         | 19 ++++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 33b0ff3..685009a 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -72,6 +72,7 @@ enum {
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> +    VIRT_UART_2,
>  };
>  
>  typedef struct MemMapEntry {
> @@ -85,6 +86,7 @@ typedef struct {
>      bool no_its;
>      bool no_pmu;
>      bool claim_edge_triggered_timers;
> +    bool no_second_uart;
>  } VirtMachineClass;
>  
>  typedef struct {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 543f9bd..e234f55 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -139,6 +139,7 @@ static const MemMapEntry a15memmap[] = {
>      [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
> +    [VIRT_UART_2] =             { 0x09050000, 0x00001000 },
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -157,6 +158,7 @@ static const int a15irqmap[] = {
>      [VIRT_PCIE] = 3, /* ... to 6 */
>      [VIRT_GPIO] = 7,
>      [VIRT_SECURE_UART] = 8,
> +    [VIRT_UART_2] = 9,
>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
> @@ -676,7 +678,7 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
>  
>      if (uart == VIRT_UART) {
>          qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
> -    } else {
> +    } else if (uart == VIRT_SECURE_UART) {
>          /* Mark as not usable by the normal world */
>          qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
>          qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
> @@ -1260,6 +1262,7 @@ static void machvirt_init(MachineState *machine)
>      int n, virt_max_cpus;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> +    int uart_count = 0;
>  
>      /* We can probe only here because during property set
>       * KVM is not available yet
> @@ -1419,11 +1422,16 @@ static void machvirt_init(MachineState *machine)
>  
>      fdt_add_pmu_nodes(vms);
>  
> -    create_uart(vms, pic, VIRT_UART, sysmem, serial_hds[0]);
> +    create_uart(vms, pic, VIRT_UART, sysmem, serial_hds[uart_count++]);
>  
>      if (vms->secure) {
>          create_secure_ram(vms, secure_sysmem);
> -        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hds[1]);
> +        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem,
> +                    serial_hds[uart_count++]);
> +    }
> +
> +    if (!vmc->no_second_uart) {
> +        create_uart(vms, pic, VIRT_UART_2, sysmem, serial_hds[uart_count++]);
>      }
>  
>      create_rtc(vms, pic);
> @@ -1693,8 +1701,13 @@ static void virt_2_11_instance_init(Object *obj)
>  
>  static void virt_machine_2_11_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_2_12_options(mc);
>      SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
> +
> +    /* The second NS UART was added in 2.12 */
> +    vmc->no_second_uart = true;
>  }
>  DEFINE_VIRT_MACHINE(2, 11)
>  
> 
I'm wondering if it need to provide a machine option for user to choose
whether adding the second uart or not.

Thanks,
-- 
Shannon
