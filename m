Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F30AC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19352206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5bB0Fdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19352206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUXj-0001Xz-8G
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixUWK-0000Wr-J0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixUWI-0007l3-Tu
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:31:32 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixUWH-0007h9-EZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:31:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id m16so8158054wrx.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Z4EQUJ7EQZAuPx9JHJxqUqe/4r66GpdApjzdI7UMRg8=;
 b=I5bB0FdzX4bm3J5MPH+zFXl3wvbBMCOya9WwIoxZQZntDaLd2NFqVgtbTUN4xUZKjy
 P3cee4ULJ78Lq6RHbyyPFKDrB4uvFfmArRlq1AaE7jUWTzwoiuNH3ty1P53+1DZByaRC
 zUBrnfip0UCyteEPt53KSO20gChoUuuStw8MY3hQUJuUMrGYVmp1adulYtrhrj7qnpX9
 rCNZQvQf65g3D7Pv3PbWuZ6ZfIiNB8j5H2Q5AWW46fQhQeECLKgHmYHNaJAMAF2yqFLB
 5lOAZzt2YGUKaLqaDbsu4+sSOVXyZLY9QiNYykmEg4YGzzAgerDatRxXQp+jTvLULaCc
 Z8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Z4EQUJ7EQZAuPx9JHJxqUqe/4r66GpdApjzdI7UMRg8=;
 b=fnPx4UqLyxLIEw8Tem4ykB0X9s2wnNCGp85MnTBbkgPqCGiZzSbmyLNX4yXatRyVmn
 kmv5LKIo/jqA9Qw+4Dw/ZLJVwcZRMbcq8Vk2zyrRCrZl8NWHkJWxqtjDcmj9aGewx4Zk
 p/rzUunoBKPSt5jd5mjXrrdOeNvQDISKTYRGE/Luv6NRdSLZI5w1MjCPSo+8drbTELrG
 F/1X7gBDU/pfWR26VzjvTNj4pHd+/H7QZLaOsiFDg2FSDMeuKbzGKhnJOnxeae81w7eZ
 dMRAZGi2InwrqqxbHaQF3FW7Gci2JW0AN2aC6JKHKhhYQGtBZicMzUHScROtD3mEQ3jc
 m4Cw==
X-Gm-Message-State: APjAAAVQFAahtjPh86BZzlSgAliRjPap/wM3AN9uAGPxCNYb/VzCb5do
 2ED564JyVkHrwo08K7SV9qdXyw==
X-Google-Smtp-Source: APXvYqxuvsuiI6VT5K03+oOxvl5+858FfxifOu3trtxaeHUkACLy3KJojaK0NITLUJjRJHxk8JFaVw==
X-Received: by 2002:adf:e686:: with SMTP id r6mr11763643wrm.177.1580470287643; 
 Fri, 31 Jan 2020 03:31:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm10089677wmi.44.2020.01.31.03.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 03:31:25 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E4B9D1FF87;
 Fri, 31 Jan 2020 11:31:24 +0000 (GMT)
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
 <20200131010941.10636-3-philmd@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] !fixup "hw/timer: Add limited support for AVR
 16-bit timer peripheral"
In-reply-to: <20200131010941.10636-3-philmd@redhat.com>
Date: Fri, 31 Jan 2020 11:31:24 +0000
Message-ID: <87pnez981f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Convert DB_PRINT() to trace events.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/timer/avr_timer16.c | 25 +++++++++++++++----------
>  hw/timer/trace-events  | 12 ++++++++++++
>  2 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
> index 4e16afc61c..073f36aa76 100644
> --- a/hw/timer/avr_timer16.c
> +++ b/hw/timer/avr_timer16.c
> @@ -36,6 +36,7 @@
>  #include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> +#include "trace.h"
>=20=20
>  /* Register offsets */
>  #define T16_CRA     0x0
> @@ -104,7 +105,6 @@
>  /* Helper macros */
>  #define VAL16(l, h) ((h << 8) | l)
>  #define DB_PRINT(fmt, args...) /* Nothing */
> -/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## ar=
gs)*/
>=20=20
>  static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State *t16, int6=
4_t t)
>  {
> @@ -168,8 +168,8 @@ static void avr_timer16_clksrc_update(AVRTimer16State=
 *t16)
>      if (divider) {
>          t16->freq_hz =3D t16->cpu_freq_hz / divider;
>          t16->period_ns =3D NANOSECONDS_PER_SECOND / t16->freq_hz;
> -        DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns =
(%f s)",
> -                 t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
> +        trace_avr_timer16_clksrc_update(t16->freq_hz, t16->period_ns,
> +                                        (uint64_t)(1e6 /
>  t16->freq_hz));

Is it worth including a computed value here?

>      }
>  }
>=20=20
> @@ -235,8 +235,7 @@ static void avr_timer16_set_alarm(AVRTimer16State *t1=
6)
>          t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_ns=
);
>      timer_mod(t16->timer, alarm_ns);
>=20=20
> -    DB_PRINT("next alarm %" PRIu64 " ns from now",
> -        alarm_offset * t16->period_ns);
> +    trace_avr_timer16_next_alarm(alarm_offset * t16->period_ns);
>  }
>=20=20
>  static void avr_timer16_interrupt(void *opaque)
> @@ -253,11 +252,11 @@ static void avr_timer16_interrupt(void *opaque)
>          return;
>      }
>=20=20
> -    DB_PRINT("interrupt, cnt =3D %d", CNT(t16));
> +    trace_avr_timer16_interrupt_count(CNT(t16));
>=20=20
>      /* Counter overflow */
>      if (t16->next_interrupt =3D=3D OVERFLOW) {
> -        DB_PRINT("0xffff overflow");
> +        trace_avr_timer16_interrupt_overflow("counter 0xffff");
>          avr_timer16_clock_reset(t16);
>          if (t16->imsk & T16_INT_TOV) {
>              t16->ifr |=3D T16_INT_TOV;
> @@ -266,12 +265,12 @@ static void avr_timer16_interrupt(void *opaque)
>      }
>      /* Check for ocra overflow in CTC mode */
>      if (mode =3D=3D T16_MODE_CTC_OCRA && t16->next_interrupt =3D=3D COMP=
A) {
> -        DB_PRINT("CTC OCRA overflow");
> +        trace_avr_timer16_interrupt_overflow("CTC OCRA");
>          avr_timer16_clock_reset(t16);
>      }
>      /* Check for icr overflow in CTC mode */
>      if (mode =3D=3D T16_MODE_CTC_ICR && t16->next_interrupt =3D=3D CAPT)=
 {
> -        DB_PRINT("CTC ICR overflow");
> +        trace_avr_timer16_interrupt_overflow("CTC ICR");

Rather than spamming strings to the trace log I'd suggest expanding
trace_avr_timer16_interrupt_count to include the mode and next_interrupt
state as hex values.

>          avr_timer16_clock_reset(t16);
>          if (t16->imsk & T16_INT_IC) {
>              t16->ifr |=3D T16_INT_IC;
> @@ -367,6 +366,8 @@ static uint64_t avr_timer16_read(void *opaque, hwaddr=
 offset, unsigned size)
>      default:
>          break;
>      }
> +    trace_avr_timer16_read(offset, retval);
> +
>      return (uint64_t)retval;
>  }
>=20=20
> @@ -378,7 +379,7 @@ static void avr_timer16_write(void *opaque, hwaddr of=
fset,
>      uint8_t val8 =3D (uint8_t)val64;
>      uint8_t prev_clk_src =3D CLKSRC(t16);
>=20=20
> -    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> +    trace_avr_timer16_write(offset, val8);
>=20=20
>      switch (offset) {
>      case T16_CRA:
> @@ -475,6 +476,7 @@ static uint64_t avr_timer16_imsk_read(void *opaque,
>  {
>      assert(size =3D=3D 1);
>      AVRTimer16State *t16 =3D opaque;
> +    trace_avr_timer16_read_imsk(offset ? 0 : t16->imsk);
>      if (offset !=3D 0) {
>          return 0;
>      }
> @@ -486,6 +488,7 @@ static void avr_timer16_imsk_write(void *opaque, hwad=
dr offset,
>  {
>      assert(size =3D=3D 1);
>      AVRTimer16State *t16 =3D opaque;
> +    trace_avr_timer16_write_imsk(val64);
>      if (offset !=3D 0) {
>          return;
>      }
> @@ -498,6 +501,7 @@ static uint64_t avr_timer16_ifr_read(void *opaque,
>  {
>      assert(size =3D=3D 1);
>      AVRTimer16State *t16 =3D opaque;
> +    trace_avr_timer16_read_ifr(offset ? 0 : t16->ifr);
>      if (offset !=3D 0) {
>          return 0;
>      }
> @@ -509,6 +513,7 @@ static void avr_timer16_ifr_write(void *opaque, hwadd=
r offset,
>  {
>      assert(size =3D=3D 1);
>      AVRTimer16State *t16 =3D opaque;
> +    trace_avr_timer16_write_imsk(val64);
>      if (offset !=3D 0) {
>          return;
>      }
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 29fda7870e..5d9f4c93fb 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -74,3 +74,15 @@ nrf51_timer_write(uint64_t addr, uint32_t value, unsig=
ned size) "write addr 0x%"
>  bcm2835_systmr_irq(bool enable) "timer irq state %u"
>  bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset =
0x%" PRIx64 " data 0x%" PRIx64
>  bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offse=
t 0x%" PRIx64 " data 0x%" PRIx64
> +
> +# avr_timer16.c
> +avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u valu=
e:%u"
> +avr_timer16_read_ifr(uint8_t value) "timer16 read addr:ifr value:%u"
> +avr_timer16_read_imsk(uint8_t value) "timer16 read addr:imsk value:%u"
> +avr_timer16_write(uint8_t addr, uint8_t value) "timer16 write addr:%u va=
lue:%u"
> +avr_timer16_write_ifr(uint8_t value) "timer16 write addr:ifr value:%u"
> +avr_timer16_write_imsk(uint8_t value) "timer16 write addr:imsk value:%u"
> +avr_timer16_interrupt_count(uint8_t cnt) "count: %u"
> +avr_timer16_interrupt_overflow(const char *reason) "overflow: %s"
> +avr_timer16_next_alarm(uint64_t delay_ns) "next alarm: %" PRIu64 " ns fr=
om now"
> +avr_timer16_clksrc_update(uint64_t freq_hz, uint64_t period_ns, uint64_t=
 delay_s) "timer frequency: %" PRIu64 " Hz, period: %" PRIu64 " ns (%" PRId=
64 " us)"


--=20
Alex Benn=C3=A9e

