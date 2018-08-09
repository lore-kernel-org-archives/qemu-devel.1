Received: from eggs.gnu.org ([2001:4830:134:3::10]:56484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fno4L-0001CP-TY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fno4K-0000Oj-Lg
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:45:49 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fno4K-0000OA-DN
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:45:48 -0400
Received: by mail-wm0-x244.google.com with SMTP id w24-v6so949717wmc.1
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 09:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-7-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-7-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Aug 2018 17:45:46 +0100
Message-ID: <CAJSP0QWJjttRSutLkc_ycsq+THEuNUByZOOkj3qsWfsbypYxgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] hw/timer/nrf51_timer: Add nRF51 Timer
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> +/* Trigger */
> +#define NRF51_TRIGGER_TASK 0x01
> +
> +/* Events */
> +#define NRF51_EVENT_CLEAR  0x00

NRF51_TRIGGER_TASK and NRF51_EVENT_CLEAR are generic nRF51 SoC
constants.  Please put them in a header to avoid duplication.

> +static void nrf51_timer_reset(DeviceState *dev)
> +{
> +    Nrf51TimerState *s =3D NRF51_TIMER(dev);
> +
> +    s->runstate =3D NRF51_TIMER_STOPPED;

This leaves the timer pending if it was scheduled and then reset is
called.  I think timer_del() is necessary.

> diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_time=
r.h
> new file mode 100644
> index 0000000000..a1278f17bd
> --- /dev/null
> +++ b/include/hw/timer/nrf51_timer.h
> @@ -0,0 +1,63 @@
> +/*
> +* nRF51 System-on-Chip Timer peripheral
> + *
> + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
> + * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1.p=
df
> + *
> + * QEMU interface:
> + * + sysbus MMIO regions 0: GPIO registers
> + * + sysbus irq
> + *
> + * Accuracy of the peripheral model:
> + * + Only TIMER mode is implemented, COUNTER mode is not implemented.

This information was in a doc comment above the device state struct in
other patches you've sent.  Here it's at the top of the file.  For
consistency please put it in a doc comment.

> +typedef enum {
> +    NRF51_TIMER_STOPPED =3D 0,
> +    NRF51_TIMER_RUNNING
> +} Nrf51TimerRunstate;

This is basically a bool and the Nrf51TimerState->runstate field is
uint8_t.  The code can be simplified by dropping the enum and changing
the field to "bool running".

> +typedef enum {
> +    NRF51_TIMER_TIMER =3D 0,
> +    NRF51_TIMER_COUNTER =3D 1
> +} Nrf51TimerMode;

Since Nrf51TimerMode isn't used in this header file (the
Nrf51TimerState->mode field is uint32_t), this enum is internal to the
device implementation.  It can be moved to the .c file.
