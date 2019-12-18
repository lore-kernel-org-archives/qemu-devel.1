Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757EEC2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F52D20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYe4i0OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F52D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUjk-0007tY-Qq
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUfa-0002eV-Iy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUfZ-00033X-Gx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:26:58 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihUfZ-00031l-Aw; Wed, 18 Dec 2019 03:26:57 -0500
Received: by mail-ot1-x344.google.com with SMTP id a15so1495171otf.1;
 Wed, 18 Dec 2019 00:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m9f/p9XSU77rE+9iAxpKkClXlh3MNGFo2vxjttUKlLU=;
 b=dYe4i0OMKE+jxWkvmY2y0GreyxyeHE1HuXAl4CTHSlwlRSBe6tiYcRmcGcAbXBLvZ+
 yOsR2cJAtSgm2ozhm1aKcUBo/CG8vlDwtWfwjHvWZUTucSfZduWCDqJJS2Qh1TxljJpT
 e5jSsrWqc9laFmCBiGMSDPhqL0YkUnWJq9BrWQAzl/63mV9MzVSi4uRVxjPJeFvxVRPf
 y5BQoXsq1Ovx0wqLeA57aQbWgf+Qrd3NJL93NoavzuZqyTgItQ3Hj8yEFpBtM2KnUX82
 /Ov1pc2pkhUarGtWgpgDVqphLN5Z5P2I3Iry9jXTZHpbbb/IaCNFDJPIYgDZDLQPBIUK
 izVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m9f/p9XSU77rE+9iAxpKkClXlh3MNGFo2vxjttUKlLU=;
 b=hO/zFS1dMW014+U2Qld0rk19OvasC47q6J/sf+lgkdOQFbqtjKrX6WoywShCz3x2Rl
 xA7EDdXGUGyhCO1kG5a+Onax1uU33dPslQzrldprlYlUwUgZe0Zvd5xSFo02jnfAPaQd
 uFTatBtxvBLRK42amizP1VYjxG8gBkI+iN4e6dSG5IMAJ+XhDeLsyox9XdHLfG6H4cG7
 S2iGvYjuYpYKlntAx+eLB3Vgxs3M7heu4XwathqFcwYs5YNZEmyi6fYr3+4DV45kbfki
 KOlTM914//cwOsLMPhEqY0QKtwwX6NHlOXAFvAMNRArkp5NT3HxAKuNiY53Zy0c68YD6
 3wmw==
X-Gm-Message-State: APjAAAVvtRPBPyuda7y8yeXYJP5JTLosdzhalnJMD1L1mxoa+8pkAhbP
 JrEIO21NiLiVdPZTT8SGdsS83V0FC+ojofyug1c=
X-Google-Smtp-Source: APXvYqzlSiRQ0xVigKKFcn3M08hSox4Z4LC1Jo20tplcsid6WPy8NGf9OI0kHp03TraCLNt20iKVy9yEz2t5MPNAG9U=
X-Received: by 2002:a05:6830:3054:: with SMTP id
 p20mr1313877otr.121.1576657616346; 
 Wed, 18 Dec 2019 00:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-5-philmd@redhat.com>
In-Reply-To: <20191217173425.5082-5-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 09:26:45 +0100
Message-ID: <CAL1e-=gT078HJzMkkBez8xywRQdy6H8qXBgTcc_Bf2rnO=LrJg@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/timer/aspeed_timer: Add a fall through comment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:Stellaris" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 17, 2019 at 6:37 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=3D2:
>
>   hw/timer/aspeed_timer.c: In function =E2=80=98aspeed_timer_set_value=E2=
=80=99:
>   hw/timer/aspeed_timer.c:283:24: error: this statement may fall through =
[-Werror=3Dimplicit-fallthrough=3D]
>     283 |         if (old_reload || !t->reload) {
>         |             ~~~~~~~~~~~^~~~~~~~~~~~~
>   hw/timer/aspeed_timer.c:287:5: note: here
>     287 |     case TIMER_REG_STATUS:
>         |     ^~~~
>   cc1: all warnings being treated as errors
>
> Add the missing fall through comment.
>
> Fixes: 1403f364472
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/timer/aspeed_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index a8c38cc118..c91f18415c 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -283,7 +283,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlSta=
te *s, int timer, int reg,
>          if (old_reload || !t->reload) {
>              break;
>          }
> -
> +        /* fall through to re-enable */
>      case TIMER_REG_STATUS:
>          if (timer_enabled(t)) {
>              uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> --
> 2.21.0
>
>

