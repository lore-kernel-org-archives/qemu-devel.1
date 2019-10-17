Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B5ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6BF20820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLrQOJRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6BF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL94f-0005f7-F3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL8DP-0002tQ-Sb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL8DL-0004yH-RC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:01:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL8DL-0004xs-BE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:01:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id n14so2970058wrw.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BAzQ9Rb8xI131CY1j5PtveSlcHmseu5FFL3jx1DVdaA=;
 b=jLrQOJRpcVKNwXfCBLaXjb3hRNxVeL3btAo2XiHSa/UPWOzy9xXpxBpaOnffn33d2O
 dJ55FjYSo7PscOynXsFwR/kNgaqQ8kv+IE4oM4wDPxOl2abPKDf3mmryiCV3VUbCK/Yy
 PBmJ2rV7723erjHZVLgW7D6N24BKQ64ScGVQXRBs+6acXWNGsuake1f0vmpMMQK+OUWH
 UEaOEgOavw8tImIJWLpHsRQJGfsPNgPf4oT/e3Dvq/iROFvVDkW4RX7xnsZAlgwZuooS
 VqL6n57pIsDgbi979THcmEmRmjYhG2VdUdawmsj8im2mWsLDazNSxokqV/ddIcyazEbA
 Uhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BAzQ9Rb8xI131CY1j5PtveSlcHmseu5FFL3jx1DVdaA=;
 b=dIyVyt/rg1jVJ+JrF2CbvlHMRdB78He4ojfG5/EcG0lVH9zzGRBp25drw/UHcqiszP
 jJLm7VA/bZbWnIqUJgmPjt191vi6f9RiYs6gJTgIFoMYub0gQDNlt9qzrNSJBbxyTWjq
 yHYslZZ44qR3iarS2GeFRp6eV4DI67xPBj1pVQEoyC8PbSXG7QQWNRWC2cFsl9VhvM4E
 EtYxsZH5skmt12vY8SJt9Xp8u1Sck+HD7VayUB5KgKJMeupWjSjjCON5lmTPzgITxAPh
 VaEo9nh+R27AcwdkzKyJBCM3utQF+ZGoomrWnMsWe8/lsl/j7h6bTMyAUie4By2QoCul
 Y7ww==
X-Gm-Message-State: APjAAAWM/HWZR8VzaajUZ9R3hDcD+4rAKAIl0xN9av3+RjHTrJa9IV8S
 8luZcpfe2LsPbCyBwNdAtooMSqtbQN8=
X-Google-Smtp-Source: APXvYqzxDbU4Tz/5z5CAyBzpl+IKfDO0RPy/rV5ZsCNBcygQsJtX0FYSNJICZ4zfZFNRaB8E5OhpNQ==
X-Received: by 2002:adf:c98b:: with SMTP id f11mr3936979wrh.274.1571328081284; 
 Thu, 17 Oct 2019 09:01:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b144sm2577572wmb.3.2019.10.17.09.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:01:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BFB9D1FF87;
 Thu, 17 Oct 2019 17:01:19 +0100 (BST)
References: <20191017044232.27601-1-richard.henderson@linaro.org>
 <20191017044232.27601-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] target/arm: Vectorize USHL and SSHL
In-reply-to: <20191017044232.27601-2-richard.henderson@linaro.org>
Date: Thu, 17 Oct 2019 17:01:19 +0100
Message-ID: <874l07pdio.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> These instructions shift left or right depending on the sign
> of the input, and 7 bits are significant to the shift.  This
> requires several masks and selects in addition to the actual
> shifts to form the complete answer.
>
> That said, the operation is still a small improvement even for
> two 64-bit elements -- 13 vector operations instead of 2 * 7
> integer operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Fix operand ordering for aa32 VSHL.
> ---
>  target/arm/helper.h        |  11 +-
>  target/arm/translate.h     |   6 +
>  target/arm/neon_helper.c   |  33 ----
>  target/arm/translate-a64.c |  18 +--
>  target/arm/translate.c     | 301 +++++++++++++++++++++++++++++++++++--
>  target/arm/vec_helper.c    |  88 +++++++++++
>  6 files changed, 391 insertions(+), 66 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 1fb2cb5a77..fc0d594a14 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -296,14 +296,8 @@ DEF_HELPER_2(neon_abd_s16, i32, i32, i32)
>  DEF_HELPER_2(neon_abd_u32, i32, i32, i32)
>  DEF_HELPER_2(neon_abd_s32, i32, i32, i32)
>
> -DEF_HELPER_2(neon_shl_u8, i32, i32, i32)
> -DEF_HELPER_2(neon_shl_s8, i32, i32, i32)
>  DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
>  DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
> -DEF_HELPER_2(neon_shl_u32, i32, i32, i32)
> -DEF_HELPER_2(neon_shl_s32, i32, i32, i32)
> -DEF_HELPER_2(neon_shl_u64, i64, i64, i64)
> -DEF_HELPER_2(neon_shl_s64, i64, i64, i64)
>  DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
>  DEF_HELPER_2(neon_rshl_s8, i32, i32, i32)
>  DEF_HELPER_2(neon_rshl_u16, i32, i32, i32)
> @@ -690,6 +684,11 @@ DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, =
f32, ptr)
>  DEF_HELPER_FLAGS_2(frint32_d, TCG_CALL_NO_RWG, f64, f64, ptr)
>  DEF_HELPER_FLAGS_2(frint64_d, TCG_CALL_NO_RWG, f64, f64, ptr)
>
> +DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
>  #include "helper-sve.h"
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index dd24f91f26..0c4e6e4bbd 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -274,6 +274,8 @@ uint64_t vfp_expand_imm(int size, uint8_t imm8);
>  extern const GVecGen3 mla_op[4];
>  extern const GVecGen3 mls_op[4];
>  extern const GVecGen3 cmtst_op[4];
> +extern const GVecGen3 sshl_op[4];
> +extern const GVecGen3 ushl_op[4];
>  extern const GVecGen2i ssra_op[4];
>  extern const GVecGen2i usra_op[4];
>  extern const GVecGen2i sri_op[4];
> @@ -283,6 +285,10 @@ extern const GVecGen4 sqadd_op[4];
>  extern const GVecGen4 uqsub_op[4];
>  extern const GVecGen4 sqsub_op[4];
>  void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
> +void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
> +void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
> +void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
>
>  /*
>   * Forward to the isar_feature_* tests given a DisasContext pointer.
> diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
> index 4259056723..c581ffb7d3 100644
> --- a/target/arm/neon_helper.c
> +++ b/target/arm/neon_helper.c
> @@ -615,24 +615,9 @@ NEON_VOP(abd_u32, neon_u32, 1)
>      } else { \
>          dest =3D src1 << tmp; \
>      }} while (0)
> -NEON_VOP(shl_u8, neon_u8, 4)
>  NEON_VOP(shl_u16, neon_u16, 2)
> -NEON_VOP(shl_u32, neon_u32, 1)
>  #undef NEON_FN
>
> -uint64_t HELPER(neon_shl_u64)(uint64_t val, uint64_t shiftop)
> -{
> -    int8_t shift =3D (int8_t)shiftop;
> -    if (shift >=3D 64 || shift <=3D -64) {
> -        val =3D 0;
> -    } else if (shift < 0) {
> -        val >>=3D -shift;
> -    } else {
> -        val <<=3D shift;
> -    }
> -    return val;
> -}
> -
>  #define NEON_FN(dest, src1, src2) do { \
>      int8_t tmp; \
>      tmp =3D (int8_t)src2; \
> @@ -645,27 +630,9 @@ uint64_t HELPER(neon_shl_u64)(uint64_t val, uint64_t=
 shiftop)
>      } else { \
>          dest =3D src1 << tmp; \
>      }} while (0)
> -NEON_VOP(shl_s8, neon_s8, 4)
>  NEON_VOP(shl_s16, neon_s16, 2)
> -NEON_VOP(shl_s32, neon_s32, 1)
>  #undef NEON_FN
>
> -uint64_t HELPER(neon_shl_s64)(uint64_t valop, uint64_t shiftop)
> -{
> -    int8_t shift =3D (int8_t)shiftop;
> -    int64_t val =3D valop;
> -    if (shift >=3D 64) {
> -        val =3D 0;
> -    } else if (shift <=3D -64) {
> -        val >>=3D 63;
> -    } else if (shift < 0) {
> -        val >>=3D -shift;
> -    } else {
> -        val <<=3D shift;
> -    }
> -    return val;
> -}
> -
>  #define NEON_FN(dest, src1, src2) do { \
>      int8_t tmp; \
>      tmp =3D (int8_t)src2; \
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2d6cd09634..255a168df6 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -8685,9 +8685,9 @@ static void handle_3same_64(DisasContext *s, int op=
code, bool u,
>          break;
>      case 0x8: /* SSHL, USHL */
>          if (u) {
> -            gen_helper_neon_shl_u64(tcg_rd, tcg_rn, tcg_rm);
> +            gen_ushl_i64(tcg_rd, tcg_rn, tcg_rm);
>          } else {
> -            gen_helper_neon_shl_s64(tcg_rd, tcg_rn, tcg_rm);
> +            gen_sshl_i64(tcg_rd, tcg_rn, tcg_rm);
>          }
>          break;
>      case 0x9: /* SQSHL, UQSHL */
> @@ -11082,6 +11082,10 @@ static void disas_simd_3same_int(DisasContext *s=
, uint32_t insn)
>                         is_q ? 16 : 8, vec_full_reg_size(s),
>                         (u ? uqsub_op : sqsub_op) + size);
>          return;
> +    case 0x08: /* SSHL, USHL */
> +        gen_gvec_op3(s, is_q, rd, rn, rm,
> +                     u ? &ushl_op[size] : &sshl_op[size]);
> +        return;
>      case 0x0c: /* SMAX, UMAX */
>          if (u) {
>              gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
> @@ -11197,16 +11201,6 @@ static void disas_simd_3same_int(DisasContext *s=
, uint32_t insn)
>                  genfn =3D fns[size][u];
>                  break;
>              }
> -            case 0x8: /* SSHL, USHL */
> -            {
> -                static NeonGenTwoOpFn * const fns[3][2] =3D {
> -                    { gen_helper_neon_shl_s8, gen_helper_neon_shl_u8 },
> -                    { gen_helper_neon_shl_s16, gen_helper_neon_shl_u16 },
> -                    { gen_helper_neon_shl_s32, gen_helper_neon_shl_u32 },
> -                };
> -                genfn =3D fns[size][u];
> -                break;
> -            }
>              case 0x9: /* SQSHL, UQSHL */
>              {
>                  static NeonGenTwoOpEnvFn * const fns[3][2] =3D {
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 698c594e8c..598bb1cc00 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -3580,13 +3580,13 @@ static inline void gen_neon_shift_narrow(int size=
, TCGv_i32 var, TCGv_i32 shift,
>          if (u) {
>              switch (size) {
>              case 1: gen_helper_neon_shl_u16(var, var, shift); break;
> -            case 2: gen_helper_neon_shl_u32(var, var, shift); break;
> +            case 2: gen_ushl_i32(var, var, shift); break;
>              default: abort();
>              }
>          } else {
>              switch (size) {
>              case 1: gen_helper_neon_shl_s16(var, var, shift); break;
> -            case 2: gen_helper_neon_shl_s32(var, var, shift); break;
> +            case 2: gen_sshl_i32(var, var, shift); break;
>              default: abort();
>              }
>          }
> @@ -4389,6 +4389,282 @@ const GVecGen3 cmtst_op[4] =3D {
>        .vece =3D MO_64 },
>  };
>
> +void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)

nit: this would have been nicer to read if the ops where dst, src, shift
or some such.

> +{
> +    TCGv_i32 lval =3D tcg_temp_new_i32();
> +    TCGv_i32 rval =3D tcg_temp_new_i32();
> +    TCGv_i32 lsh =3D tcg_temp_new_i32();
> +    TCGv_i32 rsh =3D tcg_temp_new_i32();
> +    TCGv_i32 zero =3D tcg_const_i32(0);
> +    TCGv_i32 max =3D tcg_const_i32(32);
> +
> +    /*
> +     * Rely on the TCG guarantee that out of range shifts produce
> +     * unspecified results, not undefined behaviour (i.e. no trap).
> +     * Discard out-of-range results after the fact.
> +     */
> +    tcg_gen_ext8s_i32(lsh, b);
> +    tcg_gen_neg_i32(rsh, lsh);
> +    tcg_gen_shl_i32(lval, a, lsh);
> +    tcg_gen_shr_i32(rval, a, rsh);
> +    tcg_gen_movcond_i32(TCG_COND_LTU, d, lsh, max, lval, zero);
> +    tcg_gen_movcond_i32(TCG_COND_LTU, d, rsh, max, rval, d);

Do these get dead coded away if the shift is a const?

> +
> +    tcg_temp_free_i32(lval);
> +    tcg_temp_free_i32(rval);
> +    tcg_temp_free_i32(lsh);
> +    tcg_temp_free_i32(rsh);
> +    tcg_temp_free_i32(zero);
> +    tcg_temp_free_i32(max);
> +}
> +
> +void gen_ushl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 lval =3D tcg_temp_new_i64();
> +    TCGv_i64 rval =3D tcg_temp_new_i64();
> +    TCGv_i64 lsh =3D tcg_temp_new_i64();
> +    TCGv_i64 rsh =3D tcg_temp_new_i64();
> +    TCGv_i64 zero =3D tcg_const_i64(0);
> +    TCGv_i64 max =3D tcg_const_i64(64);
> +
> +    /*
> +     * Rely on the TCG guarantee that out of range shifts produce
> +     * unspecified results, not undefined behaviour (i.e. no trap).
> +     * Discard out-of-range results after the fact.
> +     */
> +    tcg_gen_ext8s_i64(lsh, b);
> +    tcg_gen_neg_i64(rsh, lsh);
> +    tcg_gen_shl_i64(lval, a, lsh);
> +    tcg_gen_shr_i64(rval, a, rsh);
> +    tcg_gen_movcond_i64(TCG_COND_LTU, d, lsh, max, lval, zero);
> +    tcg_gen_movcond_i64(TCG_COND_LTU, d, rsh, max, rval, d);
> +
> +    tcg_temp_free_i64(lval);
> +    tcg_temp_free_i64(rval);
> +    tcg_temp_free_i64(lsh);
> +    tcg_temp_free_i64(rsh);
> +    tcg_temp_free_i64(zero);
> +    tcg_temp_free_i64(max);
> +}
> +
> +static void gen_ushl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec=
 b)
> +{
> +    TCGv_vec lval =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec rval =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec lsh =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec rsh =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec msk, max;
> +
> +    /*
> +     * Rely on the TCG guarantee that out of range shifts produce
> +     * unspecified results, not undefined behaviour (i.e. no trap).
> +     * Discard out-of-range results after the fact.
> +     */
> +    tcg_gen_neg_vec(vece, rsh, b);
> +    if (vece =3D=3D MO_8) {
> +        tcg_gen_mov_vec(lsh, b);
> +    } else {
> +        msk =3D tcg_temp_new_vec_matching(d);
> +        tcg_gen_dupi_vec(vece, msk, 0xff);
> +        tcg_gen_and_vec(vece, lsh, b, msk);
> +        tcg_gen_and_vec(vece, rsh, rsh, msk);
> +        tcg_temp_free_vec(msk);
> +    }
> +
> +    /*
> +     * Perform possibly out of range shifts, trusting that the operation
> +     * does not trap.  Discard unused results after the fact.
> +     */
> +    tcg_gen_shlv_vec(vece, lval, a, lsh);
> +    tcg_gen_shrv_vec(vece, rval, a, rsh);
> +
> +    max =3D tcg_temp_new_vec_matching(d);
> +    tcg_gen_dupi_vec(vece, max, 8 << vece);
> +
> +    /*
> +     * The choice of LT (signed) and GEU (unsigned) are biased toward
> +     * the instructions of the x86_64 host.  For MO_8, the whole byte
> +     * is significant so we must use an unsigned compare; otherwise we
> +     * have already masked to a byte and so a signed compare works.
> +     * Other tcg hosts have a full set of comparisons and do not care.
> +     */
> +    if (vece =3D=3D MO_8) {
> +        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
> +        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
> +        tcg_gen_andc_vec(vece, lval, lval, lsh);
> +        tcg_gen_andc_vec(vece, rval, rval, rsh);
> +    } else {
> +        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
> +        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
> +        tcg_gen_and_vec(vece, lval, lval, lsh);
> +        tcg_gen_and_vec(vece, rval, rval, rsh);
> +    }
> +    tcg_gen_or_vec(vece, d, lval, rval);
> +
> +    tcg_temp_free_vec(max);
> +    tcg_temp_free_vec(lval);
> +    tcg_temp_free_vec(rval);
> +    tcg_temp_free_vec(lsh);
> +    tcg_temp_free_vec(rsh);
> +}
> +
> +static const TCGOpcode ushl_list[] =3D {
> +    INDEX_op_neg_vec, INDEX_op_shlv_vec,
> +    INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
> +};
> +
> +const GVecGen3 ushl_op[4] =3D {
> +    { .fniv =3D gen_ushl_vec,
> +      .fno =3D gen_helper_gvec_ushl_b,
> +      .opt_opc =3D ushl_list,
> +      .vece =3D MO_8 },
> +    { .fniv =3D gen_ushl_vec,
> +      .fno =3D gen_helper_gvec_ushl_h,
> +      .opt_opc =3D ushl_list,
> +      .vece =3D MO_16 },
> +    { .fni4 =3D gen_ushl_i32,
> +      .fniv =3D gen_ushl_vec,
> +      .opt_opc =3D ushl_list,
> +      .vece =3D MO_32 },
> +    { .fni8 =3D gen_ushl_i64,
> +      .fniv =3D gen_ushl_vec,
> +      .opt_opc =3D ushl_list,
> +      .vece =3D MO_64 },
> +};
> +
> +void gen_sshl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    TCGv_i32 lval =3D tcg_temp_new_i32();
> +    TCGv_i32 rval =3D tcg_temp_new_i32();
> +    TCGv_i32 lsh =3D tcg_temp_new_i32();
> +    TCGv_i32 rsh =3D tcg_temp_new_i32();
> +    TCGv_i32 zero =3D tcg_const_i32(0);
> +    TCGv_i32 max =3D tcg_const_i32(31);
> +
> +    /*
> +     * Rely on the TCG guarantee that out of range shifts produce
> +     * unspecified results, not undefined behaviour (i.e. no trap).
> +     * Discard out-of-range results after the fact.
> +     */
> +    tcg_gen_ext8s_i32(lsh, b);
> +    tcg_gen_neg_i32(rsh, lsh);
> +    tcg_gen_shl_i32(lval, a, lsh);
> +    tcg_gen_umin_i32(rsh, rsh, max);
> +    tcg_gen_sar_i32(rval, a, rsh);
> +    tcg_gen_movcond_i32(TCG_COND_LEU, lval, lsh, max, lval, zero);
> +    tcg_gen_movcond_i32(TCG_COND_LT, d, lsh, zero, rval, lval);
> +
> +    tcg_temp_free_i32(lval);
> +    tcg_temp_free_i32(rval);
> +    tcg_temp_free_i32(lsh);
> +    tcg_temp_free_i32(rsh);
> +    tcg_temp_free_i32(zero);
> +    tcg_temp_free_i32(max);
> +}
> +
> +void gen_sshl_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    TCGv_i64 lval =3D tcg_temp_new_i64();
> +    TCGv_i64 rval =3D tcg_temp_new_i64();
> +    TCGv_i64 lsh =3D tcg_temp_new_i64();
> +    TCGv_i64 rsh =3D tcg_temp_new_i64();
> +    TCGv_i64 zero =3D tcg_const_i64(0);
> +    TCGv_i64 max =3D tcg_const_i64(63);
> +
> +    /*
> +     * Rely on the TCG guarantee that out of range shifts produce
> +     * unspecified results, not undefined behaviour (i.e. no trap).
> +     * Discard out-of-range results after the fact.
> +     */
> +    tcg_gen_ext8s_i64(lsh, b);
> +    tcg_gen_neg_i64(rsh, lsh);
> +    tcg_gen_shl_i64(lval, a, lsh);
> +    tcg_gen_umin_i64(rsh, rsh, max);
> +    tcg_gen_sar_i64(rval, a, rsh);
> +    tcg_gen_movcond_i64(TCG_COND_LEU, lval, lsh, max, lval, zero);
> +    tcg_gen_movcond_i64(TCG_COND_LT, d, lsh, zero, rval, lval);
> +
> +    tcg_temp_free_i64(lval);
> +    tcg_temp_free_i64(rval);
> +    tcg_temp_free_i64(lsh);
> +    tcg_temp_free_i64(rsh);
> +    tcg_temp_free_i64(zero);
> +    tcg_temp_free_i64(max);
> +}
> +
> +static void gen_sshl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec=
 b)
> +{
> +    TCGv_vec lval =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec rval =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec lsh =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec rsh =3D tcg_temp_new_vec_matching(d);
> +    TCGv_vec tmp =3D tcg_temp_new_vec_matching(d);
> +
> +    /*
> +     * Rely on the TCG guarantee that out of range shifts produce
> +     * unspecified results, not undefined behaviour (i.e. no trap).
> +     * Discard out-of-range results after the fact.
> +     */
> +    tcg_gen_neg_vec(vece, rsh, b);
> +    if (vece =3D=3D MO_8) {
> +        tcg_gen_mov_vec(lsh, b);
> +    } else {
> +        tcg_gen_dupi_vec(vece, tmp, 0xff);
> +        tcg_gen_and_vec(vece, lsh, b, tmp);
> +        tcg_gen_and_vec(vece, rsh, rsh, tmp);
> +    }
> +
> +    /* Bound rsh so out of bound right shift gets -1.  */
> +    tcg_gen_dupi_vec(vece, tmp, (8 << vece) - 1);
> +    tcg_gen_umin_vec(vece, rsh, rsh, tmp);
> +    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, tmp);
> +
> +    tcg_gen_shlv_vec(vece, lval, a, lsh);
> +    tcg_gen_sarv_vec(vece, rval, a, rsh);
> +
> +    /* Select in-bound left shift.  */
> +    tcg_gen_andc_vec(vece, lval, lval, tmp);
> +
> +    /* Select between left and right shift.  */
> +    if (vece =3D=3D MO_8) {
> +        tcg_gen_dupi_vec(vece, tmp, 0);
> +        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, d, lsh, tmp, rval, lval);
> +    } else {
> +        tcg_gen_dupi_vec(vece, tmp, 0x80);
> +        tcg_gen_cmpsel_vec(TCG_COND_LT, vece, d, lsh, tmp, lval, rval);
> +    }
> +
> +    tcg_temp_free_vec(lval);
> +    tcg_temp_free_vec(rval);
> +    tcg_temp_free_vec(lsh);
> +    tcg_temp_free_vec(rsh);
> +    tcg_temp_free_vec(tmp);
> +}
> +
> +static const TCGOpcode sshl_list[] =3D {
> +    INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
> +    INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
> +};
> +
> +const GVecGen3 sshl_op[4] =3D {
> +    { .fniv =3D gen_sshl_vec,
> +      .fno =3D gen_helper_gvec_sshl_b,
> +      .opt_opc =3D sshl_list,
> +      .vece =3D MO_8 },
> +    { .fniv =3D gen_sshl_vec,
> +      .fno =3D gen_helper_gvec_sshl_h,
> +      .opt_opc =3D sshl_list,
> +      .vece =3D MO_16 },
> +    { .fni4 =3D gen_sshl_i32,
> +      .fniv =3D gen_sshl_vec,
> +      .opt_opc =3D sshl_list,
> +      .vece =3D MO_32 },
> +    { .fni8 =3D gen_sshl_i64,
> +      .fniv =3D gen_sshl_vec,
> +      .opt_opc =3D sshl_list,
> +      .vece =3D MO_64 },
> +};
> +
>  static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
>                            TCGv_vec a, TCGv_vec b)
>  {
> @@ -4792,6 +5068,12 @@ static int disas_neon_data_insn(DisasContext *s, u=
int32_t insn)
>                                    vec_size, vec_size);
>              }
>              return 0;
> +
> +        case NEON_3R_VSHL:
> +            /* Note the operation is vshl vd,vm,vn */
> +            tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
> +                           u ? &ushl_op[size] : &sshl_op[size]);
> +            return 0;
>          }
>
>          if (size =3D=3D 3) {
> @@ -4800,13 +5082,6 @@ static int disas_neon_data_insn(DisasContext *s, u=
int32_t insn)
>                  neon_load_reg64(cpu_V0, rn + pass);
>                  neon_load_reg64(cpu_V1, rm + pass);
>                  switch (op) {
> -                case NEON_3R_VSHL:
> -                    if (u) {
> -                        gen_helper_neon_shl_u64(cpu_V0, cpu_V1, cpu_V0);
> -                    } else {
> -                        gen_helper_neon_shl_s64(cpu_V0, cpu_V1, cpu_V0);
> -                    }
> -                    break;
>                  case NEON_3R_VQSHL:
>                      if (u) {
>                          gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
> @@ -4841,7 +5116,6 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>          }
>          pairwise =3D 0;
>          switch (op) {
> -        case NEON_3R_VSHL:
>          case NEON_3R_VQSHL:
>          case NEON_3R_VRSHL:
>          case NEON_3R_VQRSHL:
> @@ -4921,9 +5195,6 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>          case NEON_3R_VHSUB:
>              GEN_NEON_INTEGER_OP(hsub);
>              break;
> -        case NEON_3R_VSHL:
> -            GEN_NEON_INTEGER_OP(shl);
> -            break;
>          case NEON_3R_VQSHL:
>              GEN_NEON_INTEGER_OP_ENV(qshl);
>              break;
> @@ -5332,9 +5603,9 @@ static int disas_neon_data_insn(DisasContext *s, ui=
nt32_t insn)
>                              }
>                          } else {
>                              if (input_unsigned) {
> -                                gen_helper_neon_shl_u64(cpu_V0, in, tmp6=
4);
> +                                gen_ushl_i64(cpu_V0, in, tmp64);
>                              } else {
> -                                gen_helper_neon_shl_s64(cpu_V0, in, tmp6=
4);
> +                                gen_sshl_i64(cpu_V0, in, tmp64);
>                              }
>                          }
>                          tmp =3D tcg_temp_new_i32();
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index dedef62403..fcb3663903 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -1046,3 +1046,91 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn=
, void *vm,
>      do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
>                   get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
>  }
> +
> +void HELPER(gvec_sshl_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, opr_sz =3D simd_oprsz(desc);
> +    int8_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz; ++i) {
> +        int8_t mm =3D m[i];
> +        int8_t nn =3D n[i];
> +        int8_t res =3D 0;
> +        if (mm >=3D 0) {
> +            if (mm < 8) {
> +                res =3D nn << mm;
> +            }
> +        } else {
> +            res =3D nn >> (mm > -8 ? -mm : 7);
> +        }
> +        d[i] =3D res;
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_sshl_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, opr_sz =3D simd_oprsz(desc);
> +    int16_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz / 2; ++i) {
> +        int8_t mm =3D m[i];   /* only 8 bits of shift are significant */
> +        int16_t nn =3D n[i];
> +        int16_t res =3D 0;
> +        if (mm >=3D 0) {
> +            if (mm < 16) {
> +                res =3D nn << mm;
> +            }
> +        } else {
> +            res =3D nn >> (mm > -16 ? -mm : 15);
> +        }
> +        d[i] =3D res;
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_ushl_b)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, opr_sz =3D simd_oprsz(desc);
> +    uint8_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz; ++i) {
> +        int8_t mm =3D m[i];
> +        uint8_t nn =3D n[i];
> +        uint8_t res =3D 0;
> +        if (mm >=3D 0) {
> +            if (mm < 8) {
> +                res =3D nn << mm;
> +            }
> +        } else {
> +            if (mm > -8) {
> +                res =3D nn >> -mm;
> +            }
> +        }
> +        d[i] =3D res;
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}
> +
> +void HELPER(gvec_ushl_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, opr_sz =3D simd_oprsz(desc);
> +    uint16_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz / 2; ++i) {
> +        int8_t mm =3D m[i];   /* only 8 bits of shift are significant */
> +        uint16_t nn =3D n[i];
> +        uint16_t res =3D 0;
> +        if (mm >=3D 0) {
> +            if (mm < 16) {
> +                res =3D nn << mm;
> +            }
> +        } else {
> +            if (mm > -16) {
> +                res =3D nn >> -mm;
> +            }
> +        }
> +        d[i] =3D res;
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}

Anyway otherwise it LGTM:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

