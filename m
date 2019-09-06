Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C82CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A12D2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2Jh6Ndc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A12D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6DmB-0007fC-Gj
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6Dl7-0006XD-KC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6Dl6-0002up-Ah
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:54:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6Dl6-0002tt-4M
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:54:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id s28so5605343otd.4
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=99kRWFcUQPb4CAJhJZA1o6dq5nYip7uaNgoR+RUnZrQ=;
 b=t2Jh6Ndc4C3GEe70MSXP7LygU06U8OWHdpT4kC3NFd+YfzkDTVkbQF1Mv4i1slxPD6
 SEM4mXCeqJ0ax9IlSYxBP089SicXIfLqr89DgY6ciJ4vzIHoHVRgNj06R2A5CHHhmD4/
 x29x4MIHc3gh0VoCr+0e0fl9q8jk0uSnTfZyT3KXfi+1QTik9V8NvqLSAIPieWmyKzGn
 t+z57BwxfjXMZ9CidhYt+4yZkQXqPra6RcQYrhHl63DQdxURBHVde7WHuvOqAJnw5zob
 HI1IH18bdyy6U6YML/Q0syCJ8ysxDN0D6mYd2JRazsEv2qNpV3dfl9oOrUFohR6BHGz5
 or+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=99kRWFcUQPb4CAJhJZA1o6dq5nYip7uaNgoR+RUnZrQ=;
 b=KtSuJiQflyJVPymF2Psu+mP2LWjOWyQL0RI08GdwfVbehsHu1INlXezIlRJnSk0dP4
 ETtYIxaH3rGJRg2RjaKHmW0mlMhnSoFpTCR2Fd+IjtA6jSbUFM40J9zImeWBsVovdK/1
 AriZjx7Z35rmHFFDtQoxiyOp4Z+EcQBvs7uT4UpK45KhwySEVs/xFiD463n+HS5Y2bwF
 PnwI+/5EftyZFZY2U21m44H7K/DQlfiWwVQwnzFDg0DxH5SR+/d2o41jVysORyLTbxbg
 3JDG5X17ENo1oeIqYXRpRJw5Mh/nReLRyO3Y6Fj4Up7Oa1u8yA37bGE7/d+kUmKJGxEO
 6tyw==
X-Gm-Message-State: APjAAAWwRGV/duwtaXtz5mhWu7olf+6HvrvIX5DtCMcYkTDfb9nRMbPh
 NxJBhlxyIRp0+krV4Y8b0hPR104N1e5zrBp2ar5CHA==
X-Google-Smtp-Source: APXvYqwePGp+uC8QK2lkl3OYZ58/AESKxdudkcMFlBu4HcbUOa1szORlGsm6pgEPqda+OF4RBsnTovoL3y3xlEVaHDA=
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr3879997oth.232.1567774475085; 
 Fri, 06 Sep 2019 05:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190906124706.19145-1-alex.bennee@linaro.org>
 <20190906124706.19145-3-alex.bennee@linaro.org>
In-Reply-To: <20190906124706.19145-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 13:54:23 +0100
Message-ID: <CAFEAcA84VXqw+ZGP9Nv=Wy069ZU_C0WkVdv0h28GVbnzyx6w6w@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/arm: handle A-profile
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

On Fri, 6 Sep 2019 at 13:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
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
> ---
>  target/arm/translate.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4cda7812bcb..ed4a97cfb44 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10222,14 +10222,25 @@ static bool trans_CBZ(DisasContext *s, arg_CBZ =
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
> +    if (semihosting_enabled() &&
> +#ifndef CONFIG_USER_ONLY
> +        s->current_el !=3D 0 &&
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

Doesn't this accidentally enable semihosting via SVC for
M-profile ?

thanks
-- PMM

