Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D50C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311902166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwynSQ5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311902166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYRk-0002cy-B0
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUYN9-0008W5-IL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUYLm-0006Ph-Pz
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:18:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUYLm-0006Nw-91
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:17:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so210510wmh.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JZ75jGE1ZDNpxRDu+TiQcZDghhE9MZ4WnRaTK4tyyVU=;
 b=BwynSQ5nY/DdblaY8gxNvMzPdNGUHKIDnbRcXzGWYN0gnYAB9vmgLW7MK3gnsI9YWU
 27Mno2rSdlsQzv8X2mfTkczzq4dZOk3F5bT3QBfunx5rawT7siX6FJhlsLRsP4kMwea9
 ai4K9Vu/hEBKxeXO0MJnutcH4himEf1+Rqey2w5QzjlufRbec6Q/oa0cE3QiNaLxpws0
 q17ZhceCa0EPOumsmSvFmtYJIKq3NWFnLvbclt64xKGhtHf+daGyqpY44gl04yoTuarj
 tMegC3knTfu5O0TCC2/TOAQZTXTEkLQpd3nvGymxt88BDQEl0IlLV15MbXbYL8G16U2G
 4Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JZ75jGE1ZDNpxRDu+TiQcZDghhE9MZ4WnRaTK4tyyVU=;
 b=FYdWng5aY7BVUiD7tAeiowA7lQMs7tMNxgAW+KNVwWOOTDwJd+eCY7OJrtSxi5T2rt
 0T7boTRbpc5qyaWLEfCbb211q6LbII+qCk+lOpLsidxDcGOTyoM+4AHbaHIgDh/uM9ww
 6/2yaGgU+Lj3WxZpe9BSkvaf3wCjbm5QHi/xPl/Msc8gq26/9LpD28BAVNCX8mpJVezh
 Ec+gWpa4qRmFYGb64zxTecSZ+dYYuaqrwyh4mQkLhMwAnUyKxTSNsYIAjYM37Ej+DvDX
 cH9Ytvy/muYU/q8SQesOuE2tUqw0LCJnBKMI4KjQbopio5VaczI9NfSP5TT3SbsvHuHg
 8mVg==
X-Gm-Message-State: AGi0PuaqREASd8gjH5EuqyUrAvhwVnRs7e0X5Xjktm3+44FlXSWbgiuj
 EOY2TUWSIhiszcJsyfUjz5snXHLreVc=
X-Google-Smtp-Source: APiQypIwqFJbEJIOZlEwQjX+uOe2bYxqz6ciGhdkYg2RDN9QZbQ8U3Nmr4qc/FTlxK6xAO75T73/RQ==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr295428wmm.150.1588349836458; 
 Fri, 01 May 2020 09:17:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i25sm93893wml.43.2020.05.01.09.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 09:17:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86BD21FF7E;
 Fri,  1 May 2020 17:17:14 +0100 (BST)
References: <alpine.DEB.2.21.2005010036120.30535@digraph.polyomino.org.uk>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 1/4] softfloat: silence sNaN for conversions to/from
 floatx80
In-reply-to: <alpine.DEB.2.21.2005010036120.30535@digraph.polyomino.org.uk>
Date: Fri, 01 May 2020 17:17:14 +0100
Message-ID: <87k11viq9h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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


Joseph Myers <joseph@codesourcery.com> writes:

> Conversions between IEEE floating-point formats should convert
> signaling NaNs to quiet NaNs.  Most of those in QEMU's softfloat code
> do so, but those for floatx80 fail to.  Fix those conversions to
> silence signaling NaNs as well.

I realised we hadn't enabled float-to-float tests for check-softfloat so
with this applied:

--8<---------------cut here---------------start------------->8---
tests/tcg: add check-softfloat-conv-f2f

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

1 file changed, 17 insertions(+), 1 deletion(-)
tests/Makefile.include | 18 +++++++++++++++++-

modified   tests/Makefile.include
@@ -687,7 +687,23 @@ test-softfloat =3D $(call quiet-command, \
 			(cat $2.out && exit 1;), \
 			"FLOAT TEST", $2)
=20
-# Conversion Routines:
+# Conversion Routines: Float to Float
+# FIXME: f32_to_f128 (broken)
+check-softfloat-conv-f2f: $(FP_TEST_BIN)
+	$(call test-softfloat, \
+		f16_to_f32 f16_to_f64 \
+		f16_to_extF80 f16_to_f128 \
+		f32_to_f16 f32_to_f64 \
+		f32_to_extF80 \
+		f64_to_f16 f64_to_f32 \
+		f64_to_extF80 f64_to_f128 \
+		extF80_to_f16 extF80_to_f32 \
+		extF80_to_f64 extF80_to_f128 \
+		f128_to_f16 f128_to_f32 \
+		f128_to_f64 f128_to_extF80, \
+		float-to-float)
+
+# Conversion Routines: Float to Float
 # FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
 #        ui32_to_f128 (not implemented), extF80_roundToInt (broken)
 #
--8<---------------cut here---------------end--------------->8---

I still see some failures for:

  f64_to_extF80
  f128_to_extF80

(as well as other conversions you've not touched). Ideally we want to
convert the extF80 and f128 code to use the newer FloatParts code which
is pretty robustly tested now. However the trick would be finding a way
to do that that doesn't involve break or regressing the performance for
the f16/32/64 cases. Just using a union causes all sorts of problems.

Anyway I'd settle for fixing the old style code and enabling the tests
we can.

>
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  fpu/softfloat.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index ae6ba71854..ac116c70b8 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -4498,7 +4498,9 @@ floatx80 float32_to_floatx80(float32 a, float_statu=
s *status)
>      aSign =3D extractFloat32Sign( a );
>      if ( aExp =3D=3D 0xFF ) {
>          if (aSig) {
> -            return commonNaNToFloatx80(float32ToCommonNaN(a, status), st=
atus);
> +            floatx80 res =3D commonNaNToFloatx80(float32ToCommonNaN(a, s=
tatus),
> +                                               status);
> +            return floatx80_silence_nan(res, status);
>          }
>          return packFloatx80(aSign,
>                              floatx80_infinity_high,
> @@ -5016,7 +5018,9 @@ floatx80 float64_to_floatx80(float64 a, float_statu=
s *status)
>      aSign =3D extractFloat64Sign( a );
>      if ( aExp =3D=3D 0x7FF ) {
>          if (aSig) {
> -            return commonNaNToFloatx80(float64ToCommonNaN(a, status), st=
atus);
> +            floatx80 res =3D commonNaNToFloatx80(float64ToCommonNaN(a, s=
tatus),
> +                                               status);
> +            return floatx80_silence_nan(res, status);
>          }
>          return packFloatx80(aSign,
>                              floatx80_infinity_high,
> @@ -5618,7 +5622,9 @@ float32 floatx80_to_float32(floatx80 a, float_statu=
s *status)
>      aSign =3D extractFloatx80Sign( a );
>      if ( aExp =3D=3D 0x7FFF ) {
>          if ( (uint64_t) ( aSig<<1 ) ) {
> -            return commonNaNToFloat32(floatx80ToCommonNaN(a, status), st=
atus);
> +            float32 res =3D commonNaNToFloat32(floatx80ToCommonNaN(a, st=
atus),
> +                                             status);
> +            return float32_silence_nan(res, status);
>          }
>          return packFloat32( aSign, 0xFF, 0 );
>      }
> @@ -5650,7 +5656,9 @@ float64 floatx80_to_float64(floatx80 a, float_statu=
s *status)
>      aSign =3D extractFloatx80Sign( a );
>      if ( aExp =3D=3D 0x7FFF ) {
>          if ( (uint64_t) ( aSig<<1 ) ) {
> -            return commonNaNToFloat64(floatx80ToCommonNaN(a, status), st=
atus);
> +            float64 res =3D commonNaNToFloat64(floatx80ToCommonNaN(a, st=
atus),
> +                                             status);
> +            return float64_silence_nan(res, status);
>          }
>          return packFloat64( aSign, 0x7FF, 0 );
>      }
> @@ -5681,7 +5689,9 @@ float128 floatx80_to_float128(floatx80 a, float_sta=
tus *status)
>      aExp =3D extractFloatx80Exp( a );
>      aSign =3D extractFloatx80Sign( a );
>      if ( ( aExp =3D=3D 0x7FFF ) && (uint64_t) ( aSig<<1 ) ) {
> -        return commonNaNToFloat128(floatx80ToCommonNaN(a, status), statu=
s);
> +        float128 res =3D commonNaNToFloat128(floatx80ToCommonNaN(a, stat=
us),
> +                                           status);
> +        return float128_silence_nan(res, status);
>      }
>      shift128Right( aSig<<1, 0, 16, &zSig0, &zSig1 );
>      return packFloat128( aSign, aExp, zSig0, zSig1 );
> @@ -6959,7 +6969,9 @@ floatx80 float128_to_floatx80(float128 a, float_sta=
tus *status)
>      aSign =3D extractFloat128Sign( a );
>      if ( aExp =3D=3D 0x7FFF ) {
>          if ( aSig0 | aSig1 ) {
> -            return commonNaNToFloatx80(float128ToCommonNaN(a, status), s=
tatus);
> +            floatx80 res =3D commonNaNToFloatx80(float128ToCommonNaN(a, =
status),
> +                                               status);
> +            return floatx80_silence_nan(res, status);
>          }
>          return packFloatx80(aSign, floatx80_infinity_high,
>                                     floatx80_infinity_low);
> --=20
> 2.17.1


--=20
Alex Benn=C3=A9e

