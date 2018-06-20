Received: from eggs.gnu.org ([2001:4830:134:3::10]:52707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fVbCt-00027Q-OZ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fVbCs-0007zD-Dz
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:23:23 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fVbCs-0007yl-6q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:23:22 -0400
Received: by mail-wr0-x242.google.com with SMTP id o12-v6so2874883wrm.12
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 04:23:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619105451.29163-1-contrib@steffen-goertz.de>
References: <20180619105451.29163-1-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Jun 2018 12:23:19 +0100
Message-ID: <CAJSP0QWx6wAV001uAwAh-BKFCGFiTH09yErZCoj=pyJCLNNv-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Add NRF51 RNG peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On Tue, Jun 19, 2018 at 11:54 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> Add a model of the NRF51 RNG peripheral.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/misc/Makefile.objs       |   1 +
>  hw/misc/nrf51_rng.c         | 241 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/nrf51_rng.h |  61 +++++++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 hw/misc/nrf51_rng.c
>  create mode 100644 include/hw/misc/nrf51_rng.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 00e834d0f0..fd8cc97249 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -70,3 +70,4 @@ obj-$(CONFIG_AUX) +=3D auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>  obj-y +=3D mmio_interface.o
>  obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
> +obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o
> diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
> new file mode 100644
> index 0000000000..6bf1e3efc9
> --- /dev/null
> +++ b/hw/misc/nrf51_rng.c
> @@ -0,0 +1,241 @@
> +/*
> + * nrf51_rng.c
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.

Please include a reference to the datasheet for this device and
mention the full name "Random Number Generator" so the purpose of this
device is clear.

> +static void rng_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned int size)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(opaque);
> +
> +    assert(size =3D=3D 4);

The guest must not be able to crash QEMU via small/large store instructions=
.

Have you looked at the access size constraints in MemoryRegionOps?

This device must behave the way real hardware does.  What is supposed
to happen if the guest uses a STRB or STRH instruction?

The same applies to rng_read().

> +static void nrf51_rng_timer_expire(void *opaque) {
> +    Nrf51RNGState *s =3D NRF51_RNG(opaque);
> +
> +    qcrypto_random_bytes(&s->value, 1, NULL);
> +
> +    s->state.event_valrdy =3D 1;
> +    qemu_set_irq(s->eep_valrdy, 1);
> +
> +    if(s->state.interrupt_enabled) {
> +        qemu_irq_pulse(s->irq);
> +    }

Why does eep_valrdy use qemu_set_irq() while s->irq uses
qemu_irq_pulse()?  I don't see a many other qemu_irq_pulse() instances
in hw/arm/ so I'm curious why it was necessary.

> diff --git a/include/hw/misc/nrf51_rng.h b/include/hw/misc/nrf51_rng.h
> new file mode 100644
> index 0000000000..cec7d5f92c
> --- /dev/null
> +++ b/include/hw/misc/nrf51_rng.h
> @@ -0,0 +1,61 @@
> +/*
> + * nrf51_rng.h
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * * QEMU interface:
> + * + Property "time_between_values": Time between two biased values in
> + *   microseconds.

This is outdated.  The code uses period_unfiltered_us and period_filtered_u=
s.
