Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CB1C11D15
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFF424673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrAZdKmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFF424673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4q4t-0007IH-7H
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4q4A-00068P-00
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4q48-00056a-Vj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:56:49 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4q48-00056I-Ph
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:56:48 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so4523658otd.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aTgTw/kLl0fBctrw+cPBCDKisJ+8JE/FiweQ50VxrGk=;
 b=rrAZdKmTvKdn9kNyhbIOtgWv70ftOWuZdxuxuVt372yTLlhh1qt9cJm5R9h4oR9p/T
 Do1vkKPtQ8cQ7Pucgt2HAo4zdzyyGWiOBiBnSG4hT8ZYuBX0f9y9lVyR9/YrwShzHEBt
 QoylH9H0asdR+8NkkHlbtFsPEefC6VeH63hZuXCXa15uJsg7jnG1QyAG51d33wIZTLLq
 ZwV5yULerVJF3fG7WD9556WOrDnm4t9J9FXkuICiry5AEjrH08QJowPaxotJAq7J7+Kx
 N2w+boJ1sd9OQcdAs0GRY2iaS3xs8RsmHAQu9edPL+Obku9nbPjklvHaC6WmPe2u/C0f
 4Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aTgTw/kLl0fBctrw+cPBCDKisJ+8JE/FiweQ50VxrGk=;
 b=m1Uvk156/GG+DzkEyOrD6Jo9ekQtQEq1hwGbh3oqxC8bNFfbsFcEl5QfJBSV4ExNkI
 bar2GvNOXo5kL5ZoO/dpASGbNFfLaMg65CS84Uprts0P+iq4xMKsI9IRWmJG18rBszuE
 1yOu84Kl6iUaICGFSKY8bccQY3TThZAEwGupcIIOLY/AlgCgUS5Rt2quk08dwlIpt4lw
 G2SxVcPkKR3q/R7JTd+4eSyJRG339M8pzclO/T6kUxKsdLjRqHP2vxjam45p6Lq27yRW
 YT+GBmYzNDwT0Bv0S0aBkxCjxBABFqI/o0CqPCW3cyBRO4dfiLBfER30Ylne10gXXFbi
 N/iw==
X-Gm-Message-State: APjAAAWkIIHKOaPjcLFmjAiovsL5e16oytAvhFi/5SBX62EVVOteCnEB
 dzA9/U4BY7eqXFRT8O0EBntPTvjkR8W6siRwxcDl8g==
X-Google-Smtp-Source: APXvYqyKvzPPsBZ9k7btPrJQwxfjNnuF848pwfvGLl77hMe5XtF5GOBLRv2xruzJ0LPRCQM6prmbI0d6iXCOklQnW1g=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr12483446oto.135.1582221408022; 
 Thu, 20 Feb 2020 09:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20200217032127.46508-1-pannengyuan@huawei.com>
 <20200217032127.46508-3-pannengyuan@huawei.com>
In-Reply-To: <20200217032127.46508-3-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 17:56:37 +0000
Message-ID: <CAFEAcA_AxCVaAgho3g2q=kCifSdhz9Qi72eoVAM9gRjb3-_Sog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw: move timer_new from init() into realize() to
 avoid memleaks
To: Pan Nengyuan <pannengyuan@huawei.com>
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, mav2-rk.cave-ayland@ilande.co.uk,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 03:22, <pannengyuan@huawei.com> wrote:
>
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> There are some memleaks when we call 'device_list_properties'. This patch=
 move timer_new from init into realize to fix it.
> Meanwhile, do the null check in mos6522_reset() to avoid null deref if we=
 move timer_new into realize().
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
> index 19e154b870..980eda7599 100644
> --- a/hw/misc/mos6522.c
> +++ b/hw/misc/mos6522.c
> @@ -465,11 +465,15 @@ static void mos6522_reset(DeviceState *dev)
>      s->timers[0].frequency =3D s->frequency;
>      s->timers[0].latch =3D 0xffff;
>      set_counter(s, &s->timers[0], 0xffff);
> -    timer_del(s->timers[0].timer);
> +    if (s->timers[0].timer) {
> +        timer_del(s->timers[0].timer);
> +    }
>
>      s->timers[1].frequency =3D s->frequency;
>      s->timers[1].latch =3D 0xffff;
> -    timer_del(s->timers[1].timer);
> +    if (s->timers[1].timer) {
> +        timer_del(s->timers[1].timer);
> +    }
>  }

What code path calls a device 'reset' method on a device
that has not yet been realized ? I wasn't expecting that
to be valid...

thanks
-- PMM

