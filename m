Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ediT6-0008ED-Bs
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ediT5-0003C2-8u
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:13:24 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516650109.git.alistair.francis@xilinx.com>
	<7b176d7bc8271aebdaacb4635f7f31d8fc41c078.1516650109.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <754d7340-287e-2068-4ece-b13e6da6d4f8@amsat.org>
Date: Mon, 22 Jan 2018 17:13:17 -0300
MIME-Version: 1.0
In-Reply-To: <7b176d7bc8271aebdaacb4635f7f31d8fc41c078.1516650109.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 9/9] xlnx-zynqmp: Connect the IPI device
 to the ZynqMP SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair23@gmail.com, qemu-arm@nongnu.org

On 01/22/2018 04:43 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  include/hw/arm/xlnx-zynqmp.h |  2 ++
>  hw/arm/xlnx-zynqmp.c         | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 3e6fb9b7bd..0a2b037c6b 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -28,6 +28,7 @@
>  #include "hw/ssi/xilinx_spips.h"
>  #include "hw/dma/xlnx_dpdma.h"
>  #include "hw/display/xlnx_dp.h"
> +#include "hw/intc/xlnx-zynqmp-ipi.h"
>  
>  #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
>  #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
> @@ -90,6 +91,7 @@ typedef struct XlnxZynqMPState {
>      XlnxZynqMPQSPIPS qspi;
>      XlnxDPState dp;
>      XlnxDPDMAState dpdma;
> +    XlnxZynqMPIPI ipi;
>  
>      char *boot_cpu;
>      ARMCPU *boot_cpu_ptr;
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 325642058b..ca398c4159 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -50,6 +50,9 @@
>  #define DPDMA_ADDR          0xfd4c0000
>  #define DPDMA_IRQ           116
>  
> +#define IPI_ADDR            0xFF300000
> +#define IPI_IRQ             64
> +
>  static const uint64_t gem_addr[XLNX_ZYNQMP_NUM_GEMS] = {
>      0xFF0B0000, 0xFF0C0000, 0xFF0D0000, 0xFF0E0000,
>  };
> @@ -183,6 +186,9 @@ static void xlnx_zynqmp_init(Object *obj)
>  
>      object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
>      qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
> +
> +    object_initialize(&s->ipi, sizeof(s->ipi), TYPE_XLNX_ZYNQMP_IPI);
> +    qdev_set_parent_bus(DEVICE(&s->ipi), sysbus_get_default());
>  }
>  
>  static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> @@ -454,6 +460,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                               &error_abort);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
> +
> +    object_property_set_bool(OBJECT(&s->ipi), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
>  }
>  
>  static Property xlnx_zynqmp_props[] = {
> 
