Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A168DC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D1C2053B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6W6q6fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D1C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igMiv-00046e-H4
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igMhk-0003Cg-NN
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igMhj-00034a-7M
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:44:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igMhj-000346-3r
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576388670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXHDthb2VBRza70jI/L32cZ/r6ruv8qzxHsEBU/KZok=;
 b=f6W6q6fSvtDLoZEOFpmYRT48dRfBb16UoOx6qnU6dInZT6BpQQ6foEiGfGVmdA/BX4mLzK
 L1Hp0lCnnOpU2gNk/qJRYvDLc1KRVqGcHJIsKSsfCXtCHGBsKGoaTdbPb5vGAUs43R5OmV
 bArGXY4veHDuBcSAVWR0UlyNf37Wlms=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-us7ENQatOeGLhWfDa85xEw-1; Sun, 15 Dec 2019 00:44:28 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so426788wrx.22
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LCbxER/qbDrWnzhBNY67VUK81ytUvAaa8+3YGAyx2t0=;
 b=dtENrE8ATXnGpsGOOfM5tdFMOa2u0AHthnB4z7xxEGk8xcqGBKRWM6Gh8w7ygH9TrP
 et64dIiNtpWN7XfOnWQVUPjLcC+6Y4iSAMOuZZJ4MaALTAEmz37jeAVmmZT1yoM+P9Z6
 +UtPlqyLDQR1vuS4cDmWULMDEW2EJ9QAUFxKaiM5YnMLxz8qFvdTzmLWMsa7E8zIL25V
 nUHM4DnN6MrExrX5LJ4pTfd+iYwioUtuSmCW8A+7TrvgeqMINLsz7/oabMVjEe1/2hmi
 UZ/J5aM+0Dm7W/3YHt3HZ2kVgIN/lCs+lc6eEukVGuxz+P8YCFbLrd+mwuStT1N5UX1z
 lJ4g==
X-Gm-Message-State: APjAAAXu6lcydOi8l8UBy4fy5hFM7cawcsG/CJZLQA+8XUGanurkN2zh
 QGL6O/sj4yYHHRuFtWNugCX3GoOMmeLWHnSdN5oykKNEuPI4W47JIEWcwpfLfks3Lz48gTa/GUd
 e5X3vMdLvX7JozLE=
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr21935055wro.209.1576388667213; 
 Sat, 14 Dec 2019 21:44:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbYACkNzWhSkEIzvtOkZDQmSO81fzFn5rCxmWDiPoRFXPkide84jZmGzzpyz8caWqXv3/NrQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr21935041wro.209.1576388666933; 
 Sat, 14 Dec 2019 21:44:26 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id w13sm16640128wru.38.2019.12.14.21.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:44:26 -0800 (PST)
Subject: Re: [PATCH v4 34/37] omap-gpio: remove PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-35-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <904a5fd6-4b16-9f51-b6eb-0f45e451ccf7@redhat.com>
Date: Sun, 15 Dec 2019 06:44:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-35-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: us7ENQatOeGLhWfDa85xEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Since clocks are not QOM objects, replace PROP_PTR of clocks with
> setters methods.
>=20
> Move/adapt the existing TODO comment about a clock framework.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/omap1.c        |  2 +-
>   hw/arm/omap2.c        | 13 +++++++------
>   hw/gpio/omap_gpio.c   | 42 +++++++++++++++---------------------------
>   include/hw/arm/omap.h | 33 +++++++++++++++++++++++++++++----
>   4 files changed, 52 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 807e5f70d1..761cc17ea9 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -4012,7 +4012,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryReg=
ion *dram,
>  =20
>       s->gpio =3D qdev_create(NULL, "omap-gpio");
>       qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
> -    qdev_prop_set_ptr(s->gpio, "clk", omap_findclk(s, "arm_gpio_ck"));
> +    omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"=
));
>       qdev_init_nofail(s->gpio);
>       sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
>                          qdev_get_gpio_in(s->ih[0], OMAP_INT_GPIO_BANK1))=
;
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index 171e2d0472..e1c11de5ce 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -2449,13 +2449,14 @@ struct omap_mpu_state_s *omap2420_mpu_init(Memory=
Region *sdram,
>  =20
>       s->gpio =3D qdev_create(NULL, "omap2-gpio");
>       qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
> -    qdev_prop_set_ptr(s->gpio, "iclk", omap_findclk(s, "gpio_iclk"));
> -    qdev_prop_set_ptr(s->gpio, "fclk0", omap_findclk(s, "gpio1_dbclk"));
> -    qdev_prop_set_ptr(s->gpio, "fclk1", omap_findclk(s, "gpio2_dbclk"));
> -    qdev_prop_set_ptr(s->gpio, "fclk2", omap_findclk(s, "gpio3_dbclk"));
> -    qdev_prop_set_ptr(s->gpio, "fclk3", omap_findclk(s, "gpio4_dbclk"));
> +    omap2_gpio_set_iclk(OMAP2_GPIO(s->gpio), omap_findclk(s, "gpio_iclk"=
));
> +    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 0, omap_findclk(s, "gpio1_d=
bclk"));
> +    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 1, omap_findclk(s, "gpio2_d=
bclk"));
> +    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 2, omap_findclk(s, "gpio3_d=
bclk"));
> +    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 3, omap_findclk(s, "gpio4_d=
bclk"));
>       if (s->mpu_model =3D=3D omap2430) {
> -        qdev_prop_set_ptr(s->gpio, "fclk4", omap_findclk(s, "gpio5_dbclk=
"));
> +        omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 4,
> +                            omap_findclk(s, "gpio5_dbclk"));
>       }
>       qdev_init_nofail(s->gpio);
>       busdev =3D SYS_BUS_DEVICE(s->gpio);
> diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
> index 41e1aa798c..85c16897ae 100644
> --- a/hw/gpio/omap_gpio.c
> +++ b/hw/gpio/omap_gpio.c
> @@ -40,10 +40,6 @@ struct omap_gpio_s {
>       uint16_t pins;
>   };
>  =20
> -#define TYPE_OMAP1_GPIO "omap-gpio"
> -#define OMAP1_GPIO(obj) \
> -    OBJECT_CHECK(struct omap_gpif_s, (obj), TYPE_OMAP1_GPIO)
> -
>   struct omap_gpif_s {
>       SysBusDevice parent_obj;
>  =20
> @@ -212,10 +208,6 @@ struct omap2_gpio_s {
>       uint8_t delay;
>   };
>  =20
> -#define TYPE_OMAP2_GPIO "omap2-gpio"
> -#define OMAP2_GPIO(obj) \
> -    OBJECT_CHECK(struct omap2_gpif_s, (obj), TYPE_OMAP2_GPIO)
> -
>   struct omap2_gpif_s {
>       SysBusDevice parent_obj;
>  =20
> @@ -747,21 +739,13 @@ static void omap2_gpio_realize(DeviceState *dev, Er=
ror **errp)
>       }
>   }
>  =20
> -/* Using qdev pointer properties for the clocks is not ideal.
> - * qdev should support a generic means of defining a 'port' with
> - * an arbitrary interface for connecting two devices. Then we
> - * could reframe the omap clock API in terms of clock ports,
> - * and get some type safety. For now the best qdev provides is
> - * passing an arbitrary pointer.
> - * (It's not possible to pass in the string which is the clock
> - * name, because this device does not have the necessary information
> - * (ie the struct omap_mpu_state_s*) to do the clockname to pointer
> - * translation.)
> - */
> +void omap_gpio_set_clk(omap_gpif *gpio, omap_clk clk)
> +{
> +    gpio->clk =3D clk;
> +}
>  =20
>   static Property omap_gpio_properties[] =3D {
>       DEFINE_PROP_INT32("mpu_model", struct omap_gpif_s, mpu_model, 0),
> -    DEFINE_PROP_PTR("clk", struct omap_gpif_s, clk),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> @@ -784,15 +768,19 @@ static const TypeInfo omap_gpio_info =3D {
>       .class_init    =3D omap_gpio_class_init,
>   };
>  =20
> +void omap2_gpio_set_iclk(omap2_gpif *gpio, omap_clk clk)
> +{
> +    gpio->iclk =3D clk;
> +}
> +
> +void omap2_gpio_set_fclk(omap2_gpif *gpio, uint8_t i, omap_clk clk)
> +{
> +    assert(i <=3D 5);
> +    gpio->fclk[i] =3D clk;
> +}
> +
>   static Property omap2_gpio_properties[] =3D {
>       DEFINE_PROP_INT32("mpu_model", struct omap2_gpif_s, mpu_model, 0),
> -    DEFINE_PROP_PTR("iclk", struct omap2_gpif_s, iclk),
> -    DEFINE_PROP_PTR("fclk0", struct omap2_gpif_s, fclk[0]),
> -    DEFINE_PROP_PTR("fclk1", struct omap2_gpif_s, fclk[1]),
> -    DEFINE_PROP_PTR("fclk2", struct omap2_gpif_s, fclk[2]),
> -    DEFINE_PROP_PTR("fclk3", struct omap2_gpif_s, fclk[3]),
> -    DEFINE_PROP_PTR("fclk4", struct omap2_gpif_s, fclk[4]),
> -    DEFINE_PROP_PTR("fclk5", struct omap2_gpif_s, fclk[5]),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 39a295ba20..6be386d0e2 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -77,6 +77,16 @@ typedef struct omap_intr_handler_s omap_intr_handler;
>   /*
>    * TODO: Ideally we should have a clock framework that
>    * let us wire these clocks up with QOM properties or links.
> + *
> + * qdev should support a generic means of defining a 'port' with
> + * an arbitrary interface for connecting two devices. Then we
> + * could reframe the omap clock API in terms of clock ports,
> + * and get some type safety. For now the best qdev provides is
> + * passing an arbitrary pointer.
> + * (It's not possible to pass in the string which is the clock
> + * name, because this device does not have the necessary information
> + * (ie the struct omap_mpu_state_s*) to do the clockname to pointer
> + * translation.)
>    */
>   void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
>   void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
> @@ -87,13 +97,28 @@ void omap_intc_set_fclk(omap_intr_handler *intc, omap=
_clk clk);
>  =20
>   typedef struct OMAPI2CState OMAPI2CState;
>  =20
> -/*
> - * TODO: Ideally we should have a clock framework that
> - * let us wire these clocks up with QOM properties or links.
> - */
> +/* TODO: clock framework (see above) */
>   void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk);
>   void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
>  =20
> +/* omap_gpio.c */
> +#define TYPE_OMAP1_GPIO "omap-gpio"
> +#define OMAP1_GPIO(obj)                                         \
> +    OBJECT_CHECK(struct omap_gpif_s, (obj), TYPE_OMAP1_GPIO)
> +
> +#define TYPE_OMAP2_GPIO "omap2-gpio"
> +#define OMAP2_GPIO(obj)                                         \
> +    OBJECT_CHECK(struct omap2_gpif_s, (obj), TYPE_OMAP2_GPIO)
> +
> +typedef struct omap_gpif_s omap_gpif;
> +typedef struct omap2_gpif_s omap2_gpif;
> +
> +/* TODO: clock framework (see above) */
> +void omap_gpio_set_clk(omap_gpif *gpio, omap_clk clk);
> +
> +void omap2_gpio_set_iclk(omap2_gpif *gpio, omap_clk clk);
> +void omap2_gpio_set_fclk(omap2_gpif *gpio, uint8_t i, omap_clk clk);
> +
>   /* OMAP2 l4 Interconnect */
>   struct omap_l4_s;
>   struct omap_l4_region_s {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


