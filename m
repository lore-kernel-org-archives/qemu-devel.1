Received: from eggs.gnu.org ([2001:4830:134:3::10]:46999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebue2-0006QG-OQ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebue0-00046N-5b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:49:14 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebue0-00046D-0k
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:49:12 -0500
Received: by mail-qt0-x242.google.com with SMTP id o35so14865584qtj.13
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 12:49:11 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516209965.git.alistair.francis@xilinx.com>
	<dd94d623370e93921062e7efc814693ec6aef7ca.1516209965.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5de1d0fe-17d8-7739-a4a4-e995ab9783f2@amsat.org>
Date: Wed, 17 Jan 2018 17:49:07 -0300
MIME-Version: 1.0
In-Reply-To: <dd94d623370e93921062e7efc814693ec6aef7ca.1516209965.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] xlnx-zynqmp: Connect the RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

On 01/17/2018 02:27 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> --
> 2.14.1
> 
