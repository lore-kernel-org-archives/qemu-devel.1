Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA46C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9056022257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ceg/miq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9056022257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURvm-0006Kf-AY
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kURuv-0005lS-Cs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:57:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kURut-0003WG-P2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:57:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id p15so9654349wmi.4
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2FJxcsGN5pk0MdmuohKhdJSMUkI6rvIWEhM48uMLpfg=;
 b=Ceg/miq/LOZp7RHrd1r5ngQCZ9igqHZUJqun0CaVZt2XZJaZhPm+rwACcV3sx2WjOw
 VjL/aaERY/EFqj8z5nADpNL7Y/XYWJHINdyXrzB4IH/fUV7rmhvXzF7d31Ajv2xKuqyh
 SdEaqkj/tAKb0HwM06zrBrQdSMGP47iUPbyMVKG1IPsoceKXrD40AZK8TGYwBXNmEyGP
 9DYi/1LOtdnQKF7B8QqHZM5VgfFu90Q4lrgaJGAZK8Evv/G/IqaWgMTM4dcu58RRKi1p
 /goRT8T/JRQ2B2/2b/Gljxqe9sRcw8XJg2XSBPrHtIYsfCHeKRPVynga2hVsTfGGEtmu
 hrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2FJxcsGN5pk0MdmuohKhdJSMUkI6rvIWEhM48uMLpfg=;
 b=NtND6bk/77zNfYcD9c63xHp0aOvpAwQWKFtK5zcxva3npDaX/t7NQ9ga/+4KYztQni
 11hPXpEpZQQ7VsuqOIAdmKZiub/csJYspcR1QqdAGeH2B2p6sb3N4DpvejQdE2AHsoj0
 X0ltEu3uXf/CuU/bmfr3IZJSGP19MXq90j0p2bFkWYM3v3J4t9bhPlfgImV9d0b+tH+o
 R5LezT9OfNA4sAC/cSi6dNB/aDJu5xQKjCHlihBjtIBAOi3vOLmJ2nEd05AObi32NY1p
 5KEh7dC7yK2MspWi9UvMH/3h0QhRA5oif3WaAD//NuTEqS0Cx+ckJqviCD3Zasfqe3xN
 XFZQ==
X-Gm-Message-State: AOAM530NDLy9TPuuVt1+BCUa/Jj+JnQDTggGz/Puh/VNNhti3j/Y0Mnx
 CHjLX45769x4p/H6tqXFf3PjEw==
X-Google-Smtp-Source: ABdhPJw9IkrFn5KMHRlSuaikFuoauvwQaM8DzPJCXbnrzmKIChegsCWmfzvl4pS4xrcEmYrxT0nYwg==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr17461207wmk.91.1603101441697; 
 Mon, 19 Oct 2020 02:57:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm12814291wme.2.2020.10.19.02.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 02:57:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C44B31FF7E;
 Mon, 19 Oct 2020 10:57:19 +0100 (BST)
References: <4ba9afe5-d5f0-7315-2a6f-139a4a6e66be@linaro.org>
 <20201018210625.1232930-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] softfpu: Generalize pick_nan_muladd to opaque structures
In-reply-to: <20201018210625.1232930-1-richard.henderson@linaro.org>
Date: Mon, 19 Oct 2020 10:57:19 +0100
Message-ID: <87y2k2wnb4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This will allow us to share code between FloatParts and FloatParts128.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Alex Bennee <alex.bennee@linaro.org>
>
> What do you think of this instead of inlining pick_nan_muladd
> into the two muladd implementations?

I think that can work. I was noodling about with float_addsub128 over
the weekend so I'll post what that looks like once I've tested it.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
> r~
>
> ---
>  fpu/softfloat.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 3e625c47cd..60fdddd163 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -929,16 +929,23 @@ static FloatParts pick_nan(FloatParts a, FloatParts=
 b, float_status *s)
>      return a;
>  }
>=20=20
> -static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts=
 c,
> -                                  bool inf_zero, float_status *s)
> +/*
> + * Given pointers to A, B, C, and the respective classes, return the
> + * pointer to the structure that is the NaN result, or NULL to signal
> + * that the result is the default NaN.
> + */
> +static inline void *
> +pick_nan_muladd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
> +                void *a, void *b, void *c,
> +                bool inf_zero, int abc_mask, float_status *s)
>  {
>      int which;
>=20=20
> -    if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
> +    if (unlikely(abc_mask & float_cmask_snan)) {
>          s->float_exception_flags |=3D float_flag_invalid;
>      }
>=20=20
> -    which =3D pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
> +    which =3D pickNaNMulAdd(a_cls, b_cls, c_cls, inf_zero, s);
>=20=20
>      if (s->default_nan_mode) {
>          /* Note that this check is after pickNaNMulAdd so that function
> @@ -949,23 +956,16 @@ static FloatParts pick_nan_muladd(FloatParts a, Flo=
atParts b, FloatParts c,
>=20=20
>      switch (which) {
>      case 0:
> -        break;
> +        return a;
>      case 1:
> -        a =3D b;
> -        break;
> +        return b;
>      case 2:
> -        a =3D c;
> -        break;
> +        return c;
>      case 3:
> -        return parts_default_nan(s);
> +        return NULL;
>      default:
>          g_assert_not_reached();
>      }
> -
> -    if (is_snan(a.cls)) {
> -        return parts_silence_nan(a, s);
> -    }
> -    return a;
>  }
>=20=20
>  /*
> @@ -1366,7 +1366,15 @@ static FloatParts muladd_floats(FloatParts a, Floa=
tParts b, FloatParts c,
>       * off to the target-specific pick-a-NaN routine.
>       */
>      if (unlikely(abc_mask & float_cmask_anynan)) {
> -        return pick_nan_muladd(a, b, c, inf_zero, s);
> +        FloatParts *r =3D pick_nan_muladd(a.cls, b.cls, c.cls, &a, &b, &=
c,
> +                                        inf_zero, abc_mask, s);
> +        if (r =3D=3D NULL) {
> +            return parts_default_nan(s);
> +        }
> +        if (is_snan(r->cls)) {
> +            return parts_silence_nan(*r, s);
> +        }
> +        return *r;
>      }
>=20=20
>      if (unlikely(inf_zero)) {


--=20
Alex Benn=C3=A9e

