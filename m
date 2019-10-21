Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29BA20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="APt9yhY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29BA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZGh-0006s3-6r
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iMZE1-00042K-R1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iMZDw-0007ZB-LD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:04:01 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iMZDw-0007X7-6U
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:03:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id 60so11274919otu.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ygXBxJFwhSCxk9IebzEG5Q2RRK+LMZU+c13O0BSfDG0=;
 b=APt9yhY5RsSbQyAiKUQPD0WINpbf21OXRBtMH43QBEQAjJzCASWwfM0DpNMCzR/XRV
 1dWalq5m4O13lS2jHvh1PgzKONYZepg1IwPOKyNBKwis6rI4NbdoQwW6Rm2oCKs0V/pv
 i+v4Eja6WGJZ1VEv452L54K6GyXUtYuPfSrWLmvirsaOKgfDIjvRIqqRXh39fY8C4cFT
 ybeVJDmH/dyAiYBCWivBAyge67Cm1Y40XXCU6kVaXKcJqrACFZQqjyOhJpKLO/4mio6d
 czLC2CE2bTn8rrbTMnWaBesjG6ley3+PXxr5H2roFUzghD2TRc0o6xwQI+Qk+aGYMRf6
 YqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=ygXBxJFwhSCxk9IebzEG5Q2RRK+LMZU+c13O0BSfDG0=;
 b=HS+9Jb1HZLDymJQ9FaCkd+LOGJOTEfp4qrdoRVStPca2pY1dUU14A0unOlVMdhuTZr
 jgm3MZvanKWWNmKz0r6JG39AquW1zZd3wFwAzY8CcAcgBY/0wogItLLmGPetiPFhjff4
 olmPbjlSdN09dMHetcTOFWXMKtEs0FD7QazfEu6VITf4Z0zsI4yP2uNKrl3ZqXOuFF1T
 6agrLr3qE6Cy0h5s2Kuf4HAbb4rGP3M3WYfwYtuGTORoVgEXKMv+ltREiERbWG1TSV66
 9G2Mgk4GoknHTlNbq9FkAEhE1K2aWrEUeWosGl16NmsRH1gbZO/8xGvHvEyGOsaWga2k
 56EQ==
X-Gm-Message-State: APjAAAVMYeLM9ELyMrMrhcTK65bnhTCAJh3Lplmzwm36CG/Y0Oj4E9Nz
 9WGu4XqohygHLwwvn4SEWqXs9Q==
X-Google-Smtp-Source: APXvYqw16rRHIRYmm/Ispy68epRWEsNV/luOlzYfSE+TeqrD2SwvIPHLCYNIOTKWq7bRHu/GEmFm8w==
X-Received: by 2002:a05:6830:10cc:: with SMTP id
 z12mr18261594oto.20.1571670233588; 
 Mon, 21 Oct 2019 08:03:53 -0700 (PDT)
Received: from t560 ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id h5sm4241093oth.29.2019.10.21.08.03.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Oct 2019 08:03:52 -0700 (PDT)
Date: Mon, 21 Oct 2019 10:03:51 -0500
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 11/14] omap-i2c: remove PROP_PTR
Message-ID: <20191021150351.GJ25427@t560>
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018154212.13458-12-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Reply-To: cminyard@mvista.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 05:42:09PM +0200, Marc-André Lureau wrote:
> Since clock are not QOM objects, replace PROP_PTR of clocks with
> setters methods.

I agree with Peter's comment, a clock framework might be something
useful someday (not sure), a comment might be nice.

Other than that, looks good to me.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/arm/omap1.c        |  2 +-
>  hw/arm/omap2.c        |  8 ++++----
>  hw/i2c/omap_i2c.c     | 19 ++++++++++++-------
>  include/hw/arm/omap.h |  9 +++++++++
>  4 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index c5583b10e0..fe55c44c7e 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -4032,7 +4032,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>  
>      s->i2c[0] = qdev_create(NULL, "omap_i2c");
>      qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
> -    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "mpuper_ck"));
> +    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
>      qdev_init_nofail(s->i2c[0]);
>      busdev = SYS_BUS_DEVICE(s->i2c[0]);
>      sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I2C));
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index 726a628e64..046fb6ffb5 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -2428,8 +2428,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>  
>      s->i2c[0] = qdev_create(NULL, "omap_i2c");
>      qdev_prop_set_uint8(s->i2c[0], "revision", 0x34);
> -    qdev_prop_set_ptr(s->i2c[0], "iclk", omap_findclk(s, "i2c1.iclk"));
> -    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "i2c1.fclk"));
> +    omap_i2c_set_iclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.iclk"));
> +    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.fclk"));
>      qdev_init_nofail(s->i2c[0]);
>      busdev = SYS_BUS_DEVICE(s->i2c[0]);
>      sysbus_connect_irq(busdev, 0,
> @@ -2440,8 +2440,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>  
>      s->i2c[1] = qdev_create(NULL, "omap_i2c");
>      qdev_prop_set_uint8(s->i2c[1], "revision", 0x34);
> -    qdev_prop_set_ptr(s->i2c[1], "iclk", omap_findclk(s, "i2c2.iclk"));
> -    qdev_prop_set_ptr(s->i2c[1], "fclk", omap_findclk(s, "i2c2.fclk"));
> +    omap_i2c_set_iclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.iclk"));
> +    omap_i2c_set_fclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.fclk"));
>      qdev_init_nofail(s->i2c[1]);
>      busdev = SYS_BUS_DEVICE(s->i2c[1]);
>      sysbus_connect_irq(busdev, 0,
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index 3ba965a58f..3ccbd5cc2c 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -28,10 +28,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  
> -#define TYPE_OMAP_I2C "omap_i2c"
> -#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
> -
> -typedef struct OMAPI2CState {
> +struct OMAPI2CState {
>      SysBusDevice parent_obj;
>  
>      MemoryRegion iomem;
> @@ -56,7 +53,7 @@ typedef struct OMAPI2CState {
>      uint8_t divider;
>      uint8_t times[2];
>      uint16_t test;
> -} OMAPI2CState;
> +};
>  
>  #define OMAP2_INTR_REV	0x34
>  #define OMAP2_GC_REV	0x34
> @@ -504,10 +501,18 @@ static void omap_i2c_realize(DeviceState *dev, Error **errp)
>      }
>  }
>  
> +void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk)
> +{
> +    i2c->iclk = clk;
> +}
> +
> +void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
> +{
> +    i2c->fclk = clk;
> +}
> +
>  static Property omap_i2c_properties[] = {
>      DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
> -    DEFINE_PROP_PTR("iclk", OMAPI2CState, iclk),
> -    DEFINE_PROP_PTR("fclk", OMAPI2CState, fclk),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index 6b7897ba27..08ee0c7702 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -77,6 +77,15 @@ typedef struct omap_intr_handler_s omap_intr_handler;
>  void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
>  void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
>  
> +/* omap_i2c.c */
> +#define TYPE_OMAP_I2C "omap_i2c"
> +#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
> +
> +typedef struct OMAPI2CState OMAPI2CState;
> +
> +void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk);
> +void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
> +
>  /* OMAP2 l4 Interconnect */
>  struct omap_l4_s;
>  struct omap_l4_region_s {
> -- 
> 2.23.0.606.g08da6496b6
> 

