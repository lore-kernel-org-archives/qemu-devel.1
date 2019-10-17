Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A7BECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616D02089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsmPpC/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616D02089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7rb-0005VD-1M
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL72a-0008VY-Jj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL72Y-0007dm-T0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:46:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL72Y-0007dQ-HO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571323569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ePLuvdpjiCrVsfMHqaKGaoDZ/EbnB1HE43qLtprzLU=;
 b=GsmPpC/b1IxF286fs/H1GqUlYGPOcOTLHqfVsb5mBcqA9e5KZkwW+yKcmfy6xnD4suoaVX
 V6h+fO90lK7+fcEXBsKao0qcbEgoFpNtZIBWZoH8As2Qv7EoXoDJxv6UmjVlvNX1HHdacq
 pKwNbCvPVO6qBlYzjjIuCMBRXGHxWOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-pUfIQZDBMjyd_NpUzv5N3Q-1; Thu, 17 Oct 2019 10:46:06 -0400
Received: by mail-wr1-f71.google.com with SMTP id j2so1068023wrg.19
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dKjKISv6Eh/62IDaORUG/Ahz7/jSmijXvXZXmqrw8Qo=;
 b=FFuTsUQ1+dEfzEHjuxVntSuX4ouQ0FTeLq2jF7QczkVAyRn14C7FGhdQ0a4j/fHrX0
 L0CHqGOAPs9IsPVMWc1tRRiBHPt4YSgnVqBYexmamzFDhjuB9hWkCY7s/AYNq+pVFjGs
 GTMlUgFM6vjWWS1Av1pG67ue542K7C7S+PnqrKonwF6mi9zssJFfX1aotAyWSdkEuONn
 z195M23ZjDAtSjecx5B/vkTURC26940y4Iw09g4FpVLHXVed5T1EudXX8zqkim6Mod0f
 HUj1TKzc7aGkwWNqCBPkMX31i4+AQSc2GJ8xhlGysuXsWeRYeKo/DsLWmv5W2LpG67aO
 Nzpw==
X-Gm-Message-State: APjAAAUt9b8z3EyEcH6LQlnS5VtYCt3pe05V6Xc47YjNvNgGxafrEJ8v
 78/TFgJxuPMLborZIzsi4XXSJDmreR3SY9VSekUql7yb0Ut5QwBbOSGuVlwyHEE1SHZG+9KF73t
 BF5n/kYDU7JZl+sI=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr3290163wro.234.1571323564978; 
 Thu, 17 Oct 2019 07:46:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxl9BKLBVlXWDQ4HFQuWvt5Yg0IkvV54R92QwyDh6KzWvXku0gS+71OviymYpc2SrEt13NcOQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr3290136wro.234.1571323564739; 
 Thu, 17 Oct 2019 07:46:04 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id u1sm2558055wru.90.2019.10.17.07.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:46:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/timer/grlib_gptimer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132351.4762-1-peter.maydell@linaro.org>
 <20191017132351.4762-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c6b7739-84c5-95b6-2af4-94f561b404c8@redhat.com>
Date: Thu, 17 Oct 2019 16:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132351.4762-2-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: pUfIQZDBMjyd_NpUzv5N3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/17/19 3:23 PM, Peter Maydell wrote:
> Switch the grlib_gptimer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/grlib_gptimer.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
> index bb09268ea14..7a9371c0e30 100644
> --- a/hw/timer/grlib_gptimer.c
> +++ b/hw/timer/grlib_gptimer.c
> @@ -29,7 +29,6 @@
>   #include "hw/irq.h"
>   #include "hw/ptimer.h"
>   #include "hw/qdev-properties.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>  =20
>   #include "trace.h"
> @@ -63,7 +62,6 @@ typedef struct GPTimer     GPTimer;
>   typedef struct GPTimerUnit GPTimerUnit;
>  =20
>   struct GPTimer {
> -    QEMUBH *bh;
>       struct ptimer_state *ptimer;
>  =20
>       qemu_irq     irq;
> @@ -93,6 +91,17 @@ struct GPTimerUnit {
>       uint32_t config;
>   };
>  =20
> +static void grlib_gptimer_tx_begin(GPTimer *timer)
> +{
> +    ptimer_transaction_begin(timer->ptimer);
> +}
> +
> +static void grlib_gptimer_tx_commit(GPTimer *timer)
> +{
> +    ptimer_transaction_commit(timer->ptimer);
> +}
> +
> +/* Must be called within grlib_gptimer_tx_begin/commit block */
>   static void grlib_gptimer_enable(GPTimer *timer)
>   {
>       assert(timer !=3D NULL);
> @@ -115,6 +124,7 @@ static void grlib_gptimer_enable(GPTimer *timer)
>       ptimer_run(timer->ptimer, 1);
>   }
>  =20
> +/* Must be called within grlib_gptimer_tx_begin/commit block */
>   static void grlib_gptimer_restart(GPTimer *timer)
>   {
>       assert(timer !=3D NULL);
> @@ -141,7 +151,9 @@ static void grlib_gptimer_set_scaler(GPTimerUnit *uni=
t, uint32_t scaler)
>       trace_grlib_gptimer_set_scaler(scaler, value);
>  =20
>       for (i =3D 0; i < unit->nr_timers; i++) {
> +        ptimer_transaction_begin(unit->timers[i].ptimer);
>           ptimer_set_freq(unit->timers[i].ptimer, value);
> +        ptimer_transaction_commit(unit->timers[i].ptimer);
>       }
>   }
>  =20
> @@ -266,8 +278,10 @@ static void grlib_gptimer_write(void *opaque, hwaddr=
 addr,
>           switch (timer_addr) {
>           case COUNTER_OFFSET:
>               trace_grlib_gptimer_writel(id, addr, value);
> +            grlib_gptimer_tx_begin(&unit->timers[id]);
>               unit->timers[id].counter =3D value;
>               grlib_gptimer_enable(&unit->timers[id]);
> +            grlib_gptimer_tx_commit(&unit->timers[id]);
>               return;
>  =20
>           case COUNTER_RELOAD_OFFSET:
> @@ -291,6 +305,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr =
addr,
>               /* gptimer_restart calls gptimer_enable, so if "enable" and=
 "load"
>                  bits are present, we just have to call restart. */
>  =20
> +            grlib_gptimer_tx_begin(&unit->timers[id]);
>               if (value & GPTIMER_LOAD) {
>                   grlib_gptimer_restart(&unit->timers[id]);
>               } else if (value & GPTIMER_ENABLE) {
> @@ -301,6 +316,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr =
addr,
>               value &=3D ~(GPTIMER_LOAD & GPTIMER_DEBUG_HALT);
>  =20
>               unit->timers[id].config =3D value;
> +            grlib_gptimer_tx_commit(&unit->timers[id]);
>               return;
>  =20
>           default:
> @@ -344,9 +360,11 @@ static void grlib_gptimer_reset(DeviceState *d)
>           timer->counter =3D 0;
>           timer->reload =3D 0;
>           timer->config =3D 0;
> +        ptimer_transaction_begin(timer->ptimer);
>           ptimer_stop(timer->ptimer);
>           ptimer_set_count(timer->ptimer, 0);
>           ptimer_set_freq(timer->ptimer, unit->freq_hz);
> +        ptimer_transaction_commit(timer->ptimer);
>       }
>   }
>  =20
> @@ -365,14 +383,16 @@ static void grlib_gptimer_realize(DeviceState *dev,=
 Error **errp)
>           GPTimer *timer =3D &unit->timers[i];
>  =20
>           timer->unit   =3D unit;
> -        timer->bh     =3D qemu_bh_new(grlib_gptimer_hit, timer);
> -        timer->ptimer =3D ptimer_init_with_bh(timer->bh, PTIMER_POLICY_D=
EFAULT);
> +        timer->ptimer =3D ptimer_init(grlib_gptimer_hit, timer,
> +                                    PTIMER_POLICY_DEFAULT);
>           timer->id     =3D i;
>  =20
>           /* One IRQ line for each timer */
>           sysbus_init_irq(sbd, &timer->irq);
>  =20
> +        ptimer_transaction_begin(timer->ptimer);
>           ptimer_set_freq(timer->ptimer, unit->freq_hz);
> +        ptimer_transaction_commit(timer->ptimer);
>       }
>  =20
>       memory_region_init_io(&unit->iomem, OBJECT(unit), &grlib_gptimer_op=
s,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


