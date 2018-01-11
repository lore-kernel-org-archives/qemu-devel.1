Received: from eggs.gnu.org ([2001:4830:134:3::10]:52437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZhiM-0007wn-MN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZhiJ-0005kg-8m
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:36:34 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZhiJ-0005kG-4G
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:36:31 -0500
Received: by mail-qt0-x241.google.com with SMTP id u42so3003594qte.7
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:36:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <b799d9d21170a492c54fb2c4eaf8326b06e0bdf6.1515523657.git.alistair.francis@xilinx.com>
	<0ecd5644773477442fbaa0f4bcadb58bbe488c78.1515523657.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <656bb912-94ac-9eda-a664-ad23db3564c3@amsat.org>
Date: Thu, 11 Jan 2018 15:36:27 -0300
MIME-Version: 1.0
In-Reply-To: <0ecd5644773477442fbaa0f4bcadb58bbe488c78.1515523657.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] xlnx-zynqmp: Connect the RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, edgar.iglesias@gmail.com

On 01/09/2018 03:50 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  hw/arm/xlnx-zynqmp.c         | 14 ++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 325642058b..deef583c2a 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -50,6 +50,9 @@
>  #define DPDMA_ADDR          0xfd4c0000
>  #define DPDMA_IRQ           116
>  
> +#define RTC_ADDR            0xffa60000
> +#define RTC_IRQ             26
> +
>  static const uint64_t gem_addr[XLNX_ZYNQMP_NUM_GEMS] = {
>      0xFF0B0000, 0xFF0C0000, 0xFF0D0000, 0xFF0E0000,
>  };
> @@ -183,6 +186,9 @@ static void xlnx_zynqmp_init(Object *obj)
>  
>      object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
>      qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
> +
> +    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_XLNX_ZYNQMP_RTC);

While here:

    object_property_add_child(obj, "rtc", OBJECT(&s->rtc), NULL);

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());
>  }
>  
>  static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> @@ -454,6 +460,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                               &error_abort);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
> +
> +    object_property_set_bool(OBJECT(&s->rtc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
>  }
>  
>  static Property xlnx_zynqmp_props[] = {
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 3e6fb9b7bd..9e8c9e18dd 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -28,6 +28,7 @@
>  #include "hw/ssi/xilinx_spips.h"
>  #include "hw/dma/xlnx_dpdma.h"
>  #include "hw/display/xlnx_dp.h"
> +#include "hw/timer/xlnx-zynqmp-rtc.h"
>  
>  #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
>  #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
> @@ -90,6 +91,7 @@ typedef struct XlnxZynqMPState {
>      XlnxZynqMPQSPIPS qspi;
>      XlnxDPState dp;
>      XlnxDPDMAState dpdma;
> +    XlnxZynqMPRTC rtc;
>  
>      char *boot_cpu;
>      ARMCPU *boot_cpu_ptr;
> 
