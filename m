Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD1C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4181E20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LC4vYc2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4181E20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCR8V-0001I8-DY
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCR7k-0000pv-Io
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCR7i-0002cS-BJ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:23:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCR7i-0002YZ-3I
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:23:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so14644437wrm.12
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dA8Tw/YV0dGWF8J2SHy5wJjakAENS24bvPOg6DVgJu4=;
 b=LC4vYc2ipsZXma1qjyNDUIMue6PY4C4xBk16Rqxsf/mwoVxuSK/90p8g8eOAsuB/Q6
 8xaxLrfDFWYmcWnNr0LD2i64yZ7vMN0OYYQdljv0SJ8++lJICjZBH8lKWfTQ0TDueNxM
 xV9E+2n4mkYK13vdbz+9QdazeLdXnVyBb1Rp+2MAbp9a+yTva40ojks8ZBRFdFcvZc65
 /t4RozYLa7KAF2Y7SsGPuae4wMjDE1PAUMpOD5I2VxFiEX0sqQlcOBjcHQsZ3Md4l9P1
 u6nwvaEAly96oNFVT5fjbdQDm04P9iueIlBWeDjqg+gXcuZFqbVUoRZ6JVqhwwQrByTh
 XBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dA8Tw/YV0dGWF8J2SHy5wJjakAENS24bvPOg6DVgJu4=;
 b=kHveO0nk+PuuTdNJjHAE8tsp90vNO5wbDBfPsEQ07B1l3b21M5a84jkSeUZwRZN8RA
 QcvdeELpp1lSr0T7aA4xxQAU7XazpYfxSvxvMwDl0Mby1Z+J4qbGRYGTbqUSuplX9bEe
 +IKaH1wNXgF/2y6HSf2+8BpnZvqx4xDobNPDbfXBsWkXNG+umleBxUmWbOuk11rWz/BZ
 6IrEmQoWLWiffPZ56YBxAc2N+QVmUYXkID6sRqD8XRKdIsM4pgLQtOWmKZGTyN5cDzE6
 AgQFqHA+mhl335G5KPaumazIOp63eGJq4z01Av4/XUQnjGjmgx0129UULVF0rcIB2osr
 wNvg==
X-Gm-Message-State: APjAAAV31sQDj2SyQC0aBcsPpdzfi6DCcOE3fuO9zO0E3S25pabSoZoo
 yD/K9qAHmiZUphUf1TUICPTIGQ==
X-Google-Smtp-Source: APXvYqyZ9cDr44UzRlLH5NHNsQkF5xaHaWoNg9ExRhGI4lf6bnxrNvEDpQhXkh+7shUmlcyRwm7Exw==
X-Received: by 2002:a5d:5185:: with SMTP id k5mr181265wrv.341.1569255816763;
 Mon, 23 Sep 2019 09:23:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 17sm11779769wrl.15.2019.09.23.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:23:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D9231FF87;
 Mon, 23 Sep 2019 17:23:35 +0100 (BST)
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/7] target/alpha: Use array for FPCR_DYN conversion
In-reply-to: <20190921043256.4575-2-richard.henderson@linaro.org>
Date: Mon, 23 Sep 2019 17:23:35 +0100
Message-ID: <87r247asmw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is a bit more straight-forward than using a switch statement.
> No functional change.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  target/alpha/helper.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 19cda0a2db..6c1703682e 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -36,6 +36,13 @@ uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
>
>  void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
>  {
> +    static const uint8_t rm_map[] =3D {
> +        [FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT] =3D float_round_nearest_even,
> +        [FPCR_DYN_CHOPPED >> FPCR_DYN_SHIFT] =3D float_round_to_zero,
> +        [FPCR_DYN_MINUS >> FPCR_DYN_SHIFT] =3D float_round_down,
> +        [FPCR_DYN_PLUS >> FPCR_DYN_SHIFT] =3D float_round_up,
> +    };
> +
>      uint32_t fpcr =3D val >> 32;
>      uint32_t t =3D 0;
>
> @@ -48,22 +55,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t=
 val)
>      env->fpcr =3D fpcr;
>      env->fpcr_exc_enable =3D ~t & FPCR_STATUS_MASK;
>
> -    switch (fpcr & FPCR_DYN_MASK) {
> -    case FPCR_DYN_NORMAL:
> -    default:
> -        t =3D float_round_nearest_even;
> -        break;
> -    case FPCR_DYN_CHOPPED:
> -        t =3D float_round_to_zero;
> -        break;
> -    case FPCR_DYN_MINUS:
> -        t =3D float_round_down;
> -        break;
> -    case FPCR_DYN_PLUS:
> -        t =3D float_round_up;
> -        break;
> -    }
> -    env->fpcr_dyn_round =3D t;
> +    env->fpcr_dyn_round =3D rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SH=
IFT];
>
>      env->fpcr_flush_to_zero =3D (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
>      env->fp_status.flush_inputs_to_zero =3D (fpcr & FPCR_DNZ) !=3D 0;


--
Alex Benn=C3=A9e

