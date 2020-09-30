Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF2C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D8F20789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFEbzxJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D8F20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNekC-0005wS-9W
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNegX-0002Vo-Pb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:10:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNegU-0003C1-U8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:10:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id g4so2453240wrs.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iunHu55sigd55xo5y01pJ1wT3hnlwEkRst1zp/vR5Ys=;
 b=aFEbzxJqukiO0YM4gq8b0sKA3tivqU2ut+jQGF7alRki1PT9MJ7FVIpR1FFPJ++eVO
 id9Hp4qjxEe5/+ELO2WIdt26ng2whiEfC/cVWqK5X1mpRvpDanR8e9PKMPBWcFVkC8hc
 YJWKRWj0705gXL0D1f/Chz1IeRh57Tl01Auj30PUbXo/1aEe1BqZUqMFTpGSuIxwdPks
 n9elAqYlX6Ol/+cKCixE5rvfXrXHJNX257xuaWno+GdtE/TdQ+X6u5fotopSaf7IJ8EY
 X7+3VjAKFpkkigUOAKf6EjRDrxuNQuPYo97v8ZuSvhrVGtt4EZtV+LRQMfFPUxpE6mIF
 WRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iunHu55sigd55xo5y01pJ1wT3hnlwEkRst1zp/vR5Ys=;
 b=C8/wn/P+3D2Tz0ZbjwcGokzI/Ixj3SC3LWEnPYrD67FW0ITSauTUL4ZnGDu8/SYRt3
 kjo+Ys1R2UQtnAae54i0WtiFq4DDn0dWE7A0hZaObXhsgMOea9SyXaONrgwlJTa8X0ct
 mnba2V8z1Yo0tk8pL3pXTYFWv0jFsNSy5wAPC9hMhDwRHCC25jIJdOWOLJOiAabn39CN
 2DaOcc6YTuCg8Ux/aqI+y9HS8w0VVs8D8bIgtp+0aDb5w3QMNyBstxFVZqQfrjZFJiYN
 KY2bx4MQZCep65U6sAfHkZu9UyqDHRc7AaeIQqfeP/GFDQ4aW2Ar9W3ZerD6i2xXHftB
 +sRg==
X-Gm-Message-State: AOAM533NyNxV1/02U0tA0jDCGkzsoULzoeXjUW7oV/NRLd79LKKug58T
 GQTpleOI+0M1l9hEKnrJvS7aEg==
X-Google-Smtp-Source: ABdhPJxH9rgtlXsN7N6v+g4WO6AEWRPXE2cbawmKEKzJE5UAGTNhno1XITAjDicVrxLijaOQye8Jkw==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr3853942wrw.261.1601482223699; 
 Wed, 30 Sep 2020 09:10:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j14sm3929222wrr.66.2020.09.30.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:10:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA5CA1FF7E;
 Wed, 30 Sep 2020 17:10:21 +0100 (BST)
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-2-david@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 01/20] softfloat: Implement
 float128_(min|minnum|minnummag|max|maxnum|maxnummag)
In-reply-to: <20200930145523.71087-2-david@redhat.com>
Date: Wed, 30 Sep 2020 17:10:21 +0100
Message-ID: <87o8lnnt3m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> Implementation inspired by minmax_floats(). Unfortuantely, we don't have
> any tests we can simply adjust/unlock.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fpu/softfloat.c         | 100 ++++++++++++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h |   6 +++
>  2 files changed, 106 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 9af75b9146..9463c5ea56 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -621,6 +621,8 @@ static inline FloatParts float64_unpack_raw(float64 f)
>      return unpack_raw(float64_params, f);
>  }
>=20=20
> +static void float128_unpack(FloatParts128 *p, float128 a, float_status *=
status);
> +
>  /* Pack a float from parts, but do not canonicalize.  */
>  static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
>  {
> @@ -3180,6 +3182,89 @@ static FloatParts minmax_floats(FloatParts a, Floa=
tParts b, bool ismin,
>      }
>  }

It would be desirable to share as much logic for this as possible with
the existing minmax_floats code. I appreciate at some point we end up
having to deal with fractions and we haven't found a good way to
efficiently handle dealing with FloatParts and FloatParts128 in the same
unrolled code, however:

>=20=20
> +static float128 float128_minmax(float128 a, float128 b, bool ismin, bool=
 ieee,
> +                                bool ismag, float_status *s)
> +{
> +    FloatParts128 pa, pb;
> +    int a_exp, b_exp;
> +    bool a_less;
> +
> +    float128_unpack(&pa, a, s);
> +    float128_unpack(&pb, b, s);
> +

From here:
> +    if (unlikely(is_nan(pa.cls) || is_nan(pb.cls))) {
> +        /* See comment in minmax_floats() */
> +        if (ieee && !is_snan(pa.cls) && !is_snan(pb.cls)) {
> +            if (is_nan(pa.cls) && !is_nan(pb.cls)) {
> +                return b;
> +            } else if (is_nan(pb.cls) && !is_nan(pa.cls)) {
> +                return a;
> +            }
> +        }
> +
> +        /* Similar logic to pick_nan(), avoiding re-packing. */
> +        if (is_snan(pa.cls) || is_snan(pb.cls)) {
> +            s->float_exception_flags |=3D float_flag_invalid;
> +        }
> +        if (s->default_nan_mode) {
> +            return float128_default_nan(s);
> +        }

to here is common logic - is there anyway we could share it?

> +        if (pickNaN(pa.cls, pb.cls,
> +                    pa.frac0 > pb.frac0 ||
> +                    (pa.frac0 =3D=3D pb.frac0 && pa.frac1 > pb.frac1) ||
> +                    (pa.frac0 =3D=3D pb.frac0 && pa.frac1 =3D=3D pb.frac=
1 &&
> +                     pa.sign < pb.sign), s)) {
> +            return is_snan(pb.cls) ? float128_silence_nan(b, s) : b;
> +        }
> +        return is_snan(pa.cls) ? float128_silence_nan(a, s) : a;
> +    }
> +
> +    switch (pa.cls) {
> +    case float_class_normal:
> +        a_exp =3D pa.exp;
> +        break;
> +    case float_class_inf:
> +        a_exp =3D INT_MAX;
> +        break;
> +    case float_class_zero:
> +        a_exp =3D INT_MIN;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }

Likewise I wonder if there is scope for a float_minmax_exp helper that
could be shared here?

> +    switch (pb.cls) {
> +    case float_class_normal:
> +        b_exp =3D pb.exp;
> +        break;
> +    case float_class_inf:
> +        b_exp =3D INT_MAX;
> +        break;
> +    case float_class_zero:
> +        b_exp =3D INT_MIN;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +
> +    a_less =3D a_exp < b_exp;
> +    if (a_exp =3D=3D b_exp) {
> +        a_less =3D pa.frac0 < pb.frac0;
> +        if (pa.frac0 =3D=3D pb.frac0) {
> +            a_less =3D pa.frac1 < pb.frac1;
> +        }
> +    }
> +
> +    if (ismag &&
> +        (a_exp !=3D b_exp || pa.frac0 !=3D pb.frac0 || pa.frac1 !=3D pb.=
frac1)) {
> +        return a_less ^ ismin ? b : a;
> +    } else if (pa.sign =3D=3D pb.sign) {
> +        return pa.sign ^ a_less ^ ismin ? b : a;
> +    }
> +    return pa.sign ^ ismin ? b : a;
> +}

Otherwise it seems sane to me.

--=20
Alex Benn=C3=A9e

