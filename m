Received: from eggs.gnu.org ([2001:4830:134:3::10]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLB8-0001vu-EJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLB7-0003pR-Il
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:31:18 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqLB7-0003pJ-EA
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:31:17 -0400
Received: by mail-oi0-x241.google.com with SMTP id q11-v6so9065637oic.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:31:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808210750.3915-3-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-3-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:30:56 +0100
Message-ID: <CAFEAcA8HPHUZC1ZDAhG1p+CkJY3SBWLY6Liy1dOOt_nfLfwMfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/arm/nrf51_soc: Connect UART to
 nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 8 August 2018 at 22:07, Julia Suvorova <jusual@mail.ru> wrote:
> Wire up nRF51 UART in the corresponding SoC using in-place init/realize.
>
> Based-on: <20180803052137.10602-1-joel@jms.id.au>
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/arm/nrf51_soc.c         | 20 ++++++++++++++++++++
>  include/hw/arm/nrf51_soc.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 9f9649c780..8b5602f363 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -38,9 +38,12 @@
>  #define NRF51822_FLASH_SIZE     (256 * 1024)
>  #define NRF51822_SRAM_SIZE      (16 * 1024)
>
> +#define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
> +
>  static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>  {
>      NRF51State *s = NRF51_SOC(dev_soc);
> +    MemoryRegion *mr = NULL;

This variable is unconditionally assigned before use later,
so you don't need to initialize it here. (Some compilers and
analysis tools will complain that the value assigned here is
never used.)

>      Error *err = NULL;
>
>      if (!s->board_memory) {
> @@ -70,6 +73,19 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>      }
>      memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
>
> +    /* UART */
> +    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));

serial_hd() ideally is something that should only be used by board
code. It's better to have the SoC object define a chardev property
which the board then connects up to the serial_hd() chardev.

You can do this by calling
   object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev",
                             &error_abort);
in the SoC's init function. That will create a property "serial0"
on the SoC object that just passes through to the "chardev" property
on the UART. Then in the board code you can set the SoC serial0
property to serial_hd(0).

> +    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
> +    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->cpu),
> +                                        BASE_TO_IRQ(UART_BASE)));
> +
>      create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
>      create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
>      create_unimplemented_device("nrf51_soc.private", 0xF0000000, 0x10000000);
> @@ -86,6 +102,10 @@ static void nrf51_soc_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(&s->cpu), sysbus_get_default());
>      qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type", ARM_CPU_TYPE_NAME("cortex-m0"));
>      qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
> +
> +    object_initialize(&s->uart, sizeof(s->uart), TYPE_NRF51_UART);
> +    object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abort);
> +    qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());

Instead of these three lines, use sysbus_init_child_obj() (which
probably didn't exist when you wrote this code). This avoids a
leak of a refcount on the object.

>  }
>
>  static Property nrf51_soc_properties[] = {
> diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
> index e380ec26b8..46a1c1a66c 100644
> --- a/include/hw/arm/nrf51_soc.h
> +++ b/include/hw/arm/nrf51_soc.h
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/armv7m.h"
> +#include "hw/char/nrf51_uart.h"
>
>  #define TYPE_NRF51_SOC "nrf51-soc"
>  #define NRF51_SOC(obj) \
> @@ -25,6 +26,8 @@ typedef struct NRF51State {
>      /*< public >*/
>      ARMv7MState cpu;
>
> +    NRF51UARTState uart;
> +
>      MemoryRegion iomem;
>      MemoryRegion sram;
>      MemoryRegion flash;
> --
> 2.17.1

thanks
-- PMM
