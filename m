Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB8420828
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANzn0hdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB8420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDEl-0003Yk-9g
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuDDg-0002Ht-CC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuDDe-0002ub-PY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:26:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuDDe-0002td-IJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:26:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so6611398wro.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HMQpvxEKbEDAeRkf4OY+Hn1X5JhhpxYJX6+ZnaZn7ZE=;
 b=ANzn0hdqBoKoYYGbV/wLvEH8YyAKk194fBMDRdByMyHk9LrkuRZjHthno6a50kzorL
 wgCvD+4koGRj64/mjuKug9R4IZHT13WLk3+gjPXh92vZSzze87sQPNYumFsaxTX7WR8b
 sOkBdqhPBcZGWqVEz2wvQ2/tcw6a0uiZDTykmepCKOEp9Nnv+oKPr7Y+tS5toX3FJV+8
 0wmGNq5tC6CTj0F0oZ4hyyoHKv0ylLL3+EfLjQiFZnW/nRCSpeoxg0Ij4Q5zibUIGTvi
 r9WMTdLjHQPFsUsfy5dBqvR9iHaRET1X4cLvGvwGJxTjnqA90cmbkOT1NFyBJWPkrW2W
 MVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HMQpvxEKbEDAeRkf4OY+Hn1X5JhhpxYJX6+ZnaZn7ZE=;
 b=smn+N2OdRSJVKy93N8ktmKwzUtsZIBugVIAHLfyYwsSLBJAvlDxw93RTBxKaXO7wKu
 WYtEDTmLIoRBk4Ibl4RfFvbQn6KFyL7t1L7s34rqsJEIqH3X7vurcJbH9iJwFCtemENe
 UyrK5zbkF45++P+4R/2U3H3ye+A6exo0CsxpgySpqmvlBU+2Fvl3Xjp05JBaIcymipbT
 14xZVfP3yB9rNF9djelMSjRVvc7Zrn3tMoQ+eRIcAnWWhbygKcGRhF9F3sfpgIYBjE2t
 WFS6iekSVQwEh9Phu6fjsn+uRGP5LxfuCvP4G7yCvaO2nrKWhmfTwNf4MiFUaH25rpAQ
 ZJEA==
X-Gm-Message-State: APjAAAWoCrYeXxJyKNudQxWMklFHlEaEzs/16QgaDvagoYwnOC0hDQOk
 +dvfKtU05Zor6Aj8em0SGEXp3A==
X-Google-Smtp-Source: APXvYqwB/SnLmn4Tri3v/6Dq6VgEbP7hYWIAeV0eMELMnX6iR6lrh3QzFKzFGZWb9BPKjh9dFJDyvg==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr10468824wrq.206.1579688800384; 
 Wed, 22 Jan 2020 02:26:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t125sm3462104wmf.17.2020.01.22.02.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 02:26:39 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D17B71FF87;
 Wed, 22 Jan 2020 10:26:38 +0000 (GMT)
References: <20200121213853.9601-1-f4bug@amsat.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/misc/stm32f4xx_syscfg: Fix copy/paste error
In-reply-to: <20200121213853.9601-1-f4bug@amsat.org>
Date: Wed, 22 Jan 2020 10:26:38 +0000
Message-ID: <871rrr23dt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Missed in 870c034da0b, hopefully reported by Coverity.
>
> Fixes: Coverity CID 1412793 (Incorrect expression)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
>=20=20
>      trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);


--=20
Alex Benn=C3=A9e

