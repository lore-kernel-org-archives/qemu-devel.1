Received: from eggs.gnu.org ([2001:4830:134:3::10]:52953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSFcu-0003ow-Ga
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 00:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dSFct-0006in-3l
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 00:39:52 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1499094812-13239-1-git-send-email-peter.maydell@linaro.org>
References: <1499094812-13239-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 4 Jul 2017 01:39:42 -0300
Message-ID: <CAAdtpL6MJJLy27ZRH-9jLWx-1U88+_H4xsfy0+3f=AKBdSQNfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] include/hw/ptimer.h: Add documentation
 comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Patch Tracking <patches@linaro.org>

On Mon, Jul 3, 2017 at 12:13 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> Add documentation comments describing the public API of the
> ptimer countdown timer.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
> I was trying to write a timer device and discovered that the ptimer
> API wasn't actually documented, so I wrote some basic notes for it...

I used to believe this file had no comments on purpose, feeling hazed
after reading "only the source code tells the full story" from the
GettingStartedDevelopers wiki entry.

/me gives Peter a big hug!

>
>  include/hw/ptimer.h | 120 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 120 insertions(+)
>
> diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
> index eafc3f0..fc4ef5c 100644
> --- a/include/hw/ptimer.h
> +++ b/include/hw/ptimer.h
> @@ -12,6 +12,20 @@
>  #include "qemu/timer.h"
>  #include "migration/vmstate.h"
>
> +/* The ptimer API implements a simple periodic countdown timer.
> + * The countdown timer has a value (which can be read and written via
> + * ptimer_get_count() and ptimer_set_count()). When it is enabled
> + * using ptimer_run(), the value will count downwards at the frequency
> + * which has been configured using ptimer_set_period() or ptimer_set_fre=
q().
> + * When it reaches zero it will trigger a QEMU bottom half handler, and
> + * can be set to either reload itself from a specified limit value
> + * and keep counting down, or to stop (as a one-shot timer).
> + *
> + * Forgetting to set the period/frequency (or setting it to zero) is a
> + * bug in the QEMU device and will cause warning messages to be printed
> + * to stderr when the guest attempts to enable the timer.
> + */
> +
>  /* The default ptimer policy retains backward compatibility with the leg=
acy
>   * timers. Custom policies are adjusting the default one. Consider provi=
ding
>   * a correct policy for your timer.
> @@ -59,15 +73,121 @@
>  typedef struct ptimer_state ptimer_state;
>  typedef void (*ptimer_cb)(void *opaque);
>
> +/**
> + * ptimer_init - Allocate and return a new ptimer
> + * @bh: QEMU bottom half which is run on timer expiry
> + * @policy: PTIMER_POLICY_* bits specifying behaviour
> + *
> + * The ptimer returned must be freed using ptimer_free().
> + * The ptimer takes ownership of @bh and will delete it
> + * when the ptimer is eventually freed.
> + */
>  ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_mask);
> +
> +/**
> + * ptimer_free - Free a ptimer
> + * @s: timer to free
> + *
> + * Free a ptimer created using ptimer_init() (including
> + * deleting the bottom half which it is using).
> + */
>  void ptimer_free(ptimer_state *s);
> +
> +/**
> + * ptimer_set_period - Set counter increment interval in nanoseconds
> + * @s: ptimer to configure
> + * @period: period of the counter in nanoseconds
> + *
> + * Note that if your counter behaviour is specified as having a
> + * particular frequency rather than a period then ptimer_set_freq()
> + * may be more appropriate.
> + */
>  void ptimer_set_period(ptimer_state *s, int64_t period);

I like to use explicit unit in variable name, i.e. period_ns.

> +
> +/**
> + * ptimer_set_freq - Set counter frequency in Hz
> + * @s: ptimer to configure
> + * @freq: counter frequency in Hz
> + *
> + * This does the same thing as ptimer_set_period(), so you only
> + * need to call one of them. If the counter behaviour is specified
> + * as setting the frequency then this function is more appropriate,
> + * because it allows specifying an effective period which is
> + * precise to fractions of a nanosecond, avoiding rounding errors.
> + */
>  void ptimer_set_freq(ptimer_state *s, uint32_t freq);
> +
> +/**
> + * ptimer_get_limit - Get the configured limit of the ptimer
> + * @s: ptimer to query
> + *
> + * This function returns the current limit (reload) value
> + * of the down-counter; that is, the value which it will be
> + * reset to when it hits zero.
> + *
> + * Generally timer devices using ptimers should be able to keep
> + * their reload register state inside the ptimer using the get
> + * and set limit functions rather than needing to also track it
> + * in their own state structure.
> + */
>  uint64_t ptimer_get_limit(ptimer_state *s);
> +
> +/**
> + * ptimer_set_limit - Set the limit of the ptimer
> + * @s: ptimer
> + * @limit: initial countdown value
> + * @reload: if nonzero, then reset the counter to the new limit
> + *
> + * Set the limit value of the down-counter. The @reload flag can
> + * be used to emulate the behaviour of timers which immediately
> + * reload the counter when their reload register is written to.
> + */
>  void ptimer_set_limit(ptimer_state *s, uint64_t limit, int reload);
> +
> +/**
> + * ptimer_get_count - Get the current value of the ptimer
> + * @s: ptimer
> + *
> + * Return the current value of the down-counter. This will
> + * return the correct value whether the counter is enabled or
> + * disabled.
> + */
>  uint64_t ptimer_get_count(ptimer_state *s);
> +
> +/**
> + * ptimer_set_count - Set the current value of the ptimer
> + * @s: ptimer
> + * @count: count value to set
> + *
> + * Set the value of the down-counter. If the counter is currently
> + * enabled this will arrange for a timer callback at the appropriate
> + * point in the future.
> + */
>  void ptimer_set_count(ptimer_state *s, uint64_t count);
> +
> +/**
> + * ptimer_run - Start a ptimer counting
> + * @s: ptimer
> + * @oneshot: non-zero if this timer should only count down once
> + *
> + * Start a ptimer counting down; when it reaches zero the bottom half
> + * passed to ptimer_init() will be invoked. If the @oneshot argument is =
zero,
> + * the counter value will then be reloaded from the limit and it will
> + * start counting down again. If @oneshot is non-zero, then the counter
> + * will disable itself when it reaches zero.
> + */
>  void ptimer_run(ptimer_state *s, int oneshot);
> +
> +/**
> + * ptimer_stop - Stop a ptimer counting
> + * @s: ptimer
> + *
> + * Pause a timer (the count stays at its current value until ptimer_run(=
)
> + * is called to start it counting again).
> + *
> + * Note that this can cause it to "lose" time, even if it is immediately
> + * restarted.
> + */
>  void ptimer_stop(ptimer_state *s);
>
>  extern const VMStateDescription vmstate_ptimer;
> --
> 2.7.4
>
>
