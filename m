Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4029AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE2F207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUE5yORl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE2F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaym0-0003Qe-4u
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaylB-0002D4-Ut
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:42:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jayl9-0000HR-QC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:42:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id u188so2730794wmu.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aOT0mp+RDAjf02TKg/wTWkxbLtu1X0JL8TxM8MrJueg=;
 b=OUE5yORlTzkenZIYlxJeK5qp8tX8LAqDM5JkLxF1QD1AIDnL/L8Gaahuu5yFdNmYfB
 uBpiWcyEABoD2zatJ/7myAWcrRm1vmnbv6OTXk4sywMgRzF56+AVNR/hOxasg9pyICH7
 Fesul0MP9ZGYPoOJDGB1YzNHnmfFKQ0FA11+/CExuDxI7Jq601Yg3narpoEliBbjn3KY
 CF63z869GJh35sRJI1s/6Z9s7d0wbqgnYvcRK/fUMdMi00NbWdp30so7Eu3emLuv0Yi0
 x1Vx3INPibhhB8la5P2ulJgc9lNkEyD2l6TkEQD9dXRBcvXnHJ5w8HrmyBm2PnXkqmsd
 W7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aOT0mp+RDAjf02TKg/wTWkxbLtu1X0JL8TxM8MrJueg=;
 b=HwkLZNHUtJPZHeblY33xZHuKd0wt/E+XZ+OcAaQyLGhT09zWn8K90hummgUoJaNSNl
 FSWbWuALO7jTKomVHSzOlYTHZzlk/BRmrK3dTpUhg2CtWj7QKMa+Kw1Wlf3A+FAF79jL
 glLic3feFiAU+sHBTqTK/FpYg3O9AG8fMiJXO3bIyBrbUJaHMkU8cy6i/y1S5lMeZKO/
 kbO5QWMwzjFnLdzhHkZMh1kcHiSDTW5U1i/p83C9Z6Uy+Ncwkk2uKTO0eYbZv5v8E1eQ
 K3wnGD7lY4RsFhfsHe4GXOaPz0E+RNItuof1lDnhjK3lPIaiUAnZdSGlfsBaqY7BS2LW
 md0w==
X-Gm-Message-State: AOAM533GHAymp+u5IWofpyDd1ZoplCH3twiGxF/p/OReLe8JFhW4hB3m
 UmeBrBBHSF+AF2KuA5DUZfQu9w==
X-Google-Smtp-Source: ABdhPJx8u5ND54cYrEOaOlbTksEmHk2m91LQq84l8IMNMHd+VRO74GNSZ5HmFe4EBgfaGuBdkMr7Tw==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr4416454wma.15.1589881322171; 
 Tue, 19 May 2020 02:42:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm19886019wrn.82.2020.05.19.02.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 02:42:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 536FB1FF7E;
 Tue, 19 May 2020 10:41:59 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-10-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 09/10] softfloat: Inline floatx80 compare specializations
In-reply-to: <20200515190153.6017-10-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 10:41:59 +0100
Message-ID: <87mu64i7mg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Replace the floatx80 compare specializations with inline functions
> that call the standard floatx80_compare{,_quiet} functions.
> Use bool as the return type.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/fpu/softfloat.h |  49 ++++++--
>  fpu/softfloat.c         | 257 ----------------------------------------
>  2 files changed, 41 insertions(+), 265 deletions(-)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index cfb3cda46b..37217d9b9b 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -689,14 +689,6 @@ floatx80 floatx80_mul(floatx80, floatx80, float_stat=
us *status);
>  floatx80 floatx80_div(floatx80, floatx80, float_status *status);
>  floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
>  floatx80 floatx80_sqrt(floatx80, float_status *status);
> -int floatx80_eq(floatx80, floatx80, float_status *status);
> -int floatx80_le(floatx80, floatx80, float_status *status);
> -int floatx80_lt(floatx80, floatx80, float_status *status);
> -int floatx80_unordered(floatx80, floatx80, float_status *status);
> -int floatx80_eq_quiet(floatx80, floatx80, float_status *status);
> -int floatx80_le_quiet(floatx80, floatx80, float_status *status);
> -int floatx80_lt_quiet(floatx80, floatx80, float_status *status);
> -int floatx80_unordered_quiet(floatx80, floatx80, float_status *status);
>  FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
>  FloatRelation floatx80_compare_quiet(floatx80, floatx80, float_status *s=
tatus);
>  int floatx80_is_quiet_nan(floatx80, float_status *status);
> @@ -746,6 +738,47 @@ static inline int floatx80_is_any_nan(floatx80 a)
>      return ((a.high & 0x7fff) =3D=3D 0x7fff) && (a.low<<1);
>  }
>=20=20
> +static inline bool floatx80_eq(floatx80 a, floatx80 b, float_status *s)
> +{
> +    return floatx80_compare(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool floatx80_le(floatx80 a, floatx80 b, float_status *s)
> +{
> +    return floatx80_compare(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool floatx80_lt(floatx80 a, floatx80 b, float_status *s)
> +{
> +    return floatx80_compare(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool floatx80_unordered(floatx80 a, floatx80 b, float_stat=
us *s)
> +{
> +    return floatx80_compare(a, b, s) =3D=3D float_relation_unordered;
> +}
> +
> +static inline bool floatx80_eq_quiet(floatx80 a, floatx80 b, float_statu=
s *s)
> +{
> +    return floatx80_compare_quiet(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool floatx80_le_quiet(floatx80 a, floatx80 b, float_statu=
s *s)
> +{
> +    return floatx80_compare_quiet(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool floatx80_lt_quiet(floatx80 a, floatx80 b, float_statu=
s *s)
> +{
> +    return floatx80_compare_quiet(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
> +                                           float_status *s)
> +{
> +    return floatx80_compare_quiet(a, b, s) =3D=3D float_relation_unorder=
ed;
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Return whether the given value is an invalid floatx80 encoding.
>  | Invalid floatx80 encodings arise when the integer bit is not set, but
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 4567dda112..6c8f2d597a 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -5849,263 +5849,6 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *=
status)
>                                  0, zExp, zSig0, zSig1, status);
>  }
>=20=20
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point value `a' is=
 equal
> -| to the corresponding value `b', and 0 otherwise.  The invalid exceptio=
n is
> -| raised if either operand is a NaN.  Otherwise, the comparison is perfo=
rmed
> -| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int floatx80_eq(floatx80 a, floatx80 b, float_status *status)
> -{
> -
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
> -        || (extractFloatx80Exp(a) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(a) << 1))
> -        || (extractFloatx80Exp(b) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(b) << 1))
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    return
> -           ( a.low =3D=3D b.low )
> -        && (    ( a.high =3D=3D b.high )
> -             || (    ( a.low =3D=3D 0 )
> -                  && ( (uint16_t) ( ( a.high | b.high )<<1 ) =3D=3D 0 ) )
> -           );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point value `a' is
> -| less than or equal to the corresponding value `b', and 0 otherwise.  T=
he
> -| invalid exception is raised if either operand is a NaN.  The compariso=
n is
> -| performed according to the IEC/IEEE Standard for Binary Floating-Point
> -| Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int floatx80_le(floatx80 a, floatx80 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
> -        || (extractFloatx80Exp(a) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(a) << 1))
> -        || (extractFloatx80Exp(b) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(b) << 1))
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    aSign =3D extractFloatx80Sign( a );
> -    bSign =3D extractFloatx80Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            || (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 =3D=3D 0 );
> -    }
> -    return
> -          aSign ? le128( b.high, b.low, a.high, a.low )
> -        : le128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point value `a' is
> -| less than the corresponding value `b', and 0 otherwise.  The invalid
> -| exception is raised if either operand is a NaN.  The comparison is per=
formed
> -| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int floatx80_lt(floatx80 a, floatx80 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
> -        || (extractFloatx80Exp(a) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(a) << 1))
> -        || (extractFloatx80Exp(b) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(b) << 1))
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    aSign =3D extractFloatx80Sign( a );
> -    bSign =3D extractFloatx80Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            && (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 !=3D 0 );
> -    }
> -    return
> -          aSign ? lt128( b.high, b.low, a.high, a.low )
> -        : lt128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point values `a' a=
nd `b'
> -| cannot be compared, and 0 otherwise.  The invalid exception is raised =
if
> -| either operand is a NaN.   The comparison is performed according to the
> -| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -int floatx80_unordered(floatx80 a, floatx80 b, float_status *status)
> -{
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
> -        || (extractFloatx80Exp(a) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(a) << 1))
> -        || (extractFloatx80Exp(b) =3D=3D 0x7FFF
> -            && (uint64_t) (extractFloatx80Frac(b) << 1))
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 1;
> -    }
> -    return 0;
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point value `a' is
> -| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do =
not
> -| cause an exception.  The comparison is performed according to the IEC/=
IEEE
> -| Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int floatx80_eq_quiet(floatx80 a, floatx80 b, float_status *status)
> -{
> -
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    if (    (    ( extractFloatx80Exp( a ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
> -         || (    ( extractFloatx80Exp( b ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
> -       ) {
> -        if (floatx80_is_signaling_nan(a, status)
> -         || floatx80_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    return
> -           ( a.low =3D=3D b.low )
> -        && (    ( a.high =3D=3D b.high )
> -             || (    ( a.low =3D=3D 0 )
> -                  && ( (uint16_t) ( ( a.high | b.high )<<1 ) =3D=3D 0 ) )
> -           );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point value `a' is=
 less
> -| than or equal to the corresponding value `b', and 0 otherwise.  Quiet =
NaNs
> -| do not cause an exception.  Otherwise, the comparison is performed acc=
ording
> -| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int floatx80_le_quiet(floatx80 a, floatx80 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    if (    (    ( extractFloatx80Exp( a ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
> -         || (    ( extractFloatx80Exp( b ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
> -       ) {
> -        if (floatx80_is_signaling_nan(a, status)
> -         || floatx80_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    aSign =3D extractFloatx80Sign( a );
> -    bSign =3D extractFloatx80Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            || (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 =3D=3D 0 );
> -    }
> -    return
> -          aSign ? le128( b.high, b.low, a.high, a.low )
> -        : le128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point value `a' is=
 less
> -| than the corresponding value `b', and 0 otherwise.  Quiet NaNs do not =
cause
> -| an exception.  Otherwise, the comparison is performed according to the
> -| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int floatx80_lt_quiet(floatx80 a, floatx80 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    if (    (    ( extractFloatx80Exp( a ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
> -         || (    ( extractFloatx80Exp( b ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
> -       ) {
> -        if (floatx80_is_signaling_nan(a, status)
> -         || floatx80_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    aSign =3D extractFloatx80Sign( a );
> -    bSign =3D extractFloatx80Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            && (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 !=3D 0 );
> -    }
> -    return
> -          aSign ? lt128( b.high, b.low, a.high, a.low )
> -        : lt128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the extended double-precision floating-point values `a' a=
nd `b'
> -| cannot be compared, and 0 otherwise.  Quiet NaNs do not cause an excep=
tion.
> -| The comparison is performed according to the IEC/IEEE Standard for Bin=
ary
> -| Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *statu=
s)
> -{
> -    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
> -        float_raise(float_flag_invalid, status);
> -        return 1;
> -    }
> -    if (    (    ( extractFloatx80Exp( a ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
> -         || (    ( extractFloatx80Exp( b ) =3D=3D 0x7FFF )
> -              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
> -       ) {
> -        if (floatx80_is_signaling_nan(a, status)
> -         || floatx80_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 1;
> -    }
> -    return 0;
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns the result of converting the quadruple-precision floating-point
>  | value `a' to the 32-bit two's complement integer format.  The conversi=
on


--=20
Alex Benn=C3=A9e

