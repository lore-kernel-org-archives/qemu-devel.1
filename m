Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEFC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0119F20679
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX2GmjTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmuZ-0006Bw-62
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmro-00024A-8M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmrn-0003S4-5p
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:51:28 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXmrm-0003RJ-W4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:51:27 -0500
Received: by mail-ot1-x343.google.com with SMTP id r24so2916693otk.12
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Uo6TYPbqUjmNcoj/a2xEUCpBiEzNJmC9PXXQWFYm704=;
 b=HX2GmjTXR1hwhPiJ4no4dtX81Z+Ecb+vQLYQ50sOEU7dmLMX55HKzT1TiqZqGfx0Ym
 Pej8ixOxZHy3uuZtdZbnlG4TE9tspA4z8UpI9CSfSkwjjOQzvK6UTHIj0/S52me2lHqQ
 +7Y7vW97pBbDDR1drb5r8PE+ueUSaguDVO1XeaT9Bc6aEH+fvm5EOYE+Xi7r1ojsSc28
 HYKHeU9cnOvMkNH15epxIraC6CISNTkVZi/i+gG8Gh2IGR6f8jDckGT9f3fmtxZJy/Hs
 gfTJ+ET2MLXD0WJRiEYrfw7UEXqlLhWbVpw3Sw09dLbTAz9uvf+pvl3B5sdNjalhU3MU
 7MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Uo6TYPbqUjmNcoj/a2xEUCpBiEzNJmC9PXXQWFYm704=;
 b=Tt+327m50OJwfYPQHevklvS+Y5yez/kzSYkIKUuqtE6FqpP3GLGvMptWtOHP+4BNF2
 JiSVCV9KSJKBx7yDfS+9iANYiBXvz+DrQC2NAbt/HeJnzMoG5O7ueev3+4WRT5IvGMXn
 tih2mZiXUqzqohISEp/p3nhZzVlNMqJfmAEF0fLJb7TQ9RdwOEUWAiKc976S2NpSXW2p
 tbkAp80hs85xrifgStuIFEqdq2cAQe8/lVQENH+F9mh9Dg6TYkuRcxb2fmei2czEZqGO
 cOjfjjsgqKwDq6fBnWZDzE65Ll3SGGtS/hSJn+HGS4o8iu5KT5FUece/UvKDt1i9rzji
 qROA==
X-Gm-Message-State: APjAAAV8/sRBvqI2VZmXXOmkKTtA7ciMq3vkq9kbK4eC3v5EFtVTNt/c
 oRfYQ4O21Pg4FBvOtxuCn1J41e79u6JEtyzjZuvl4A==
X-Google-Smtp-Source: APXvYqzSb99thWn5iJywce3MXZOPFoB9/MmiWOg6BiguZ00FKWucgjAIUCQom5yEVXepvY+rIMtO3eM0clLN6Jft71A=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr6538888otn.135.1574344286190; 
 Thu, 21 Nov 2019 05:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-28-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-28-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 13:51:15 +0000
Message-ID: <CAFEAcA-k5tHOzAoUERk2MGx8BPjHUvWELgvgONfLS_UQMmJRuA@mail.gmail.com>
Subject: Re: [PATCH v4 27/37] leon3: use qdev gpio facilities for the PIL
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 15:30, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/sparc/leon3.c   | 6 ++++--
>  target/sparc/cpu.h | 1 -
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index cac987373e..1a89d44e57 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -230,8 +230,10 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
>
>      /* Allocate IRQ manager */
>      dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
> -    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
> -    qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
> +    qdev_init_gpio_in_named_with_opaque(DEVICE(env), leon3_set_pil_in,
> +                                        env, "pil", 1);
> +    qdev_connect_gpio_out_named(dev, "grlib-irq", 0,
> +                                qdev_get_gpio_in_named(DEVICE(env), "pil=
", 0));
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
>      env->irq_manager =3D dev;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Creating a gpio pin on some object that isn't yourself
looks a bit odd, but all this leon3 code is modifying
the CPU object from the outside anyway. Someday we might
tidy it up, but not today.

thanks
-- PMM

