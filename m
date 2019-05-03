Received: from eggs.gnu.org ([209.51.188.92]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMZzc-0004AT-UQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMZzb-0001FZ-1x
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:20:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMZzX-0001C7-Fa
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:20:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id h11so7172446wmb.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:20:49 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-8-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-8-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:20:47 +0100
Message-ID: <87pnoz4l9s.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 07/12] hw/timer: RX62N internal
 timer modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> renesas_tmr: 8bit timer modules.
> renesas_cmt: 16bit compare match timer modules.
> This part use many renesas's CPU.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/timer/renesas_cmt.h |  33 +++
>  include/hw/timer/renesas_tmr.h |  46 +++++
>  hw/timer/renesas_cmt.c         | 277 +++++++++++++++++++++++++
>  hw/timer/renesas_tmr.c         | 458 +++++++++++++++++++++++++++++++++++=
++++++
>  hw/timer/Kconfig               |   6 +
>  hw/timer/Makefile.objs         |   3 +
>  6 files changed, 823 insertions(+)
>  create mode 100644 include/hw/timer/renesas_cmt.h
>  create mode 100644 include/hw/timer/renesas_tmr.h
>  create mode 100644 hw/timer/renesas_cmt.c
>  create mode 100644 hw/timer/renesas_tmr.c
>
> diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cm=
t.h
> new file mode 100644
> index 0000000000..7e393d7ad3
> --- /dev/null
> +++ b/include/hw/timer/renesas_cmt.h
> @@ -0,0 +1,33 @@
> +/*
> + * Renesas Compare-match timer Object
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This code is licensed under the GPL version 2 or later.
> + *
> + */
> +
> +#ifndef HW_RENESAS_CMT_H
> +#define HW_RENESAS_CMT_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_RENESAS_CMT "renesas-cmt"
> +#define RCMT(obj) OBJECT_CHECK(RCMTState, (obj), TYPE_RENESAS_CMT)
> +
> +typedef struct RCMTState {
> +    SysBusDevice parent_obj;
> +
> +    uint64_t input_freq;
> +    MemoryRegion memory;
> +
> +    uint16_t cmstr;
> +    uint16_t cmcr[2];
> +    uint16_t cmcnt[2];
> +    uint16_t cmcor[2];
> +    int64_t tick[2];
> +    qemu_irq cmi[2];
> +    QEMUTimer *timer[2];
> +} RCMTState;
> +
> +#endif
> diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tm=
r.h
> new file mode 100644
> index 0000000000..718d9dc4ff
> --- /dev/null
> +++ b/include/hw/timer/renesas_tmr.h
> @@ -0,0 +1,46 @@
> +/*
> + * Renesas 8bit timer Object
> + *
> + * Copyright (c) 2018 Yoshinori Sato
> + *
> + * This code is licensed under the GPL version 2 or later.
> + *
> + */
> +
> +#ifndef HW_RENESAS_TMR_H
> +#define HW_RENESAS_TMR_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_RENESAS_TMR "renesas-tmr"
> +#define RTMR(obj) OBJECT_CHECK(RTMRState, (obj), TYPE_RENESAS_TMR)
> +
> +enum timer_event {cmia =3D 0,
> +                  cmib =3D 1,
> +                  ovi =3D 2,
> +                  none =3D 3,
> +                  TMR_NR_EVENTS =3D 4};
> +enum {CH =3D 2};
> +typedef struct RTMRState {
> +    SysBusDevice parent_obj;
> +
> +    uint64_t input_freq;
> +    MemoryRegion memory;
> +
> +    uint8_t tcnt[CH];
> +    uint8_t tcora[CH];
> +    uint8_t tcorb[CH];
> +    uint8_t tcr[CH];
> +    uint8_t tccr[CH];
> +    uint8_t tcor[CH];
> +    uint8_t tcsr[CH];
> +    int64_t tick;
> +    int64_t div_round[CH];
> +    enum timer_event next[CH];
> +    qemu_irq cmia[CH];
> +    qemu_irq cmib[CH];
> +    qemu_irq ovi[CH];
> +    QEMUTimer *timer[CH];
> +} RTMRState;
> +
> +#endif
> diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
> new file mode 100644
> index 0000000000..b82250dbc2
> --- /dev/null
> +++ b/hw/timer/renesas_cmt.c
> @@ -0,0 +1,277 @@
> +/*
> + * Renesas 16bit Compare-match timer
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qemu/timer.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/registerfields.h"
> +#include "hw/timer/renesas_cmt.h"
> +#include "qemu/error-report.h"
> +
> +/*
> + *  +0 CMSTR - common control
> + *  +2 CMCR  - ch0
> + *  +4 CMCNT - ch0
> + *  +6 CMCOR - ch0
> + *  +8 CMCR  - ch1
> + * +10 CMCNT - ch1
> + * +12 CMCOR - ch1
> + * If we think that the address of CH 0 has an offset of +2,
> + * we can treat it with the same address as CH 1, so define it like that.
> + */
> +REG16(CMSTR, 0)
> +  FIELD(CMSTR, STR0, 0, 1)
> +  FIELD(CMSTR, STR1, 1, 1)
> +  FIELD(CMSTR, STR,  0, 2)
> +/* This addeess is channel offset */
> +REG16(CMCR, 0)
> +  FIELD(CMCR, CKS, 0, 2)
> +  FIELD(CMCR, CMIE, 6, 1)
> +REG16(CMCNT, 2)
> +REG16(CMCOR, 4)
> +
> +static void update_events(RCMTState *cmt, int ch)
> +{
> +    int64_t next_time;
> +
> +    if ((cmt->cmstr & (1 << ch)) =3D=3D 0) {
> +        /* count disable, so not happened next event. */
> +        return ;
> +    }
> +    next_time =3D cmt->cmcor[ch] - cmt->cmcnt[ch];
> +    next_time *=3D NANOSECONDS_PER_SECOND;
> +    next_time /=3D cmt->input_freq;
> +    /*
> +     * CKS -> div rate
> +     *  0 -> 8 (1 << 3)
> +     *  1 -> 32 (1 << 5)
> +     *  2 -> 128 (1 << 7)
> +     *  3 -> 512 (1 << 9)
> +     */
> +    next_time *=3D 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
> +    next_time +=3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    timer_mod(cmt->timer[ch], next_time);
> +}
> +
> +static int64_t read_cmcnt(RCMTState *cmt, int ch)
> +{
> +    int64_t delta, now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    if (cmt->cmstr & (1 << ch)) {
> +        delta =3D (now - cmt->tick[ch]);
> +        delta /=3D NANOSECONDS_PER_SECOND;
> +        delta /=3D cmt->input_freq;
> +        delta /=3D 1 << (3 + FIELD_EX16(cmt->cmcr[ch], CMCR, CKS) * 2);
> +        cmt->tick[ch] =3D now;
> +        return cmt->cmcnt[ch] + delta;
> +    } else {
> +        return cmt->cmcnt[ch];
> +    }
> +}
> +
> +static uint64_t cmt_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    hwaddr offset =3D addr & 0x0f;
> +    RCMTState *cmt =3D opaque;
> +    int ch =3D offset / 0x08;
> +    uint64_t ret;
> +
> +    if (offset =3D=3D A_CMSTR) {
> +        ret =3D 0;
> +        ret =3D FIELD_DP16(ret, CMSTR, STR,
> +                         FIELD_EX16(cmt->cmstr, CMSTR, STR));
> +        return ret;
> +    } else {
> +        offset &=3D 0x07;
> +        if (ch =3D=3D 0) {
> +            offset -=3D 0x02;
> +        }
> +        switch (offset) {
> +        case A_CMCR:
> +            ret =3D 0;
> +            ret =3D FIELD_DP16(ret, CMCR, CKS,
> +                             FIELD_EX16(cmt->cmstr, CMCR, CKS));
> +            ret =3D FIELD_DP16(ret, CMCR, CMIE,
> +                             FIELD_EX16(cmt->cmstr, CMCR, CMIE));
> +            return ret;
> +        case A_CMCNT:
> +            return read_cmcnt(cmt, ch);
> +        case A_CMCOR:
> +            return cmt->cmcor[ch];
> +        }
> +    }
> +    qemu_log_mask(LOG_UNIMP,
> +                  "renesas_cmt: Register %08lx not implemented\n",
> +                  offset);
> +    return 0xffffffffffffffffUL;
> +}
> +
> +static void start_stop(RCMTState *cmt, int ch, int st)
> +{
> +    if (st) {
> +        update_events(cmt, ch);
> +    } else {
> +        timer_del(cmt->timer[ch]);
> +    }
> +}
> +
> +static void cmt_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
> +{
> +    hwaddr offset =3D addr & 0x0f;
> +    RCMTState *cmt =3D opaque;
> +    int ch =3D offset / 0x08;
> +
> +    if (offset =3D=3D A_CMSTR) {
> +        cmt->cmstr =3D FIELD_EX16(val, CMSTR, STR);
> +        start_stop(cmt, 0, FIELD_EX16(cmt->cmstr, CMSTR, STR0));
> +        start_stop(cmt, 1, FIELD_EX16(cmt->cmstr, CMSTR, STR1));
> +    } else {
> +        offset &=3D 0x07;
> +        if (ch =3D=3D 0) {
> +            offset -=3D 0x02;
> +        }
> +        switch (offset) {
> +        case A_CMCR:
> +            cmt->cmcr[ch] =3D FIELD_DP16(cmt->cmcr[ch], CMCR, CKS,
> +                                       FIELD_EX16(val, CMCR, CKS));
> +            cmt->cmcr[ch] =3D FIELD_DP16(cmt->cmcr[ch], CMCR, CMIE,
> +                                       FIELD_EX16(val, CMCR, CMIE));
> +            break;
> +        case 2:
> +            cmt->cmcnt[ch] =3D val;
> +            break;
> +        case 4:
> +            cmt->cmcor[ch] =3D val;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP,
> +                          "renesas_cmt: Register %08lx not implemented\n=
",
> +                          offset);
> +            return;
> +        }
> +        if (FIELD_EX16(cmt->cmstr, CMSTR, STR) & (1 << ch)) {
> +            update_events(cmt, ch);
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps cmt_ops =3D {
> +    .write =3D cmt_write,
> +    .read  =3D cmt_read,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 2,
> +        .max_access_size =3D 2,
> +    },
> +};
> +
> +static void timer_events(RCMTState *cmt, int ch)
> +{
> +    cmt->cmcnt[ch] =3D 0;
> +    cmt->tick[ch] =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    update_events(cmt, ch);
> +    if (FIELD_EX16(cmt->cmcr[ch], CMCR, CMIE)) {
> +        qemu_irq_pulse(cmt->cmi[ch]);
> +    }
> +}
> +
> +static void timer_event0(void *opaque)
> +{
> +    RCMTState *cmt =3D opaque;
> +
> +    timer_events(cmt, 0);
> +}
> +
> +static void timer_event1(void *opaque)
> +{
> +    RCMTState *cmt =3D opaque;
> +
> +    timer_events(cmt, 1);
> +}

I guess there is enough shared state RCMTState that you couldn't have an
array of channel structures and just pass that when you setup the
timers:

> +static void rcmt_init(Object *obj)
> +{
<snip>
> +    cmt->timer[0] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event0, cmt=
);
> +    cmt->timer[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, timer_event1,
> cmt);

here?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
