Received: from eggs.gnu.org ([2001:4830:134:3::10]:35179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqK7A-0000HD-D3
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqK77-0004Rt-WA
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:23:07 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqK77-0004Qj-Bf
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:23:05 -0400
Received: by mail-oi0-x244.google.com with SMTP id 13-v6so8696534ois.1
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:23:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180811090836.4024-8-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-8-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 16:22:43 +0100
Message-ID: <CAFEAcA-ntqANcVzUTJa0BC7C9e2+CaJVvCD+eyH03W_5D+UEVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] arm: Instantiate Microbit board-level
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 11 August 2018 at 10:08, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> =
wrote:
> Instantiate the LED matrix and set board-level
> pull-up default values to buttons A and B.
> This is necessary to calm down the microsoft pxt
> javascript runtime available for the micro:bit.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

> +static void microbit_reset(void)
> +{
> +    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
> +
> +    qemu_devices_reset();
> +
> +    /* Board level pull-up */
> +    if (!qtest_enabled()) {
> +        qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->nrf51), BUTTON_A_PIN), =
1);
> +        qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->nrf51), BUTTON_B_PIN), =
1);
> +    }

Reset functions should not call qemu_set_irq().

The problem is that there's no ordering on device reset functions,
so there's no guarantee that the reset function on this end is
called after the reset function for the device it's trying to set
the input GPIO line for. If the two resets happen in the other order
then the device will forget that the input line was high.

There is no good way to handle a line that is supposed to be
pulled high on reset, I'm afraid. You just have to try to avoid
modelling things in a way that requires it.

(Yes, our modelling of reset is basically broken. It's a
hard design problem that nobody's found the time to tackle
properly. You'll see various more-or-less dubious workarounds
if you dig in the right parts of the code base...)

> +}
> +
>
>  static void microbit_machine_init(MachineClass *mc)
>  {
>      mc->desc =3D "BBC micro:bit";
>      mc->init =3D microbit_init;
>      mc->max_cpus =3D 1;
> +    mc->reset =3D microbit_reset;
>  }
>
>  static void microbit_machine_init_class_init(ObjectClass *oc, void *data=
)
> diff --git a/include/hw/arm/microbit.h b/include/hw/arm/microbit.h
> index 89f0c6bc07..094326b4ae 100644
> --- a/include/hw/arm/microbit.h
> +++ b/include/hw/arm/microbit.h
> @@ -24,6 +24,7 @@ typedef struct MicrobitMachineState {
>      MachineState parent_obj;
>
>      NRF51State nrf51;
> +    LEDMatrixState matrix;
>  } MicrobitMachineState;

thanks
-- PMM
