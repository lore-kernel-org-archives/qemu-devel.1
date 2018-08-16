Received: from eggs.gnu.org ([2001:4830:134:3::10]:50401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqKpO-0003Xz-KL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqKpM-0006ry-5s
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:08:50 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqKpK-0006r0-ER
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:08:46 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so8936712oiw.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:08:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-5-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-5-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:08:25 +0100
Message-ID: <CAFEAcA9a-1VCQNkCEtZC6_eEyBiPfqs7MVJ-sE_xQiZGa=rtHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] hw/gpio/nrf51_gpio: Add nRF51 GPIO
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

On 6 August 2018 at 11:01, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> w=
rote:
> This adds a model of the nRF51 GPIO peripheral.
>
> Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> The nRF51 series microcontrollers support up to 32 GPIO pins in various c=
onfigurations.
> The pins can be used as input pins with pull-ups or pull-down.
> Furthermore, three different output driver modes per level are
> available (disconnected, standard, high-current).
>
> The GPIO-Peripheral has a mechanism for detecting level changes which is
> not featured in this model.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

I have a couple of style nits below but otherwise this looks good.

> +#define NRF51_GPIO_SIZE 0x1000
> +
> +#define NRF51_GPIO_REG_OUT          0x504
> +#define NRF51_GPIO_REG_OUTSET       0x508
> +#define NRF51_GPIO_REG_OUTCLR       0x50C
> +#define NRF51_GPIO_REG_IN           0x510
> +#define NRF51_GPIO_REG_DIR          0x514
> +#define NRF51_GPIO_REG_DIRSET       0x518
> +#define NRF51_GPIO_REG_DIRCLR       0x51C
> +#define NRF51_GPIO_REG_CNF_START    0x700
> +#define NRF51_GPIO_REG_CNF_END      0x77F
> +
> +#define GPIO_PULLDOWN 1
> +#define GPIO_PULLUP 3
> +
> +/**

"/**" is for doc-comment format comments. Generally we only
need those for functions that are global, not file-local ones.
If you want to do a doc-comment, then you want to do it in the
right syntax, with description of input arguments and result
(eg see include/qemu/bitops.h for some examples). If not, just
start with "/*".

> + * Check if the output driver is connected to the direction switch
> + * given the current configuration and logic level.
> + * It is not differentiated between standard and "high"(-power) drive mo=
des.
> + */
> +static bool is_connected(uint32_t config, uint32_t level)
> +{
> +    bool state;
> +    uint32_t drive_config =3D extract32(config, 8, 3);
> +
> +    switch (drive_config) {
> +    case 0 ... 3:
> +        state =3D true;
> +        break;
> +    case 4 ... 5:
> +        state =3D level !=3D 0;
> +        break;
> +    case 6 ... 7:
> +        state =3D level =3D=3D 0;
> +        break;
> +    }
> +
> +    return state;
> +}
> +
> +static void update_output_irq(Nrf51GPIOState *s, size_t i,
> +                              bool connected, bool level)
> +{
> +    int64_t irq_level =3D connected ? level : -1;
> +    bool old_connected =3D extract32(s->old_out_connected, i, 1);
> +    bool old_level =3D extract32(s->old_out, i, 1);
> +
> +    if ((old_connected !=3D connected) || (old_level !=3D level)) {
> +        qemu_set_irq(s->output[i], irq_level);
> +        trace_nrf51_gpio_update_output_irq(i, irq_level);
> +    }
> +
> +    s->old_out =3D deposit32(s->old_out, i, 1, level);
> +    s->old_out_connected =3D deposit32(s->old_out_connected, i, 1, conne=
cted);
> +}
> +
> +static void update_state(Nrf51GPIOState *s)
> +{
> +    uint32_t pull;
> +    bool connected_out, dir, connected_in, out, input;
> +
> +    for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
> +        pull =3D extract32(s->cnf[i], 2, 2);
> +        dir =3D extract32(s->cnf[i], 0, 1);
> +        connected_in =3D extract32(s->in_mask, i, 1);
> +        out =3D extract32(s->out, i, 1);
> +        input =3D !extract32(s->cnf[i], 1, 1);
> +        connected_out =3D is_connected(s->cnf[i], out) && dir;
> +
> +        update_output_irq(s, i, connected_out, out);
> +
> +        /** Pin both driven externally and internally */

Inline comments like these should definitely not have the doc-comment
starting indicator.

> +        if (connected_out && connected_in) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited=
\n", i);
> +        }

> diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
> new file mode 100644
> index 0000000000..11486b09b9
> --- /dev/null
> +++ b/hw/gpio/trace-events
> @@ -0,0 +1,7 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# hw/gpio/nrf51_gpio.c
> +nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value=
 0x%" PRIx64
> +nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " =
value 0x%" PRIx64
> +nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value 0x%"=
 PRIi64
> +nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi6=
4 " value 0x%" PRIi64
> \ No newline at end of file

You want to make sure there's a newline at the end of the file...


thanks
-- PMM
