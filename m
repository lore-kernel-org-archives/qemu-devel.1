Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D574C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12242077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWmV9fw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12242077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugu4-00025b-Iq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iudvL-0004Cd-5x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iudvK-0007lN-59
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:57:35 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iudvJ-0007iy-V2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:57:34 -0500
Received: by mail-ot1-x341.google.com with SMTP id k14so2989042otn.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=78OoLEKFshaco3XqlhTyDxZN2Mdmre/EN0v1XtzbuR0=;
 b=ZWmV9fw7omIzoYFDr9pbun5Qfn3dVDRHV4eAiqcI08YWzC/lXrf6WZEcfJ1DWaX3wq
 uHzQUXzgfz5kBsTDzHjXPn3IkBBd6X9+bqLWLXTlUCr8WrwR+uokTnZUmxJOSnFkHm6Q
 GrYGZE52ERXMWOdYyQxwD9L3+2vCBoqbT7BkBPx8FfvMunp0ycengbtd099f0Lpcz+I0
 qYI6m/7MCO+vSV32ycQLSiWk3QFBUlxRKAE/T4Bj/24o66MTfDUGkBHtZFeMkDMQhMGf
 62gPC1tqlu7DHDh6rIh5AQIYNv5QQxkbbFbTtJikJBCa/2r/U0PwzHrcXtrNum2J0sE7
 iTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=78OoLEKFshaco3XqlhTyDxZN2Mdmre/EN0v1XtzbuR0=;
 b=RQORejScrkcT9kUlLtcZ+4lL7CMJqS8EX+LA6Z7vnUoot55xgKj32lbwSeFVzw/Ucy
 lDGJGQ6gJUvV7wIJg0HOu7LRKsbh4RL9EUPzPnarcVWZTO/Ev7Vy4NiuTiEJpKE9ZwHV
 Bu7mzwYTPujctoZAlKfOqz6LWlJibV2EIKG8V2FfYWzOIozqp+4P9vOkAdSsSbYGWVZ9
 W5+MuO6YH2c35bGUDr7rZh/cJUwNoCN7BoTdDjZDqiGKbacdOw5g2UknFuPz3cBsjTW1
 Iko7oOIuZMgP4YJZjxQirFLr8VtXowvMjAG5QnVWo1LbcVk5BthxJ1sPxN8BGFYs/KVE
 V+kA==
X-Gm-Message-State: APjAAAW/YxtvibyD8uwTg5L1PYNmjYoB1lOIzLhfFHu7OlREpkuoDI2P
 qu6Qsz3r3LMF0tIjl7MAry+IJKKQjuFOnfuoYVyHqy/05d4=
X-Google-Smtp-Source: APXvYqxeoCf+W762Ucg8W/W4FjNefJdeQ8bYNiSyC9LFCiEAsMtG9gtLOoHuwJfzdfCTdoTooem8+bs3ddCSunh36B8=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr11914530ota.232.1579791453016; 
 Thu, 23 Jan 2020 06:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20200121213853.9601-1-f4bug@amsat.org>
In-Reply-To: <20200121213853.9601-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 14:57:22 +0000
Message-ID: <CAFEAcA_yVNoFjgTcdCfxzzLLrz2jpENS9FZVp9vWS2X-R11REA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/stm32f4xx_syscfg: Fix copy/paste error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 21:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Missed in 870c034da0b, hopefully reported by Coverity.
>
> Fixes: Coverity CID 1412793 (Incorrect expression)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/misc/stm32f4xx_syscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
> index dbcdca59f8..f960e4ea1e 100644
> --- a/hw/misc/stm32f4xx_syscfg.c
> +++ b/hw/misc/stm32f4xx_syscfg.c
> @@ -47,7 +47,7 @@ static void stm32f4xx_syscfg_set_irq(void *opaque, int =
irq, int level)
>      STM32F4xxSyscfgState *s =3D opaque;
>      int icrreg =3D irq / 4;
>      int startbit =3D (irq & 3) * 4;
> -    uint8_t config =3D config =3D irq / 16;
> +    uint8_t config =3D irq / 16;
>
>      trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);



Applied to target-arm.next, thanks.

-- PMM

