Received: from eggs.gnu.org ([2001:4830:134:3::10]:34798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erRkx-0003GM-5M
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erRkd-0002vv-0p
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:12:35 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1erRkc-0002ut-HW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:12:14 -0500
Received: by mail-wm0-x243.google.com with SMTP id i3so12135136wmi.4
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:12:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1519856998.git.alistair.francis@xilinx.com>
	<20a6c98d693277a5e291779164a022cbb37007cf.1519856998.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ebcb58d0-5d72-8edb-276e-a7d7e5a39261@amsat.org>
Date: Thu, 1 Mar 2018 14:12:12 -0300
MIME-Version: 1.0
In-Reply-To: <20a6c98d693277a5e291779164a022cbb37007cf.1519856998.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] hw/gpio: Add support for the
 xlnx-pmu-iomod-gpi device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair23@gmail.com

Hi Alistair,

On 02/28/2018 07:32 PM, Alistair Francis wrote:
> Add support for setting the device and either input or output.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  include/hw/gpio/xlnx-pmu-iomod-gp.h |  7 ++++-
>  hw/gpio/xlnx-pmu-iomod-gp.c         | 55 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/gpio/xlnx-pmu-iomod-gp.h b/include/hw/gpio/xlnx-pmu-iomod-gp.h
> index 0ee162829b..d682693742 100644
> --- a/include/hw/gpio/xlnx-pmu-iomod-gp.h
> +++ b/include/hw/gpio/xlnx-pmu-iomod-gp.h
> @@ -33,18 +33,23 @@
>  #define XLNX_ZYNQMP_IOMOD_GPIO(obj) \
>       OBJECT_CHECK(XlnxPMUIOGPIO, (obj), TYPE_XLNX_ZYNQMP_IOMOD_GPIO)
>  
> -#define XLNX_ZYNQMP_IOMOD_GPIO_R_MAX (0x00 + 1)
> +#define XLNX_ZYNQMP_IOMOD_GPIO_R_MAX (0x20 + 1)
>  
>  typedef struct XlnxPMUIOGPIO {
>      SysBusDevice parent_obj;
>      MemoryRegion iomem;
>  
> +    bool input;

Maybe rename as 'is_input'.

>      uint32_t size;
>  
>      /* GPO */
>      uint32_t init;
>      qemu_irq outputs[32];
>  
> +    /* GPI */
> +    uint32_t ien;
> +    qemu_irq parent_irq;
> +
>      uint32_t regs[XLNX_ZYNQMP_IOMOD_GPIO_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_IOMOD_GPIO_R_MAX];
>  } XlnxPMUIOGPIO;
> diff --git a/hw/gpio/xlnx-pmu-iomod-gp.c b/hw/gpio/xlnx-pmu-iomod-gp.c
> index 0e45a89b44..467d844ae0 100644
> --- a/hw/gpio/xlnx-pmu-iomod-gp.c
> +++ b/hw/gpio/xlnx-pmu-iomod-gp.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU model of Xilinx I/O Module GPO
> + * QEMU model of Xilinx I/O Module GPO and GPI
>   *
>   * Copyright (c) 2013 Xilinx Inc
>   * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> @@ -34,12 +34,17 @@
>  #endif
>  
>  REG32(GPO0, 0x00)
> +REG32(GPI0, 0x20)
>  
>  static void xlnx_iomod_gpio_gpo0_prew(RegisterInfo *reg, uint64_t value)
>  {
>      XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(reg->opaque);
>      unsigned int i;
>  
> +    if (s->input) {

Shouldn't we log something here? GUEST_ERROR probably.

> +        return;
> +    }
> +
>      for (i = 0; i < s->size; i++) {
>          bool flag = !!(value & (1 << i));
>          qemu_set_irq(s->outputs[i], flag);
> @@ -51,10 +56,50 @@ static uint64_t xlnx_iomod_gpio_gpo0_postr(RegisterInfo *reg, uint64_t value)
>      return 0;
>  }
>  
> +static void xlnx_iomod_gpio_irq_handler(void *opaque, int irq, int level)
> +{
> +    XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(opaque);
> +    uint32_t old = s->regs[R_GPI0];
> +
> +    if (!s->input) {

Ditto.

> +        return;
> +    }
> +
> +    /* If enable is set for @irq pin, update @irq pin in GPI and
> +     * trigger interrupt if transition is 0 -> 1.
> +     */
> +    if (s->ien & (1 << irq)) {
> +        s->regs[R_GPI0] &= ~(1 << irq);
> +        s->regs[R_GPI0] |= level << irq;
> +        /* On input pin transition 0->1 trigger interrupt. */
> +        if ((old != s->regs[R_GPI0]) && level) {
> +            qemu_irq_pulse(s->parent_irq);
> +        }
> +    }
> +}
> +
> +/* Called when someone writes into LOCAL GPIx_ENABLE */
> +static void xlnx_iomod_gpio_ien_handler(void *opaque, int n, int level)
> +{
> +    XlnxPMUIOGPIO *s = XLNX_ZYNQMP_IOMOD_GPIO(opaque);
> +
> +    if (!s->input) {

Ditto.

> +        return;
> +    }
> +
> +    s->ien = level;
> +
> +    /* Clear all GPIs that got disabled */
> +    s->regs[R_GPI0] &= s->ien;
> +}
> +
>  static const RegisterAccessInfo xlnx_iomod_gpio_regs_info[] = {
>      {   .name = "GPO0",  .addr = A_GPO0,
>          .post_write = xlnx_iomod_gpio_gpo0_prew,
>          .post_read = xlnx_iomod_gpio_gpo0_postr,
> +    },{ .name = "GPI0",  .addr = A_GPI0,
> +        .rsvd = 0x300030,
> +        .ro = 0xffcfffcf,

or
           .ro = ~0x300030,

>      }
>  };
>  
> @@ -68,6 +113,9 @@ static void xlnx_iomod_gpio_reset(DeviceState *dev)
>      }
>  
>      xlnx_iomod_gpio_gpo0_prew(&s->regs_info[R_GPO0], s->init);
> +
> +    /* Disable all interrupts initially. */
> +    s->ien = 0;
>  }
>  
>  static const MemoryRegionOps xlnx_iomod_gpio_ops = {
> @@ -86,6 +134,9 @@ static void xlnx_iomod_gpio_realize(DeviceState *dev, Error **errp)
>  
>      assert(s->size <= 32);
>      qdev_init_gpio_out(dev, s->outputs, s->size);
> +
> +    qdev_init_gpio_in_named(dev, xlnx_iomod_gpio_irq_handler, "GPI", 32);
> +    qdev_init_gpio_in_named(dev, xlnx_iomod_gpio_ien_handler, "IEN", 32);

eventually 32 -> XLNX_(PMU_)IOMOD_GPIO_COUNT.

>  }
>  
>  static void xlnx_iomod_gpio_init(Object *obj)
> @@ -107,6 +158,7 @@ static void xlnx_iomod_gpio_init(Object *obj)
>                                  0x0,
>                                  &reg_array->mem);
>      sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->parent_irq);
>  }
>  
>  static const VMStateDescription vmstate_xlnx_iomod_gpio = {
> @@ -119,6 +171,7 @@ static const VMStateDescription vmstate_xlnx_iomod_gpio = {
>  };
>  
>  static Property xlnx_iomod_gpio_properties[] = {
> +    DEFINE_PROP_BOOL("input", XlnxPMUIOGPIO, input, false),
>      DEFINE_PROP_UINT32("size", XlnxPMUIOGPIO, size, 0),
>      DEFINE_PROP_UINT32("gpo-init", XlnxPMUIOGPIO, init, 0),
>      DEFINE_PROP_END_OF_LIST(),
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
