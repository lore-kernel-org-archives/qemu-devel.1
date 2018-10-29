Received: from eggs.gnu.org ([2001:4830:134:3::10]:53633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHHIG-00007B-45
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHHIF-000703-52
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:50:00 -0400
MIME-Version: 1.0
References: <20181029232100.8454-1-philmd@redhat.com>
	<20181029232100.8454-3-philmd@redhat.com>
In-Reply-To: <20181029232100.8454-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Oct 2018 16:49:26 -0700
Message-ID: <CAKmqyKM5p26jF2ZASmEiE-qDJOc5g7Znw9EsgOi3keGu9NjMXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/dma/pl330: Factor out pl330_init()
 from hw/arm/xilinx_zynq.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Edgar Iglesias <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Oct 29, 2018 at 4:24 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS            |  1 +
>  hw/arm/xilinx_zynq.c   | 18 ++----------------
>  hw/dma/pl330.c         |  2 +-
>  include/hw/dma/pl330.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 17 deletions(-)
>  create mode 100644 include/hw/dma/pl330.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66..647e2aa0d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -452,6 +452,7 @@ F: hw/display/pl110*
>  F: hw/dma/pl080.c
>  F: include/hw/dma/pl080.h
>  F: hw/dma/pl330.c
> +F: include/hw/dma/pl330.h
>  F: hw/gpio/pl061.c
>  F: hw/input/pl050.c
>  F: hw/intc/pl190.c
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 57497b0c4d..a4c4d44f00 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -34,6 +34,7 @@
>  #include "hw/char/cadence_uart.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/cpu/a9mpcore.h"
> +#include "hw/dma/pl330.h"
>
>  #define NUM_SPI_FLASHES 4
>  #define NUM_QSPI_FLASHES 2
> @@ -278,22 +279,7 @@ static void zynq_init(MachineState *machine)
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-IRQ_OFFSET]);
>
> -    dev =3D qdev_create(NULL, "pl330");
> -    qdev_prop_set_uint8(dev, "num_chnls",  8);
> -    qdev_prop_set_uint8(dev, "num_periph_req",  4);
> -    qdev_prop_set_uint8(dev, "num_events",  16);
> -
> -    qdev_prop_set_uint8(dev, "data_width",  64);
> -    qdev_prop_set_uint8(dev, "wr_cap",  8);
> -    qdev_prop_set_uint8(dev, "wr_q_dep",  16);
> -    qdev_prop_set_uint8(dev, "rd_cap",  8);
> -    qdev_prop_set_uint8(dev, "rd_q_dep",  16);
> -    qdev_prop_set_uint16(dev, "data_buffer_dep",  256);
> -
> -    qdev_init_nofail(dev);
> -    busdev =3D SYS_BUS_DEVICE(dev);
> -    sysbus_mmio_map(busdev, 0, 0xF8003000);
> -    sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line=
 */
> +    pl330_init(0xf8003000, pic[45 - IRQ_OFFSET], 4); /* abort irq line *=
/
>      for (n =3D 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
>          sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET])=
;
>      }
> diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
> index d071049233..711cf9a605 100644
> --- a/hw/dma/pl330.c
> +++ b/hw/dma/pl330.c
> @@ -20,6 +20,7 @@
>  #include "qemu/timer.h"
>  #include "sysemu/dma.h"
>  #include "qemu/log.h"
> +#include "hw/dma/pl330.h"
>
>  #ifndef PL330_ERR_DEBUG
>  #define PL330_ERR_DEBUG 0
> @@ -271,7 +272,6 @@ struct PL330State {
>
>  };
>
> -#define TYPE_PL330 "pl330"
>  #define PL330(obj) OBJECT_CHECK(PL330State, (obj), TYPE_PL330)
>
>  static const VMStateDescription vmstate_pl330 =3D {
> diff --git a/include/hw/dma/pl330.h b/include/hw/dma/pl330.h
> new file mode 100644
> index 0000000000..9a586c0df9
> --- /dev/null
> +++ b/include/hw/dma/pl330.h
> @@ -0,0 +1,41 @@
> +/*
> + * ARM PrimeCell PL330 DMA Controller
> + *
> + * Copyright (c) 2009 Samsung Electronics.
> + * Contributed by Kirill Batuzov <batuzovk@ispras.ru>
> + * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.crosthwaite@petalogi=
x.com)
> + * Copyright (c) 2012 PetaLogix Pty Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_DMA_PL330_H
> +#define HW_DMA_PL330_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_PL330 "pl330"
> +
> +static inline void pl330_init(uint32_t base, qemu_irq irq, int nreq)
> +{
> +    SysBusDevice *busdev;
> +    DeviceState *dev;
> +
> +    dev =3D qdev_create(NULL, TYPE_PL330);
> +    qdev_prop_set_uint8(dev, "num_chnls", 8);
> +    qdev_prop_set_uint8(dev, "num_periph_req", nreq);
> +    qdev_prop_set_uint8(dev, "num_events", 16);
> +    qdev_prop_set_uint8(dev, "data_width", 64);
> +    qdev_prop_set_uint8(dev, "wr_cap", 8);
> +    qdev_prop_set_uint8(dev, "wr_q_dep", 16);
> +    qdev_prop_set_uint8(dev, "rd_cap", 8);
> +    qdev_prop_set_uint8(dev, "rd_q_dep", 16);
> +    qdev_prop_set_uint16(dev, "data_buffer_dep", 256);
> +    qdev_init_nofail(dev);
> +
> +    busdev =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(busdev, 0, base);
> +    sysbus_connect_irq(busdev, 0, irq);
> +}
> +
> +#endif /* HW_DMA_PL330_H */
> --
> 2.17.2
>
>
