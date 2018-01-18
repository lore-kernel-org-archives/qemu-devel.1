Received: from eggs.gnu.org ([2001:4830:134:3::10]:33061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecHmt-00016t-2n
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecHms-00021p-67
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:31:55 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516300623.git.alistair.francis@xilinx.com>
	<01de185b273b999f1a4df07cb0e4b2e8216689f0.1516300623.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c36cbf6-3bbb-02ed-af88-ce1e8faaa491@amsat.org>
Date: Thu, 18 Jan 2018 18:31:45 -0300
MIME-Version: 1.0
In-Reply-To: <01de185b273b999f1a4df07cb0e4b2e8216689f0.1516300623.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 6/9] xlnx-zynqmp-pmu: Connect the PMU
 interrupt controller
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

On 01/18/2018 03:38 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  hw/microblaze/xlnx-zynqmp-pmu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 145837b372..7312bfe23e 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -24,6 +24,8 @@
>  #include "cpu.h"
>  #include "boot.h"
>  
> +#include "hw/intc/xlnx-pmu-iomod-intc.h"
> +
>  /* Define the PMU device */
>  
>  #define TYPE_XLNX_ZYNQMP_PMU_SOC "xlnx,zynqmp-pmu-soc"
> @@ -34,14 +36,18 @@
>  #define XLNX_ZYNQMP_PMU_ROM_ADDR    0xFFD00000
>  #define XLNX_ZYNQMP_PMU_RAM_ADDR    0xFFDC0000
>  
> +#define XLNX_ZYNQMP_PMU_INTC_ADDR   0xFFD40000
> +
>  typedef struct XlnxZynqMPPMUSoCState {
>      /*< private >*/
>      DeviceState parent_obj;
>  
>      /*< public >*/
>      MicroBlazeCPU cpu;
> +    XlnxPMUIOIntc intc;
>  }  XlnxZynqMPPMUSoCState;
>  
> +
>  static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>  {
>      XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
> @@ -50,6 +56,9 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>                        TYPE_MICROBLAZE_CPU);
>      object_property_add_child(obj, "pmu-cpu", OBJECT(&s->cpu),
>                                &error_abort);
> +
> +    object_initialize(&s->intc, sizeof(s->intc), TYPE_XLNX_PMU_IO_INTC);
> +    qdev_set_parent_bus(DEVICE(&s->intc), sysbus_get_default());
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
> @@ -80,6 +89,21 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> +
> +    object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size",
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge",
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->intc), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->cpu), MB_CPU_IRQ));
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
> 
