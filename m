Received: from eggs.gnu.org ([2001:4830:134:3::10]:43975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7U5k-0003DE-9j
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7U5Z-0007CW-Nx
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:28:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7U5U-000730-JN
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:28:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so4043099wrr.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 16:28:17 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-10-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <66b12ef2-5e26-907d-7df8-d0982d7016d5@redhat.com>
Date: Wed, 3 Oct 2018 01:28:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-10-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 9/9] hw/arm/xilinx_zynq: connect uart
 clocks to slcr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com

On 10/2/18 4:24 PM, Damien Hedde wrote:
> Add the connection between the slcr's output clocks and the uarts inputs.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/arm/xilinx_zynq.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index f1496d2927..88f61c6a18 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -166,7 +166,7 @@ static void zynq_init(MachineState *machine)
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
>      MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
> -    DeviceState *dev;
> +    DeviceState *dev, *slcr;
>      SysBusDevice *busdev;
>      qemu_irq pic[64];
>      int n;
> @@ -212,9 +212,10 @@ static void zynq_init(MachineState *machine)
>                            1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
>                                0);
>  
> -    dev = qdev_create(NULL, "xilinx,zynq_slcr");
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
> +    /* Create slcr, keep a pointer to connect clocks */
> +    slcr = qdev_create(NULL, "xilinx,zynq_slcr");
> +    qdev_init_nofail(slcr);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>  
>      dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
>      qdev_prop_set_uint32(dev, "num-cpu", 1);
> @@ -235,8 +236,12 @@ static void zynq_init(MachineState *machine)
>      sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
>      sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
>  
> -    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
> -    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
> +    dev = cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
> +    qdev_connect_clock(dev, "busclk", slcr, "uart0_amba_clk", &error_abort);
> +    qdev_connect_clock(dev, "refclk", slcr, "uart0_ref_clk", &error_abort);
> +    dev = cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
> +    qdev_connect_clock(dev, "busclk", slcr, "uart1_amba_clk", &error_abort);
> +    qdev_connect_clock(dev, "refclk", slcr, "uart1_ref_clk", &error_abort);
>  
>      sysbus_create_varargs("cadence_ttc", 0xF8001000,
>              pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
