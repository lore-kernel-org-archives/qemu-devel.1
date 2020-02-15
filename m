Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1797C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5662D2067D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgMtBZor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5662D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2usq-0001xb-FJ
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 05:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2us0-000116-KJ
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2urz-000263-0S
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:40:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2ury-00025r-TL
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581763218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSg2QGGBx6LkJHH7D0q6/WafQGFlLhrhugSNzXIdq7k=;
 b=VgMtBZorlEDaPLBGT7WbVjZ2TRXlUfn01TeT4KelXAcHyyxSGhuMKm4tvqZFQc1Y0SK83j
 VX7tIu28s7UrkA96E+rgXrntvGz8H8H4OWG99vfwNWZj4jxFZ4eXPK8pDyAPm9KNOEZFJL
 xzB84zilckdxeYSGXj4PfmD2SPH1/C8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-tOIkXARtNgS-tVKEmNjS-A-1; Sat, 15 Feb 2020 05:40:16 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so5481847wrm.17
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 02:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XGx4ATsorrbcYvy7KZX8q+tEnDKZZXLGIGV08iNRHzc=;
 b=RNdJ6cvzhw09S7EpE3X2FdByrMAAcrB5r7xjQSbmeAai3JDlFUOToUxG17gPIWgd0k
 hITG5ifv7Kd4UaAM2sPseuwyafSOURqZObt+Tl7zZjIZmqb7h2cIt2NMuYCptKyNJ5MK
 Pk0GYWwG8dkGqDwJXmHPkVyNzIOCMKDjsH8vX4kF3me5m30Z/Ks4oiRY4lXqQ2TlGG2m
 kNBPle4WRF1aAztfCtRbq6ON8y3+aV1nDVwTcf9FgshQOeNRlC9u6lmrlhDO+W+riBiv
 abDra1J59IbFuDph2dyjqbGRNSa0VSSMZcTRxo1IdEDxYPSyEzsY13cx2S5gjLM1aUl/
 EK5Q==
X-Gm-Message-State: APjAAAXaM0MQcghW/JE0SSjvJoTvd0D2wD4SLe0WfTGE9nztzreFJJ3f
 0supCjrY9ADegv4O+7gNw0Vzytmn+MTBTaArTiiTUkdPTN9WpDYc5vCRIkI0PfBlsS/tcpum6td
 DSAtF33RVDuMb7xY=
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr10846550wma.171.1581763204410; 
 Sat, 15 Feb 2020 02:40:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2HFo9dm2bQm4Z1gxCOGkQBQKPBWfwoHsCo3joIyH7d7YR4w+XWmXg10Q6krtwTruleA+AAw==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr10846514wma.171.1581763204092; 
 Sat, 15 Feb 2020 02:40:04 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id 16sm11012988wmi.0.2020.02.15.02.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 02:40:03 -0800 (PST)
Subject: Re: [PATCH 2/2] hw: move timer_new from init() into realize() to
 avoid memleaks
To: pannengyuan@huawei.com, balrogg@gmail.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk, david@gibson.dropbear.id.au,
 edgar.iglesias@gmail.com, alistair@alistair23.me
References: <20200215083715.5147-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39ddfe16-1e76-d4a4-878c-c45e7504f596@redhat.com>
Date: Sat, 15 Feb 2020 11:40:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215083715.5147-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: tOIkXARtNgS-tVKEmNjS-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: euler.robot@huawei.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 9:37 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> There are some memleaks when we call 'device_list_properties'. This patch=
 move timer_new from init into realize to fix it.
> Meanwhile, do the null check in mos6522_reset() to avoid null deref if we=
 move timer_new into realize().
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>   hw/arm/pxa2xx.c        | 17 +++++++++++------
>   hw/arm/spitz.c         |  8 +++++++-
>   hw/arm/strongarm.c     | 18 ++++++++++++------
>   hw/misc/mos6522.c      | 14 ++++++++++++--
>   hw/timer/cadence_ttc.c | 16 +++++++++++-----
>   5 files changed, 53 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index b33f8f1351..56a36202d7 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -1134,18 +1134,22 @@ static void pxa2xx_rtc_init(Object *obj)
>       s->last_rtcpicr =3D 0;
>       s->last_hz =3D s->last_sw =3D s->last_pi =3D qemu_clock_get_ms(rtc_=
clock);
>  =20
> +    sysbus_init_irq(dev, &s->rtc_irq);
> +
> +    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
> +                          "pxa2xx-rtc", 0x10000);
> +    sysbus_init_mmio(dev, &s->iomem);
> +}
> +
> +static void pxa2xx_rtc_realize(DeviceState *dev, Error **errp)
> +{
> +    PXA2xxRTCState *s =3D PXA2XX_RTC(dev);
>       s->rtc_hz    =3D timer_new_ms(rtc_clock, pxa2xx_rtc_hz_tick,    s);
>       s->rtc_rdal1 =3D timer_new_ms(rtc_clock, pxa2xx_rtc_rdal1_tick, s);
>       s->rtc_rdal2 =3D timer_new_ms(rtc_clock, pxa2xx_rtc_rdal2_tick, s);
>       s->rtc_swal1 =3D timer_new_ms(rtc_clock, pxa2xx_rtc_swal1_tick, s);
>       s->rtc_swal2 =3D timer_new_ms(rtc_clock, pxa2xx_rtc_swal2_tick, s);
>       s->rtc_pi    =3D timer_new_ms(rtc_clock, pxa2xx_rtc_pi_tick,    s);
> -
> -    sysbus_init_irq(dev, &s->rtc_irq);
> -
> -    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
> -                          "pxa2xx-rtc", 0x10000);
> -    sysbus_init_mmio(dev, &s->iomem);
>   }
>  =20
>   static int pxa2xx_rtc_pre_save(void *opaque)
> @@ -1203,6 +1207,7 @@ static void pxa2xx_rtc_sysbus_class_init(ObjectClas=
s *klass, void *data)
>  =20
>       dc->desc =3D "PXA2xx RTC Controller";
>       dc->vmsd =3D &vmstate_pxa2xx_rtc_regs;
> +    dc->realize =3D pxa2xx_rtc_realize;
>   }
>  =20
>   static const TypeInfo pxa2xx_rtc_sysbus_info =3D {
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index e001088103..cbfa6934cf 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -524,11 +524,16 @@ static void spitz_keyboard_init(Object *obj)
>  =20
>       spitz_keyboard_pre_map(s);
>  =20
> -    s->kbdtimer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick=
, s);
>       qdev_init_gpio_in(dev, spitz_keyboard_strobe, SPITZ_KEY_STROBE_NUM)=
;
>       qdev_init_gpio_out(dev, s->sense, SPITZ_KEY_SENSE_NUM);
>   }
>  =20
> +static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
> +{
> +    SpitzKeyboardState *s =3D SPITZ_KEYBOARD(dev);
> +    s->kbdtimer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick=
, s);
> +}
> +
>   /* LCD backlight controller */
>  =20
>   #define LCDTG_RESCTL=090x00
> @@ -1115,6 +1120,7 @@ static void spitz_keyboard_class_init(ObjectClass *=
klass, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->vmsd =3D &vmstate_spitz_kbd;
> +    dc->realize =3D spitz_keyboard_realize;
>   }
>  =20
>   static const TypeInfo spitz_keyboard_info =3D {
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index cd8a99aaf2..3010d765bb 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -399,9 +399,6 @@ static void strongarm_rtc_init(Object *obj)
>       s->last_rcnr =3D (uint32_t) mktimegm(&tm);
>       s->last_hz =3D qemu_clock_get_ms(rtc_clock);
>  =20
> -    s->rtc_alarm =3D timer_new_ms(rtc_clock, strongarm_rtc_alarm_tick, s=
);
> -    s->rtc_hz =3D timer_new_ms(rtc_clock, strongarm_rtc_hz_tick, s);
> -
>       sysbus_init_irq(dev, &s->rtc_irq);
>       sysbus_init_irq(dev, &s->rtc_hz_irq);
>  =20
> @@ -410,6 +407,13 @@ static void strongarm_rtc_init(Object *obj)
>       sysbus_init_mmio(dev, &s->iomem);
>   }
>  =20
> +static void strongarm_rtc_realize(DeviceState *dev, Error **errp)
> +{
> +    StrongARMRTCState *s =3D STRONGARM_RTC(dev);
> +    s->rtc_alarm =3D timer_new_ms(rtc_clock, strongarm_rtc_alarm_tick, s=
);
> +    s->rtc_hz =3D timer_new_ms(rtc_clock, strongarm_rtc_hz_tick, s);
> +}
> +
>   static int strongarm_rtc_pre_save(void *opaque)
>   {
>       StrongARMRTCState *s =3D opaque;
> @@ -451,6 +455,7 @@ static void strongarm_rtc_sysbus_class_init(ObjectCla=
ss *klass, void *data)
>  =20
>       dc->desc =3D "StrongARM RTC Controller";
>       dc->vmsd =3D &vmstate_strongarm_rtc_regs;
> +    dc->realize =3D strongarm_rtc_realize;
>   }
>  =20
>   static const TypeInfo strongarm_rtc_sysbus_info =3D {
> @@ -1240,15 +1245,16 @@ static void strongarm_uart_init(Object *obj)
>                             "uart", 0x10000);
>       sysbus_init_mmio(dev, &s->iomem);
>       sysbus_init_irq(dev, &s->irq);
> -
> -    s->rx_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_u=
art_rx_to, s);
> -    s->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_tx, =
s);
>   }
>  =20
>   static void strongarm_uart_realize(DeviceState *dev, Error **errp)
>   {
>       StrongARMUARTState *s =3D STRONGARM_UART(dev);
>  =20
> +    s->rx_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                       strongarm_uart_rx_to,
> +                                       s);
> +    s->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, strongarm_uart_tx, =
s);
>       qemu_chr_fe_set_handlers(&s->chr,
>                                strongarm_uart_can_receive,
>                                strongarm_uart_receive,
> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 19e154b870..980eda7599 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -465,11 +465,15 @@ static void mos6522_reset(DeviceState *dev)
>       s->timers[0].frequency =3D s->frequency;
>       s->timers[0].latch =3D 0xffff;
>       set_counter(s, &s->timers[0], 0xffff);
> -    timer_del(s->timers[0].timer);
> +    if (s->timers[0].timer) {
> +        timer_del(s->timers[0].timer);
> +    }

I am surprised but you are right, timer_del() doesn't allow NULL (I=20
guess I confused with timer_free()).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>       s->timers[1].frequency =3D s->frequency;
>       s->timers[1].latch =3D 0xffff;
> -    timer_del(s->timers[1].timer);
> +    if (s->timers[1].timer) {
> +        timer_del(s->timers[1].timer);
> +    }
>   }
>  =20
>   static void mos6522_init(Object *obj)
> @@ -485,6 +489,11 @@ static void mos6522_init(Object *obj)
>       for (i =3D 0; i < ARRAY_SIZE(s->timers); i++) {
>           s->timers[i].index =3D i;
>       }
> +}
> +
> +static void mos6522_realize(DeviceState *dev, Error **errp)
> +{
> +    MOS6522State *s =3D MOS6522(dev);
>  =20
>       s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_tim=
er1, s);
>       s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_tim=
er2, s);
> @@ -502,6 +511,7 @@ static void mos6522_class_init(ObjectClass *oc, void =
*data)
>  =20
>       dc->reset =3D mos6522_reset;
>       dc->vmsd =3D &vmstate_mos6522;
> +    dc->realize =3D mos6522_realize;
>       device_class_set_props(dc, mos6522_properties);
>       mdc->parent_reset =3D dc->reset;
>       mdc->set_sr_int =3D mos6522_set_sr_int;
> diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
> index 5e3128c1e3..b0ba6b2bba 100644
> --- a/hw/timer/cadence_ttc.c
> +++ b/hw/timer/cadence_ttc.c
> @@ -412,16 +412,21 @@ static void cadence_timer_init(uint32_t freq, Caden=
ceTimerState *s)
>   static void cadence_ttc_init(Object *obj)
>   {
>       CadenceTTCState *s =3D CADENCE_TTC(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
> +                          "timer", 0x1000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static void cadence_ttc_realize(DeviceState *dev, Error **errp)
> +{
> +    CadenceTTCState *s =3D CADENCE_TTC(dev);
>       int i;
>  =20
>       for (i =3D 0; i < 3; ++i) {
>           cadence_timer_init(133000000, &s->timer[i]);
> -        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->timer[i].irq);
> +        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->timer[i].irq);
>       }
> -
> -    memory_region_init_io(&s->iomem, obj, &cadence_ttc_ops, s,
> -                          "timer", 0x1000);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>   }
>  =20
>   static int cadence_timer_pre_save(void *opaque)
> @@ -479,6 +484,7 @@ static void cadence_ttc_class_init(ObjectClass *klass=
, void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->vmsd =3D &vmstate_cadence_ttc;
> +    dc->realize =3D cadence_ttc_realize;
>   }
>  =20
>   static const TypeInfo cadence_ttc_info =3D {
>=20


