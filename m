Received: from eggs.gnu.org ([2001:4830:134:3::10]:59719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Fuv-0001OI-AB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Fuq-0004rp-CB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6Fuq-0004rV-1u
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:31:28 -0400
References: <20170504115948.3048-1-xiaoguangrong@tencent.com>
	<20170504115948.3048-3-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bdc4c8a-b07a-dd3a-af9a-1718623fcc2e@redhat.com>
Date: Thu, 4 May 2017 14:31:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170504115948.3048-3-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] mc146818rtc: precisely count the
 clock for periodic timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 04/05/2017 13:59, guangrong.xiao@gmail.com wrote:
> From: Tai Yunfang <yunfangtai@tencent.com>
>=20
> There are two issues in current code:
> 1) If the period is changed by re-configuring RegA, the coalesced
>    irq will be scaled to reflect the new period, however, it
>    calculates the new interrupt number like this:
>     s->irq_coalesced =3D (s->irq_coalesced * s->period) / period;
>=20
>    There are some clocks will be lost if they are not enough to
>    be squeezed to a single new period that will cause the VM clock
>    slower
>=20
>    In order to fix the issue, we calculate the interrupt window
>    based on the precise clock rather than period, then the clocks
>    lost during period is scaled can be compensated properly
>=20
> 2) If periodic_timer_update() is called due to RegA reconfiguration,
>    i.e, the period is updated, current time is not the start point
>    for the next periodic timer, instead, which should start from the
>    last interrupt, otherwise, the clock in VM will become slow
>=20
>    This patch takes the clocks from last interrupt to current clock
>    into account and compensates the clocks for the next interrupt,
>    especially=EF=BC=8Cif a complete interrupt was lost in this window, =
the
>    time can be caught up by LOST_TICK_POLICY_SLEW
>=20
> [ Xiao: redesign the algorithm based on Yunfang's original work. ]
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> Signed-off-by: Tai Yunfang <yunfangtai@tencent.com>
> ---
>  hw/timer/mc146818rtc.c | 116 ++++++++++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 96 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 5cccb2a..14bde1a 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -146,31 +146,104 @@ static void rtc_coalesced_timer(void *opaque)
>  }
>  #endif
> =20
> -/* handle periodic timer */
> -static void periodic_timer_update(RTCState *s, int64_t current_time)
> +static int period_code_to_clock(int period_code)
> +{
> +    /* periodic timer is disabled. */
> +    if (!period_code) {
> +        return 0;
> +    }
> +
> +    if (period_code <=3D 2) {
> +        period_code +=3D 7;
> +    }
> +
> +    /* period in 32 Khz cycles */
> +    return 1 << (period_code - 1);
> +}
> +
> +/*
> + * handle periodic timer. @old_period indicates the periodic timer upd=
ate
> + * is just due to period adjustment.
> + */
> +static void
> +periodic_timer_update(RTCState *s, int64_t current_time, int old_perio=
d)

We need old_period to distinguish reconfiguration from interrupts ("if
(old_period)" below), but it can be a bool.  Instead of passing the old
period value, we can use s->period which is
period_code_to_clock(old_period).

That is, just do

    old_period =3D s->period;
    s->period =3D rtc_periodic_clock_ticks(s);

    /*
     * if the periodic timer's update is due to period re-configuration,
     * the clock should count since last interrupt.
     */
    if (s->period !=3D 0) {
        ...
        if (!from_interrupt) {
        }
        ...
    }

where rtc_periodic_clock_ticks takes into account both regA and regB,
returning the result in 32 kHZ ticks.

>  {
>      int period_code, period;
> -    int64_t cur_clock, next_irq_clock;
> +    int64_t cur_clock, next_irq_clock, lost_clock =3D 0;
> =20
>      period_code =3D s->cmos_data[RTC_REG_A] & 0x0f;
>      if (period_code !=3D 0
>          && (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
> -        if (period_code <=3D 2)
> -            period_code +=3D 7;
> -        /* period in 32 Khz cycles */
> -        period =3D 1 << (period_code - 1);
> -#ifdef TARGET_I386
> -        if (period !=3D s->period) {
> -            s->irq_coalesced =3D (s->irq_coalesced * s->period) / peri=
od;
> -            DPRINTF_C("cmos: coalesced irqs scaled to %d\n", s->irq_co=
alesced);
> -        }
> -        s->period =3D period;
> -#endif
> +        period =3D period_code_to_clock(period_code);


Since we have old_period, we can assign s->period here.

>          /* compute 32 khz clock */
>          cur_clock =3D
>              muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SEC=
OND);
> =20
> -        next_irq_clock =3D (cur_clock & ~(period - 1)) + period;
> +        /*
> +        * if the periodic timer's update is due to period re-configura=
tion,
> +        * we should count the clock since last interrupt.
> +        */
> +        if (old_period) {
> +            int64_t last_periodic_clock;
> +
> +            last_periodic_clock =3D muldiv64(s->next_periodic_time,
> +                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SE=
COND);
> +            /*
> +             * if the next interrupt has not happened yet, we recall t=
he last
> +             * interrupt based on the original period.
> +             */
> +            if (last_periodic_clock > cur_clock) {
> +                last_periodic_clock -=3D period_code_to_clock(old_peri=
od);

This becomes "last_periodic_clock -=3D old_period".

But, I'm not sure how it can happen that last_periodic_clock <=3D
cur_clock.  More precisely, if it happened, you have lost a tick and you
should add it to s->irq_coalesced it below.  The simplest way to do it,
is to *always* do the subtraction.


> +
> +                /* the last interrupt must have happened. */
> +                assert(cur_clock >=3D last_periodic_clock);
> +            }
> +
> +            /* calculate the clock since last interrupt. */
> +            lost_clock =3D cur_clock - last_periodic_clock;
> +        }

I think the "assert(lost_clock >=3D 0)" should be here.  Then you can als=
o
remove the "the last interrupt must have happened" assertion, since the
two test exactly the same formula:

	lost_clock >=3D 0
	cur_clock - last_periodic_clock >=3D 0
	cur_clock >=3D last_periodic_clock.

Putting everything together, this becomes:

	if (!from_interrupt) {
            int64_t next_periodic_clock, last_periodic_clock;

            next_periodic_clock =3D muldiv64(s->next_periodic_time,
                                    RTC_CLOCK_RATE,
				    NANOSECONDS_PER_SECOND);
	    last_periodic_clock =3D next_periodic_clock - old_period;
	    lost_clock =3D cur_clock - last_periodic_clock;
	    assert(lost_clock >=3D 0);
	}

	if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
	    ...
	} else {
	    lost_clock =3D MIN(lost_clock, s->period);
	}
	assert(lost_clock >=3D 0 && lost_clock < s->period);

> +            /*
> +#ifdef TARGET_I386
> +        /*
> +         * recalculate the coalesced irqs for two reasons:
> +         *    a) the lost_clock is more that a period, i,e. the timer
> +         *       interrupt has been lost, we should catch up the time.
> +         *
> +         *    b) the period may be reconfigured, under this case, when
> +         *       switching from a shorter to a longer period, scale do=
wn
> +         *       the missing ticks since we expect the OS handler to
> +         *       treat the delayed ticks as longer. Any leftovers are
> +         *       put back into lost_clock.
> +         *       When switching to a shorter period, scale up the miss=
ing
> +         *       ticks since we expect the OS handler to treat the del=
ayed
> +         *       ticks as shorter.
> +         */
> +        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
> +            uint32_t cur_irq_coalesced =3D s->irq_coalesced;
> +            uint32_t cur_period =3D s->period;

These are really "old" values rather than current.

> +
> +            lost_clock +=3D cur_irq_coalesced * cur_period;
> +            s->irq_coalesced =3D lost_clock / period;
> +            lost_clock %=3D period;
> +            s->period =3D period;
> +            if ((cur_irq_coalesced !=3D s->irq_coalesced) ||
> +               (cur_period |=3D s->period)) {

Typo here, so this becomes:

        uint32_t old_irq_coalesced =3D s->irq_coalesced;
	lost_clock +=3D old_irq_coalesced * old_period;
	s->irq_coalesced =3D lost_clock / s->period;
	lost_clock %=3D s->period;
	if (old_irq_coalesced !=3D s->irq_coalesced ||
	    old_period !=3D s->period) {
		DPRINTF ...
		rtc_coalesced_timer_update(s);
	}

> +                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, =
"
> +                          "period scaled from %d to %d\n", cur_irq_coa=
lesced,
> +                          s->irq_coalesced, cur_period, s->period);
> +                rtc_coalesced_timer_update(s);
> +            }
> +        }
> +#endif
> +        /*
> +         * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
> +         * is not used, we should make the time progress anyway.
> +         */
> +        lost_clock =3D MIN(lost_clock, period);

See above---let's put it under "else", since it is unnecessary in the
SLEW case.

This is already much more understandable, and all of it makes a lot of
sense.  The next version should be perfect. :)

Paolo

> +        assert(lost_clock >=3D 0);
> +
> +        next_irq_clock =3D cur_clock + period - lost_clock;
>          s->next_periodic_time =3D muldiv64(next_irq_clock, NANOSECONDS=
_PER_SECOND,
>                                           RTC_CLOCK_RATE) + 1;
>          timer_mod(s->periodic_timer, s->next_periodic_time);
> @@ -186,7 +259,7 @@ static void rtc_periodic_timer(void *opaque)
>  {
>      RTCState *s =3D opaque;
> =20
> -    periodic_timer_update(s, s->next_periodic_time);
> +    periodic_timer_update(s, s->next_periodic_time, 0);
>      s->cmos_data[RTC_REG_C] |=3D REG_C_PF;
>      if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
>          s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
> @@ -391,6 +464,7 @@ static void cmos_ioport_write(void *opaque, hwaddr =
addr,
>                                uint64_t data, unsigned size)
>  {
>      RTCState *s =3D opaque;
> +    int cur_period;
>      bool update_periodic_timer;
> =20
>      if ((addr & 1) =3D=3D 0) {
> @@ -424,6 +498,7 @@ static void cmos_ioport_write(void *opaque, hwaddr =
addr,
>              }
>              break;
>          case RTC_REG_A:
> +            cur_period =3D s->cmos_data[RTC_REG_A] & 0xf;
>              update_periodic_timer =3D (s->cmos_data[RTC_REG_A] ^ data)=
 & 0x0f;
> =20
>              if ((data & 0x60) =3D=3D 0x60) {
> @@ -450,7 +525,8 @@ static void cmos_ioport_write(void *opaque, hwaddr =
addr,
>                  (s->cmos_data[RTC_REG_A] & REG_A_UIP);
> =20
>              if (update_periodic_timer) {
> -                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock))=
;
> +                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
> +                                      cur_period);
>              }
> =20
>              check_update_timer(s);
> @@ -487,7 +563,7 @@ static void cmos_ioport_write(void *opaque, hwaddr =
addr,
>              s->cmos_data[RTC_REG_B] =3D data;
> =20
>              if (update_periodic_timer) {
> -                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock))=
;
> +                periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),=
 0);
>              }
> =20
>              check_update_timer(s);
> @@ -757,7 +833,7 @@ static int rtc_post_load(void *opaque, int version_=
id)
>          uint64_t now =3D qemu_clock_get_ns(rtc_clock);
>          if (now < s->next_periodic_time ||
>              now > (s->next_periodic_time + get_max_clock_jump())) {
> -            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
> +            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
>          }
>      }
> =20
> @@ -822,7 +898,7 @@ static void rtc_notify_clock_reset(Notifier *notifi=
er, void *data)
>      int64_t now =3D *(int64_t *)data;
> =20
>      rtc_set_date_from_host(ISA_DEVICE(s));
> -    periodic_timer_update(s, now);
> +    periodic_timer_update(s, now, 0);
>      check_update_timer(s);
>  #ifdef TARGET_I386
>      if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
>=20
