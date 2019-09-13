Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA0C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FBE208C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2eRi6RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FBE208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lMC-00009B-0B
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lFO-0002a6-0A
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lFL-0005L4-RG
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:04:21 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8lFJ-0005JV-Lt
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:04:18 -0400
Received: by mail-oi1-x242.google.com with SMTP id k20so2195720oih.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lJM2ojp36nj5j9CBSnwk8ZLfnJIsWvjr8zkFPoizZg4=;
 b=R2eRi6RJg1WrxbNKgsFY0gme2AEFJ9xjhNZIN/MK9HTVaemUuzlSiMVdPrtq4DhWMg
 9ZDb34f708xyMe9ESFaN70gbNmsvQ0vcE0qtaB0xu6F5cDBz3G5i4dzHxhyy2Z0msHXe
 6JRNrC6bbbeKkDEwaBzeFxiZwx3pKtVWwWg14F0MtUgyS+bH+x3c8pajGpStwGIB95PO
 uFbC0Q4ltfI3PdOsmqqgTwRVzO3/7eNxkHcWcrs0xBtrxt1iFk543oVKb/epe+unS0tN
 CF2JzM7MBXeDag6duMycaHnjxCToU9ZOgun4FLLOUM6hCrSdj35zIJh1kohQeQJ2D+b0
 exew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lJM2ojp36nj5j9CBSnwk8ZLfnJIsWvjr8zkFPoizZg4=;
 b=QKGaqHHcTrQ0/MzbRU5xn3HFl66KaTXmU7rWVIiFVOTWpojNT7wdSfZ8z5PSamwVhj
 anL7Yp0CDkI/tjVR5W3ihobZU8dwceHnFzHQg46rVoOSqj/uKy9uqNIp6MC353aWQ0F5
 3hhUyF3FnntOl9qq0Iq4JImi8yDRFKcXUWw+gNj9MnKS5rWxU0bTjQ7nVZugRcMdgBdM
 cXdPk/zbhcttB0QxyUrQ/t7YHLwjbUXGYt4ERaOgGItPcxuZbxib4Q7lB0dX/bVvMydm
 TC3hgXs8zVCuP9L26Z/32yBE5ICqjQJbLiQDhHcV4d665VRfekpWba1s9hJLcCaUEzWZ
 zQdw==
X-Gm-Message-State: APjAAAW0MCmU05e2yzfumgt04Szo1K4EL0p1ad4bt/P3sYhIns50+PLb
 GTibXI79ddhu3su7qLqQrvl4J2kgdlVaEYv1GKxwPw==
X-Google-Smtp-Source: APXvYqxr6IgNQtrgroWI8Ck5MOxTceBNBvHmI+AKIC3uOI4BOiT5n4f4Wh1IzT8umt/HCMhjCk+8Zm5uFRnmk3/xQ5k=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr2904994oib.48.1568379856290; 
 Fri, 13 Sep 2019 06:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-4-alex.bennee@linaro.org>
In-Reply-To: <20190911164959.11003-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:04:05 +0100
Message-ID: <CAFEAcA_NCz_qFFFOShV8ktV4vHeYezQ=5S7QQPTMQywGfY1FGw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 3/5] target/arm: handle A-profile
 semihosting at translate time
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 17:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> As for the other semihosting calls we can resolve this at translate
> time.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - update for change to gen_exception_internal_insn API
> v3
>   - update for decode tree, merge T32 & A32 commits
>   - dropped r-b due to changes
> v4
>   - !IS_USER and !arm_dc_feature(s, ARM_FEATURE_M)
> v5
>   - only if !IS_USER for softmmu, linux-user is still allowed
> ---
>  target/arm/translate.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 6689acc911e..fac791c4b06 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10219,14 +10219,25 @@ static bool trans_CBZ(DisasContext *s, arg_CBZ =
*a)
>  }
>
>  /*
> - * Supervisor call
> + * Supervisor call - both T32 & A32 come here so we need to check
> + * which mode we are in when checking for semihosting.
>   */
>
>  static bool trans_SVC(DisasContext *s, arg_SVC *a)
>  {
> -    gen_set_pc_im(s, s->base.pc_next);
> -    s->svc_imm =3D a->imm;
> -    s->base.is_jmp =3D DISAS_SWI;
> +    const uint32_t semihost_imm =3D s->thumb ? 0xab : 0x123456;
> +
> +    if (!arm_dc_feature(s, ARM_FEATURE_M) && semihosting_enabled() &&
> +#ifndef CONFIG_USER_ONLY
> +        !IS_USER(s) &&
> +#endif
> +        (a->imm =3D=3D semihost_imm)) {
> +        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
> +    } else {
> +        gen_set_pc_im(s, s->base.pc_next);
> +        s->svc_imm =3D a->imm;
> +        s->base.is_jmp =3D DISAS_SWI;
> +    }
>      return true;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

