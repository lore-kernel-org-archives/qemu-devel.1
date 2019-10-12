Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D553C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 16:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335C120679
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 16:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHMI0YJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335C120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJKWq-0003MO-Uv
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 12:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iJKUQ-0001Fh-Nf
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 12:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iJKM9-0002iD-5U
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 12:35:02 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iJKM8-0002i2-Uk; Sat, 12 Oct 2019 12:35:01 -0400
Received: by mail-lj1-x244.google.com with SMTP id a22so12724709ljd.0;
 Sat, 12 Oct 2019 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aEN0BXrZm6iZSlp+WUj/6WY/Tz+UnFpcDTWoVbuLCDw=;
 b=KHMI0YJVyp8pwjZXhMnwSW9SyIEwYEAB9BfF3mVPA5O6vH3BVulwmVfX0ZhlseJZo5
 sbdew8Dnsvk61uM6Yv/J2titD7eLpzGvNnmVwYkcgQZK1cUcJr6g63+XJ2WC1/sCRhRA
 LJ6qUb7t0EP4XKDFMcLOR0UvdSWaecY1YxaxCNHzBbiEfpZTdpspejOZa1ayCNssmaon
 u/EsVf4bPtVoMSwO+4g5GlAasu2WTzCVsqkJd4a4e2Lb2onVA0EoI/qOwj0DoGCDJGGV
 d/8FkwKX42VAr2ypPMdA0ZIkoccGRAHA+W7kJ16fqpTM6EYDEit/HTfiNBjJNW+y+hYr
 YW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aEN0BXrZm6iZSlp+WUj/6WY/Tz+UnFpcDTWoVbuLCDw=;
 b=fB2N3VeFKDH942ttq89kmKXgXC+WM6sDexeTnrhuw79XJp9HiST21+Q5UxtG1CmUuj
 JqhUZ+WvH0p3VcxyPQknD3fxh4K8ogeU89Y6KR+A7FgN0T73n+d/0PvzNWpgRjfoHV6d
 56Y22dVEMvvhBwHi7p2zWcmbAZrQ/0pBLohxF07ky6gjOTRaRB/jH/+/DxQN5GXQEPih
 F/g7m8H/XSAENbyeSRf7kRWYvAOeXU5NY5rD1bNMLWWdSgEfvIIK94i98zQktn6JrXQr
 NKzDoYmP+BuvlMFxO53K5oaKdCvMGTY3Ihl31gH5cLHXMfJjRCF+WMTk4PJm1fwciw+g
 kJgA==
X-Gm-Message-State: APjAAAWXIPpUtPKJLwn+f7YCzal2H2dGno7w504J1XuA0tHPGBscWRV3
 oVJpHaQg3fSE9yi0R5eJEpPb2Vkh7uIPN1ayNAU=
X-Google-Smtp-Source: APXvYqxYsaAwcmN+51oFCEjwzICEZbijVg3F1DK0Q89as5kks6uwuLAi24cC4VY3uFeKdAYTfbh+5TcsP5b1EwIKwT8=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr12855552ljj.4.1570898099300; 
 Sat, 12 Oct 2019 09:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191012065426.10772-1-philmd@redhat.com>
 <20191012065426.10772-3-philmd@redhat.com>
In-Reply-To: <20191012065426.10772-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 12 Oct 2019 09:34:32 -0700
Message-ID: <CAKmqyKON_tkLgHBXEDHe4vCMKrfRwu7YO3Z6-t2bqwqtfO9geA@mail.gmail.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Cc the qemu-arm@nongnu.org for the ARM
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 11:56 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Not all ARM machines sections Cc the qemu-arm@nongnu.org list,
> fix this.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47eae9fc46..65fbc6d7b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -805,6 +805,7 @@ F: hw/arm/virt-acpi-build.c
>  STM32F205
>  M: Alistair Francis <alistair@alistair23.me>
>  M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/stm32f205_soc.c
>  F: hw/misc/stm32f2xx_syscfg.c
> @@ -817,12 +818,14 @@ F: include/hw/*/stm32*.h
>  Netduino 2
>  M: Alistair Francis <alistair@alistair23.me>
>  M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/netduino2.c
>
>  SmartFusion2
>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/msf2-soc.c
>  F: hw/misc/msf2-sysreg.c
> @@ -836,6 +839,7 @@ F: include/hw/ssi/mss-spi.h
>  Emcraft M2S-FG484
>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/msf2-som.c
>
> @@ -1349,6 +1353,7 @@ T: git https://github.com/jnsnow/qemu.git ide
>
>  OMAP
>  M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/omap*
>  F: include/hw/arm/omap.h
> --
> 2.21.0
>
>

