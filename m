Received: from eggs.gnu.org ([209.51.188.92]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUek-0007NZ-NC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUej-0000IQ-R9
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:57:58 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkUej-0000Gn-Ex
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:57:57 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so9015801oia.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20190110094020.18354-1-stefanha@redhat.com>
	<20190110094020.18354-2-stefanha@redhat.com>
In-Reply-To: <20190110094020.18354-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 13:57:44 +0000
Message-ID: <CAFEAcA9aypaAyroky0xpFzTUWp4PksqW17O8gkub2rLkS8o=ZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>

On Thu, 10 Jan 2019 at 09:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>
> Recent microbit firmwares panic if the TWI magnetometer/accelerometer
> devices are not detected during startup.  We don't implement TWI (I2C)
> so let's stub out these devices just to let the firmware boot.
>

> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -16,11 +16,13 @@
>  #include "exec/address-spaces.h"
>
>  #include "hw/arm/nrf51_soc.h"
> +#include "hw/i2c/microbit_i2c.h"
>
>  typedef struct {
>      MachineState parent;
>
>      NRF51State nrf51;
> +    MicrobitI2CState i2c;
>  } MicrobitMachineState;
>
>  #define TYPE_MICROBIT_MACHINE MACHINE_TYPE_NAME("microbit")
> @@ -32,7 +34,9 @@ static void microbit_init(MachineState *machine)
>  {
>      MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
>      MemoryRegion *system_memory =3D get_system_memory();
> +    MemoryRegion *mr;
>      Object *soc =3D OBJECT(&s->nrf51);
> +    Object *i2c =3D OBJECT(&s->i2c);
>
>      sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf51=
),
>                            TYPE_NRF51_SOC);
> @@ -41,6 +45,17 @@ static void microbit_init(MachineState *machine)
>                               &error_fatal);
>      object_property_set_bool(soc, true, "realized", &error_fatal);
>
> +    /* Overlap the TWI stub device into the SoC.  This is a microbit-spe=
cific
> +     * hack until we implement the nRF51 TWI controller properly and the
> +     * magnetometer/accelerometer devices.
> +     */
> +    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
> +                          sizeof(s->i2c), TYPE_MICROBIT_I2C);
> +    object_property_set_bool(i2c, true, "realized", &error_fatal);
> +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
> +    memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_B=
ASE,
> +                                        mr, -1);

This is an SoC device, right? Why are we creating it here
in the board code rather than in the SoC object's code ?

thanks
-- PMM
