Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6655C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C362075E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7rds/aH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C362075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmRm-0001P1-NK
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmQO-0000R6-V6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmQN-0002g2-NC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:23:08 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXmQN-0002eY-4A
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:23:07 -0500
Received: by mail-oi1-x241.google.com with SMTP id e9so3118953oif.8
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LDp8lOU1GiwVuGa/fKc8Tmq1XqanSNL9f3i9e8NktrU=;
 b=g7rds/aHpL3zmLEpMshpzqD8HpDgioA5HRjTIFwbSsx3osZLTSSGF1YgRxrBg1pu+C
 2RpL6o8ajAIXZXoOH181JEjVSGiaxJBYUpYhV8i2Q9TSBBmrEpcbbvxYeojDFsJEZ9h4
 PZszxz92nbnMKWCEPdYfPvYYye3UvCpy/qaqcMmt/CKQHsqJDsZUNRoazvGG3EtD85cZ
 boTcOhyCWX3o+5jE88ni1+XY3pdjeyb5Yx7qwjYrPGFK0oocuBzh5Vm4FaNBV89rUZju
 E6eOou+KennRzkzsmshvxQWqJqa5kC8hguaeOWJ4219Dt0uqflwo7SeqJ1uq8SuuVQ59
 ZdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LDp8lOU1GiwVuGa/fKc8Tmq1XqanSNL9f3i9e8NktrU=;
 b=kxyfvN5OX17tQHGvqDJZhLUpJ8Xsfc4uc6CflG3HphGnF5J8X9aiKYjBNiN15isk4e
 VVv+EmnizBmM8zS5myg0Ck8aNFqEml4cAti58mNUxc3ZBXWwhGBMcDJc5kmEclFKWY63
 866bqTd1kEgPGJ5nY0CMdhHZLaLEIYjUtBQKgEn4Qkuq2dWNlLHGJRxktTX698VNvZwV
 8tJYmGprGeaS0YebiEoAJWD38cpdTXq5cXPrhzXSW9EuqgtrW5DA1G/DjZr3rBHtgVe/
 VgBaeToQ5jU03a+JBmnIl4iimZN+Zts6E/9N9O1RFl7/OLhWw2ukoe/2IerCLTUGBWPm
 17LA==
X-Gm-Message-State: APjAAAX2f9WFwpv0ppW3LucuZYD8K+pWGVj4yuUuNd9KBnH7UpIfxS0U
 5i8UWz6zn4JiZfAj3mAJiZ1vMBaYNmlzt2QsIPf/vg==
X-Google-Smtp-Source: APXvYqyQ3ghjz87V/1FSAfBsKqdHX9gjoz9sth2UDGegjBiTTABMgaDQovzga0tUeenxS6c53ymGuOpneOL18odfhBg=
X-Received: by 2002:aca:4945:: with SMTP id w66mr7845168oia.98.1574342585920; 
 Thu, 21 Nov 2019 05:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20191121014353.2604-1-jean-hugues.deschenes@ossiaco.com>
In-Reply-To: <20191121014353.2604-1-jean-hugues.deschenes@ossiaco.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 13:22:54 +0000
Message-ID: <CAFEAcA_G5JYcpJEXOdDs2dFqi8PiTdU0TFpXpBviX2Mw08EW_g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix handling of cortex-m FTYPE flag in EXCRET
To: =?UTF-8?Q?Jean=2DHugues_Desch=C3=AAnes?=
 <Jean-Hugues.Deschenes@ossiaco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 at 01:44, Jean-Hugues Desch=C3=AAnes
<Jean-Hugues.Deschenes@ossiaco.com> wrote:
>
> According to the PushStack() pseudocode in the armv7m RM,
> bit 4 of the LR should be set to NOT(CONTROL.PFCA) when
> an FPU is present. Current implementation is doing it for
> armv8, but not for armv7. This patch makes the existing
> logic applicable to both code paths.
>
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes@ossiaco.com>
> ---
>  target/arm/m_helper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
> index f2512e448e..595c49fe2a 100644
> --- a/target/arm/m_helper.c
> +++ b/target/arm/m_helper.c
> @@ -2173,19 +2173,18 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
>          if (env->v7m.secure) {
>              lr |=3D R_V7M_EXCRET_S_MASK;
>          }
> -        if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
> -            lr |=3D R_V7M_EXCRET_FTYPE_MASK;
> -        }
>      } else {
>          lr =3D R_V7M_EXCRET_RES1_MASK |
>              R_V7M_EXCRET_S_MASK |
>              R_V7M_EXCRET_DCRS_MASK |
> -            R_V7M_EXCRET_FTYPE_MASK |
>              R_V7M_EXCRET_ES_MASK;
>          if (env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK) {
>              lr |=3D R_V7M_EXCRET_SPSEL_MASK;
>          }
>      }
> +    if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
> +        lr |=3D R_V7M_EXCRET_FTYPE_MASK;
> +    }
>      if (!arm_v7m_is_handler_mode(env)) {
>          lr |=3D R_V7M_EXCRET_MODE_MASK;
>      }
> --
> 2.17.1

Thanks, applied to my target-arm.next branch for 4.2.

-- PMM

