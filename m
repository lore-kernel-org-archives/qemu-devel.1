Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14BDC46477
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990C92084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDtgkOuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990C92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsmm-0007gq-NN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsUY-0002rd-5W
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsUW-0007d2-1U
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsUV-0007bN-8h
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so9319707wma.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AxMhM0UPlNJ4cs59aRdxUsoioA0KaaAmCXRzB5Pd7dY=;
 b=RDtgkOuHhFaYd7H+r8j9cPWyM26NOoi2VJxwHlqjutzaXBLeLiHECWs8eWOAzQRvYY
 udJUVPwRKWJtzW4rXYPEUvCdAL0IHnNzP2W+8lutApwm3PBdf28YA8PjQRX1DykLHBd/
 QHXSgTtZPePp3M6DsRsUbCeH9/aHt+MsfFuFngXZDFbAMkimdO6SkF20o9NsXIBN05HD
 iE5BcawU2T7gvZcUUnJ+ow4sHqh60B5pp0yFFJL6XNRuIFdyJR5zSueDvDG45SzZvLlQ
 b7SboebFq0mmQLTCDTOPGnNN0Aty1Nwvy4rxsQ/SbvFNaGD+gHTPKwEyjXjWzNoQAJ1Y
 U4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AxMhM0UPlNJ4cs59aRdxUsoioA0KaaAmCXRzB5Pd7dY=;
 b=LFXdv70sKnqc5o5QlpubNKNJOO3iO2coVaOj5FJpIKmQpqcsP7unQV4VEb1bDAkomV
 JndXr+3vevS6WOvPHYoV0wDzNEEJ8fovDAW7zdi8UgvxA8MCiVN/yM+biIHFBUyDEifT
 UK06tOengBibOEW7Sx6tmwpRYZYpzizLVwQnqWhduPb+uWXXAs+8I9DGY+7gVD/ZjTv8
 3lQt71SPp70oPkOFxpmyskO+fpfmEdHAd9gRyFrOiDebd25uNM90kaKx5q/CaqJ1sWpb
 CtD6PHZwMoScvX5U4bARcci/sqW7fZDS1PkbD5xnfkFu6rhvqWjOGlR432ypGMNjXN7g
 fdGw==
X-Gm-Message-State: APjAAAW/EJyaUjT29isxDod6hzaD4u17/51MS0j2P5W9/7QAdz1uyyi+
 XC7Hbp4g2iRAYJ76a9lDulM0v/P3x2M=
X-Google-Smtp-Source: APXvYqz4d5ci3v6ksx8K4fvuOyqTmGr3pDaZE04GAQQvKEWnXr+V3tD/Em65pYuAMNfi5JxZLa+ogQ==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr17565806wmh.134.1560781210107; 
 Mon, 17 Jun 2019 07:20:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z5sm10928694wrh.16.2019.06.17.07.20.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:20:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0ADD1FF87;
 Mon, 17 Jun 2019 15:20:08 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-18-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-18-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:20:08 +0100
Message-ID: <87imt49tuv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 17/23] target/arm: Fix coding
 style issues
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Since we'll move this code around, fix its style first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c274c8b460..d0ab3e27e6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9179,7 +9179,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
>                  loaded_base =3D 0;
>                  loaded_var =3D NULL;
>                  n =3D 0;
> -                for(i=3D0;i<16;i++) {
> +                for (i =3D 0; i < 16; i++) {
>                      if (insn & (1 << i))
>                          n++;
>                  }
> @@ -9202,7 +9202,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
>                      }
>                  }
>                  j =3D 0;
> -                for(i=3D0;i<16;i++) {
> +                for (i =3D 0; i < 16; i++) {
>                      if (insn & (1 << i)) {
>                          if (is_load) {
>                              /* load */
> @@ -12427,12 +12427,13 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, =
int flags)
>          return;
>      }
>
> -    for(i=3D0;i<16;i++) {
> +    for (i =3D 0; i < 16; i++) {
>          qemu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
> -        if ((i % 4) =3D=3D 3)
> +        if ((i % 4) =3D=3D 3) {
>              qemu_fprintf(f, "\n");
> -        else
> +        } else {
>              qemu_fprintf(f, " ");
> +        }
>      }
>
>      if (arm_feature(env, ARM_FEATURE_M)) {


--
Alex Benn=C3=A9e

