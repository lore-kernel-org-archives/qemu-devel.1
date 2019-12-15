Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E680C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B1B22B48
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehbDP6ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B1B22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igMhh-0002rc-6a
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igMgh-0001op-Uf
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igMgg-0002Jz-I1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:43:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igMgg-0002Hh-El
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576388600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WYWZRg8tJRvZtH4+epWuAT8aPcYqczquMIkdW2aRs0U=;
 b=ehbDP6hai90Seg8IR3U6WWJaJFegWglQNKBFu+J0cMvp5OfQ/DYTGx4e0MYUPUXGI7clJF
 vAKntlXwXqjYcQLtVi+IdwKk3wtkggCVyBUGs8v6NdmyCwP1zH5f3iivoLhoVTamRIVRQ2
 4X/U2RtnTUcUYGE/DjzSNk2N2OLntZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-VUixJ9ROP5yEbYZfbUuEoQ-1; Sun, 15 Dec 2019 00:43:16 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so1823915wrh.5
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/qB7Gi5SWtltKKOuurM6xBe7Sh+GNECta0fajZrtUyI=;
 b=FkLNfTHI8UXy622YRW4gUSCFgzLIukWxI5po+Wlk0nvWjuucgCuRF29juz7u9ffSEs
 prlG2AwpA5alKlF/l6ODQAiHvYqR/yGgqoOAO3gp25cB6q0SZVkzLNNhBaZ8NEWz84yr
 z1z1kMoq5qnEty0Hc4W7R38JA5wG934F6jz9h8U7xlJV4LT/WPVJsSXwBivWWyrU7GJn
 DgpWayI2cAAuWDna5S9E+NbFS4rHPMjjlVCjuje3Pe0abm7kazZXdXXmAJ8SIp134RYJ
 t02VeTC+MtOvDa1caL60YjfkdDy5tMRfvv0m3E+Go7aTZ5i8UxwBj+F3GY8hHq7whT+N
 YvJQ==
X-Gm-Message-State: APjAAAVHT6BpIBn3x0TJY+OA6V+Nxmt9bKEuiYkNgftJIqP7nBMy4mwc
 /dPZLtDbQipWu9XqiUJpM0BCkDCuX54tJVn+9s+OpivsalN8I0SsKjcwtFLOkQ+iMM+7IkcT5DW
 hTqBxYxE3ENYIMqM=
X-Received: by 2002:a1c:234b:: with SMTP id j72mr8631662wmj.128.1576388595220; 
 Sat, 14 Dec 2019 21:43:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/QFupxpgKpIpN+MpdrUw+Em0rqBSY3iDQHYCUOW3+UPEK2UyLz62b+HTQYhVO3sPRcWywMg==
X-Received: by 2002:a1c:234b:: with SMTP id j72mr8631649wmj.128.1576388594995; 
 Sat, 14 Dec 2019 21:43:14 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id p26sm16212404wmc.24.2019.12.14.21.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:43:14 -0800 (PST)
Subject: Re: [PATCH v4 33/37] omap-i2c: remove PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-34-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11934efd-128a-2ebf-5b5f-3f6433acf3c6@redhat.com>
Date: Sun, 15 Dec 2019 06:43:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-34-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: VUixJ9ROP5yEbYZfbUuEoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/omap1.c        |  2 +-
>   hw/arm/omap2.c        |  8 ++++----
>   hw/i2c/omap_i2c.c     | 19 ++++++++++++-------
>   include/hw/arm/omap.h | 13 +++++++++++++
>   4 files changed, 30 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 1afd1d3d7f..807e5f70d1 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -4030,7 +4030,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryReg=
ion *dram,
>  =20
>       s->i2c[0] =3D qdev_create(NULL, "omap_i2c");
>       qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
> -    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "mpuper_ck"));
> +    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"))=
;
>       qdev_init_nofail(s->i2c[0]);
>       busdev =3D SYS_BUS_DEVICE(s->i2c[0]);
>       sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I=
2C));
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index 1d7cc435ef..171e2d0472 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -2425,8 +2425,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sdram,
>  =20
>       s->i2c[0] =3D qdev_create(NULL, "omap_i2c");
>       qdev_prop_set_uint8(s->i2c[0], "revision", 0x34);
> -    qdev_prop_set_ptr(s->i2c[0], "iclk", omap_findclk(s, "i2c1.iclk"));
> -    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "i2c1.fclk"));
> +    omap_i2c_set_iclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.iclk"))=
;
> +    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.fclk"))=
;
>       qdev_init_nofail(s->i2c[0]);
>       busdev =3D SYS_BUS_DEVICE(s->i2c[0]);
>       sysbus_connect_irq(busdev, 0,
> @@ -2437,8 +2437,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sdram,
>  =20
>       s->i2c[1] =3D qdev_create(NULL, "omap_i2c");
>       qdev_prop_set_uint8(s->i2c[1], "revision", 0x34);
> -    qdev_prop_set_ptr(s->i2c[1], "iclk", omap_findclk(s, "i2c2.iclk"));
> -    qdev_prop_set_ptr(s->i2c[1], "fclk", omap_findclk(s, "i2c2.fclk"));
> +    omap_i2c_set_iclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.iclk"))=
;
> +    omap_i2c_set_fclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.fclk"))=
;
>       qdev_init_nofail(s->i2c[1]);
>       busdev =3D SYS_BUS_DEVICE(s->i2c[1]);
>       sysbus_connect_irq(busdev, 0,
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index 3ba965a58f..3ccbd5cc2c 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -28,10 +28,7 @@
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>  =20
> -#define TYPE_OMAP_I2C "omap_i2c"
> -#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
> -
> -typedef struct OMAPI2CState {
> +struct OMAPI2CState {
>       SysBusDevice parent_obj;
>  =20
>       MemoryRegion iomem;
> @@ -56,7 +53,7 @@ typedef struct OMAPI2CState {
>       uint8_t divider;
>       uint8_t times[2];
>       uint16_t test;
> -} OMAPI2CState;
> +};
>  =20
>   #define OMAP2_INTR_REV=090x34
>   #define OMAP2_GC_REV=090x34
> @@ -504,10 +501,18 @@ static void omap_i2c_realize(DeviceState *dev, Erro=
r **errp)
>       }
>   }
>  =20
> +void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk)
> +{
> +    i2c->iclk =3D clk;
> +}
> +
> +void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
> +{
> +    i2c->fclk =3D clk;
> +}
> +
>   static Property omap_i2c_properties[] =3D {
>       DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
> -    DEFINE_PROP_PTR("iclk", OMAPI2CState, iclk),
> -    DEFINE_PROP_PTR("fclk", OMAPI2CState, fclk),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index bcecf19f89..39a295ba20 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -81,6 +81,19 @@ typedef struct omap_intr_handler_s omap_intr_handler;
>   void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
>   void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
>  =20
> +/* omap_i2c.c */
> +#define TYPE_OMAP_I2C "omap_i2c"
> +#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
> +
> +typedef struct OMAPI2CState OMAPI2CState;
> +
> +/*
> + * TODO: Ideally we should have a clock framework that
> + * let us wire these clocks up with QOM properties or links.
> + */
> +void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk);
> +void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
> +
>   /* OMAP2 l4 Interconnect */
>   struct omap_l4_s;
>   struct omap_l4_region_s {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


