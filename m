Received: from eggs.gnu.org ([2001:4830:134:3::10]:40760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNh7x-0006CO-PG
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNh7x-0001Zl-10
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:37:53 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNh7w-0001Yq-LY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:37:52 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so21866938otk.3
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:37:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112214224.31560-12-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-12-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 16:37:31 +0000
Message-ID: <CAFEAcA8nZ48tjyXADzNB5RFny=Y5b+PCXikTJtWPTMOPTYrmfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 11/14] hw/timer/nrf51_timer: Add nRF51
 Timer peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12 November 2018 at 21:42, Steffen G=C3=B6rtz <contrib@steffen-goertz.de=
> wrote:
> This patch adds the model for the nRF51 timer peripheral.
> Currently, only the TIMER mode is implemented.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

> +static void set_prescaler(NRF51TimerState *s, uint32_t prescaler)
> +{
> +    uint64_t period;
> +    s->prescaler =3D prescaler;
> +
> +    period =3D ((1UL << s->prescaler) * TIMER_TICK_PS) / 1000;
> +    /* Limit minimum timeout period to 10us to allow some progress */
> +    if (period < MINIMUM_PERIOD) {
> +        s->tick_period =3D MINIMUM_PERIOD;
> +        s->counter_inc =3D MINIMUM_PERIOD / period;
> +    } else {
> +        s->tick_period =3D period;
> +        s->counter_inc =3D 1;
> +    }
> +}
> +
> +static void update_irq(NRF51TimerState *s)
> +{
> +    bool flag =3D false;
> +    size_t i;
> +
> +    for (i =3D 0; i < NRF51_TIMER_REG_COUNT; i++) {
> +        flag |=3D s->events_compare[i] && extract32(s->inten, 16 + i, 1)=
;
> +    }
> +    qemu_set_irq(s->irq, flag);
> +}
> +
> +static void timer_expire(void *opaque)
> +{
> +    NRF51TimerState *s =3D NRF51_TIMER(opaque);
> +    bool should_stop =3D false;
> +    uint32_t counter =3D s->counter;
> +    size_t i;
> +    uint64_t diff;
> +
> +    if (s->running) {
> +        for (i =3D 0; i < NRF51_TIMER_REG_COUNT; i++) {
> +            if (counter < s->cc[i]) {
> +                diff =3D s->cc[i] - counter;
> +            } else {
> +                diff =3D (s->cc[i] + BIT(bitwidths[s->bitmode])) - count=
er;
> +            }
> +
> +            if (diff <=3D s->counter_inc) {
> +                s->events_compare[i] =3D true;
> +
> +                if (s->shorts & BIT(i)) {
> +                    s->counter =3D 0;
> +                }
> +
> +                should_stop |=3D s->shorts & BIT(i + 8);
> +            }
> +        }
> +
> +        s->counter +=3D s->counter_inc;
> +        s->counter &=3D (BIT(bitwidths[s->bitmode]) - 1);
> +
> +        update_irq(s);
> +
> +        if (should_stop) {
> +            s->running =3D false;
> +            timer_del(&s->timer);
> +        } else {
> +            s->time_offset +=3D s->tick_period;
> +            timer_mod_ns(&s->timer, s->time_offset);
> +        }
> +    } else {
> +        timer_del(&s->timer);
> +    }
> +}

This looks like it's setting the timer to fire every tick_period,
whether that is going to hit a comparison point or not. This
is not recommended because it's a lot of overhead. It's much
better to identify when the next interesting event is going to
happen and set the timer for that point, and then evaluate
what has happened at the point when your timer has fired.
(If the guest reads a register in the meantime you can
calculate what its value should be at the point when the guest
does the read.)

thanks
-- PMM
