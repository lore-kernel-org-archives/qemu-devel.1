Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C84C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03DB206F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcVwRkyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03DB206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhBx-0003Xb-24
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhBA-00036z-C3
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:56:24 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhB8-00024s-BG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:56:24 -0400
Received: by mail-ej1-x644.google.com with SMTP id f7so8635969ejq.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NYC6Ebdmwf7RZyIAMfm0Dysd6AENpI1O+6NVUSvgJsc=;
 b=KcVwRkyn1LTBz+nY05gQXUxXM0I9GI56mGGk6gVllBl2HYgFDhKBsndDUnHk1HnxCk
 swfOrU8ck9vZSzCHVe/b4hI/VOOEV7TMartvcrXN0kD15hQI0yzr8+xRoM9Nd0Ud6JzB
 COFB744zoBdVnNDsRTX0d5Ln4eE2XESLJz5LI1Q2sJNoMnlPnDNr7dl4OH2KyLTHAJkT
 D+Amf0/uxQGu1hSDUEPDoZkZ/wjJ+4jdOpJYkd9nIycTJuKhmGomHnHaNJyWp8ptqyun
 tj+N1F2lpZiMj8aV/SbHss5gpR73kGePDJe7EhY/jLs5YCtWChfT7wJRZPWC/k5bSV0L
 x1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NYC6Ebdmwf7RZyIAMfm0Dysd6AENpI1O+6NVUSvgJsc=;
 b=AvGX3/plZS6Hw2ZrVUTe+uEOPK+mJvKFhf+RvTDqrVVmeYLvSjaTPorVXDboG+QTE0
 ephrQM5U9lydzucGpCsV/ezWlHSqxf+fgZaRRH18glkObqjNQ0f/tghtqhwET44lVZzp
 Om6pkJOcS0EMhdeenJavB6slB7cEfByIwZjlCWwm+FQkUsWYGp+egwr8Wii3MLheItWN
 QPT6wv3yIAuDG4VeF4vJQNZbhIiJYXKK4zfjk8a075Zu+KduJleVSkVgcTFI3VHjui07
 tBVUC4xasD88igFXTAZhFuFQfFywIZWvKzHOA+HQX4/iiFpbKsMCgyy1V3efRcL0R4fa
 Xwnw==
X-Gm-Message-State: AOAM5314lou5GasgDw2UUxF3d8mwHwDcg9HhUsdiB6TtI72BmZRcXfkg
 8ujGsCHDjRf/qhSO/OvM+PsoIN/CP8Qhj/Ti82I=
X-Google-Smtp-Source: ABdhPJxf5L5GstBQdNT0MX+HYwUomlcW9Gg8ry30Ckxqgu8QS4M9X+tR0lfu7OBILqdcWdfwVVKlXCWNOvAhmmKYZDQ=
X-Received: by 2002:a17:906:f20b:: with SMTP id
 gt11mr11213616ejb.307.1591005380817; 
 Mon, 01 Jun 2020 02:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200601092057.10555-1-f4bug@amsat.org>
In-Reply-To: <20200601092057.10555-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 11:56:10 +0200
Message-ID: <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 1, 2020 at 11:21 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> I don't have much clue about the Renesas hardware, but at least
> I know now the source files a little bit, so I volunteer to pick
> up patches and send pull-requests for them during my scarce
> hobbyist time, until someone else with more knowledge steps up
> to do this job instead.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

There is alive and well Renesas target maintainer that obviously has
the access to Renesas hardware, and I have no idea why you should
be the maintainer for something that you say do not have much clue,
while at the same time omitting the original Renesas contributor.

Scandalous.

Regards,
Aleksandar

>  MAINTAINERS | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0944d9c731..cbba3ac757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: target/sh4/
> -F: hw/sh4/
>  F: disas/sh4.c
> -F: include/hw/sh4/
>
>  SPARC TCG CPUs
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
>
> +Renesas Hardware
> +----------------
> +SH4 Hardware
> +M: Aurelien Jarno <aurelien@aurel32.net>
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Odd Fixes
> +F: hw/sh4/
> +F: hw/char/sh_serial.c
> +F: hw/intc/sh_intc.c
> +F: hw/timer/sh_timer.c
> +F: include/hw/sh4/
> +
>  SH4 Machines
>  ------------
>  R2D
> @@ -1246,6 +1256,7 @@ S: Maintained
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c
> +F: include/hw/sh4/sh_intc.h
>
>  Shix
>  M: Magnus Damm <magnus.damm@gmail.com>
> --
> 2.21.3
>
>

