Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C4FC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9D121783
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ls2GAGKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrx5-0002Re-8n
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrvT-0001Q7-Jp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrvS-0001qk-7d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:39:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrvS-0001qH-02
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:39:10 -0500
Received: by mail-wr1-x444.google.com with SMTP id s5so2202527wrw.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QBoYTNpvqdx2XMcniOzNK0S6Cxx+PCkcLF8xvjIAgDk=;
 b=Ls2GAGKstC+aJb05hXdz/0TqCiWjKDWLJhX6j6uj3k3XclDzNF/xgrrcvBOblQvyoO
 Q+G3WH6qeUMJFcqChZT2cuUfOlL+6fxu6vz2b4FLM8kV3FbhT5MoWOSTOK1TIf1xeYLP
 8tjJMXR3x5z7tXa7mVNUrFYmaPGbQ6LV3JQW3pGFz/rbicwPLUcdzX+AqCSM64eK354V
 r2aSAC6ztJaKJL35oWHr2L+Cq8n6zyK7IiVR/XPlA5xguCFXbhvbI1wa888cw6tpt5zD
 +z4q+AhBwQNweM0jLQbNAse69Jgcw89rWIQL/OAWugih3t3I2xknwtdl163YnxjEEJQ3
 fCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QBoYTNpvqdx2XMcniOzNK0S6Cxx+PCkcLF8xvjIAgDk=;
 b=KzCFIK10tzXwgdg8e7uaW8B9s+i13jaSGQoulRSNqncF965s6hSHrCgl7S1Xk5jLDn
 T3nO4JMJf6k7eYH/OA9PDcEmQb84BfF10mbr5oYcAGmtzU9KsZ3vfXZl+sfPU4wQ55Oc
 RAY6iWAgv87lvljE6qyfU1AXat3gbtsxqaxymzflAkqU64bL2bVCpUSNSblw2Q7xrNAx
 6BlLty3Xzg7j3u07oQfCbCZ+Ki1Q0XT5f2ENXaupzsRBcF+0bTRYYsdg5G2zQZTrOgS/
 fpHFIGtyk+5QQ+eHVEkSbtqYuU5o8VJsZVSG8sDzqrtFFmyfFpUzVKJZLMw9OoZVxvT9
 0nKw==
X-Gm-Message-State: APjAAAVt8At9MYL3jAe6VYi6dy9kgsa2oBai3+57cc0lOZGvFF+BCfav
 e5RgwPBMA3w2EUOn+cn0iZWNWw==
X-Google-Smtp-Source: APXvYqzbcpDotrwV8O166RgP1FxoCJmwbaRaOxJzTDsSs+CBfLVz3yoLodgX99BJIWDaQp3EXvrLAA==
X-Received: by 2002:adf:c413:: with SMTP id v19mr2545055wrf.208.1573648748556; 
 Wed, 13 Nov 2019 04:39:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm3133956wrb.67.2019.11.13.04.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 04:39:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 06DC01FF87;
 Wed, 13 Nov 2019 12:39:07 +0000 (GMT)
References: <20191113005201.19005-1-joel@jms.id.au>
 <20191113005201.19005-5-joel@jms.id.au>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v2 4/4] watchdog/aspeed: Fix AST2600 frequency behaviour
In-reply-to: <20191113005201.19005-5-joel@jms.id.au>
Date: Wed, 13 Nov 2019 12:39:06 +0000
Message-ID: <871ruc7xxx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joel Stanley <joel@jms.id.au> writes:

> The AST2600 control register sneakily changed the meaning of bit 4
> without anyone noticing. It no longer controls the 1MHz vs APB clock
> select, and instead always runs at 1MHz.
>
> The AST2500 was always 1MHz too, but it retained bit 4, making it read
> only. We can model both using the same fixed 1MHz calculation.
>
> Fixes: 6b2b2a703cad ("hw: wdt_aspeed: Add AST2600 support")
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Fix Fixes line in commit message
> ---
>  hw/watchdog/wdt_aspeed.c         | 21 +++++++++++++++++----
>  include/hw/watchdog/wdt_aspeed.h |  1 +
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 8787c5ad0f97..9a8a2200fd8e 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -93,11 +93,11 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr =
offset, unsigned size)
>
>  }
>
> -static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
> +static void aspeed_wdt_reload(AspeedWDTState *s)
>  {
>      uint64_t reload;
>
> -    if (pclk) {
> +    if (!(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK)) {
>          reload =3D muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_S=
ECOND,
>                            s->pclk_freq);
>      } else {
> @@ -109,6 +109,16 @@ static void aspeed_wdt_reload(AspeedWDTState *s, boo=
l pclk)
>      }
>  }
>
> +static void aspeed_wdt_reload_1mhz(AspeedWDTState *s)
> +{
> +    uint64_t reload =3D s->regs[WDT_RELOAD_VALUE] * 1000ULL;
> +
> +    if (aspeed_wdt_is_enabled(s)) {
> +        timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + relo=
ad);
> +    }
> +}
> +
> +
>  static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
>                               unsigned size)
>  {
> @@ -130,13 +140,13 @@ static void aspeed_wdt_write(void *opaque, hwaddr o=
ffset, uint64_t data,
>      case WDT_RESTART:
>          if ((data & 0xFFFF) =3D=3D WDT_RESTART_MAGIC) {
>              s->regs[WDT_STATUS] =3D s->regs[WDT_RELOAD_VALUE];
> -            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK=
));
> +            awc->wdt_reload(s);
>          }
>          break;
>      case WDT_CTRL:
>          if (enable && !aspeed_wdt_is_enabled(s)) {
>              s->regs[WDT_CTRL] =3D data;
> -            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
> +            awc->wdt_reload(s);
>          } else if (!enable && aspeed_wdt_is_enabled(s)) {
>              s->regs[WDT_CTRL] =3D data;
>              timer_del(s->timer);
> @@ -283,6 +293,7 @@ static void aspeed_2400_wdt_class_init(ObjectClass *k=
lass, void *data)
>      awc->offset =3D 0x20;
>      awc->ext_pulse_width_mask =3D 0xff;
>      awc->reset_ctrl_reg =3D SCU_RESET_CONTROL1;
> +    awc->wdt_reload =3D aspeed_wdt_reload;
>  }
>
>  static const TypeInfo aspeed_2400_wdt_info =3D {
> @@ -317,6 +328,7 @@ static void aspeed_2500_wdt_class_init(ObjectClass *k=
lass, void *data)
>      awc->ext_pulse_width_mask =3D 0xfffff;
>      awc->reset_ctrl_reg =3D SCU_RESET_CONTROL1;
>      awc->reset_pulse =3D aspeed_2500_wdt_reset_pulse;
> +    awc->wdt_reload =3D aspeed_wdt_reload_1mhz;
>  }
>
>  static const TypeInfo aspeed_2500_wdt_info =3D {
> @@ -336,6 +348,7 @@ static void aspeed_2600_wdt_class_init(ObjectClass *k=
lass, void *data)
>      awc->ext_pulse_width_mask =3D 0xfffff; /* TODO */
>      awc->reset_ctrl_reg =3D AST2600_SCU_RESET_CONTROL1;
>      awc->reset_pulse =3D aspeed_2500_wdt_reset_pulse;
> +    awc->wdt_reload =3D aspeed_wdt_reload_1mhz;
>  }
>
>  static const TypeInfo aspeed_2600_wdt_info =3D {
> diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_a=
speed.h
> index dfedd7662dd1..819c22993a6e 100644
> --- a/include/hw/watchdog/wdt_aspeed.h
> +++ b/include/hw/watchdog/wdt_aspeed.h
> @@ -47,6 +47,7 @@ typedef struct AspeedWDTClass {
>      uint32_t ext_pulse_width_mask;
>      uint32_t reset_ctrl_reg;
>      void (*reset_pulse)(AspeedWDTState *s, uint32_t property);
> +    void (*wdt_reload)(AspeedWDTState *s);
>  }  AspeedWDTClass;
>
>  #endif /* WDT_ASPEED_H */


--
Alex Benn=C3=A9e

