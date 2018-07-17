Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffTAN-0003Aa-Pj
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffTAM-00030v-T9
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:49:35 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffTAM-0002zJ-LU
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:49:34 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so3282557oie.7
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:49:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180713154007.3853-1-contrib@steffen-goertz.de>
References: <20180713154007.3853-1-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 17:49:13 +0100
Message-ID: <CAFEAcA_BR6gECO4Vps=zOd6ZWfw-kRL9pqpD3hRkGRZMAitpPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3] arm: Add NRF51 random number generator
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 13 July 2018 at 16:40, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> wr=
ote:
> Add a model of the NRF51 random number generator peripheral.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
> Changes since v3:
>   - Replace bitfields
>   - Add VMState / reset
>   - Add reference to reference manual
>
> Changes since v2:
>   - Add missing 'qapi/error.h' for error_abort
>
> Changes since v1:
>   - Add implementation access size hints to MemoryRegionOps
>   - Fail on error if qcrypto_random_bytes fails
>   - Add references to Nrf51 datasheets
>
>
>  hw/misc/Makefile.objs       |   1 +
>  hw/misc/nrf51_rng.c         | 269 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/nrf51_rng.h |  71 ++++++++++
>  3 files changed, 341 insertions(+)
>  create mode 100644 hw/misc/nrf51_rng.c
>  create mode 100644 include/hw/misc/nrf51_rng.h
>

> +
> +static void nrf51_rng_timer_expire(void *opaque)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(opaque);
> +
> +    qcrypto_random_bytes(&s->value, 1, &error_abort);
> +
> +    s->event_valrdy =3D 1;
> +    qemu_set_irq(s->eep_valrdy, 1);
> +
> +    if (s->interrupt_enabled) {
> +        qemu_irq_pulse(s->irq);

Is this definitely a pulse interrupt ? Usually
devices raise an irq line and keep it high until
the guest checks them and tells them to drop it.

> +    }
> +
> +    if (s->shortcut_stop_on_valrdy) {
> +        s->active =3D 0;
> +    }
> +
> +    rng_update_timer(s);
> +}
> +
> +static void nrf51_rng_tep_start(void *opaque, int n, int level)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(opaque);
> +
> +    if (level) {
> +        s->active =3D 1;
> +        rng_update_timer(s);
> +    }
> +}
> +
> +static void nrf51_rng_tep_stop(void *opaque, int n, int level)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(opaque);
> +
> +    if (level) {
> +        s->active =3D 0;
> +        rng_update_timer(s);
> +    }
> +}
> +
> +
> +static void nrf51_rng_init(Object *obj)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &rng_ops, s,
> +            TYPE_NRF51_RNG, NRF51_RNG_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    timer_init_us(&s->timer, QEMU_CLOCK_VIRTUAL, nrf51_rng_timer_expire,=
 s);
> +
> +    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "irq", 1);
> +
> +    /* Tasks */
> +    qdev_init_gpio_in_named(DEVICE(s), nrf51_rng_tep_start, "tep_start",=
 1);
> +    qdev_init_gpio_in_named(DEVICE(s), nrf51_rng_tep_stop, "tep_stop", 1=
);
> +
> +    /* Events */
> +    qdev_init_gpio_out_named(DEVICE(s), &s->eep_valrdy, "eep_valrdy", 1)=
;
> +}
> +
> +static void nrf51_rng_reset(DeviceState *dev)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(dev);
> +
> +    rng_update_timer(s);

Isn't this reset function missing some code to reset the
various bits of guest-modifiable state (eg s->active,
s->event_valrdy) ?

> +}

thanks
-- PMM
